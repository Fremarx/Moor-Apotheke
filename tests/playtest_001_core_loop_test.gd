extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://playtest_001_test_save.json"

var _failures: Array[String] = []
var _capture_path := ""


func _initialize() -> void:
	var user_args := OS.get_cmdline_user_args()
	if not user_args.is_empty():
		_capture_path = str(user_args[0])
	call_deferred("_run")


func _run() -> void:
	_remove_test_save()
	var main := MAIN_SCENE.instantiate()
	var save_manager := main.get_node_or_null("SaveManager")
	if save_manager != null:
		save_manager.set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame

	var player := main.get_node_or_null("World/Player")
	var inventory := main.get_node_or_null("Inventory")
	var board := main.get_node_or_null("World/TestMap/QuestBoard") as Area2D
	var mint := main.get_node_or_null("World/TestMap/Sumpfminze") as Area2D
	var rack := main.get_node_or_null("World/TestMap/Trockengestell") as Area2D
	var cauldron := main.get_node_or_null("World/TestMap/Braukessel") as Area2D
	var fenja := main.get_node_or_null("World/TestMap/Fenja") as Area2D
	var quest := main.get_node_or_null("Quest/FenjaQuest")
	var board_panel := main.get_node_or_null("HUD/QuestBoardPanel") as Control
	var inventory_panel := main.get_node_or_null("HUD/InventoryWindowPanel") as PanelContainer
	var fenja_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/FenjaRow/AcceptButton") as Button
	var board_close_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/CloseButton") as Button
	var quest_status := main.get_node_or_null("HUD/QuestStatus") as Label
	var coin_hud := main.get_node_or_null("HUD/CoinCount") as Label

	_check(save_manager != null, "the save manager exists")
	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(board != null, "the quest board exists")
	_check(mint != null, "the mint pickup exists")
	_check(rack != null, "the drying rack exists")
	_check(cauldron != null, "the brewing cauldron exists")
	_check(fenja != null, "Fenja exists")
	_check(quest != null, "Fenja's quest exists")
	_check(board_panel != null and inventory_panel != null, "both modal panels exist")
	_check(fenja_button != null and board_close_button != null, "the quest board actions exist")
	_check(quest_status != null and coin_hud != null, "quest and coin HUD labels exist")
	if save_manager == null or player == null or inventory == null or board == null or mint == null or rack == null or cauldron == null or fenja == null or quest == null or board_panel == null or inventory_panel == null or fenja_button == null or board_close_button == null or quest_status == null or coin_hud == null:
		main.queue_free()
		await process_frame
		_remove_test_save()
		_finish()
		return

	_check(int(inventory.call("get_count", "coins")) == 0, "the isolated playthrough starts with no coins")
	_check(str(quest.get("state")) == "not_accepted", "Fenja's request starts unaccepted")
	var mint_patch_count := _pickup_count(main, "sump_mint")
	var reed_root_patch_count := _pickup_count(main, "reed_root")
	var night_moss_patch_count := _pickup_count(main, "night_moss")
	print("PLAYTEST-001 one-time pickup audit: %d Sumpfminze, %d Schilfwurzel, %d Nachtmoos." % [mint_patch_count, reed_root_patch_count, night_moss_patch_count])

	await _move_near(player, board)
	_press_e(player)
	_check(board_panel.visible, "interacting with the board opens the request list")
	_check(not fenja_button.disabled, "Fenja's request is available")
	fenja_button.emit_signal("pressed")
	_check(str(quest.get("state")) == "active", "the board accepts Fenja's request")
	_check(quest_status.text == "Sammle eine Sumpfminze.", "the objective begins with collecting mint")
	board_close_button.emit_signal("pressed")
	_check(not board_panel.visible and player.is_physics_processing(), "closing the board restores movement")

	await _move_near(player, mint)
	_check(player.call("get_current_interactable") == mint, "the mint becomes the selected nearby interaction")
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "collecting mint adds one fresh ingredient")
	_check(not mint.visible, "the collected mint disappears from the map")
	_check(quest_status.text == "Trockne die Sumpfminze.", "the objective advances to drying")

	await _move_near(player, rack)
	_check(player.call("get_current_interactable") == rack, "the drying rack becomes the selected nearby interaction")
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "drying consumes the fresh ingredient")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "drying creates one dried ingredient")
	_check(quest_status.text == "Braue Beruhigungstee.", "the objective advances to brewing")

	await _move_near(player, cauldron)
	_check(player.call("get_current_interactable") == cauldron, "the cauldron becomes the selected nearby interaction")
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "brewing consumes the dried mint")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "brewing creates one calming tea")
	_check(quest_status.text == "Bringe Fenja den Beruhigungstee.", "the objective advances to the hand-in")

	await _move_near(player, fenja)
	_check(player.call("get_current_interactable") == fenja, "Fenja becomes the selected nearby interaction")
	_press_e(player)
	_check(str(quest.get("state")) == "completed", "giving Fenja the tea completes the request")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "the hand-in consumes exactly one tea")
	_check(int(inventory.call("get_count", "coins")) == 5, "the completed request awards five coins")
	_check(coin_hud.text == "Münzen: 5", "the coin HUD reflects the reward")
	_check(quest_status.text == "Aufgabe erfüllt: Fenjas Bitte.", "the HUD keeps the completed objective visible")

	_press_i(main)
	await process_frame
	_check(inventory_panel.visible, "I opens the inventory after the quest")
	_check(_count_text(inventory_panel, "sump_mint") == "0", "the inventory shows no fresh mint left")
	_check(_count_text(inventory_panel, "dried_sump_mint") == "0", "the inventory shows no dried mint left")
	_check(_count_text(inventory_panel, "calming_tea") == "0", "the inventory shows no tea left after hand-in")
	_check(_count_text(inventory_panel, "coins") == "5", "the inventory shows the five-coin reward")
	if not _capture_path.is_empty():
		await RenderingServer.frame_post_draw
		var preview := root.get_texture().get_image()
		var save_error := preview.save_png(_capture_path)
		_check(save_error == OK, "the visible viewport preview saves successfully")
		print("PLAYTEST-001 viewport preview: %s (%d x %d)" % [_capture_path, preview.get_width(), preview.get_height()])

	var cancel := InputEventAction.new()
	cancel.action = "ui_cancel"
	cancel.pressed = true
	main.call("_unhandled_input", cancel)
	_check(not inventory_panel.visible and player.is_physics_processing(), "Escape closes the inventory and restores movement")

	main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _move_near(player: CharacterBody2D, target: Node2D) -> void:
	for horizontal in [true, false]:
		var steps := 0
		while steps < 300:
			var delta := target.global_position - player.global_position
			var axis_delta := delta.x if horizontal else delta.y
			if absf(axis_delta) <= 18.0:
				break
			var action := "move_right" if axis_delta > 0.0 else "move_left"
			if not horizontal:
				action = "move_down" if axis_delta > 0.0 else "move_up"
			Input.action_press(action)
			await physics_frame
			Input.action_release(action)
			steps += 1
		_check(steps < 300, "the player can walk to %s without getting stuck" % target.name)
		await physics_frame


func _press_e(player: Node) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = KEY_E
	event.pressed = true
	player.call("_unhandled_input", event)


func _press_i(main: Node) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = KEY_I
	event.pressed = true
	main.call("_unhandled_input", event)


func _count_text(panel: Control, item_id: String) -> String:
	var label := panel.find_child("Count_%s" % item_id, true, false) as Label
	if label == null:
		_check(false, "the inventory contains %s" % item_id)
		return ""
	return label.text


func _pickup_count(main: Node, item_id: String) -> int:
	var count := 0
	for pickup in main.get_tree().get_nodes_in_group("item_pickups"):
		if str(pickup.get("item_id")) == item_id:
			count += 1
	return count


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("PLAYTEST-001 core loop checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("PLAYTEST-001 check failed: " + failure)
	quit(1)