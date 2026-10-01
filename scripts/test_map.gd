extends Node2D

const MAP_SIZE := Vector2(640, 360)
const WALL_THICKNESS := 16.0
const ATLAS_COLUMNS := 4.0
const ATLAS_ROWS := 4.0
const DECORATION_ATLAS: Texture2D = preload("res://assets/tilesets/moor_vegetation_atlas_ai_20261001.png")

@export var area_id: StringName = &"TestMap"


func _ready() -> void:
	add_to_group("world_areas")
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2(0, MAP_SIZE.y - WALL_THICKNESS), Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(MAP_SIZE.x - WALL_THICKNESS, 0), Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(429, 16), Vector2(181, 91)))
	_add_solid_rect(Rect2(Vector2(533, 82), Vector2(27, 31)))

	# Blocked patches keep the collision positions from the graybox while
	# the drawn rock, root, and reed sprites make them readable in the scene.
	_add_solid_rect(Rect2(Vector2(134, 108), Vector2(28, 22)))
	_add_solid_rect(Rect2(Vector2(294, 91), Vector2(30, 22)))
	_add_solid_rect(Rect2(Vector2(470, 139), Vector2(26, 34)))
	_add_solid_rect(Rect2(Vector2(402, 267), Vector2(32, 24)))


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
	_draw_pond()
	_draw_water_lilies()
	_draw_old_peat_dock()
	_draw_path()
	_draw_obstacles()
	_draw_reeds()
	_draw_scattered_details()
	_draw_interaction_probe()


func _draw_ground() -> void:
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("344940"))
	draw_rect(Rect2(Vector2(16, 16), Vector2(608, 328)), Color("707a50"))
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(28, 38), Vector2(73, 31), Vector2(111, 40),
			Vector2(119, 62), Vector2(88, 76), Vector2(44, 67)
		]),
		Color("7f8a58")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(25, 99), Vector2(46, 88), Vector2(69, 94),
			Vector2(82, 111), Vector2(74, 132), Vector2(53, 138),
			Vector2(40, 126), Vector2(24, 128)
		]),
		Color("506a54")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(344, 40), Vector2(371, 31), Vector2(396, 39),
			Vector2(416, 52), Vector2(397, 76), Vector2(374, 72),
			Vector2(357, 70)
		]),
		Color("4f684f")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(147, 132), Vector2(169, 123), Vector2(193, 130),
			Vector2(211, 143), Vector2(207, 163), Vector2(187, 174),
			Vector2(164, 168), Vector2(151, 154)
		]),
		Color("7d8452")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(274, 140), Vector2(293, 134), Vector2(315, 139),
			Vector2(327, 148), Vector2(346, 146), Vector2(358, 157),
			Vector2(355, 177), Vector2(334, 186), Vector2(315, 180),
			Vector2(292, 188), Vector2(280, 174), Vector2(269, 164)
		]),
		Color("526b57")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(372, 177), Vector2(392, 169), Vector2(411, 178),
			Vector2(419, 195), Vector2(403, 207), Vector2(380, 202)
		]),
		Color("85784e")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(36, 306), Vector2(77, 293), Vector2(112, 302),
			Vector2(104, 328), Vector2(58, 336)
		]),
		Color("7d8250")
	)

	for y in range(16, 352, 16):
		for x in range(16, 624, 16):
			var pattern := (x * 17 + y * 31) % 17
			var detail_position := Vector2(x + 2 + pattern % 5, y + 3 + pattern % 4)
			if pattern < 4:
				draw_rect(Rect2(detail_position, Vector2(6, 3)), Color("89945c"))
			elif pattern < 8:
				draw_rect(Rect2(detail_position, Vector2(5, 3)), Color("4b634a"))
			elif pattern == 10:
				draw_rect(Rect2(detail_position, Vector2(3, 2)), Color("bea46a"))
			elif pattern == 14:
				draw_rect(Rect2(detail_position, Vector2(7, 2)), Color("9aa76c"))

