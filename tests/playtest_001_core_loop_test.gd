extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://resource_001_test_save.json"

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

	var player := main.get_node_or_null("World/Player") as CharacterBody2D
	var inventory := main.get_node_or_null("Inventory")
	var board := main.get_node_or_null("World/TestMap/QuestBoard") as Area2D
	var mint := main.get_node_or_null("World/TestMap/Sumpfminze") as Area2D
	var southern_mint := main.get_node_or_null("World/TestMap/SumpfminzeSued") as Area2D
	var reed_root := main.get_node_or_null("World/TestMap/Schilfwurzel") as Area2D
	var southeastern_reed_root := main.get_node_or_null("World/TestMap/SchilfwurzelSuedost") as Area2D
	var night_moss := main.get_node_or_null("World/TestMap/Nachtmoos") as Area2D
	var rack := main.get_node_or_null("World/TestMap/Trockengestell") as Area2D
	var cauldron := main.get_node_or_null("World/TestMap/Braukessel") as Area2D
	var fenja := main.get_node_or_null("World/TestMap/Fenja") as Area2D
	var marten := main.get_node_or_null("World/TestMap/Marten") as Area2D
	var lene := main.get_node_or_null("World/TestMap/Lene") as Area2D
	var fenja_quest := main.get_node_or_null("Quest/FenjaQuest")
	var marten_quest := main.get_node_or_null("Quest/MartenQuest")
	var lene_quest := main.get_node_or_null("Quest/LeneQuest")
	var board_panel := main.get_node_or_null("HUD/QuestBoardPanel") as Control
	var inventory_panel := main.get_node_or_null("HUD/InventoryWindowPanel") as PanelContainer
	var fenja_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/FenjaRow/AcceptButton") as Button
	var marten_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/MartenRow/AcceptButton") as Button
	var lene_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/LeneRow/AcceptButton") as Button
	var board_close_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/CloseButton") as Button
	var quest_status := main.get_node_or_null("HUD/QuestStatus") as Label
	var coin_hud := main.get_node_or_null("HUD/CoinCount") as Label

	_check(save_manager != null, "the save manager exists")
	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(board != null, "the quest board exists")
	_check(mint != null and southern_mint != null, "both mint pickups exist")
	_check(reed_root != null and southeastern_reed_root != null, "both reed-root pickups exist")
	_check(night_moss != null, "the night-moss pickup exists")
	_check(rack != null and cauldron != null, "both processing stations exist")
	_check(fenja != null and marten != null and lene != null, "all quest residents exist")
	_check(fenja_quest != null and marten_quest != null and lene_quest != null, "all quest states exist")
	_check(board_panel != null and inventory_panel != null, "both modal panels exist")
	_check(fenja_button != null and marten_button != null and lene_button != null and board_close_button != null, "the quest board actions exist")
	_check(quest_status != null and coin_hud != null, "quest and coin HUD labels exist")
	if save_manager == null or player == null or inventory == null or board == null or mint == null or southern_mint == null or reed_root == null or southeastern_reed_root == null or night_moss == null or rack == null or cauldron == null or fenja == null or marten == null or lene == null or fenja_quest == null or marten_quest == null or lene_quest == null or board_panel == null or inventory_panel == null or fenja_button == null or marten_button == null or lene_button == null or board_close_button == null or quest_status == null or coin_hud == null:
		main.queue_free()
		await process_frame
		_remove_test_save()
		_finish()
		return

	_check(int(inventory.call("get_count", "coins")) == 0, "the isolated playthrough starts with no coins")
	_check(str(fenja_quest.get("state")) == "not_accepted", "Fenja's request starts unaccepted")
	var mint_patch_count := _pickup_count(main, "sump_mint")
	var reed_root_patch_count := _pickup_count(main, "reed_root")
	var night_moss_patch_count := _pickup_count(main, "night_moss")
	_check(mint_patch_count == 3, "three mint patches are available across both areas")
	_check(reed_root_patch_count == 3, "three reed-root patches are available across both areas")
	_check(night_moss_patch_count == 2, "two night-moss patches are available across both areas")
	var pickup_ids: Dictionary = {}
	var total_pickups := 0
	for pickup in main.get_tree().get_nodes_in_group("item_pickups"):
		var pickup_id := str(pickup.get("pickup_id"))
		_check(not pickup_id.is_empty(), "each pickup has a persistent ID")
		_check(not pickup_ids.has(pickup_id), "pickup ID is unique: %s" % pickup_id)
		pickup_ids[pickup_id] = true
		total_pickups += 1
	_check(pickup_ids.size() == total_pickups, "all map pickups use distinct persistent IDs")
	print("RESOURCE-001 pickup audit: %d Sumpfminze, %d Schilfwurzel, %d Nachtmoos; %d unique IDs." % [mint_patch_count, reed_root_patch_count, night_moss_patch_count, pickup_ids.size()])

	await _accept_quest(player, board, fenja_button, board_panel, board_close_button, fenja_quest, "Fenja")
	_check(quest_status.text == "Sammle eine Sumpfminze.", "Fenja's objective begins with collecting mint")
	await _collect(player, mint, inventory, "sump_mint", 1)
	_check(quest_status.text == "Trockne die Sumpfminze.", "Fenja's objective advances to drying")
	await _process_at(player, rack)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "drying consumes Fenja's fresh mint")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "drying creates one dried mint")
	_check(quest_status.text == "Braue Beruhigungstee.", "Fenja's objective advances to brewing")
	await _process_at(player, cauldron)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "brewing consumes the dried mint")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "brewing creates one calming tea")
	_check(quest_status.text == "Bringe Fenja den Beruhigungstee.", "Fenja's objective advances to the hand-in")
	await _deliver(player, fenja, fenja_quest, inventory, "calming_tea", 5, "Fenja")
	_check(quest_status.text == "Aufgabe erfüllt: Fenjas Bitte.", "Fenja's completed objective remains visible")

	await _accept_quest(player, board, marten_button, board_panel, board_close_button, marten_quest, "Marten")
	_check(quest_status.text == "Sammle eine Sumpfminze für Marten.", "Marten's objective begins with mint")
	await _collect(player, southern_mint, inventory, "sump_mint", 1)
	_check(quest_status.text == "Trockne die Sumpfminze für Marten.", "Marten's objective advances to drying mint")
	await _process_at(player, rack)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "the second mint is dried for Marten")
	await _collect(player, reed_root, inventory, "reed_root", 1)
	_check(quest_status.text == "Trockne die Schilfwurzel für Marten.", "Marten's objective advances to drying reed root")
	await _process_at(player, rack)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 1, "the first reed root is dried for Marten")
	_check(quest_status.text == "Braue den Stärkenden Aufguss für Marten.", "Marten's objective advances to brewing")
	await _process_at(player, cauldron)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0 and int(inventory.call("get_count", "dried_reed_root")) == 0, "brewing consumes both infusion ingredients")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 1, "brewing creates one strengthening infusion")
	_check(quest_status.text == "Bringe Marten den Stärkenden Aufguss.", "Marten's objective advances to the hand-in")
	await _deliver(player, marten, marten_quest, inventory, "strengthening_infusion", 15, "Marten")
	_check(quest_status.text == "Aufgabe erfüllt: Martens Bitte.", "Marten's completed objective remains visible")

	await _accept_quest(player, board, lene_button, board_panel, board_close_button, lene_quest, "Lene")
	_check(quest_status.text == "Sammle eine Schilfwurzel für Lene.", "Lene's objective begins with reed root")
	await _collect(player, southeastern_reed_root, inventory, "reed_root", 1)
	_check(quest_status.text == "Trockne die Schilfwurzel für Lene.", "Lene's objective advances to drying reed root")
	await _process_at(player, rack)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 1, "the second reed root is dried for Lene")
	await _collect(player, night_moss, inventory, "night_moss", 1)
	_check(quest_status.text == "Trockne das Nachtmoos für Lene.", "Lene's objective advances to drying night moss")
	await _process_at(player, rack)
	_check(int(inventory.call("get_count", "dried_night_moss")) == 1, "the night moss is dried for Lene")
	_check(quest_status.text == "Braue den Nachttrank für Lene.", "Lene's objective advances to brewing")
	await _process_at(player, cauldron)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 0 and int(inventory.call("get_count", "dried_night_moss")) == 0, "brewing consumes both night-potion ingredients")
	_check(int(inventory.call("get_count", "night_potion")) == 1, "brewing creates one night potion")
	_check(quest_status.text == "Bringe Lene den Nachttrank.", "Lene's objective advances to the hand-in")
	await _deliver(player, lene, lene_quest, inventory, "night_potion", 30, "Lene")
	_check(str(fenja_quest.get("state")) == "completed", "Fenja's request is complete")
	_check(str(marten_quest.get("state")) == "completed", "Marten's request is complete")
	_check(str(lene_quest.get("state")) == "completed", "Lene's request is complete")
	_check(int(inventory.call("get_count", "coins")) == 30, "the full quest chain awards thirty coins")
	_check(coin_hud.text == "Münzen: 30", "the coin HUD reflects all three rewards")
	_check(quest_status.text == "Aufgabe erfüllt: Lenes Bitte.", "the last completed objective remains visible")
	for item_id in ["sump_mint", "dried_sump_mint", "reed_root", "dried_reed_root", "night_moss", "dried_night_moss", "calming_tea", "strengthening_infusion", "night_potion"]:
		_check(int(inventory.call("get_count", item_id)) == 0, "the completed chain leaves no %s behind" % item_id)
	_check(not mint.visible and not southern_mint.visible, "both mint patches are collected once")
	_check(not reed_root.visible and not southeastern_reed_root.visible, "both reed-root patches are collected once")
	_check(not night_moss.visible, "the night-moss patch is collected once")

	_press_i(main)
	await process_frame
	_check(inventory_panel.visible, "I opens the inventory after the full quest chain")
	_check(_count_text(inventory_panel, "sump_mint") == "0", "the inventory shows no fresh mint left")
	_check(_count_text(inventory_panel, "reed_root") == "0", "the inventory shows no fresh reed root left")
	_check(_count_text(inventory_panel, "night_moss") == "0", "the inventory shows no fresh night moss left")
	_check(_count_text(inventory_panel, "calming_tea") == "0", "the inventory shows no tea left after hand-in")
	_check(_count_text(inventory_panel, "strengthening_infusion") == "0", "the inventory shows no infusion left after hand-in")
	_check(_count_text(inventory_panel, "night_potion") == "0", "the inventory shows no night potion left after hand-in")
	_check(_count_text(inventory_panel, "coins") == "30", "the inventory shows the thirty-coin reward")
	if not _capture_path.is_empty():
		await RenderingServer.frame_post_draw
		var preview := root.get_texture().get_image()
		var save_error := preview.save_png(_capture_path)
		_check(save_error == OK, "the visible viewport preview saves successfully")
		print("RESOURCE-001 viewport preview: %s (%d x %d)" % [_capture_path, preview.get_width(), preview.get_height()])

	var cancel := InputEventAction.new()
	cancel.action = "ui_cancel"
	cancel.pressed = true
	main.call("_unhandled_input", cancel)
	_check(not inventory_panel.visible and player.is_physics_processing(), "Escape closes the inventory and restores movement")

	main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _accept_quest(player: CharacterBody2D, board: Area2D, accept_button: Button, board_panel: Control, close_button: Button, quest: Node, resident_name: String) -> void:
	await _move_near(player, board)
	_press_e(player)
	_check(board_panel.visible, "the board opens for %s's request" % resident_name)
	_check(not accept_button.disabled, "%s's request is available on the board" % resident_name)
	accept_button.emit_signal("pressed")
	_check(str(quest.get("state")) == "active", "the board accepts %s's request" % resident_name)
	close_button.emit_signal("pressed")
	_check(not board_panel.visible and player.is_physics_processing(), "closing the board restores movement")


