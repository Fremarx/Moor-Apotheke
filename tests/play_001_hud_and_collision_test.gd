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

	var player := main.get_node("World/Player") as CharacterBody2D
	var camera := player.get_node_or_null("Camera2D") as Camera2D
	var hud := main.get_node("HUD") as CanvasLayer
	var top_bar := hud.get_node_or_null("TopBarBackground") as Panel
	var inventory_panel := hud.get_node_or_null("InventoryPanelBackground") as Panel
	var controls := hud.get_node_or_null("ControlsHint") as Label
	var coin_count := hud.get_node_or_null("CoinCount") as Label
	var inventory_count := hud.get_node_or_null("InventoryCount") as Label
	var quest_status := hud.get_node_or_null("QuestStatus") as Label
	var feedback := hud.get_node_or_null("InteractionFeedback") as Label
	var prompt := hud.get_node_or_null("InteractionPrompt") as Label

	_check(player != null, "the player is available in the running scene")
	_check(camera != null and camera.enabled, "the player camera is active")
	_check(_action_uses_key("move_left", KEY_A) and _action_uses_key("move_left", KEY_LEFT), "A and Left Arrow are mapped to moving left")
	_check(_action_uses_key("move_right", KEY_D) and _action_uses_key("move_right", KEY_RIGHT), "D and Right Arrow are mapped to moving right")
	_check(_action_uses_key("move_up", KEY_W) and _action_uses_key("move_up", KEY_UP), "W and Up Arrow are mapped to moving up")
	_check(_action_uses_key("move_down", KEY_S) and _action_uses_key("move_down", KEY_DOWN), "S and Down Arrow are mapped to moving down")
	_check(top_bar != null, "the HUD has a top-bar backing panel")
	_check(inventory_panel != null, "the inventory has a backing panel")
	_check(controls != null and coin_count != null, "the top-bar labels exist")
	_check(inventory_count != null and quest_status != null, "the inventory and quest labels exist")
	_check(feedback != null and prompt != null, "interaction feedback and prompt labels exist")

	if top_bar == null or inventory_panel == null or controls == null or coin_count == null or inventory_count == null or quest_status == null or feedback == null or prompt == null:
		main.queue_free()
		await process_frame
		_finish()
		return

	_check(top_bar.get_index() < controls.get_index(), "the top bar is drawn behind its text")
	_check(top_bar.get_index() < coin_count.get_index(), "the top bar is drawn behind the coin count")
	_check(inventory_panel.get_index() < inventory_count.get_index(), "the inventory panel is drawn behind its counters")
	_check(inventory_panel.get_index() < quest_status.get_index(), "the inventory panel extends behind quest guidance")
	_check(top_bar.mouse_filter == Control.MOUSE_FILTER_IGNORE, "the top bar does not intercept input")
	_check(inventory_panel.mouse_filter == Control.MOUSE_FILTER_IGNORE, "the inventory panel does not intercept input")
	_check(_is_readable_surface(top_bar.get_theme_stylebox("panel")), "the top bar has a dark translucent surface and one-pixel outline")
	_check(_is_readable_surface(inventory_panel.get_theme_stylebox("panel")), "the inventory has a dark translucent surface and one-pixel outline")
	_check(_is_readable_surface(feedback.get_theme_stylebox("normal")), "interaction feedback has a contrast surface")
	_check(_is_readable_surface(prompt.get_theme_stylebox("normal")), "interaction prompts have a contrast surface")

	var start_position := player.global_position
	await _press_action("move_right", 6)
	_check(player.global_position.x > start_position.x, "right input moves the player")
	await _press_action("move_left", 6)
	_check(player.global_position.x < start_position.x + 1.0, "left input moves the player back")
	await _press_action("move_up", 6)
	_check(player.global_position.y < start_position.y, "up input moves the player")
	await _press_action("move_down", 6)
	_check(player.global_position.y < start_position.y + 1.0, "down input moves the player back")

	player.global_position = Vector2(410, 50)
	await _press_action("move_right", 30)
	_check(player.global_position.x < 429.0, "the player cannot pass through the pond boundary")
	player.global_position = Vector2(120, 119)
	await _press_action("move_right", 30)
	_check(player.global_position.x < 134.0, "the player cannot pass through a solid boulder")

	player.global_position = Vector2(24, 200)
	await _press_action("move_left", 30)
	_check(player.global_position.x >= 16.0, "the player cannot pass through the map boundary")

	main.queue_free()
	await process_frame
	_finish()


func _action_uses_key(action_name: StringName, expected_key: Key) -> bool:
	if not InputMap.has_action(action_name):
		return false
	for event in InputMap.action_get_events(action_name):
		if event is InputEventKey and event.physical_keycode == expected_key:
			return true
	return false

func _press_action(action_name: StringName, frame_count: int) -> void:
	Input.action_press(action_name)
	for frame in range(frame_count):
		await physics_frame
	Input.action_release(action_name)
	await physics_frame


func _is_readable_surface(value: StyleBox) -> bool:
	var style := value as StyleBoxFlat
	return (
		style != null
		and style.bg_color.a >= 0.85
		and style.border_width_left == 1
		and style.border_width_top == 1
		and style.border_width_right == 1
		and style.border_width_bottom == 1
	)


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("PLAY-001 HUD and collision checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("PLAY-001 check failed: " + failure)
	quit(1)
