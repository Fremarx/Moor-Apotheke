extends "res://scripts/enemy_encounter.gd"

@export_enum("Moorwühler", "Irrlicht") var encounter_kind: int = 0


func _ready() -> void:
	if encounter_kind == 0:
		drop_item_id = "peat_armor_flake"
		max_health = 2
		attack_range = 92.0
		attack_half_width = 17.0
		can_attack_player = true
	else:
		drop_item_id = "will_o_wisp_spark"
		max_health = 3
		attack_range = 72.0
		attack_half_width = 12.0
		can_attack_player = false
	super._ready()


func interact() -> String:
	if encounter_kind == 0:
		return dismiss_safely("Du weichst der Torfwelle aus und gehst am Moorwühler vorbei. Deine Kräuter bleiben bei dir.")
	return dismiss_safely("Du folgst dem echten Weglicht; das Irrlicht zieht von der sicheren Weggabelung weiter.")


func _draw() -> void:
	super._draw()
	if encounter_kind == 0:
		_draw_moorwuehler()
	else:
		_draw_irrlicht()


func _draw_moorwuehler() -> void:
	draw_colored_polygon(PackedVector2Array([
		Vector2(-20, 5), Vector2(-15, -4), Vector2(-7, -10), Vector2(5, -9),
		Vector2(16, -3), Vector2(20, 4), Vector2(15, 9), Vector2(-13, 9),
	]), Color("2f342d"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(-14, 3), Vector2(-9, -4), Vector2(-2, -7), Vector2(7, -5),
		Vector2(14, 0), Vector2(10, 5), Vector2(-10, 6),
	]), Color("514638"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(-8, -4), Vector2(-3, -8), Vector2(2, -6), Vector2(-1, -2),
	]), Color("667452"))
	draw_rect(Rect2(Vector2(4, -3), Vector2(2, 2)), Color("d5c27b"))
	draw_line(Vector2(-17, 10), Vector2(-22, 14), Color("846b4d"), 2.0)
	draw_line(Vector2(13, 10), Vector2(18, 14), Color("846b4d"), 2.0)


func _draw_irrlicht() -> void:
	draw_circle(Vector2(0, 4), 14.0, Color("315552", 0.36))
	draw_colored_polygon(PackedVector2Array([
		Vector2(-8, 8), Vector2(-6, 1), Vector2(-2, -7), Vector2(1, -13),
		Vector2(5, -6), Vector2(8, 1), Vector2(6, 8), Vector2(0, 12),
	]), Color("365c69"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(-4, 6), Vector2(-3, 0), Vector2(0, -7), Vector2(3, -2),
		Vector2(4, 4), Vector2(0, 9),
	]), Color("77a7a2"))
	draw_rect(Rect2(Vector2(-1, -4), Vector2(3, 3)), Color("c8d7a0"))
	draw_line(Vector2(-9, 16), Vector2(-3, 16), Color("b3b477"), 1.0)
	draw_line(Vector2(3, 18), Vector2(10, 18), Color("91aa8b"), 1.0)
