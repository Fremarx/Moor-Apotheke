extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://map_04_village_expansion_test.json"
const EXPECTED_BOUNDS := Rect2(Vector2.ZERO, Vector2(640, 544))
const COTTAGE_ATLAS_PATH := "res://assets/sprites/village_cottages_ai_20261001.png"
const HOUSE_MARKERS := ["DorfhausWest", "DorfhausMitte", "DorfhausOst"]

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")

func _run() -> void:
	_remove_test_save()
	var main := MAIN_SCENE.instantiate()
	main.get_node("SaveManager").set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame

	var village := main.get_node_or_null("World/TestMap")
	var player := main.get_node_or_null("World/Player") as CharacterBody2D
	var camera := main.get_node_or_null("World/Player/Camera2D") as Camera2D
	var terrain := main.get_node_or_null("World/TestMap/TerrainBase") as TileMapLayer
	_check(village != null, "the expanded village scene loads")
	if village != null:
		_check(village.call("get_map_bounds") == EXPECTED_BOUNDS, "the village grows to 640 by 544 pixels")
		_check(village.get_node_or_null("DorfhausWestBlocker") != null, "the west cottage has a foundation collision")
		_check(village.get_node_or_null("DorfhausMitteBlocker") != null, "the middle cottage has a foundation collision")
		_check(village.get_node_or_null("DorfhausOstBlocker") != null, "the east cottage has a foundation collision")
		for marker_name in HOUSE_MARKERS:
			var house := village.get_node_or_null(marker_name) as Marker2D
			_check(house != null, "%s marks a residential cottage" % marker_name)
			if house != null:
				_check(EXPECTED_BOUNDS.has_point(house.position), "%s stands inside the expanded village" % marker_name)
				_check(house.position.y >= 300.0, "%s belongs to the new southern district" % marker_name)
	if terrain != null:
		_check(terrain.map_size == Vector2i(40, 34), "the ground layer fills the 40 by 34 tile area")
		_check(terrain.get_used_cells().size() == 40 * 34, "the expanded village ground has no empty cells")
	if camera != null:
		_check(camera.limit_right == 640 and camera.limit_bottom == 544, "the camera reaches the new southern border")

	var cottage_texture := load(COTTAGE_ATLAS_PATH) as Texture2D
	_check(cottage_texture != null, "the cottage atlas can be loaded as a texture")
	if cottage_texture != null:
		_check(cottage_texture.get_size() == Vector2(2172, 724), "the cottage atlas contains three 724 pixel sprite cells")
		var cottage_image := cottage_texture.get_image()
		_check(cottage_image.get_pixel(0, 0).a < 0.05, "the cottage atlas keeps a transparent background")


	main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("MAP-04 village expansion checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("MAP-04 check failed: " + failure)
	quit(1)