func _collect(player: CharacterBody2D, pickup: Area2D, inventory: Node, item_id: String, expected_count: int) -> void:
	await _move_near(player, pickup)
	_check(player.call("get_current_interactable") == pickup, "%s becomes the selected nearby pickup" % pickup.name)
	_press_e(player)
	_check(int(inventory.call("get_count", item_id)) == expected_count, "collecting %s adds the expected amount" % pickup.name)
	_check(not pickup.visible, "collected %s disappears from the map" % pickup.name)


func _process_at(player: CharacterBody2D, station: Area2D) -> void:
	await _move_near(player, station)
	_check(player.call("get_current_interactable") == station, "%s becomes the selected nearby station" % station.name)
	_press_e(player)


func _deliver(player: CharacterBody2D, resident: Area2D, quest: Node, inventory: Node, item_id: String, expected_coins: int, resident_name: String) -> void:
	await _move_near(player, resident)
	_check(player.call("get_current_interactable") == resident, "%s becomes the selected nearby resident" % resident_name)
	_press_e(player)
	_check(str(quest.get("state")) == "completed", "giving the requested item completes %s's request" % resident_name)
	_check(int(inventory.call("get_count", item_id)) == 0, "the %s hand-in consumes its item" % resident_name)
	_check(int(inventory.call("get_count", "coins")) == expected_coins, "the completed chain awards %d coins after %s" % [expected_coins, resident_name])


func _move_near(player: CharacterBody2D, target: Node2D) -> void:
	var movement_axes := [false, true] if target.name == "Trockengestell" else [true, false]
	for horizontal in movement_axes:
		var steps := 0
		while steps < 600:
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
		_check(steps < 600, "the player can walk to %s without getting stuck" % target.name)
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
		print("RESOURCE-001 full quest-chain checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("RESOURCE-001 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
