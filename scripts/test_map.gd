extends Node2D

const MAP_SIZE := Vector2(640, 360)
const WALL_THICKNESS := 16.0
const ATLAS_COLUMNS := 4.0
const ATLAS_ROWS := 4.0
const DECORATION_ATLAS: Texture2D = preload("res://assets/tilesets/moor_vegetation_atlas_ai_20261001.png")
const ENVIRONMENT_ATLAS: Texture2D = preload("res://assets/sprites/moor_environment_atlas_ai_20261001.png")

@export var area_id: StringName = &"Dorfplatz"


func _ready() -> void:
	add_to_group("world_areas")
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2(0, MAP_SIZE.y - WALL_THICKNESS), Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(MAP_SIZE.x - WALL_THICKNESS, 0), Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	# The northern pond keeps a walkable corridor for the Quellsenke bridge.
	_add_solid_rect(Rect2(Vector2(429, 16), Vector2(181, 58)))
	_add_solid_rect(Rect2(Vector2(429, 120), Vector2(181, 14)))
	# Locked route barriers stop the player at each unbuilt region entrance.
	_add_solid_rect(Rect2(Vector2(574, 76), Vector2(18, 44)))
	_add_solid_rect(Rect2(Vector2(576, 166), Vector2(18, 36)))
	_add_solid_rect(Rect2(Vector2(42, 280), Vector2(18, 38)))
	_add_solid_rect(Rect2(Vector2(574, 290), Vector2(18, 38)))
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
	_draw_pond()
	_draw_water_lilies()
	_draw_village_paths()
	_draw_bridge()
	_draw_village_square()
	_draw_apothecary()
	_draw_village_signs()
	_draw_locked_route_gates()
	_draw_obstacles()
	_draw_reeds()
	_draw_scattered_details()
	_draw_interaction_probe()


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
	# Paths match the five directions in the world overview.
	# NW Schilfufer (open).
	_draw_road(PackedVector2Array([
		Vector2(278, 178), Vector2(250, 188), Vector2(220, 198),
		Vector2(180, 202), Vector2(145, 194), Vector2(114, 178),
		Vector2(88, 152), Vector2(67, 122), Vector2(40, 89),
		Vector2(16, 73), Vector2(16, 108), Vector2(47, 135),
		Vector2(77, 169), Vector2(104, 197), Vector2(141, 219),
		Vector2(184, 226), Vector2(224, 220), Vector2(260, 204)
	]))
	# NE Quellsenke (locked until its later progression step).
	_draw_road(PackedVector2Array([
		Vector2(306, 140), Vector2(324, 145), Vector2(365, 129),
		Vector2(407, 110), Vector2(428, 85), Vector2(610, 82),
		Vector2(610, 119), Vector2(448, 123), Vector2(438, 142),
		Vector2(395, 163), Vector2(355, 177), Vector2(333, 190)
	]))
	# E Alter Torfstich.
	_draw_road(PackedVector2Array([
		Vector2(386, 166), Vector2(430, 157), Vector2(480, 159),
		Vector2(530, 168), Vector2(610, 174), Vector2(610, 208),
		Vector2(528, 202), Vector2(478, 194), Vector2(432, 193),
		Vector2(388, 213)
	]))
	# SW Nebelhain.
	_draw_road(PackedVector2Array([
		Vector2(269, 214), Vector2(249, 237), Vector2(212, 257),
		Vector2(169, 278), Vector2(121, 295), Vector2(70, 308),
		Vector2(16, 307), Vector2(16, 274), Vector2(70, 273),
		Vector2(113, 261), Vector2(157, 242), Vector2(205, 223),
		Vector2(258, 194)
	]))
	# SE Versunkener Wurzelhain.
	_draw_road(PackedVector2Array([
		Vector2(366, 231), Vector2(394, 244), Vector2(434, 260),
		Vector2(477, 277), Vector2(522, 296), Vector2(569, 314),
		Vector2(624, 315), Vector2(624, 280), Vector2(571, 279),
		Vector2(534, 266), Vector2(493, 248), Vector2(451, 230),
		Vector2(399, 210)
	]))