func _draw_pond() -> void:
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(423, 16), Vector2(611, 16), Vector2(611, 102),
			Vector2(573, 112), Vector2(548, 104), Vector2(517, 113),
			Vector2(491, 101), Vector2(462, 107), Vector2(435, 83)
		]),
		Color("263f43")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(430, 18), Vector2(608, 18), Vector2(608, 97),
			Vector2(573, 106), Vector2(548, 98), Vector2(517, 107),
			Vector2(492, 95), Vector2(464, 101), Vector2(439, 80)
		]),
		Color("315759")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(449, 26), Vector2(496, 23), Vector2(519, 35),
			Vector2(502, 42), Vector2(465, 39)
		]),
		Color("365f60")
	)
	draw_line(Vector2(423, 17), Vector2(435, 83), Color("b29461"), 2.0)
	draw_line(Vector2(435, 83), Vector2(462, 107), Color("9e8b59"), 2.0)
	draw_line(Vector2(462, 107), Vector2(491, 101), Color("af9861"), 2.0)
	draw_line(Vector2(491, 101), Vector2(517, 113), Color("a38b58"), 2.0)
	draw_line(Vector2(517, 113), Vector2(548, 104), Color("b39a62"), 2.0)
	draw_line(Vector2(548, 104), Vector2(573, 112), Color("9f8957"), 2.0)

	for ripple in [Vector2(467, 55), Vector2(532, 38), Vector2(578, 72), Vector2(507, 76)]:
		draw_line(ripple, ripple + Vector2(11, 0), Color("789080"), 1.0)
		draw_rect(Rect2(ripple + Vector2(3, 2), Vector2(4, 1)), Color("496c68"))
	draw_rect(Rect2(Vector2(552, 30), Vector2(8, 1)), Color("b09560"))
	draw_rect(Rect2(Vector2(564, 35), Vector2(4, 1)), Color("d0aa6a"))


func _draw_water_lilies() -> void:
	_draw_atlas_sprite(Vector2(484, 51), Vector2i(1, 2), Vector2(32, 32))
	_draw_atlas_sprite(Vector2(579, 52), Vector2i(2, 2), Vector2(32, 32))


func _draw_old_peat_dock() -> void:
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(516, 111), Vector2(545, 107), Vector2(575, 120),
			Vector2(566, 151), Vector2(538, 158), Vector2(516, 140)
		]),
		Color("3f5144")
	)
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(521, 114), Vector2(543, 111), Vector2(568, 122),
			Vector2(560, 145), Vector2(539, 151), Vector2(520, 137)
		]),
		Color("63734c")
	)
	draw_rect(Rect2(Vector2(529, 78), Vector2(30, 39)), Color("40382f"))
	draw_rect(Rect2(Vector2(532, 79), Vector2(24, 35)), Color("715139"))
	draw_rect(Rect2(Vector2(534, 80), Vector2(20, 33)), Color("8c6844"))
	for y in [82.0, 90.0, 98.0, 106.0]:
		draw_rect(Rect2(Vector2(534, y), Vector2(20, 5)), Color("9a754c"))
		draw_line(Vector2(534, y + 5), Vector2(554, y + 5), Color("5b4837"), 1.0)
	draw_rect(Rect2(Vector2(531, 80), Vector2(3, 37)), Color("574432"))
	draw_rect(Rect2(Vector2(555, 81), Vector2(3, 35)), Color("5e4a34"))
	draw_rect(Rect2(Vector2(538, 84), Vector2(2, 1)), Color("c09960"))
	draw_rect(Rect2(Vector2(548, 100), Vector2(2, 1)), Color("c09960"))


