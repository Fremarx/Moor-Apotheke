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
	var lene := main.get_node_or_null("World/TestMap/Lene") as Area2D
	var fenja_quest := main.get_node_or_null("Quest/FenjaQuest")
	var marten_quest := main.get_node_or_null("Quest/MartenQuest")
	var lene_quest := main.get_node_or_null("Quest/LeneQuest")
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var potion_count := main.get_node_or_null("HUD/NightPotionCount") as Label
	var quest_status := main.get_node_or_null("HUD/QuestStatus") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(fenja != null, "Fenja exists")
	_check(marten != null, "Marten exists")
	_check(lene != null, "Lene exists as an interactable NPC")
	_check(fenja_quest != null, "Fenja's quest still exists")
	_check(marten_quest != null, "Marten's quest still exists")
	_check(lene_quest != null, "Lene's quest exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(potion_count != null, "the night potion inventory count exists")
	_check(quest_status != null, "the quest status HUD exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or fenja == null or marten == null or lene == null or fenja_quest == null or marten_quest == null or lene_quest == null or prompt == null or potion_count == null or quest_status == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(str(lene_quest.get("state")) == "not_accepted", "Lene's quest starts unaccepted")
	_check(not quest_status.visible, "the quest HUD stays hidden before Lene's request is accepted")

	await _move_near(player, lene)
	_check(prompt.text.contains("Sprechen"), "Lene does not offer her request before Marten is helped")
	_press_e(player)
	_check(str(lene_quest.get("state")) == "not_accepted", "Lene's request stays unavailable before Marten's quest is complete")
	_check(feedback.text.contains("Marten"), "Lene explains that Marten must be helped first")

	inventory.call("add_item", "calming_tea", 1)
	main.call("_on_fenja_accept_pressed")
	await _move_near(player, fenja)
	_press_e(player)
	_check(str(fenja_quest.get("state")) == "completed", "Fenja's request can still be completed")
	inventory.call("add_item", "strengthening_infusion", 1)
	main.call("_on_marten_accept_pressed")
	await _move_near(player, marten)
	_press_e(player)
	_check(str(marten_quest.get("state")) == "completed", "Marten's request can still be completed")

	await _move_near(player, lene)
	_check(prompt.text.contains("Sprechen"), "Lene directs available requests to the board")
	main.call("_on_lene_accept_pressed")
	_check(str(lene_quest.get("state")) == "active", "accepting Lene's request from the board starts her quest")
	_check(quest_status.visible and quest_status.text == "Sammle eine Schilfwurzel für Lene.", "the HUD guides the first missing ingredient")
	_check(feedback.text.to_lower().contains("nachttrank"), "Lene names the requested night potion")

	inventory.call("add_item", "reed_root", 1)
	_check(quest_status.text == "Trockne die Schilfwurzel für Lene.", "the HUD asks to dry a fresh reed root")
	_check(bool(inventory.call("transfer_item", "reed_root", "dried_reed_root", 1)), "the reed root can be dried")
	_check(quest_status.text == "Sammle Nachtmoos für Lene.", "the HUD advances to the missing night moss")
	inventory.call("add_item", "night_moss", 1)
	_check(quest_status.text == "Trockne das Nachtmoos für Lene.", "the HUD asks to dry fresh night moss")
	_check(bool(inventory.call("transfer_item", "night_moss", "dried_night_moss", 1)), "the night moss can be dried")
	_check(quest_status.text == "Braue den Nachttrank für Lene.", "the HUD asks to brew when both ingredients are ready")

	_press_e(player)
	_check(str(lene_quest.get("state")) == "active", "Lene's request stays active without the potion")
	_check(int(inventory.call("get_count", "night_potion")) == 0, "a failed hand-in does not create or consume a potion")
	_check(feedback.text.to_lower().contains("nachttrank"), "Lene explains which item she still needs")

	inventory.call("add_item", "night_potion", 2)
	_check(potion_count.text == "Nachttrank: 2", "adding potions updates the HUD")
	_check(quest_status.text == "Bringe Lene den Nachttrank.", "the HUD changes to the hand-in objective")
	_press_e(player)
	_check(str(lene_quest.get("state")) == "completed", "giving Lene a potion completes the request")
	_check(int(inventory.call("get_count", "night_potion")) == 1, "Lene receives exactly one potion")
	_check(potion_count.text == "Nachttrank: 1", "the potion HUD shows the remaining item")
	_check(quest_status.visible and quest_status.text.contains("Lenes Bitte"), "the HUD keeps Lene's completion visible")
	_check(feedback.text.contains("Danke"), "Lene thanks the player")
	_check(prompt.text.contains("Sprechen"), "Lene changes to a conversation prompt after completion")

	_press_e(player)
	_check(str(lene_quest.get("state")) == "completed", "Lene's completed request stays complete")
	_check(int(inventory.call("get_count", "night_potion")) == 1, "repeating the interaction consumes no more potions")
	_check(potion_count.text == "Nachttrank: 1", "the potion HUD stays unchanged after repeated interaction")

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
		print("QUEST-003 Lene quest checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("QUEST-003 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
