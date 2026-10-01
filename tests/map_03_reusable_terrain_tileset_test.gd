extends SceneTree

const TERRAIN_TILESET: TileSet = preload("res://assets/tilesets/moor_terrain_tileset.tres")
const MAP_CASES := [
	{"path": "res://scenes/world/test_map.tscn", "profile": 0, "pickup": "Sumpfminze/Visual", "map_size": Vector2i(40, 34)},
	{"path": "res://scenes/world/schilfufer.tscn", "profile": 1, "pickup": "SumpfminzeSchilfufer/Visual", "map_size": Vector2i(150, 68)},
]
var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_check_tileset()
	for map_case in MAP_CASES:
		await _check_map(map_case)
	if _failures.is_empty():
		print("MAP-03 reusable terrain TileSet checks passed.")
		quit(0)
	else:
		for failure in _failures:
			push_error(failure)
		quit(1)


func _check_tileset() -> void:
	_expect(TERRAIN_TILESET.tile_size == Vector2i(16, 16), "TileSet uses 16x16 logical tiles")
	_expect(TERRAIN_TILESET.get_source_count() == 1, "TileSet has one reusable atlas source")
	var source := TERRAIN_TILESET.get_source(0) as TileSetAtlasSource
	_expect(source != null, "TileSet source is an atlas")
	if source == null:
		return
	_expect(source.texture.get_size() == Vector2(128, 128), "atlas texture is exactly 128x128")
	_expect(source.texture_region_size == Vector2i(16, 16), "atlas cells are 16x16")
	_expect(source.get_atlas_grid_size() == Vector2i(8, 8), "atlas is an 8x8 sheet")
	for y in range(8):
		for x in range(8):
			_expect(source.has_tile(Vector2i(x, y)), "atlas cell (%d, %d) is registered" % [x, y])


func _check_map(map_case: Dictionary) -> void:
	var scene := load(map_case.path) as PackedScene
	_expect(scene != null, "%s loads" % map_case.path)
	if scene == null:
		return
	var map_root := scene.instantiate() as Node2D
	root.add_child(map_root)
	await process_frame

	var terrain := map_root.get_node_or_null("TerrainBase") as TileMapLayer
	_expect(terrain != null, "%s has a TileMapLayer terrain base" % map_case.path)
	if terrain != null:
		_expect(terrain.tile_set == TERRAIN_TILESET, "%s reuses the shared TileSet" % map_case.path)
		_expect(terrain.terrain_profile == map_case.profile, "%s has the expected terrain profile" % map_case.path)
		_expect(terrain.map_size == map_case.map_size, "%s fills its configured tile area" % map_case.path)
		_expect(terrain.get_used_cells().size() == map_case.map_size.x * map_case.map_size.y, "%s has no empty ground cells" % map_case.path)
		_expect(terrain.get_cell_source_id(Vector2i(0, 0)) == 0, "%s uses atlas source 0 at the origin" % map_case.path)
		_expect(terrain.get_cell_source_id(Vector2i(map_case.map_size.x - 1, map_case.map_size.y - 1)) == 0, "%s covers the bottom-right map cell" % map_case.path)
		var grass_variants: Dictionary = {}
		for cell: Vector2i in terrain.get_used_cells():
			var tile_coords := terrain.get_cell_atlas_coords(cell)
			grass_variants[tile_coords] = true
			_expect(tile_coords.y <= 1, "%s uses only the moss-and-grass rows for its walkable base" % map_case.path)
		_expect(grass_variants.size() >= 12, "%s distributes at least twelve moss-and-grass variants across the ground" % map_case.path)
		_expect(not terrain.collision_enabled, "%s ground does not add blocking collision" % map_case.path)
		_expect(not terrain.navigation_enabled, "%s decorative ground does not add navigation data" % map_case.path)
		var adjacent_center_delta := terrain.map_to_local(Vector2i(1, 0)) - terrain.map_to_local(Vector2i(0, 0))
		_expect(adjacent_center_delta == Vector2(16, 0), "%s tile cells meet on the 16px grid" % map_case.path)

	var pickup := map_root.get_node_or_null(map_case.pickup) as Sprite2D
	_expect(pickup != null and pickup.visible, "%s keeps its collectible sprite visible" % map_case.path)
	if pickup != null and pickup.texture != null:
		var cell_width := float(pickup.texture.get_width()) / float(pickup.hframes) * pickup.scale.x
		_expect(cell_width >= 20.0, "%s collectible stays readable at gameplay scale" % map_case.path)
	map_root.queue_free()
	await process_frame


func _expect(condition: bool, message: String) -> void:
	if not condition:
		_failures.append(message)

func _process(_delta: float) -> bool:
	return false
