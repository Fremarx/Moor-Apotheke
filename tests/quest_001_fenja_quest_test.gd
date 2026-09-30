extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const INVENTORY_SCRIPT: Script = preload("res://scripts/inventory.gd")

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
	var fenja := main.get_node_or_null("World/TestMap/Fenja")
	var quest := main.get_node_or_null("Quest/FenjaQuest")
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var tea_count := main.get_node_or_null("HUD/TeaCount") as Label
	var quest_status := main.get_node_or_null("HUD/QuestStatus") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(fenja != null, "Fenja exists as an interactable NPC")
	_check(quest != null, "Fenja's quest state exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(tea_count != null, "the calming tea inventory count exists")
	_check(quest_status != null, "the quest status HUD exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or fenja == null or quest == null or prompt == null or tea_count == null or quest_status == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(str(quest.get("state")) == "not_accepted", "Fenja's quest starts unaccepted")
	_check(not quest_status.visible, "the quest HUD stays hidden before acceptance")

	await _move_near(player, fenja)
	_check(prompt.text.contains("Annehmen"), "Fenja offers her request")
	_press_e(player)
	_check(str(quest.get("state")) == "active", "interacting with Fenja accepts her request")
	_check(quest_status.visible, "accepting the request shows the quest HUD")
	_check(quest_status.text.contains("Beruhigungstee"), "the active quest names the needed tea")
	_check(feedback.text.contains("Beruhigungstee"), "Fenja confirms the request")
	_check(prompt.text.contains("Abgeben"), "Fenja offers tea hand-in after acceptance")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "accepting the quest consumes no tea")

	_press_e(player)
	_check(str(quest.get("state")) == "active", "the quest stays active when no tea is available")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "a failed hand-in leaves the tea count unchanged")
	_check(feedback.text.contains("Beruhigungstee"), "Fenja explains that she still needs the tea")

	inventory.call("add_item", "calming_tea", 2)
	_check(tea_count.text == "Beruhigungstee: 2", "adding tea updates its HUD count")
	_press_e(player)
	_check(str(quest.get("state")) == "completed", "giving Fenja tea completes the quest")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "handing in tea consumes exactly one item")
	_check(tea_count.text == "Beruhigungstee: 1", "the tea HUD shows the remaining item")
	_check(quest_status.visible and quest_status.text.contains("erfüllt"), "the quest HUD keeps the completion visible")
	_check(feedback.text.contains("Danke"), "Fenja thanks the player for the tea")
	_check(prompt.text.contains("Sprechen"), "Fenja changes to a conversation prompt after completion")

	_press_e(player)
	_check(str(quest.get("state")) == "completed", "the completed quest remains completed")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "repeating the interaction consumes no extra tea")
	_check(tea_count.text == "Beruhigungstee: 1", "the tea HUD remains unchanged after repeated interaction")

	_check_remove_item_contract()

	main.queue_free()
	_finish()


func _check_remove_item_contract() -> void:
	var test_inventory := INVENTORY_SCRIPT.new() as Node
	_check(test_inventory.has_method("remove_item"), "inventory exposes remove_item")
	if not test_inventory.has_method("remove_item"):
		test_inventory.free()
		return

	_check(not bool(test_inventory.call("remove_item", "calming_tea", 1)), "removing a missing item fails")
	_check(int(test_inventory.call("get_count", "calming_tea")) == 0, "failed removal does not create a negative or missing count")
	test_inventory.call("add_item", "calming_tea", 1)
	_check(not bool(test_inventory.call("remove_item", "calming_tea", 2)), "removing more than the available count fails")
	_check(int(test_inventory.call("get_count", "calming_tea")) == 1, "insufficient removal leaves the inventory unchanged")
	_check(not bool(test_inventory.call("remove_item", "", 1)), "removing an invalid item id fails")
	_check(not bool(test_inventory.call("remove_item", "calming_tea", 0)), "removing an invalid amount fails")
	_check(bool(test_inventory.call("remove_item", "calming_tea", 1)), "removing an available item succeeds")
	_check(int(test_inventory.call("get_count", "calming_tea")) == 0, "successful removal updates the inventory count")
	test_inventory.free()


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
		print("QUEST-001 Fenja quest checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("QUEST-001 check failed: " + failure)
	quit(1)
