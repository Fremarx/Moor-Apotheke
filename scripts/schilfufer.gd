extends Node2D

const MAP_SIZE := Vector2(640, 360)
const WALL_THICKNESS := 16.0
const ATLAS_COLUMNS := 4.0
const ATLAS_ROWS := 4.0
const DECORATION_ATLAS: Texture2D = preload("res://assets/tilesets/moor_vegetation_atlas_ai_20261001.png")

@export var area_id: StringName = &"Schilfufer"


func _ready() -> void:
	add_to_group("world_areas")
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2(0, MAP_SIZE.y - WALL_THICKNESS), Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(MAP_SIZE.x - WALL_THICKNESS, 0), Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	for pool in [
		Rect2(Vector2(50, 34), Vector2(112, 61)),
		Rect2(Vector2(224, 24), Vector2(240, 98)),
		Rect2(Vector2(486, 40), Vector2(116, 60)),
		Rect2(Vector2(42, 128), Vector2(75, 50)),
		Rect2(Vector2(466, 126), Vector2(120, 52)),
		Rect2(Vector2(70, 302), Vector2(125, 38)),
		Rect2(Vector2(460, 302), Vector2(130, 38)),
	]:
		_add_solid_rect(pool)


func _add_solid_rect(rect: Rect2) -> void:
	var body := StaticBody2D.new()
	body.position = rect.position + rect.size / 2.0
	var collision := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	collision.shape = shape
	body.add_child(collision)
	add_child(body)


func _draw() -> void:
	_draw_ground()
	_draw_backwaters()
	_draw_boardwalk()
	_draw_reeds()
	_draw_details()
	_draw_exit_marker()


func _draw_ground() -> void:
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("304844"))
	draw_rect(Rect2(Vector2(16, 16), Vector2(608, 328)), Color("71805a"))
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(24, 34), Vector2(45, 27), Vector2(50, 62), Vector2(39, 87),
			Vector2(24, 91), Vector2(17, 70),
		]),
		Color("829064")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(169, 28), Vector2(210, 25), Vector2(226, 39), Vector2(214, 66),
			Vector2(186, 81), Vector2(164, 69),
		]),
		Color("7c875c")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(491, 188), Vector2(528, 174), Vector2(566, 181), Vector2(580, 205),
			Vector2(557, 220), Vector2(517, 214),
		]),
		Color("657853")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(214, 286), Vector2(245, 279), Vector2(280, 287), Vector2(294, 306),
			Vector2(278, 329), Vector2(239, 337), Vector2(211, 321),
		]),
		Color("81845a")
	)
	for y in range(24, 344, 16):
		for x in range(24, 624, 16):
			var pattern := (x * 11 + y * 23) % 19
			var point := Vector2(x + pattern % 7, y + pattern % 5)
			if pattern < 4:
				draw_rect(Rect2(point, Vector2(5, 2)), Color("929867"))
			elif pattern < 8:
				draw_rect(Rect2(point, Vector2(4, 3)), Color("506b50"))
			elif pattern == 12:
				draw_rect(Rect2(point, Vector2(2, 2)), Color("b3a16a"))
			elif pattern == 16:
				draw_rect(Rect2(point, Vector2(6, 1)), Color("a2a36a"))


func _draw_backwaters() -> void:
	_draw_water_pool(Vector2(48, 34), Vector2(116, 64))
	_draw_water_pool(Vector2(222, 24), Vector2(244, 101))
	_draw_water_pool(Vector2(484, 40), Vector2(120, 63))
	_draw_water_pool(Vector2(40, 126), Vector2(79, 54))
	_draw_water_pool(Vector2(464, 124), Vector2(124, 57))
	_draw_water_pool(Vector2(68, 300), Vector2(129, 43))
	_draw_water_pool(Vector2(458, 300), Vector2(134, 43))
	for ripple in [Vector2(75, 52), Vector2(131, 75), Vector2(277, 53), Vector2(407, 95), Vector2(529, 65), Vector2(499, 149)]:
		draw_line(ripple, ripple + Vector2(12, 0), Color("86a39a"), 1.0)
		draw_rect(Rect2(ripple + Vector2(4, 2), Vector2(4, 1)), Color("557a73"))


func _draw_water_pool(origin: Vector2, size: Vector2) -> void:
	draw_rect(Rect2(origin - Vector2(3, 2), size + Vector2(6, 4)), Color("394b43"))
	draw_rect(Rect2(origin, size), Color("34595a"))
	draw_rect(Rect2(origin + Vector2(4, 3), Vector2(size.x - 8, size.y - 8)), Color("3d6763"))
	draw_line(origin + Vector2(4, 1), origin + Vector2(size.x - 5, 1), Color("98a075"), 2.0)
	draw_line(origin + Vector2(3, size.y - 2), origin + Vector2(size.x - 8, size.y - 2), Color("70825e"), 2.0)


