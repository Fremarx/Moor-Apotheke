extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://reg_02_test.json"
const REGION_ORIGIN := Vector2(3040, 0)
const REGION_ENTRY := Vector2(3120, 408)
const SAVED_REGION_POSITION := Vector2(4940, 960)

var _failures: Array[String] = []
var _capture_path := ""


func _initialize() -> void:
	var user_args := OS.get_cmdline_user_args()
	if not user_args.is_empty():
		_capture_path = str(user_args[0])
	call_deferred("_run")


func _run() -> void:
	_remove_test_save()
	var main: Node = await _create_main()
	var player := main.get_node_or_null("World/Player") as CharacterBody2D
	var region := main.get_node_or_null("World/AlterTorfstich")
	var village := main.get_node_or_null("World/TestMap")
	_check(player != null, "the player exists")
	_check(region != null, "the Alter Torfstich is part of the world")
	_check(village != null, "the village controls the regional gate")
	if player == null or region == null or village == null:
		main.queue_free()
		await process_frame
		_remove_test_save()
		_finish()
		return

	var terrain := region.get_node_or_null("TerrainBase") as TileMapLayer
	var camera := player.get_node_or_null("Camera2D") as Camera2D
	var gate_shape := village.get_node("LockedTorfstichGate/CollisionShape2D") as CollisionShape2D
	var peat_shortcut_shape := region.get_node("RaisedPeatStegBlocker/CollisionShape2D") as CollisionShape2D
	var secret_workgang := region.get_node("HiddenWorkgang") as Area2D
	_check(region.position.is_equal_approx(REGION_ORIGIN), "the Torfstich follows the village and Schilfufer in world space")
	_check(terrain != null and terrain.map_size == Vector2i(150, 68), "the Torfstich uses the full five-by-four sector layout")
	_check(terrain != null and terrain.terrain_profile == 2, "the Torfstich has its own warm peat terrain profile")
	_check(int(region.call("get_traversable_tile_count")) >= 6120, "the region keeps at least 6,120 traversable tiles")
	_check(gate_shape != null and not gate_shape.disabled, "the village exit stays locked before Fenja's request is complete")
	_check(peat_shortcut_shape != null and not peat_shortcut_shape.disabled, "the crane shortcut begins raised")
	_check(secret_workgang != null and not secret_workgang.visible, "the measured workgang stays hidden until all stakes are checked")

	var route: PackedVector2Array = region.call("get_main_route_points")
	_check(route.size() >= 6, "the region exposes the planned multi-sector main route")
	var wuehler := region.get_node("Moorwuehler") as Area2D
	var irrlicht := region.get_node("Irrlicht") as Area2D
	_check(wuehler != null and irrlicht != null, "both optional Torfstich encounters are placed")
	_check(_distance_to_route(wuehler.position, route) >= 64.0, "the Moorwühler can be bypassed beside the main route")
	_check(_distance_to_route(irrlicht.position, route) >= 64.0, "the Irrlicht stays in a safe side route")

	var pickups: Dictionary = main.call("_get_pickups_by_id")
	_check(pickups.size() == 18, "all eighteen world pickups have unique persistent IDs")
	for pickup_name in ["NachtmoosD2", "NachtmoosC3", "NachtmoosD4", "TorfherzA3", "TorfherzB3", "TorfherzC4"]:
		_check(region.get_node_or_null(pickup_name) != null, "%s is placed in its planned sector" % pickup_name)

	player.global_position = Vector2(550, 184)
	await _press_action("move_right", 36)
	_check(player.global_position.x < 600.0, "the locked east gate physically prevents early entry")
	main.get_node("Quest/FenjaQuest").call("restore_state", "completed")
	await physics_frame
	await physics_frame
	_check(gate_shape.disabled, "completing Fenja's request opens the Torfstich route")
	player.global_position = Vector2(550, 184)
	await _press_until_area_transition(player, "move_right", 120, 3040.0)
	_check(player.global_position.is_equal_approx(REGION_ENTRY), "the eastern village path enters at the Torfhof")
	if camera != null:
		_check(camera.limit_left == 3040 and camera.limit_top == 0 and camera.limit_right == 5440 and camera.limit_bottom == 1088, "the camera switches to the full Torfstich bounds")
	if not _capture_path.is_empty():
		player.global_position = Vector2(3300, 420)
		(main.get_node("HUD/QuestStatus") as Control).hide()
		(main.get_node("HUD/InteractionFeedback") as Control).hide()
		await physics_frame
		await RenderingServer.frame_post_draw
		var preview := root.get_texture().get_image()
		_check(preview.save_png(_capture_path) == OK, "the Torfstich viewport preview saves")

	var inventory := main.get_node("Inventory")
	var selected_pickups: Array[String] = [
		"NachtmoosD2", "NachtmoosC3", "NachtmoosD4",
		"TorfherzA3", "TorfherzB3", "TorfherzC4",
	]
	for pickup_name in selected_pickups:
		var pickup := region.get_node(pickup_name) as Area2D
		player.global_position = pickup.global_position
		await physics_frame
		await physics_frame
		_check(player.try_interact(), "%s can be collected with the usual interaction" % pickup_name)
	_check(int(inventory.call("get_count", "night_moss")) == 3, "the three old-steg moss groups enter the shared inventory")
	_check(int(inventory.call("get_count", "peat_heart")) == 3, "the three safe-edge Torfherz groups enter the shared inventory")

	var peat_hoist := region.get_node("Torfkran") as Area2D
	player.global_position = peat_hoist.global_position
	await physics_frame
	await physics_frame
	_check(player.try_interact(), "the Torfkran uses the regular E interaction")
	await physics_frame
	_check(peat_shortcut_shape.disabled, "the crane permanently opens the A3-to-D4 shortcut")

	for stake_name in ["MesspfahlB4", "MesspfahlC4", "MesspfahlD4"]:
		var stake := region.get_node(stake_name) as Area2D
		player.global_position = stake.global_position
		await physics_frame
		await physics_frame
		_check(player.try_interact(), "%s responds to the standard interaction" % stake_name)
	_check(secret_workgang.visible, "the B4-C4-D4 survey reveals the buried workgang")

	var before_encounters: Dictionary = inventory.call("get_save_data")
	for encounter_name in ["Moorwuehler", "Irrlicht"]:
		var encounter := region.get_node(encounter_name) as Area2D
		player.global_position = encounter.global_position
		await physics_frame
		await physics_frame
		_check(player.try_interact(), "%s can be safely driven away" % encounter_name)
		_check(not encounter.visible, "%s leaves its optional side path open" % encounter_name)
	_check(inventory.call("get_save_data") == before_encounters, "walking past optional encounters neither removes inventory nor grants a reward")

	player.global_position = SAVED_REGION_POSITION
	_check(bool(main.call("save_game")), "the Torfstich position, inventory, shortcut, discovery, and pickups can be saved")
	for pickup_name in selected_pickups:
		(region.get_node(pickup_name) as Area2D).call("set_collected", false)
	region.call("restore_save_data", {})
	village.call("set_torfstich_unlocked", false)
	await physics_frame
	_check(not peat_shortcut_shape.disabled and not secret_workgang.visible, "resetting region state closes its shortcut and secret")
	_check(not gate_shape.disabled, "resetting the route state closes the village gate")
	player.global_position = Vector2(320, 180)
	_check(bool(main.call("load_game")), "the Torfstich save can be restored")
	await physics_frame
	_check(player.global_position.is_equal_approx(SAVED_REGION_POSITION), "loading restores the saved Torfstich position")
	_check(peat_shortcut_shape.disabled and secret_workgang.visible, "loading restores the opened shortcut and discovered workgang")
	_check(gate_shape.disabled, "loading restores Fenja's route unlock")
	_check(int(inventory.call("get_count", "peat_heart")) == 3, "the new resource remains valid in save data")
	for pickup_name in selected_pickups:
		_check(bool(region.get_node(pickup_name).call("is_collected")), "loading restores collected state for %s" % pickup_name)
	if camera != null:
		_check(camera.limit_left == 3040 and camera.limit_right == 5440 and camera.limit_bottom == 1088, "loading restores the Torfstich camera bounds")

	player.global_position = region.to_global(Vector2(32, 408))
	await physics_frame
	await physics_frame
	_check(player.global_position.is_equal_approx(Vector2(560, 184)), "the safe entrance route returns to the village east path")
	if camera != null:
		_check(camera.limit_right == 640 and camera.limit_bottom == 544, "returning restores the village camera bounds")

	main.queue_free()
	await process_frame
	var reloaded_main: Node = await _create_main()
	player = reloaded_main.get_node_or_null("World/Player") as CharacterBody2D
	camera = player.get_node_or_null("Camera2D") as Camera2D if player != null else null
	_check(player != null and player.global_position.is_equal_approx(SAVED_REGION_POSITION), "startup loading restores the saved Torfstich position")
	var legacy_save := {
		"version": 1,
		"player": {"x": 320.0, "y": 190.0},
		"inventory": {},
		"quests": {"fenja": "not_accepted", "marten": "not_accepted", "lene": "not_accepted"},
		"collected_pickups": [],
		"schilfufer": {},
	}
	_check(bool(reloaded_main.call("_is_valid_save_data", legacy_save)), "an earlier version-one save without Torfstich data remains valid")
	var reloaded_region := reloaded_main.get_node("World/AlterTorfstich")
	_check(bool(reloaded_region.call("get_save_data").get("shortcut_open")), "startup loading restores the shortcut")
	_check(bool(reloaded_region.call("get_save_data").get("survey_solved")), "startup loading restores the hidden workgang")
	if camera != null:
		_check(camera.limit_left == 3040 and camera.limit_right == 5440 and camera.limit_bottom == 1088, "startup loading restores Torfstich camera limits")
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


func _press_until_area_transition(player: CharacterBody2D, action_name: StringName, max_frames: int, destination_x: float) -> void:
	Input.action_press(action_name)
	for _frame in range(max_frames):
		await physics_frame
		if player.global_position.x >= destination_x:
			break
	Input.action_release(action_name)
	await physics_frame


func _distance_to_route(point: Vector2, route: PackedVector2Array) -> float:
	var closest_distance := INF
	for index in range(route.size() - 1):
		var closest := Geometry2D.get_closest_point_to_segment(point, route[index], route[index + 1])
		closest_distance = minf(closest_distance, point.distance_to(closest))
	return closest_distance


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("REG-02 Alter Torfstich checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("REG-02 check failed: " + failure)
	quit(1)


func _process(_delta: float) -> bool:
	return false
