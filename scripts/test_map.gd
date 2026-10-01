extends Node2D

const MAP_SIZE := Vector2(640, 360)
const WALL_THICKNESS := 16.0
const ATLAS_COLUMNS := 4.0
const ATLAS_ROWS := 4.0
const DECORATION_ATLAS: Texture2D = preload("res://assets/tilesets/moor_vegetation_atlas_ai_20261001.png")

@export var area_id: StringName = &"Dorfplatz"


func _ready() -> void:
	add_to_group("world_areas")
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2(0, MAP_SIZE.y - WALL_THICKNESS), Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(MAP_SIZE.x - WALL_THICKNESS, 0), Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(429, 16), Vector2(181, 91)))
	# The apothecary walls leave a clear approach to the front door.
	_add_solid_rect(Rect2(Vector2(104, 114), Vector2(112, 18)))
	_add_solid_rect(Rect2(Vector2(104, 132), Vector2(18, 40)))
	_add_solid_rect(Rect2(Vector2(198, 132), Vector2(18, 40)))
	_add_solid_rect(Rect2(Vector2(122, 162), Vector2(28, 10)))
	_add_solid_rect(Rect2(Vector2(176, 162), Vector2(20, 10)))
	_add_solid_rect(Rect2(Vector2(150, 150), Vector2(26, 22)))
	_add_solid_rect(Rect2(Vector2(344, 147), Vector2(31, 31)))

	# Blocked patches keep the collision positions from the graybox while
	# the drawn rock, root, and reed sprites make them readable in the scene.
	_add_solid_rect(Rect2(Vector2(384, 119), Vector2(30, 22)))
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
	_draw_village_paths()
	_draw_path()
	_draw_village_square()
	_draw_apothecary()
	_draw_village_signs()
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


func _draw_village_paths() -> void:
	_draw_road(PackedVector2Array([
		Vector2(257, 16), Vector2(296, 16), Vector2(300, 70),
		Vector2(304, 111), Vector2(330, 142), Vector2(319, 171),
		Vector2(284, 170), Vector2(267, 144), Vector2(269, 108),
		Vector2(262, 70)
	]))
	_draw_road(PackedVector2Array([
		Vector2(137, 139), Vector2(174, 139), Vector2(198, 153),
		Vector2(223, 163), Vector2(253, 174), Vector2(278, 185),
		Vector2(260, 209), Vector2(235, 194), Vector2(207, 178),
		Vector2(178, 165), Vector2(145, 163)
	]))


func _draw_road(points: PackedVector2Array) -> void:
	var shadow_points := PackedVector2Array()
	for point in points:
		shadow_points.append(point + Vector2(0, 5))
	draw_colored_polygon(shadow_points, Color("514938"))
	draw_colored_polygon(points, Color("a18158"))
	draw_polyline(points, Color("c4a574"), 2.0)


