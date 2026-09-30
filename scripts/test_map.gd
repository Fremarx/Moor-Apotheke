extends Node2D

const MAP_SIZE := Vector2(640, 360)
const WALL_THICKNESS := 16.0


func _ready() -> void:
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2(0, MAP_SIZE.y - WALL_THICKNESS), Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(MAP_SIZE.x - WALL_THICKNESS, 0), Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(429, 16), Vector2(181, 91)))
	_add_solid_rect(Rect2(Vector2(533, 82), Vector2(27, 31)))

	# Blocked patches are simple placeholders for future rocks, roots, and reeds.
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
	_draw_old_peat_dock()
	_draw_path()
	_draw_obstacles()
	_draw_reeds()
	_draw_interaction_probe()


func _draw_ground() -> void:
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("637958"))
	for y in range(16, 352, 16):
		for x in range(16, 624, 16):
			var pattern := (x * 17 + y * 31) % 13
			if pattern < 4:
				var shade := Color("6d8260") if pattern < 2 else Color("596f50")
				draw_rect(Rect2(Vector2(x + 3, y + 4), Vector2(3, 2)), shade)
			elif pattern == 8:
				draw_rect(Rect2(Vector2(x + 10, y + 9), Vector2(2, 2)), Color("78865d"))


func _draw_pond() -> void:
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(423, 16), Vector2(611, 16), Vector2(611, 102),
			Vector2(573, 112), Vector2(548, 104), Vector2(517, 113),
			Vector2(491, 101), Vector2(462, 107), Vector2(435, 83)
		]),
		Color("405c5a")
	)
	draw_line(Vector2(435, 82), Vector2(461, 100), Color("82916d"), 3.0)
	draw_line(Vector2(493, 95), Vector2(517, 106), Color("82916d"), 3.0)
	draw_line(Vector2(549, 98), Vector2(573, 105), Color("82916d"), 3.0)
	for ripple in [Vector2(472, 48), Vector2(539, 66), Vector2(584, 41)]:
		draw_line(ripple, ripple + Vector2(12, 0), Color("6f8580"), 1.0)


func _draw_old_peat_dock() -> void:
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(516, 111), Vector2(545, 107), Vector2(575, 120),
			Vector2(566, 151), Vector2(538, 158), Vector2(516, 140)
		]),
		Color("4b5a48")
	)
	draw_rect(Rect2(Vector2(531, 79), Vector2(30, 35)), Color("3c3d33"))
	draw_rect(Rect2(Vector2(534, 79), Vector2(23, 31)), Color("735c40"))
	for y in [84.0, 91.0, 98.0, 105.0]:
		draw_line(Vector2(534, y), Vector2(557, y + 1), Color("4c4437"), 2.0)
	draw_rect(Rect2(Vector2(532, 79), Vector2(3, 38)), Color("554733"))
	draw_rect(Rect2(Vector2(556, 80), Vector2(3, 35)), Color("5b4a35"))
	draw_line(Vector2(539, 84), Vector2(552, 84), Color("917550"), 1.0)


func _draw_path() -> void:
	draw_colored_polygon(
		PackedVector2Array([
			Vector2(16, 229), Vector2(132, 222), Vector2(238, 230),
			Vector2(342, 220), Vector2(462, 228), Vector2(624, 219),
			Vector2(624, 276), Vector2(475, 283), Vector2(347, 275),
			Vector2(234, 287), Vector2(129, 276), Vector2(16, 285)
		]),
		Color("9b8057")
	)
	draw_line(Vector2(28, 235), Vector2(135, 229), Color("b19a6d"), 2.0)
	draw_line(Vector2(249, 237), Vector2(343, 228), Color("b19a6d"), 2.0)
	draw_line(Vector2(479, 236), Vector2(609, 230), Color("b19a6d"), 2.0)
	for pebble in [Vector2(82, 260), Vector2(183, 246), Vector2(380, 262), Vector2(536, 253)]:
		draw_rect(Rect2(pebble, Vector2(4, 2)), Color("766348"))


func _draw_obstacles() -> void:
	# Small pixel clusters show where the matching invisible blockers sit.
	_draw_bush(Vector2(148, 119), Color("40583f"))
	_draw_stones(Vector2(309, 102))
	_draw_reed_patch(Vector2(483, 156))
	_draw_stones(Vector2(418, 279))


func _draw_bush(center: Vector2, base_color: Color) -> void:
	draw_rect(Rect2(center + Vector2(-14, -5), Vector2(28, 12)), Color("344535"))
	draw_rect(Rect2(center + Vector2(-11, -9), Vector2(20, 12)), base_color)
	draw_rect(Rect2(center + Vector2(-7, -11), Vector2(8, 4)), Color("738653"))
	draw_rect(Rect2(center + Vector2(4, -7), Vector2(6, 3)), Color("64794b"))


func _draw_stones(center: Vector2) -> void:
	draw_rect(Rect2(center + Vector2(-14, -4), Vector2(12, 8)), Color("4b5146"))
	draw_rect(Rect2(center + Vector2(-12, -7), Vector2(9, 7)), Color("899080"))
	draw_rect(Rect2(center + Vector2(1, -6), Vector2(13, 9)), Color("656d60"))
	draw_rect(Rect2(center + Vector2(3, -8), Vector2(8, 4)), Color("9ba18e"))


func _draw_reed_patch(center: Vector2) -> void:
	draw_rect(Rect2(center + Vector2(-12, 3), Vector2(24, 10)), Color("4b6547"))
	for offset in [-9.0, -3.0, 4.0, 9.0]:
		draw_line(center + Vector2(offset, 5), center + Vector2(offset - 2.0, -9), Color("9a9a58"), 2.0)
		draw_rect(Rect2(center + Vector2(offset - 4.0, -11), Vector2(4, 3)), Color("675940"))


func _draw_reeds() -> void:
	for reed in [Vector2(67, 68), Vector2(86, 79), Vector2(573, 193), Vector2(590, 207), Vector2(258, 321), Vector2(281, 330)]:
		draw_line(reed, reed + Vector2(-3, -13), Color("82905a"), 2.0)
		draw_rect(Rect2(reed + Vector2(-7, -16), Vector2(5, 4)), Color("756241"))
		draw_line(reed + Vector2(3, 1), reed + Vector2(8, -11), Color("a1a169"), 2.0)


func _draw_interaction_probe() -> void:
	var center := Vector2(270, 198)
	draw_rect(Rect2(center + Vector2(-7, 5), Vector2(14, 3)), Color("46543b"))
	draw_line(center + Vector2(0, 5), center + Vector2(0, -4), Color("768850"), 2.0)
	draw_rect(Rect2(center + Vector2(-6, -8), Vector2(5, 4)), Color("9cac6e"))
	draw_rect(Rect2(center + Vector2(1, -10), Vector2(5, 4)), Color("b0ba7a"))
	draw_rect(Rect2(center + Vector2(-2, -3), Vector2(5, 4)), Color("85925e"))
