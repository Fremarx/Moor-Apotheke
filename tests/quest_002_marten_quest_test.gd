extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var main := MAIN_SCENE.instantiate()
	root.add_child(main)
	await physics_frame
	await physics_frame

	var player := main.get_node_or_null("World/Player")
	var inventory := main.get_node_or_null("Inventory")
	var fenja := main.get_node_or_null("World/TestMap/Fenja") as Area2D
	var marten := main.get_node_or_null("World/TestMap/Marten") as Area2D
	var fenja_quest := main.get_node_or_null("Quest/FenjaQuest")
	var marten_quest := main.get_node_or_null("Quest/MartenQuest")
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var tea_count := main.get_node_or_null("HUD/TeaCount") as Label
	var infusion_count := main.get_node_or_null("HUD/InfusionCount") as Label
	var quest_status := main.get_node_or_null("HUD/QuestStatus") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(fenja != null, "Fenja exists")
	_check(marten != null, "Marten exists as an interactable NPC")
	_check(fenja_quest != null, "Fenja's quest still exists")
	_check(marten_quest != null, "Marten's quest exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(tea_count != null, "the calming tea inventory count exists")
	_check(infusion_count != null, "the strengthening infusion inventory count exists")
	_check(quest_status != null, "the quest status HUD exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or fenja == null or marten == null or fenja_quest == null or marten_quest == null or prompt == null or tea_count == null or infusion_count == null or quest_status == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(str(fenja_quest.get("state")) == "not_accepted", "Fenja's quest starts unaccepted")
	_check(str(marten_quest.get("state")) == "not_accepted", "Marten's quest starts unaccepted")
	_check(not quest_status.visible, "the quest HUD stays hidden before the first request")

	await _move_near(player, marten)
	_check(prompt.text.contains("Sprechen"), "Marten does not offer his request before Fenja is helped")
	_press_e(player)
	_check(str(marten_quest.get("state")) == "not_accepted", "Marten's request stays unavailable before Fenja's quest is complete")
	_check(feedback.text.contains("Fenja"), "Marten explains that Fenja must be helped first")

	inventory.call("add_item", "calming_tea", 1)
	await _move_near(player, fenja)
	_press_e(player)
	_check(str(fenja_quest.get("state")) == "active", "Fenja's request can still be accepted")
	_press_e(player)
	_check(str(fenja_quest.get("state")) == "completed", "Fenja's request can still be completed")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "Fenja receives her tea")
	_check(tea_count.text == "Beruhigungstee: 0", "Fenja's hand-in updates the tea HUD")

	await _move_near(player, marten)
	_check(prompt.text.contains("Annehmen"), "Marten offers his request after Fenja's is complete")
	_press_e(player)
	_check(str(marten_quest.get("state")) == "active", "talking to Marten accepts his request")
	_check(quest_status.text == "Sammle eine Sumpfminze für Marten.", "the HUD starts with the first missing infusion ingredient")
	_check(feedback.text.to_lower().contains("stärkenden aufguss"), "Marten names the requested infusion")

	inventory.call("add_item", "sump_mint", 1)
	_check(quest_status.text == "Trockne die Sumpfminze für Marten.", "the HUD asks to dry fresh mint")
	_check(bool(inventory.call("transfer_item", "sump_mint", "dried_sump_mint", 1)), "fresh mint can be dried for Marten's request")
	_check(quest_status.text == "Sammle eine Schilfwurzel für Marten.", "the HUD changes to the missing reed root")
	inventory.call("add_item", "reed_root", 1)
	_check(quest_status.text == "Trockne die Schilfwurzel für Marten.", "the HUD asks to dry fresh reed root")
	_check(bool(inventory.call("transfer_item", "reed_root", "dried_reed_root", 1)), "fresh reed root can be dried for Marten's request")
	_check(quest_status.text == "Braue den Stärkenden Aufguss für Marten.", "the HUD asks to brew when both dried ingredients are ready")

	_press_e(player)
	_check(str(marten_quest.get("state")) == "active", "the request stays active without the infusion")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 0, "a failed hand-in creates or consumes no infusion")
	_check(feedback.text.to_lower().contains("stärkenden aufguss"), "Marten explains which item he still needs")

	inventory.call("add_item", "strengthening_infusion", 2)
	_check(infusion_count.text == "Stärkender Aufguss: 2", "adding infusions updates the HUD")
	_check(quest_status.text.contains("Bringe Marten"), "the HUD changes to the hand-in objective")
	_press_e(player)
	_check(str(marten_quest.get("state")) == "completed", "giving Marten an infusion completes the request")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 1, "Marten receives exactly one infusion")
	_check(infusion_count.text == "Stärkender Aufguss: 1", "the infusion HUD shows the remaining item")
	_check(quest_status.visible and quest_status.text.contains("Martens Bitte"), "the HUD keeps Marten's completion visible")
	_check(feedback.text.contains("Danke"), "Marten thanks the player")
	_check(prompt.text.contains("Sprechen"), "Marten changes to a conversation prompt after completion")

	_press_e(player)
	_check(str(marten_quest.get("state")) == "completed", "Marten's completed request stays complete")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 1, "repeating the interaction consumes no more infusions")
	_check(infusion_count.text == "Stärkender Aufguss: 1", "the infusion HUD stays unchanged after repeated interaction")

	main.queue_free()
	_finish()


func _move_near(player: Node, target: Node2D) -> void:
	player.global_position = target.global_position + Vector2(6, 0)
	await physics_frame
	await physics_frame


func _press_e(player: Node) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = KEY_E
	event.pressed = true
	player.call("_unhandled_input", event)


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("QUEST-002 Marten quest checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("QUEST-002 check failed: " + failure)
	quit(1)
