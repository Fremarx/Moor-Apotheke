extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://area_001_test.json"
const SECOND_AREA_SPAWN := Vector2(2880, 952)
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

	var terrain := second_area.get_node_or_null("TerrainBase") as TileMapLayer
	var camera := player.get_node_or_null("Camera2D") as Camera2D
	_check(second_area.position.is_equal_approx(Vector2(640, 0)), "the second map follows the first map in world space")
	_check(terrain != null and terrain.map_size == Vector2i(150, 68), "the expanded Schilfufer uses the full five-by-four sector layout")
	_check(int(second_area.call("get_traversable_tile_count")) >= 6120, "the region keeps at least 6,120 traversable tiles")
	_check(camera != null and camera.limit_right == 640 and camera.limit_bottom == 360, "the village camera starts inside the village bounds")

	var pickups: Dictionary = main.call("_get_pickups_by_id")
	_check(pickups.size() == 12, "all twelve world pickups have unique persistent IDs")
	var mint_e4 := main.get_node("World/Schilfufer/SumpfminzeSchilfufer") as Area2D
	var root_d4 := main.get_node("World/Schilfufer/SchilfwurzelSchilfufer") as Area2D
	var mint_c3 := main.get_node("World/Schilfufer/SumpfminzeC3") as Area2D
	var mint_b2 := main.get_node("World/Schilfufer/SumpfminzeB2") as Area2D
	var root_c2 := main.get_node("World/Schilfufer/SchilfwurzelC2") as Area2D
	var root_b3 := main.get_node("World/Schilfufer/SchilfwurzelB3") as Area2D
	var schnappper := main.get_node("World/Schilfufer/Schilfschnapper") as Area2D
	var secret_moss := main.get_node("World/Schilfufer/NachtmoosSchilfufer") as Area2D
	var ferry_mast := main.get_node("World/Schilfufer/FerryMast") as Area2D
	var marker_one := main.get_node("World/Schilfufer/ReedMarkerOne") as Area2D
	var marker_two := main.get_node("World/Schilfufer/ReedMarkerTwo") as Area2D
	var marker_three := main.get_node("World/Schilfufer/ReedMarkerThree") as Area2D
	var ferry_gate := main.get_node("World/Schilfufer/RaisedFerryPlankBlocker/CollisionShape2D") as CollisionShape2D
	_check(mint_e4 != null and mint_c3 != null and mint_b2 != null, "three Sumpfminze groups are placed across the region")
	_check(root_d4 != null and root_c2 != null and root_b3 != null, "three Schilfwurzel groups are placed across the region")
	_check(schnappper != null, "the optional Schilfschnapper encounter is present")
	_check(secret_moss != null and not secret_moss.visible, "the secret moss clearing is hidden until its puzzle is solved")
	_check(ferry_gate != null and not ferry_gate.disabled, "the ferry shortcut starts blocked by the raised plank")

	await _press_action("move_left", 165)
	await _press_action("move_up", 90)
	await _press_until_area_transition(player, "move_left", 60)
	_check(player.global_position.is_equal_approx(SECOND_AREA_SPAWN), "the northwest village path enters Schilfufer at E4")
	if camera != null:
		_check(camera.limit_left == 640 and camera.limit_top == 0 and camera.limit_right == 3040 and camera.limit_bottom == 1088, "the camera switches to the expanded region bounds")

	await physics_frame
	await physics_frame
	_check(mint_e4 != null and player.try_interact(), "the entrance plant can be collected at the start of the main route")
	await _press_action("move_left", 410)
	await physics_frame
	await physics_frame
	_check(root_d4 != null and player.try_interact(), "the D4 reed-root patch is reachable along the main route")
	await _press_action("move_up", 199)
	await _press_action("move_up", 110)
	await _press_action("move_left", 351)
	await _press_action("move_down", 110)
	await physics_frame
	await physics_frame
	_check(mint_c3 != null and player.try_interact(), "the C3 mint patch is reachable at the reed ring")
	await _press_action("move_up", 199)
	await physics_frame
	await physics_frame
	_check(root_c2 != null and player.try_interact(), "the C2 reed-root patch is reachable from the labyrinth route")
	await _press_action("move_left", 351)
	await physics_frame
	await physics_frame
	_check(mint_b2 != null and player.try_interact(), "the B2 mint patch is reachable at the ferry clearing")
	await _press_action("move_down", 199)
	await physics_frame
	await physics_frame
	_check(root_b3 != null and player.try_interact(), "the B3 reed-root patch is reachable from the optional loop")
	_check(int(main.get_node("Inventory").call("get_count", "sump_mint")) == 3, "the three Schilfufer mint groups enter the shared inventory")
	_check(int(main.get_node("Inventory").call("get_count", "reed_root")) == 3, "the three Schilfufer reed-root groups enter the shared inventory")

	player.global_position = ferry_mast.global_position
	await physics_frame
	await physics_frame
	_check(player.try_interact(), "the ferry mast lowers the plank using the normal interaction")
	await physics_frame
	_check(ferry_gate.disabled, "lowering the ferry plank opens the shortcut collision")
	player.global_position = Vector2(1840, 680)
	await _press_action("move_right", 351)
	_check(player.global_position.x > 2220.0, "the lowered ferry plank is physically traversable")

	var inventory := main.get_node("Inventory")
	var mint_count_before_encounter := int(inventory.call("get_count", "sump_mint"))
	var root_count_before_encounter := int(inventory.call("get_count", "reed_root"))
	player.global_position = schnappper.global_position + Vector2(4, 0)
	await physics_frame
	await physics_frame
	_check(player.try_interact(), "the optional Schilfschnapper can be driven away with the normal interaction")
	_check(not schnappper.visible, "the driven-off Schilfschnapper leaves the path")
	_check(int(inventory.call("get_count", "sump_mint")) == mint_count_before_encounter and int(inventory.call("get_count", "reed_root")) == root_count_before_encounter, "the encounter never removes collected herbs")

	player.global_position = marker_two.global_position
	await physics_frame
	await physics_frame
	_check(player.try_interact(), "the wrong first reed-ring marker responds to interaction")
	_check(not secret_moss.visible, "an incorrect marker order resets the ring puzzle")
	for marker in [marker_one, marker_two, marker_three]:
		player.global_position = marker.global_position
		await physics_frame
		await physics_frame
		_check(player.try_interact(), "the marker sequence accepts the visible one-to-three order")
	_check(secret_moss.visible, "solving the ring reveals the hidden herb clearing")

	var return_gate := second_area.get_node("ReturnToTestMap") as Area2D
	player.global_position = return_gate.global_position
	await physics_frame
	await physics_frame
	_check(player.global_position.is_equal_approx(FIRST_AREA_RETURN_SPAWN), "the region return transition reaches the northwest village path")
	if camera != null:
		_check(camera.limit_right == 640 and camera.limit_bottom == 360, "returning restores the village camera bounds")

	var region_pickups: Array[Area2D] = [mint_e4, root_d4, mint_c3, mint_b2, root_c2, root_b3]
	player.global_position = SAVED_SECOND_AREA_POSITION
	_check(bool(main.call("save_game")), "the expanded-region position, shortcut, puzzle, and collected plants can be saved")
	second_area.call("restore_save_data", {})
	await physics_frame
	_check(not ferry_gate.disabled and not secret_moss.visible, "resetting region data closes the shortcut and secret")
	player.global_position = Vector2(320, 180)
	for pickup in region_pickups:
		pickup.call("set_collected", false)
	_check(bool(main.call("load_game")), "the expanded-region save can be loaded")
	await physics_frame
	_check(player.global_position.is_equal_approx(SAVED_SECOND_AREA_POSITION), "loading accepts and restores a legacy region position")
	if camera != null:
		_check(camera.limit_left == 640 and camera.limit_right == 3040 and camera.limit_bottom == 1088, "loading restores the Schilfufer camera bounds")
	_check(ferry_gate.disabled, "loading restores the permanent ferry shortcut")
	_check(secret_moss.visible, "loading restores the solved ring and its hidden clearing")
	for pickup in region_pickups:
		_check(not pickup.visible, "loading restores collected pickup %s" % pickup.get("pickup_id"))

	main.queue_free()
	await process_frame
	var reloaded_main: Node = await _create_main()
	player = reloaded_main.get_node_or_null("World/Player") as CharacterBody2D
	camera = player.get_node_or_null("Camera2D") as Camera2D if player != null else null
	_check(player != null and player.global_position.is_equal_approx(SAVED_SECOND_AREA_POSITION), "startup loading restores the saved region position")
	if camera != null:
		_check(camera.limit_left == 640 and camera.limit_right == 3040 and camera.limit_bottom == 1088, "startup loading restores region camera limits")
	var reloaded_region := reloaded_main.get_node("World/Schilfufer")
	var reloaded_ferry_gate := reloaded_region.get_node("RaisedFerryPlankBlocker/CollisionShape2D") as CollisionShape2D
	var reloaded_secret_moss := reloaded_region.get_node("NachtmoosSchilfufer") as Area2D
	_check(reloaded_ferry_gate.disabled and reloaded_secret_moss.visible, "startup loading restores the ferry and ring progress")
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


func _press_until_area_transition(player: CharacterBody2D, action_name: StringName, max_frames: int) -> void:
	Input.action_press(action_name)
	for _frame in range(max_frames):
		await physics_frame
		if player.global_position.x >= 640.0 and player.global_position.y == SECOND_AREA_SPAWN.y:
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
		print("REG-01 Schilfufer checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("REG-01 check failed: " + failure)
	quit(1)


func _process(_delta: float) -> bool:
	return false