func _draw_boardwalk() -> void:
	var shadow := PackedVector2Array([
		Vector2(16, 237), Vector2(143, 229), Vector2(269, 236), Vector2(389, 222),
		Vector2(509, 231), Vector2(624, 226), Vector2(624, 279), Vector2(508, 284),
		Vector2(388, 276), Vector2(267, 290), Vector2(142, 282), Vector2(16, 290),
	])
	var planks := PackedVector2Array([
		Vector2(16, 231), Vector2(143, 223), Vector2(269, 230), Vector2(389, 216),
		Vector2(509, 225), Vector2(624, 220), Vector2(624, 271), Vector2(508, 276),
		Vector2(388, 268), Vector2(267, 282), Vector2(142, 274), Vector2(16, 282),
	])
	draw_colored_polygon(shadow, Color("42463b"))
	draw_colored_polygon(planks, Color("96734c"))
	draw_line(Vector2(24, 238), Vector2(137, 231), Color("c2a16b"), 2.0)
	draw_line(Vector2(155, 232), Vector2(263, 238), Color("c2a16b"), 2.0)
	draw_line(Vector2(280, 237), Vector2(384, 224), Color("c2a16b"), 2.0)
	draw_line(Vector2(402, 224), Vector2(506, 233), Color("c2a16b"), 2.0)
	draw_line(Vector2(523, 232), Vector2(611, 228), Color("c2a16b"), 2.0)
	for nail in [Vector2(70, 250), Vector2(192, 252), Vector2(323, 252), Vector2(451, 250), Vector2(574, 249)]:
		draw_rect(Rect2(nail, Vector2(2, 2)), Color("4d4939"))
		draw_rect(Rect2(nail + Vector2(1, 0), Vector2(1, 1)), Color("d0ad70"))


func _draw_reeds() -> void:
	for reed in [
		Vector2(185, 114), Vector2(204, 122), Vector2(160, 158), Vector2(175, 167),
		Vector2(289, 159), Vector2(311, 153), Vector2(427, 117), Vector2(447, 119),
		Vector2(592, 110), Vector2(606, 122), Vector2(38, 184), Vector2(59, 191),
		Vector2(122, 314), Vector2(141, 320), Vector2(396, 316), Vector2(416, 322),
		Vector2(545, 289), Vector2(565, 295),
	]:
		_draw_atlas_sprite(reed, Vector2i(0, 0), Vector2(30, 34))
	_draw_atlas_sprite(Vector2(332, 188), Vector2i(1, 0), Vector2(30, 31))
	_draw_atlas_sprite(Vector2(98, 101), Vector2i(1, 0), Vector2(28, 29))


func _draw_details() -> void:
	_draw_atlas_sprite(Vector2(185, 274), Vector2i(1, 3), Vector2(29, 29))
	_draw_atlas_sprite(Vector2(298, 199), Vector2i(0, 1), Vector2(31, 32))
	_draw_atlas_sprite(Vector2(371, 131), Vector2i(2, 1), Vector2(35, 34))
	_draw_atlas_sprite(Vector2(603, 302), Vector2i(3, 3), Vector2(30, 33))
	for pebble in [Vector2(83, 287), Vector2(229, 222), Vector2(361, 286), Vector2(479, 291), Vector2(587, 186)]:
		draw_rect(Rect2(pebble, Vector2(5, 2)), Color("6b6047"))
		draw_rect(Rect2(pebble + Vector2(1, -1), Vector2(3, 2)), Color("c1a16b"))


func _draw_exit_marker() -> void:
	draw_rect(Rect2(Vector2(594, 188), Vector2(5, 40)), Color("4d4334"))
	draw_rect(Rect2(Vector2(590, 186), Vector2(13, 8)), Color("a9824f"))
	draw_rect(Rect2(Vector2(592, 188), Vector2(9, 4)), Color("d2b274"))
	draw_rect(Rect2(Vector2(597, 193), Vector2(2, 4)), Color("614c36"))


func _draw_atlas_sprite(center: Vector2, cell: Vector2i, target_size: Vector2) -> void:
	var atlas_size := Vector2(DECORATION_ATLAS.get_size())
	var cell_size := atlas_size / Vector2(ATLAS_COLUMNS, ATLAS_ROWS)
	var source_position := Vector2(float(cell.x) * cell_size.x, float(cell.y) * cell_size.y)
	draw_texture_rect_region(
		DECORATION_ATLAS,
		Rect2(center - target_size / 2.0, target_size),
		Rect2(source_position, cell_size),
		Color.WHITE,
		false,
		true
	)