func _draw_village_square() -> void:
	var plaza := PackedVector2Array([
		Vector2(238, 167), Vector2(261, 145), Vector2(294, 136),
		Vector2(327, 137), Vector2(359, 146), Vector2(385, 165),
		Vector2(401, 192), Vector2(395, 220), Vector2(373, 240),
		Vector2(341, 250), Vector2(305, 247), Vector2(271, 239),
		Vector2(248, 219), Vector2(232, 195)
	])
	var shadow := PackedVector2Array()
	for point in plaza:
		shadow.append(point + Vector2(0, 5))
	draw_colored_polygon(shadow, Color("574c3e"))
	draw_colored_polygon(plaza, Color("b5a37d"))
	draw_polyline(plaza, Color("d6c59a"), 2.0)

	for row in range(7):
		for column in range(9):
			var tile := Vector2(255 + column * 15 + (row % 2) * 6, 154 + row * 13)
			var tint := Color("c2b28b") if (row + column) % 3 == 0 else Color("a99a74")
			draw_rect(Rect2(tile, Vector2(8, 4)), tint)
			draw_rect(Rect2(tile + Vector2(1, 1), Vector2(4, 1)), Color("d3c397"))

	# The well is a central landmark and stays clear of the main walking lines.
	draw_colored_polygon(PackedVector2Array([
		Vector2(352, 146), Vector2(367, 146), Vector2(378, 157),
		Vector2(378, 171), Vector2(367, 181), Vector2(352, 181),
		Vector2(341, 171), Vector2(341, 157)
	]), Color("71634d"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(352, 149), Vector2(366, 149), Vector2(375, 158),
		Vector2(375, 170), Vector2(366, 178), Vector2(352, 178),
		Vector2(344, 170), Vector2(344, 158)
	]), Color("d0c092"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(353, 153), Vector2(365, 153), Vector2(371, 159),
		Vector2(371, 169), Vector2(365, 174), Vector2(353, 174),
		Vector2(348, 169), Vector2(348, 159)
	]), Color("627b72"))
	draw_rect(Rect2(Vector2(353, 155), Vector2(12, 2)), Color("93aaa0"))
	draw_line(Vector2(346, 157), Vector2(350, 153), Color("e0d0a7"), 2.0)
	draw_line(Vector2(369, 153), Vector2(374, 158), Color("e0d0a7"), 2.0)
	draw_rect(Rect2(Vector2(276, 183), Vector2(27, 5)), Color("594333"))
	draw_rect(Rect2(Vector2(278, 180), Vector2(23, 4)), Color("a77b4d"))
	_draw_atlas_sprite(Vector2(256, 218), Vector2i(1, 3), Vector2(20, 20))
	_draw_atlas_sprite(Vector2(378, 207), Vector2i(1, 3), Vector2(20, 20))


func _draw_apothecary() -> void:
	draw_set_transform(Vector2(0, 22))
	draw_rect(Rect2(Vector2(91, 79), Vector2(145, 80)), Color(0.12, 0.17, 0.14, 0.35))
	draw_rect(Rect2(Vector2(101, 90), Vector2(119, 62)), Color("53473a"))
	draw_rect(Rect2(Vector2(105, 93), Vector2(111, 55)), Color("c7ad7d"))
	draw_rect(Rect2(Vector2(110, 97), Vector2(101, 48)), Color("dcc79a"))
	draw_rect(Rect2(Vector2(116, 108), Vector2(17, 19)), Color("6e6550"))
	draw_rect(Rect2(Vector2(118, 110), Vector2(13, 15)), Color("91aa8a"))
	draw_rect(Rect2(Vector2(190, 108), Vector2(17, 19)), Color("6e6550"))
	draw_rect(Rect2(Vector2(192, 110), Vector2(13, 15)), Color("91aa8a"))
	draw_rect(Rect2(Vector2(143, 129), Vector2(34, 22)), Color("5e4637"))
	draw_rect(Rect2(Vector2(146, 131), Vector2(28, 19)), Color("754f3b"))
	draw_rect(Rect2(Vector2(166, 136), Vector2(3, 3)), Color("dfbb69"))

	draw_colored_polygon(PackedVector2Array([
		Vector2(89, 93), Vector2(118, 61), Vector2(201, 61),
		Vector2(232, 93), Vector2(222, 103), Vector2(99, 103)
	]), Color("493b32"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(96, 91), Vector2(121, 66), Vector2(199, 66),
		Vector2(225, 91), Vector2(216, 98), Vector2(104, 98)
	]), Color("85523c"))
	for row in range(3):
		var shingle_y := 73 + row * 7
		for column in range(6):
			var shingle_x := 111 + column * 17 + (row % 2) * 4
			draw_rect(Rect2(Vector2(shingle_x, shingle_y), Vector2(11, 3)), Color("a36b4b"))
			draw_rect(Rect2(Vector2(shingle_x + 1, shingle_y), Vector2(7, 1)), Color("bd8057"))
	draw_line(Vector2(119, 65), Vector2(200, 65), Color("d19a68"), 2.0)
	draw_rect(Rect2(Vector2(193, 51), Vector2(14, 23)), Color("55483b"))
	draw_rect(Rect2(Vector2(196, 54), Vector2(8, 17)), Color("9a7651"))
	draw_rect(Rect2(Vector2(191, 50), Vector2(18, 4)), Color("d0b184"))

	draw_rect(Rect2(Vector2(130, 118), Vector2(63, 13)), Color("47392e"))
	draw_rect(Rect2(Vector2(133, 120), Vector2(57, 9)), Color("936942"))
	draw_rect(Rect2(Vector2(125, 115), Vector2(4, 18)), Color("594331"))
	draw_rect(Rect2(Vector2(194, 115), Vector2(4, 18)), Color("594331"))
	draw_string(ThemeDB.fallback_font, Vector2(138, 127), "APOTHEKE", HORIZONTAL_ALIGNMENT_LEFT, 60.0, 7, Color("f0d9a5"))
	draw_rect(Rect2(Vector2(141, 132), Vector2(9, 4)), Color("5b774e"))
	draw_rect(Rect2(Vector2(144, 129), Vector2(4, 5)), Color("88a65a"))
	draw_set_transform(Vector2.ZERO)