func _draw_bridge() -> void:
	draw_rect(Rect2(Vector2(426, 76), Vector2(185, 45)), Color("493c31"))
	draw_rect(Rect2(Vector2(428, 79), Vector2(181, 39)), Color("8a6445"))
	for plank_x in range(432, 607, 12):
		draw_rect(Rect2(Vector2(plank_x, 80), Vector2(3, 37)), Color("c09a67"))
		draw_line(Vector2(plank_x + 1, 81), Vector2(plank_x + 1, 116), Color("574432"), 1.0)
	draw_line(Vector2(429, 78), Vector2(608, 78), Color("d0ad77"), 2.0)
	draw_line(Vector2(429, 119), Vector2(608, 119), Color("d0ad77"), 2.0)


func _draw_road(points: PackedVector2Array) -> void:
	var shadow_points := PackedVector2Array()
	var bounds := Rect2(points[0], Vector2.ZERO)
	for point in points:
		shadow_points.append(point + Vector2(0, 5))
		bounds = bounds.expand(point)
	draw_colored_polygon(shadow_points, Color("514938"))
	draw_colored_polygon(points, Color("a18158"))
	draw_polyline(points, Color("c4a574"), 2.0)
	for y in range(int(bounds.position.y) + 6, int(bounds.end.y) - 4, 14):
		for x in range(int(bounds.position.x) + 6, int(bounds.end.x) - 4, 14):
			var detail := Vector2(x + posmod(x * 5 + y * 3, 5), y + posmod(x * 2 + y * 7, 4))
			if not Geometry2D.is_point_in_polygon(detail, points):
				continue
			var detail_pattern := posmod(x * 17 + y * 31, 19)
			if detail_pattern < 2:
				draw_rect(Rect2(detail, Vector2(3, 2)), Color("8d7553"))
				draw_rect(Rect2(detail + Vector2(1, 0), Vector2(1, 1)), Color("c5a574"))
			elif detail_pattern == 7:
				draw_rect(Rect2(detail, Vector2(2, 1)), Color("d1b783"))


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
	_draw_atlas_sprite(Vector2(244, 190), Vector2i(3, 3), Vector2(16, 18))
	_draw_atlas_sprite(Vector2(399, 201), Vector2i(3, 3), Vector2(16, 18))


func _draw_apothecary() -> void:
	_draw_environment_sprite(
		Rect2(230.0, 20.0, 640.0, 500.0),
		Rect2(Vector2(70, 24), Vector2(180, 141))
	)
	draw_string(
		ThemeDB.fallback_font,
		Vector2(224, 112),
		"APO",
		HORIZONTAL_ALIGNMENT_LEFT,
		14.0,
		5,
		Color("3b2b20")
	)


func _draw_village_signs() -> void:
	_draw_route_sign(Vector2(23, 91), "SCHILFUFER", 68.0)
	_draw_route_sign(Vector2(493, 127), "QUELLSENKE", 76.0)
	_draw_route_sign(Vector2(502, 210), "TORFSTICH", 69.0)
	_draw_route_sign(Vector2(20, 256), "NEBELHAIN", 68.0)
	_draw_route_sign(Vector2(506, 254), "WURZELHAIN", 80.0)
	draw_rect(Rect2(Vector2(509, 73), Vector2(4, 24)), Color("594331"))
	draw_rect(Rect2(Vector2(500, 70), Vector2(54, 14)), Color("493a2f"))
	draw_rect(Rect2(Vector2(503, 72), Vector2(48, 10)), Color("a27a4f"))
	draw_string(ThemeDB.fallback_font, Vector2(506, 79), "NORDOST", HORIZONTAL_ALIGNMENT_LEFT, 43.0, 6, Color("f0d9a5"))