func _draw_path() -> void:
	var path := PackedVector2Array([
		Vector2(16, 229), Vector2(132, 222), Vector2(238, 230),
		Vector2(342, 220), Vector2(462, 228), Vector2(624, 219),
		Vector2(624, 276), Vector2(475, 283), Vector2(347, 275),
		Vector2(234, 287), Vector2(129, 276), Vector2(16, 285)
	])
	var path_shadow := PackedVector2Array([
		Vector2(16, 234), Vector2(132, 227), Vector2(238, 235),
		Vector2(342, 225), Vector2(462, 233), Vector2(624, 224),
		Vector2(624, 280), Vector2(475, 288), Vector2(347, 280),
		Vector2(234, 292), Vector2(129, 281), Vector2(16, 290)
	])
	draw_colored_polygon(path_shadow, Color("4c493b"))
	draw_colored_polygon(path, Color("a07b52"))
	draw_line(Vector2(28, 234), Vector2(135, 228), Color("d2ad73"), 2.0)
	draw_line(Vector2(249, 236), Vector2(343, 227), Color("d2ad73"), 2.0)
	draw_line(Vector2(479, 234), Vector2(609, 227), Color("d2ad73"), 2.0)
	for pebble in [Vector2(82, 260), Vector2(183, 246), Vector2(380, 262), Vector2(536, 253)]:
		draw_rect(Rect2(pebble + Vector2(1, 2), Vector2(5, 3)), Color("6a553e"))
		draw_rect(Rect2(pebble, Vector2(4, 2)), Color("c0a071"))
		draw_rect(Rect2(pebble + Vector2(1, 1), Vector2(2, 1)), Color("dbc18a"))


func _draw_obstacles() -> void:
	_draw_sprite_shadow(Vector2(148, 119), Vector2(30, 8))
	_draw_atlas_sprite(Vector2(148, 117), Vector2i(2, 0), Vector2(36, 36))
	_draw_sprite_shadow(Vector2(309, 102), Vector2(27, 8))
	_draw_atlas_sprite(Vector2(309, 100), Vector2i(2, 1), Vector2(36, 34))
	_draw_sprite_shadow(Vector2(483, 156), Vector2(25, 8))
	_draw_atlas_sprite(Vector2(483, 154), Vector2i(0, 0), Vector2(36, 40))
	_draw_sprite_shadow(Vector2(418, 279), Vector2(30, 8))
	_draw_atlas_sprite(Vector2(418, 277), Vector2i(2, 1), Vector2(34, 32))


func _draw_reeds() -> void:
	for reed in [
		Vector2(67, 68), Vector2(88, 83), Vector2(585, 196),
		Vector2(602, 213), Vector2(258, 321), Vector2(282, 331)
	]:
		_draw_atlas_sprite(reed, Vector2i(0, 0), Vector2(32, 36))
	_draw_atlas_sprite(Vector2(40, 150), Vector2i(1, 0), Vector2(28, 30))


func _draw_scattered_details() -> void:
	_draw_atlas_sprite(Vector2(106, 83), Vector2i(0, 3), Vector2(30, 30))
	_draw_atlas_sprite(Vector2(197, 157), Vector2i(0, 1), Vector2(32, 34))
	_draw_atlas_sprite(Vector2(240, 145), Vector2i(1, 1), Vector2(29, 31))
	_draw_atlas_sprite(Vector2(367, 307), Vector2i(1, 3), Vector2(29, 29))
	_draw_atlas_sprite(Vector2(390, 301), Vector2i(3, 2), Vector2(30, 30))
	_draw_atlas_sprite(Vector2(601, 298), Vector2i(3, 3), Vector2(30, 34))


func _draw_interaction_probe() -> void:
	var center := Vector2(270, 198)
	_draw_sprite_shadow(center + Vector2(0, 7), Vector2(14, 4))
	_draw_atlas_sprite(center + Vector2(0, -2), Vector2i(0, 3), Vector2(28, 30))


func _draw_sprite_shadow(center: Vector2, size: Vector2) -> void:
	draw_rect(
		Rect2(center - size / 2.0, size),
		Color(0.16, 0.23, 0.18, 0.55)
	)
	draw_rect(
		Rect2(center - Vector2(size.x * 0.3, size.y * 0.1), Vector2(size.x * 0.45, 1)),
		Color(0.36, 0.43, 0.27, 0.7)
	)


func _draw_atlas_sprite(center: Vector2, cell: Vector2i, target_size: Vector2) -> void:
	var atlas_size := Vector2(DECORATION_ATLAS.get_size())
	var cell_size := atlas_size / Vector2(ATLAS_COLUMNS, ATLAS_ROWS)
	var source_position := Vector2(float(cell.x) * cell_size.x, float(cell.y) * cell_size.y)
	var destination := Rect2(center - target_size / 2.0, target_size)
	var source := Rect2(source_position, cell_size)
	draw_texture_rect_region(DECORATION_ATLAS, destination, source, Color.WHITE, false, true)
