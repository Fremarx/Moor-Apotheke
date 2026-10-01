extends "res://scripts/interactable.gd"

@export_enum("Moorwühler", "Irrlicht") var encounter_kind: int = 0

var _driven_off := false


func _ready() -> void:
	super._ready()
	add_to_group("optional_encounters")


func interact() -> String:
	if _driven_off:
		return "Die Begegnung ist bereits weitergezogen."
	_driven_off = true
	visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	if encounter_kind == 0:
		return "Du weichst der Torfwelle aus und scheuchst den Moorwühler fort. Deine Kräuter bleiben bei dir."
	return "Du folgst dem echten Weglicht; das Irrlicht zieht von der sicheren Weggabelung weiter."


func reset_encounter() -> void:
	_driven_off = false
	visible = true
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)


func _draw() -> void:
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
