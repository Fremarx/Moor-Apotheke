extends SceneTree

const PLAYER_SCENE: PackedScene = preload("res://scenes/player/player.tscn")

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var player := PLAYER_SCENE.instantiate()
	root.add_child(player)
	await physics_frame

	var visual := player.get_node_or_null("Visual") as Sprite2D
	_check(visual != null, "the player has a directional sprite")
	if visual == null:
		_finish()
		return

	_check(visual.texture != null, "the four-direction atlas is loaded")
	_check(visual.hframes == 2 and visual.vframes == 2, "the atlas is divided into four directional frames")
	_check(visual.frame_coords == Vector2i(0, 0), "the player starts facing down")

	await _press_direction("move_left", visual, Vector2i(1, 0), "left movement selects the left profile")
	await _press_direction("move_up", visual, Vector2i(0, 1), "up movement selects the back view")
	await _press_direction("move_right", visual, Vector2i(1, 1), "right movement selects the right profile")
	await _press_direction("move_down", visual, Vector2i(0, 0), "down movement selects the front view")

	var idle_frame := visual.frame_coords
	await physics_frame
	await physics_frame
	_check(visual.frame_coords == idle_frame, "the last facing direction remains while idle")

	Input.action_press("move_up")
	Input.action_press("move_right")
	await physics_frame
	Input.action_release("move_up")
	Input.action_release("move_right")
	await physics_frame
	_check(visual.frame_coords == Vector2i(0, 1), "equal diagonal input keeps the vertical facing view")

	_finish()


func _press_direction(
	action_name: StringName,
	visual: Sprite2D,
	expected_frame: Vector2i,
	assertion: String
) -> void:
	Input.action_press(action_name)
	await physics_frame
	Input.action_release(action_name)
	await physics_frame
	_check(visual.frame_coords == expected_frame, assertion)


func _check(condition: bool, assertion: String) -> void:
	if condition:
		return
	_failures.append(assertion)
	push_error("VIS-002 failed: " + assertion)


func _finish() -> void:
	if _failures.is_empty():
		print("VIS-002 player facing checks passed.")
	else:
		push_error("VIS-002 had " + str(_failures.size()) + " failure(s).")
	quit(1 if not _failures.is_empty() else 0)
