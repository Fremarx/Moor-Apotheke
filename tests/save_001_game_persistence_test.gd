extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://save_001_test.json"
const SAVED_PLAYER_POSITION := Vector2(272, 148)
const UNSAVED_PLAYER_POSITION := Vector2(110, 96)

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_remove_test_save()
	var main: Node = await _create_main()
	var save_manager := main.get_node_or_null("SaveManager")
	var player := main.get_node_or_null("World/Player") as CharacterBody2D
	var inventory := main.get_node_or_null("Inventory")
	var fenja := main.get_node_or_null("World/TestMap/Fenja")
	var marten := main.get_node_or_null("World/TestMap/Marten")
	var lene := main.get_node_or_null("World/TestMap/Lene")
	var fenja_quest := main.get_node_or_null("Quest/FenjaQuest")
	var marten_quest := main.get_node_or_null("Quest/MartenQuest")
	var lene_quest := main.get_node_or_null("Quest/LeneQuest")
	var mint_pickup := main.get_node_or_null("World/TestMap/Sumpfminze")
	var reed_root_pickup := main.get_node_or_null("World/TestMap/Schilfwurzel")
	var night_moss_pickup := main.get_node_or_null("World/TestMap/Nachtmoos")

	_check(save_manager != null, "the save manager exists")
	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(fenja != null and marten != null and lene != null, "all quest residents exist")
	_check(fenja_quest != null and marten_quest != null and lene_quest != null, "all quest states exist")
	_check(mint_pickup != null and reed_root_pickup != null and night_moss_pickup != null, "persistent herb pickups exist")
	if save_manager == null or player == null or inventory == null or fenja == null or marten == null or lene == null or fenja_quest == null or marten_quest == null or lene_quest == null or mint_pickup == null or reed_root_pickup == null or night_moss_pickup == null:
		main.queue_free()
		await process_frame
		_remove_test_save()
		_finish()
		return

	_check(main.has_method("save_game"), "Main exposes the save action")
	_check(main.has_method("load_game"), "Main exposes the load action")
	_check(_action_uses_key("save_game", KEY_F5), "F5 is bound to saving")
	_check(_action_uses_key("load_game", KEY_F9), "F9 is bound to loading")
	if not main.has_method("save_game") or not main.has_method("load_game"):
		main.queue_free()
		await process_frame
		_remove_test_save()
		_finish()
		return

	_check(not FileAccess.file_exists(TEST_SAVE_PATH), "a new run starts without a test save")
	_check(int(inventory.call("get_count", "coins")) == 0, "a new run starts with an empty wallet")
	_check(str(fenja_quest.get("state")) == "not_accepted", "Fenja starts with an unaccepted request")

	_check(bool(fenja_quest.call("accept")), "Fenja's request can be accepted")
	inventory.call("add_item", "calming_tea", 1)
	fenja.call("interact")
	_check(str(fenja_quest.get("state")) == "completed", "Fenja's request can be completed before saving")

	_check(bool(marten_quest.call("accept")), "Marten's request unlocks after Fenja")
	inventory.call("add_item", "strengthening_infusion", 1)
	marten.call("interact")
	_check(str(marten_quest.get("state")) == "completed", "Marten's request can be completed before saving")

	_check(bool(lene_quest.call("accept")), "Lene's request unlocks after Marten")
	_check(str(lene_quest.get("state")) == "active", "Lene's request can remain active in a save")

	player.position = SAVED_PLAYER_POSITION
	mint_pickup.call("interact")
	reed_root_pickup.call("interact")
	inventory.call("add_item", "sump_mint", 2)
	inventory.call("add_item", "dried_night_moss", 3)
	_check(int(inventory.call("get_count", "coins")) == 15, "the completed requests have awarded fifteen coins")
	_check(not mint_pickup.visible, "the collected mint is hidden before saving")
	_check(not reed_root_pickup.visible, "the collected reed root is hidden before saving")

	var save_action := _action_event("save_game")
	main.call("_unhandled_input", save_action)
	await process_frame
	var written_save: Dictionary = save_manager.call("read_save_data")
	_check(bool(main.call("_is_valid_save_data", written_save)), "the written save passes its own validation")
	var valid_save_data: Dictionary = written_save.duplicate(true)
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label
	_check(FileAccess.file_exists(TEST_SAVE_PATH), "F5 writes a save file")
	_check(feedback != null and feedback.text.contains("gespeichert"), "saving gives visible confirmation")

	player.position = UNSAVED_PLAYER_POSITION
	inventory.call("add_item", "coins", 50)
	night_moss_pickup.call("interact")
	_check(not night_moss_pickup.visible, "the unsaved night moss is collected")
	_check(int(inventory.call("get_count", "night_moss")) == 1, "the unsaved pickup changed inventory")

	main.call("_unhandled_input", _action_event("load_game"))
	await physics_frame
	_check(player.position.is_equal_approx(SAVED_PLAYER_POSITION), "F9 restores the saved player position")
	_check(int(inventory.call("get_count", "coins")) == 15, "F9 discards unsaved wallet changes")
	_check(int(inventory.call("get_count", "sump_mint")) == 3, "F9 restores saved inventory amounts")
	_check(int(inventory.call("get_count", "reed_root")) == 1, "F9 restores another plant's inventory amount")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 3, "F9 restores processed ingredients")
	_check(int(inventory.call("get_count", "night_moss")) == 0, "F9 discards unsaved pickup inventory")
	_check(str(fenja_quest.get("state")) == "completed", "F9 restores Fenja's completed request")
	_check(str(marten_quest.get("state")) == "completed", "F9 restores Marten's completed request")
	_check(str(lene_quest.get("state")) == "active", "F9 restores Lene's active request")
	_check(not mint_pickup.visible, "F9 keeps a saved collected plant hidden")
	_check(not reed_root_pickup.visible, "F9 keeps a second saved plant hidden")
	_check(night_moss_pickup.visible, "F9 restores an unsaved plant to the world")
	_check(feedback != null and feedback.text.contains("geladen"), "loading gives visible confirmation")
	_check(main.get_node("HUD/CoinCount").text == "Münzen: 15", "loading refreshes the coin HUD")

	main.queue_free()
	await process_frame
	var reloaded_main: Node = await _create_main()
	player = reloaded_main.get_node_or_null("World/Player") as CharacterBody2D
	inventory = reloaded_main.get_node_or_null("Inventory")
	mint_pickup = reloaded_main.get_node_or_null("World/TestMap/Sumpfminze")
	reed_root_pickup = reloaded_main.get_node_or_null("World/TestMap/Schilfwurzel")
	night_moss_pickup = reloaded_main.get_node_or_null("World/TestMap/Nachtmoos")
	fenja_quest = reloaded_main.get_node_or_null("Quest/FenjaQuest")
	marten_quest = reloaded_main.get_node_or_null("Quest/MartenQuest")
	lene_quest = reloaded_main.get_node_or_null("Quest/LeneQuest")
	await physics_frame
	_check(player != null and player.position.is_equal_approx(SAVED_PLAYER_POSITION), "the last save loads automatically on startup")
	_check(inventory != null and int(inventory.call("get_count", "coins")) == 15, "startup loading restores currency")
	_check(mint_pickup != null and not mint_pickup.visible, "startup loading restores collected plants")
	_check(reed_root_pickup != null and not reed_root_pickup.visible, "startup loading restores a second collected plant")
	_check(night_moss_pickup != null and night_moss_pickup.visible, "startup loading leaves uncollected plants visible")
	_check(fenja_quest != null and str(fenja_quest.get("state")) == "completed", "startup loading restores Fenja")
	_check(marten_quest != null and str(marten_quest.get("state")) == "completed", "startup loading restores Marten")
	_check(lene_quest != null and str(lene_quest.get("state")) == "active", "startup loading restores Lene")

	if player != null and inventory != null and fenja_quest != null and marten_quest != null and lene_quest != null:
		var loaded_position := player.position
		var loaded_coins := int(inventory.call("get_count", "coins"))
		var loaded_fenja_state := str(fenja_quest.get("state"))
		player.position = UNSAVED_PLAYER_POSITION
		inventory.call("add_item", "coins", 7)
		_remove_test_save()
		_check(not bool(reloaded_main.call("load_game")), "loading without a file reports failure")
		_check(player.position.is_equal_approx(UNSAVED_PLAYER_POSITION), "a missing save leaves position untouched")
		_check(int(inventory.call("get_count", "coins")) == loaded_coins + 7, "a missing save leaves inventory untouched")

		_write_test_save("{ malformed json")
		_check(not bool(reloaded_main.call("load_game")), "malformed JSON is rejected")
		_check(player.position.is_equal_approx(UNSAVED_PLAYER_POSITION), "malformed JSON does not partially restore position")
		_check(int(inventory.call("get_count", "coins")) == loaded_coins + 7, "malformed JSON does not partially restore inventory")

		_write_test_save(JSON.stringify({"version": 999}))
		_check(not bool(reloaded_main.call("load_game")), "unsupported save versions are rejected")
		_check(player.position.is_equal_approx(UNSAVED_PLAYER_POSITION), "unsupported versions leave position untouched")
		_check(int(inventory.call("get_count", "coins")) == loaded_coins + 7, "unsupported versions leave inventory untouched")
		_check(str(fenja_quest.get("state")) == loaded_fenja_state, "unsupported versions leave quest progress untouched")

		var invalid_inventory_save: Dictionary = valid_save_data.duplicate(true)
		invalid_inventory_save["inventory"]["unknown_herb"] = 1
		_write_test_save(JSON.stringify(invalid_inventory_save))
		_check(not bool(reloaded_main.call("load_game")), "unknown inventory IDs are rejected")
		_check(player.position.is_equal_approx(UNSAVED_PLAYER_POSITION), "unknown inventory IDs leave position untouched")
		_check(int(inventory.call("get_count", "coins")) == loaded_coins + 7, "unknown inventory IDs leave inventory untouched")

		var invalid_quest_save: Dictionary = valid_save_data.duplicate(true)
		invalid_quest_save["quests"]["fenja"] = "active"
		_write_test_save(JSON.stringify(invalid_quest_save))
		_check(not bool(reloaded_main.call("load_game")), "inconsistent quest dependencies are rejected")
		_check(str(fenja_quest.get("state")) == loaded_fenja_state, "inconsistent quest dependencies leave quest progress untouched")

	reloaded_main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _create_main() -> Node:
	var main := MAIN_SCENE.instantiate()
	var save_manager := main.get_node_or_null("SaveManager")
	if save_manager != null:
		save_manager.set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame
	return main


func _action_event(action_name: String) -> InputEventAction:
	var event := InputEventAction.new()
	event.action = action_name
	event.pressed = true
	event.strength = 1.0
	return event


func _action_uses_key(action_name: String, expected_key: Key) -> bool:
	if not InputMap.has_action(action_name):
		return false
	for event in InputMap.action_get_events(action_name):
		if event is InputEventKey and event.physical_keycode == expected_key:
			return true
	return false


func _write_test_save(contents: String) -> void:
	var file := FileAccess.open(TEST_SAVE_PATH, FileAccess.WRITE)
	if file == null:
		_check(false, "the test can write a temporary save file")
		return
	file.store_string(contents)
	file.close()


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("SAVE-001 persistence checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("SAVE-001 check failed: " + failure)
	quit(1)