func _draw_route_sign(origin: Vector2, label: String, width: float) -> void:
	draw_rect(Rect2(origin + Vector2(3, 10), Vector2(3, 12)), Color("594331"))
	draw_rect(Rect2(origin, Vector2(width, 11)), Color("493a2f"))
	draw_rect(Rect2(origin + Vector2(2, 2), Vector2(width - 4, 7)), Color("a27a4f"))
	draw_string(ThemeDB.fallback_font, origin + Vector2(4, 8), label, HORIZONTAL_ALIGNMENT_LEFT, width - 8, 6, Color("f0d9a5"))


func _draw_locked_route_gates() -> void:
	for gate_center in [Vector2(583, 98), Vector2(585, 184), Vector2(51, 299), Vector2(583, 309)]:
		var gate := Rect2(gate_center - Vector2(8, 20), Vector2(16, 40))
		draw_rect(gate.grow(2), Color("493a2f"))
		draw_rect(gate, Color("956746"))
		draw_rect(Rect2(gate.position + Vector2(1, 7), Vector2(14, 4)), Color("c09a67"))
		draw_rect(Rect2(gate.position + Vector2(1, 28), Vector2(14, 4)), Color("c09a67"))
		draw_line(gate.position + Vector2(3, 34), gate.position + Vector2(13, 5), Color("d68b63"), 2.0)


func _draw_obstacles() -> void:
	_draw_sprite_shadow(Vector2(399, 130), Vector2(27, 8))
	_draw_atlas_sprite(Vector2(399, 128), Vector2i(2, 1), Vector2(36, 34))
	_draw_sprite_shadow(Vector2(483, 156), Vector2(25, 8))
	_draw_atlas_sprite(Vector2(483, 154), Vector2i(0, 0), Vector2(36, 40))
	_draw_sprite_shadow(Vector2(350, 329), Vector2(30, 8))
	_draw_atlas_sprite(Vector2(350, 327), Vector2i(2, 1), Vector2(34, 32))


func _draw_reeds() -> void:
	for reed in [
		Vector2(61, 146), Vector2(75, 161), Vector2(68, 246),
		Vector2(93, 337), Vector2(236, 316), Vector2(263, 329),
		Vector2(424, 304), Vector2(447, 315), Vector2(605, 341)
	]:
		_draw_atlas_sprite(reed, Vector2i(0, 0), Vector2(32, 36))
	_draw_atlas_sprite(Vector2(58, 188), Vector2i(1, 0), Vector2(28, 30))
	_draw_environment_sprite(
		Rect2(300.0, 530.0, 520.0, 350.0),
		Rect2(Vector2(423, 45), Vector2(48, 33))
	)


func _draw_scattered_details() -> void:
	_draw_atlas_sprite(Vector2(71, 152), Vector2i(0, 3), Vector2(30, 30))
	_draw_atlas_sprite(Vector2(197, 157), Vector2i(0, 1), Vector2(32, 34))
	_draw_atlas_sprite(Vector2(240, 145), Vector2i(1, 1), Vector2(29, 31))
	_draw_atlas_sprite(Vector2(367, 307), Vector2i(1, 3), Vector2(29, 29))
	_draw_atlas_sprite(Vector2(390, 301), Vector2i(3, 2), Vector2(30, 30))
	_draw_atlas_sprite(Vector2(601, 298), Vector2i(3, 3), Vector2(30, 34))
	_draw_environment_sprite(
		Rect2(1030.0, 530.0, 550.0, 350.0),
		Rect2(Vector2(500, 245), Vector2(52, 33))
	)
	_draw_environment_sprite(
		Rect2(1030.0, 530.0, 550.0, 350.0),
		Rect2(Vector2(285, 250), Vector2(48, 30))
	)


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


func _draw_environment_sprite(source: Rect2, destination: Rect2) -> void:
	draw_texture_rect_region(ENVIRONMENT_ATLAS, destination, source, Color.WHITE, false, true)
