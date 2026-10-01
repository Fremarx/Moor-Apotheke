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
	var board_panel := main.get_node_or_null("HUD/QuestBoardPanel") as Control
	var panel := main.get_node_or_null("HUD/InventoryWindowPanel") as PanelContainer
	var dim := main.get_node_or_null("HUD/InventoryDim") as ColorRect
	var close_button := main.get_node_or_null("HUD/InventoryWindowPanel/Content/Header/CloseButton") as Button
	var persistent_inventory_panel := main.get_node_or_null("HUD/InventoryPanelBackground") as Panel
	var persistent_mint_count := main.get_node_or_null("HUD/InventoryCount") as Label
	var coins_hud := main.get_node_or_null("HUD/CoinCount") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(board_panel != null, "the quest board panel exists")
	_check(panel != null, "the inventory window exists")
	_check(dim != null, "the modal backdrop exists")
	_check(close_button != null, "the inventory close button exists")
	_check(persistent_inventory_panel != null and persistent_mint_count != null, "legacy inventory HUD nodes remain available")
	_check(coins_hud != null and coins_hud.visible, "the coin total remains visible in the HUD")
	if player == null or inventory == null or board_panel == null or panel == null or dim == null or close_button == null or persistent_inventory_panel == null or persistent_mint_count == null or coins_hud == null:
		main.queue_free()
		_finish()
		return

	_check(not panel.visible and not dim.visible, "the inventory window starts closed")
	_check(not persistent_inventory_panel.visible and not persistent_mint_count.visible, "item counts are hidden from the persistent HUD")
	_check(InputMap.has_action("toggle_inventory"), "the inventory action is registered")
	_check(_action_uses_key("toggle_inventory", KEY_I), "I is bound to the inventory action")

	var item_ids := [
		"sump_mint",
		"reed_root",
		"night_moss",
		"dried_sump_mint",
		"dried_reed_root",
		"dried_night_moss",
		"calming_tea",
		"strengthening_infusion",
		"night_potion",
		"coins",
	]
	var count_labels: Dictionary = {}
	for item_id in item_ids:
		var count_label := panel.find_child("Count_%s" % item_id, true, false) as Label
		_check(count_label != null, "%s has a row in the inventory window" % item_id)
		if count_label != null:
			count_labels[item_id] = count_label
	_check(count_labels.size() == 10, "the window lists all ten inventory items")
	_check(panel.get_theme_stylebox("panel") is StyleBoxFlat, "the panel uses the existing moor-themed style")

	inventory.call("restore_from_save", {})
	inventory.call("add_item", "sump_mint", 2)
	inventory.call("add_item", "dried_night_moss", 3)
	inventory.call("add_item", "night_potion", 1)
	inventory.call("add_item", "coins", 9)
	_check(count_labels["sump_mint"].text == "2", "fresh stock updates in the window")
	_check(count_labels["dried_night_moss"].text == "3", "dried stock updates in the window")
	_check(count_labels["night_potion"].text == "1", "remedy stock updates in the window")
	_check(count_labels["coins"].text == "9", "the window shows the current coin total")

	_press_i(main)
	await process_frame
	_check(panel.visible and dim.visible, "I opens the inventory over a dimmed world")
	_check(close_button.has_focus(), "focus moves to the inventory close button")
	_check(not player.is_physics_processing(), "player movement pauses while the inventory is open")
	_check(not player.is_processing_unhandled_input(), "world interactions pause while the inventory is open")
	_check(not board_panel.visible, "opening inventory does not open the quest board")
	var panel_rect := panel.get_global_rect()
	_check(panel_rect.position.x >= 0 and panel_rect.end.x <= 480, "the inventory window fits the viewport horizontally")
	_check(panel_rect.position.y >= 0 and panel_rect.end.y <= 270, "the inventory window fits the viewport vertically")

	_press_i(main)
	_check(not panel.visible and not dim.visible, "I closes the inventory")
	_check(player.is_physics_processing() and player.is_processing_unhandled_input(), "closing the inventory restores player control")

	_press_i(main)
	var cancel := InputEventAction.new()
	cancel.action = "ui_cancel"
	cancel.pressed = true
	main.call("_unhandled_input", cancel)
	_check(not panel.visible and not dim.visible, "Escape closes the inventory")

	var board := main.get_node_or_null("World/TestMap/QuestBoard") as Area2D
	if board != null:
		await _move_near(player, board)
		_press_e(player)
		_check(board_panel.visible, "the quest board still opens independently")
		_press_i(main)
		_check(board_panel.visible and not panel.visible, "I cannot stack inventory over the quest board")
		main.call("_unhandled_input", cancel)
		_check(not board_panel.visible and not panel.visible, "Escape closes the quest board without opening inventory")
	else:
		_check(false, "the quest board exists for the modal overlap check")

	_press_i(main)
	close_button.emit_signal("pressed")
	_check(not panel.visible and player.is_physics_processing(), "the close button restores player movement")

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


func _press_i(main: Node) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = KEY_I
	event.pressed = true
	main.call("_unhandled_input", event)


func _action_uses_key(action_name: StringName, expected_key: Key) -> bool:
	if not InputMap.has_action(action_name):
		return false
	for event in InputMap.action_get_events(action_name):
		if event is InputEventKey and event.physical_keycode == expected_key:
			return true
	return false


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("INV-001 inventory window checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("INV-001 check failed: " + failure)
	quit(1)