func _draw_village_signs() -> void:
	draw_rect(Rect2(Vector2(313, 92), Vector2(4, 24)), Color("594331"))
	draw_rect(Rect2(Vector2(305, 89), Vector2(42, 14)), Color("493a2f"))
	draw_rect(Rect2(Vector2(308, 91), Vector2(36, 10)), Color("a27a4f"))
	draw_string(ThemeDB.fallback_font, Vector2(311, 98), "NORD", HORIZONTAL_ALIGNMENT_LEFT, 30.0, 6, Color("f0d9a5"))
	draw_rect(Rect2(Vector2(455, 177), Vector2(4, 24)), Color("594331"))
	draw_rect(Rect2(Vector2(418, 171), Vector2(81, 14)), Color("493a2f"))
	draw_rect(Rect2(Vector2(421, 173), Vector2(75, 10)), Color("a27a4f"))
	draw_string(ThemeDB.fallback_font, Vector2(424, 180), "SCHILFUFER", HORIZONTAL_ALIGNMENT_LEFT, 70.0, 6, Color("f0d9a5"))


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
	_draw_sprite_shadow(Vector2(399, 130), Vector2(27, 8))
	_draw_atlas_sprite(Vector2(399, 128), Vector2i(2, 1), Vector2(36, 34))
	_draw_sprite_shadow(Vector2(483, 156), Vector2(25, 8))
	_draw_atlas_sprite(Vector2(483, 154), Vector2i(0, 0), Vector2(36, 40))
	_draw_sprite_shadow(Vector2(418, 279), Vector2(30, 8))
	_draw_atlas_sprite(Vector2(418, 277), Vector2i(2, 1), Vector2(34, 32))


func _draw_reeds() -> void:
	for reed in [
		Vector2(61, 146), Vector2(75, 161), Vector2(81, 290),
		Vector2(103, 310), Vector2(236, 316), Vector2(263, 329),
		Vector2(424, 304), Vector2(447, 315), Vector2(594, 300)
	]:
		_draw_atlas_sprite(reed, Vector2i(0, 0), Vector2(32, 36))
	_draw_atlas_sprite(Vector2(58, 188), Vector2i(1, 0), Vector2(28, 30))


func _draw_scattered_details() -> void:
	_draw_atlas_sprite(Vector2(71, 152), Vector2i(0, 3), Vector2(30, 30))
	_draw_atlas_sprite(Vector2(197, 157), Vector2i(0, 1), Vector2(32, 34))
	_draw_atlas_sprite(Vector2(240, 145), Vector2i(1, 1), Vector2(29, 31))
	_draw_atlas_sprite(Vector2(367, 307), Vector2i(1, 3), Vector2(29, 29))
	_draw_atlas_sprite(Vector2(390, 301), Vector2i(3, 2), Vector2(30, 30))
	_draw_atlas_sprite(Vector2(601, 298), Vector2i(3, 3), Vector2(30, 34))


func _draw_interaction_probe() -> void:
	var center := Vector2(270, 198)
	draw_rect(Rect2(center + Vector2(-17, -4), Vector2(34, 16)), Color("594632"))
	draw_rect(Rect2(center + Vector2(-14, -7), Vector2(28, 6)), Color("a07a4d"))
	draw_rect(Rect2(center + Vector2(-12, -6), Vector2(24, 2)), Color("c49a62"))
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
