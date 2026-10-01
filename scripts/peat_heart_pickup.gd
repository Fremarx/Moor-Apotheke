extends "res://scripts/herb_pickup.gd"


func _draw() -> void:
	var shadow := PackedVector2Array([
		Vector2(-11, 5), Vector2(-8, -1), Vector2(-4, -7), Vector2(2, -10),
		Vector2(8, -6), Vector2(11, -1), Vector2(8, 5), Vector2(2, 8),
	])
	draw_colored_polygon(shadow, Color("302c25"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(-8, 2), Vector2(-5, -4), Vector2(-1, -8), Vector2(5, -6),
		Vector2(8, -1), Vector2(5, 3), Vector2(0, 5), Vector2(-5, 4),
	]), Color("67513a"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(-4, -4), Vector2(-1, -8), Vector2(4, -6), Vector2(2, -2),
	]), Color("9b7850"))
	draw_rect(Rect2(Vector2(-6, 3), Vector2(3, 2)), Color("435342"))
	draw_rect(Rect2(Vector2(2, 3), Vector2(4, 2)), Color("52664a"))
	draw_rect(Rect2(Vector2(6, -3), Vector2(2, 2)), Color("d2ae68"))
