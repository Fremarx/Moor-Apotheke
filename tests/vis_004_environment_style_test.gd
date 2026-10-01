extends SceneTree

const ATLAS_PATH := "res://assets/sprites/moor_environment_atlas_ai_20261001.png"
const ATLAS: Texture2D = preload(ATLAS_PATH)
const MAP_PATHS := [
	"res://scenes/world/test_map.tscn",
	"res://scenes/world/schilfufer.tscn",
]
const SOURCE_REGIONS := [
	Rect2(230.0, 20.0, 640.0, 500.0),
	Rect2(1050.0, 100.0, 550.0, 440.0),
	Rect2(300.0, 530.0, 520.0, 350.0),
	Rect2(1030.0, 530.0, 550.0, 350.0),
]
const EXPECTED_ATLAS_SIZE := Vector2(1774.0, 887.0)

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_check_atlas()
	for map_path: String in MAP_PATHS:
		_check_map(map_path)
	if _failures.is_empty():
		print("VIS-004 environment style checks passed.")
		quit(0)
	else:
		for failure in _failures:
			push_error(failure)
		quit(1)


func _check_atlas() -> void:
	_expect(ATLAS.get_size() == EXPECTED_ATLAS_SIZE, "environment atlas has its expected dimensions")
	var image := Image.load_from_file(ProjectSettings.globalize_path(ATLAS_PATH))
	_expect(not image.is_empty(), "environment atlas source can be read")
	if image.is_empty():
		return
	_expect(image.get_pixel(0, 0).a == 0.0, "atlas background is genuinely transparent")
	for source_region: Rect2 in SOURCE_REGIONS:
		var region_end: Vector2 = source_region.position + source_region.size
		_expect(source_region.position.x >= 0.0 and source_region.position.y >= 0.0, "sprite source region begins within the atlas")
		_expect(region_end.x <= EXPECTED_ATLAS_SIZE.x and region_end.y <= EXPECTED_ATLAS_SIZE.y, "sprite source region ends within the atlas")


func _check_map(map_path: String) -> void:
	var packed_scene := load(map_path) as PackedScene
	_expect(packed_scene != null, "%s scene loads" % map_path)
	if packed_scene == null:
		return
	var map := packed_scene.instantiate() as Node2D
	_expect(map != null, "%s scene instantiates as a 2D map" % map_path)
	if map == null:
		return
	var map_script := map.get_script() as GDScript
	_expect(map.has_method("_draw_environment_sprite"), "%s draws from the shared environment atlas" % map_path)
	_expect(map_script != null and map_script.source_code.contains("ENVIRONMENT_ATLAS"), "%s references the shared environment texture" % map_path)
	map.free()


func _expect(condition: bool, message: String) -> void:
	if not condition:
		_failures.append(message)


func _process(_delta: float) -> bool:
	return false