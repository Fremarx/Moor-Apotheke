extends TileMapLayer


enum TerrainProfile {
	VILLAGE,
	SCHILFUFER,
	TORFSTICH,
}

const TERRAIN_TILESET: TileSet = preload("res://assets/tilesets/moor_terrain_tileset.tres")
const SOURCE_ID := 0
const BASE_GRASS_TILES := [
	Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0),
	Vector2i(4, 0), Vector2i(5, 0), Vector2i(6, 0), Vector2i(7, 0),
	Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1),
	Vector2i(4, 1), Vector2i(5, 1), Vector2i(6, 1), Vector2i(7, 1),
]

@export_enum("Dorfplatz", "Schilfufer", "Alter Torfstich") var terrain_profile: int = TerrainProfile.VILLAGE
@export var map_size: Vector2i = Vector2i(40, 23)


func _ready() -> void:
	tile_set = TERRAIN_TILESET
	collision_enabled = false
	navigation_enabled = false
	match terrain_profile:
		TerrainProfile.SCHILFUFER:
			modulate = Color(0.98, 1.0, 0.93, 1.0)
		TerrainProfile.TORFSTICH:
			modulate = Color(0.97, 0.87, 0.75, 1.0)
	clear()
	for y in range(map_size.y):
		for x in range(map_size.x):
			var cell := Vector2i(x, y)
			set_cell(cell, SOURCE_ID, _base_grass_tile_for(cell))


func _base_grass_tile_for(cell: Vector2i) -> Vector2i:
	var mixed_cell_hash: int = (
		(cell.x * 73856093)
		^ (cell.y * 19349663)
		^ (cell.x * cell.y * 83492791)
		^ (terrain_profile * 265443576)
	)
	return BASE_GRASS_TILES[posmod(mixed_cell_hash, BASE_GRASS_TILES.size())]
