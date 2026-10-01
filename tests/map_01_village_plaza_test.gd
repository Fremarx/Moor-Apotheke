extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://map_01_village_plaza_test.json"
const VIEWPORT_RECT := Rect2(Vector2(80, 55), Vector2(480, 270))
const PLAYER_START := Vector2(320, 190)

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
	main.get_node("SaveManager").set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame
	if not _capture_path.is_empty():
		await RenderingServer.frame_post_draw
		var preview := root.get_texture().get_image()
		_check(preview.save_png(_capture_path) == OK, "the village viewport preview saves")

	var village := main.get_node_or_null("World/TestMap")
	var player := main.get_node_or_null("World/Player") as CharacterBody2D
	var center := main.get_node_or_null("World/TestMap/DorfplatzMitte") as Marker2D
	var apothecary := main.get_node_or_null("World/TestMap/Apotheke") as Marker2D
	var entrance := main.get_node_or_null("World/TestMap/ApothekenEingang") as Marker2D
	var north_exit := main.get_node_or_null("World/TestMap/Nordausgang") as Marker2D
	var board := main.get_node_or_null("World/TestMap/QuestBoard") as Area2D
	var board_panel := main.get_node_or_null("HUD/QuestBoardPanel") as PanelContainer
	var east_exit := main.get_node_or_null("World/TestMap/EnterSchilfufer") as Area2D

	_check(village != null and StringName(village.get("area_id")) == &"Dorfplatz", "the central map is identified as Dorfplatz")
	_check(player != null and player.position.is_equal_approx(PLAYER_START), "the player starts in the village square")
	_check(center != null and center.position.is_equal_approx(PLAYER_START), "the central marker matches the player arrival point")
	_check(apothecary != null and entrance != null, "the apothecary and its approach are marked")
	_check(board != null and board_panel != null, "the quest board remains in the village")
	_check(north_exit != null and east_exit != null, "two outward routes are visible from the hub")
	if north_exit != null:
		_check(VIEWPORT_RECT.has_point(north_exit.global_position), "the northern route is visible from the starting view")
	if east_exit != null:
		_check(VIEWPORT_RECT.has_point(Vector2(520, 228)), "the Schilfufer sign and eastern route are visible from the starting view")

	if player != null and board != null and board_panel != null:
		_check(player.position.distance_to(board.position) < 70.0, "the quest board is within a short walk from the start")
		await _press_action("move_down", 8)
		_check(player.try_interact(), "the quest board can be interacted with from the plaza")
		await physics_frame
		_check(board_panel.visible, "the quest board opens from the village square")
		main.call("_close_quest_board")

	if player != null and entrance != null:
		player.position = PLAYER_START
		await physics_frame
		await _press_action("move_left", 90)
		await _press_action("move_up", 10)
		await _press_action("move_left", 27)
		_check(player.global_position.distance_to(entrance.global_position) < 22.0, "the player can walk from the square to the apothecary entrance")

	main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _press_action(action_name: StringName, frame_count: int) -> void:
	Input.action_press(action_name)
	for _frame in range(frame_count):
		await physics_frame
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
		print("MAP-01 village plaza checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("MAP-01 check failed: " + failure)
	quit(1)