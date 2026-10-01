extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://area_001_test.json"
const SECOND_AREA_SPAWN := Vector2(710, 230)
const FIRST_AREA_RETURN_SPAWN := Vector2(80, 90)
const SAVED_SECOND_AREA_POSITION := Vector2(724, 246)

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_remove_test_save()
	var main: Node = await _create_main()
	var player := main.get_node_or_null("World/Player") as CharacterBody2D
	var second_area := main.get_node_or_null("World/Schilfufer")
	_check(player != null, "the player exists")
	_check(second_area != null, "the Schilfufer is connected to the world")
	if player == null or second_area == null:
		main.queue_free()
		await process_frame
		_remove_test_save()
		_finish()
		return

	_check(second_area.position.is_equal_approx(Vector2(640, 0)), "the second map follows the first map in world space")
	var pickups: Dictionary = main.call("_get_pickups_by_id")
	_check(pickups.size() == 8, "all eight map pickups have unique persistent IDs")
	var mint := main.get_node_or_null("World/Schilfufer/SumpfminzeSchilfufer") as Area2D
	var root_herb := main.get_node_or_null("World/Schilfufer/SchilfwurzelSchilfufer") as Area2D
	var moss := main.get_node_or_null("World/Schilfufer/NachtmoosSchilfufer") as Area2D
	_check(mint != null and root_herb != null and moss != null, "the new area has mint, reed root, and night moss")

	await _press_action("move_left", 165)
	await _press_action("move_up", 90)
	await _press_until_area_transition(player, "move_left", 60)
	_check(player.global_position.is_equal_approx(SECOND_AREA_SPAWN), "walking northwest on the trail carries the player into Schilfufer")
	await _press_action("move_right", 48)
	await _press_action("move_up", 38)
	_check(mint != null and player.try_interact(), "the mint patch is reachable by walking from the entrance")
	_check(int(main.get_node("Inventory").call("get_count", "sump_mint")) == 1, "collecting Schilfufer mint updates the shared inventory")
	await _press_action("move_right", 136)
	await _press_action("move_down", 88)
	_check(root_herb != null and player.try_interact(), "the reed-root patch is reachable along the southern route")
	await _press_action("move_up", 25)
	await _press_action("move_right", 144)
	await _press_action("move_up", 48)
	_check(moss != null and player.try_interact(), "the night-moss patch is reachable around the eastern pool")
	_check(int(main.get_node("Inventory").call("get_count", "reed_root")) == 1, "the Schilfufer reed root enters the shared inventory")
	_check(int(main.get_node("Inventory").call("get_count", "night_moss")) == 1, "the Schilfufer night moss enters the shared inventory")
	_check(mint != null and not mint.visible and root_herb != null and not root_herb.visible and moss != null and not moss.visible, "all three harvested patches disappear")
	await _press_action("move_down", 48)
	await _press_action("move_left", 345)
	await _press_until_x(player, "move_up", 640.0, false, 40)
	_check(player.global_position.is_equal_approx(FIRST_AREA_RETURN_SPAWN), "walking back along the trail returns the player to the first map")

	player.global_position = SAVED_SECOND_AREA_POSITION
	_check(bool(main.call("save_game")), "a position and the second-area harvest can be saved")
	player.global_position = Vector2(320, 180)
	if mint != null:
		mint.call("set_collected", false)
	if root_herb != null:
		root_herb.call("set_collected", false)
	if moss != null:
		moss.call("set_collected", false)
	_check(bool(main.call("load_game")), "the second-area save can be loaded")
	_check(player.global_position.is_equal_approx(SAVED_SECOND_AREA_POSITION), "loading restores the player to Schilfufer")
	_check(mint != null and not mint.visible and root_herb != null and not root_herb.visible and moss != null and not moss.visible, "loading restores all collected Schilfufer patches")

	main.queue_free()
	await process_frame
	var reloaded_main: Node = await _create_main()
	player = reloaded_main.get_node_or_null("World/Player") as CharacterBody2D
	mint = reloaded_main.get_node_or_null("World/Schilfufer/SumpfminzeSchilfufer") as Area2D
	root_herb = reloaded_main.get_node_or_null("World/Schilfufer/SchilfwurzelSchilfufer") as Area2D
	moss = reloaded_main.get_node_or_null("World/Schilfufer/NachtmoosSchilfufer") as Area2D
	_check(player != null and player.global_position.is_equal_approx(SAVED_SECOND_AREA_POSITION), "startup loading restores the second-area position")
	_check(mint != null and not mint.visible and root_herb != null and not root_herb.visible and moss != null and not moss.visible, "startup loading preserves all second-area harvests")
	reloaded_main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _create_main() -> Node:
	var main := MAIN_SCENE.instantiate()
	main.get_node("SaveManager").set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame
	return main


func _press_action(action_name: StringName, frame_count: int) -> void:
	Input.action_press(action_name)
	for _frame in range(frame_count):
		await physics_frame
	Input.action_release(action_name)
	await physics_frame


func _press_until_x(player: CharacterBody2D, action_name: StringName, threshold: float, greater: bool, max_frames: int) -> void:
	Input.action_press(action_name)
	for _frame in range(max_frames):
		await physics_frame
		if (player.global_position.x > threshold) == greater:
			break
	Input.action_release(action_name)
	await physics_frame


func _press_until_area_transition(player: CharacterBody2D, action_name: StringName, max_frames: int) -> void:
	Input.action_press(action_name)
	for _frame in range(max_frames):
		await physics_frame
		if player.global_position.x >= 640.0:
			break
	Input.action_release(action_name)
	await physics_frame


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("AREA-001 connected moor area checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("AREA-001 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
