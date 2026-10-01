extends TileMapLayer


enum TerrainProfile {
	VILLAGE,
	SCHILFUFER,
}

const TERRAIN_TILESET: TileSet = preload("res://assets/tilesets/moor_terrain_tileset.tres")
const SOURCE_ID := 0
const BASE_GRASS_TILE := Vector2i(0, 0)

@export_enum("Dorfplatz", "Schilfufer") var terrain_profile: int = TerrainProfile.VILLAGE
@export var map_size: Vector2i = Vector2i(40, 23)


func _ready() -> void:
	tile_set = TERRAIN_TILESET
	collision_enabled = false
	navigation_enabled = false
	if terrain_profile == TerrainProfile.SCHILFUFER:
		modulate = Color(0.98, 1.0, 0.93, 1.0)
	clear()
	for y in range(map_size.y):
		for x in range(map_size.x):
			set_cell(Vector2i(x, y), SOURCE_ID, BASE_GRASS_TILE)