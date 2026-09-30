extends "res://scripts/interactable.gd"

signal item_collected(item_id: String, amount: int)

@export var item_id: String = "sump_mint"

var _collected := false


func _ready() -> void:
	super._ready()
	add_to_group("item_pickups")


func interact() -> String:
	if _collected:
		return ""

	_collected = true
	item_collected.emit(item_id, 1)
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	return feedback_text


func _draw() -> void:
	if item_id == "night_moss":
		_draw_night_moss()
		return

	if item_id == "reed_root":
		_draw_reed_root()
		return

	_draw_sump_mint()


func _draw_sump_mint() -> void:
	draw_rect(Rect2(Vector2(-8, 4), Vector2(16, 3)), Color("45533b"))
	draw_line(Vector2(0, 5), Vector2(0, -5), Color("596943"), 2.0)
	draw_line(Vector2(-1, 1), Vector2(-5, -2), Color("596943"), 1.0)
	draw_line(Vector2(1, -1), Vector2(5, -4), Color("596943"), 1.0)
	draw_rect(Rect2(Vector2(-7, -4), Vector2(5, 3)), Color("809457"))
	draw_rect(Rect2(Vector2(2, -6), Vector2(5, 3)), Color("a8b76c"))
	draw_rect(Rect2(Vector2(-6, 0), Vector2(5, 3)), Color("71884e"))
	draw_rect(Rect2(Vector2(2, -1), Vector2(5, 3)), Color("8f9f59"))
	draw_rect(Rect2(Vector2(-6, -4), Vector2(2, 1)), Color("b0bd76"))
	draw_rect(Rect2(Vector2(3, -6), Vector2(2, 1)), Color("c2c47b"))


func _draw_reed_root() -> void:
	# Upright reed leaves mark the plant; the exposed root gives it a separate silhouette.
	draw_rect(Rect2(Vector2(-8, 4), Vector2(16, 3)), Color("45533b"))
	draw_rect(Rect2(Vector2(-5, -6), Vector2(2, 10)), Color("667b4c"))
	draw_rect(Rect2(Vector2(-1, -9), Vector2(2, 13)), Color("788b51"))
	draw_rect(Rect2(Vector2(3, -7), Vector2(2, 11)), Color("596f45"))
	draw_rect(Rect2(Vector2(-7, -4), Vector2(3, 2)), Color("849359"))
	draw_rect(Rect2(Vector2(2, -5), Vector2(3, 2)), Color("91a05f"))
	draw_rect(Rect2(Vector2(-6, 2), Vector2(12, 4)), Color("594735"))
	draw_rect(Rect2(Vector2(-5, 2), Vector2(9, 2)), Color("a17a4e"))
	draw_rect(Rect2(Vector2(-4, 4), Vector2(7, 1)), Color("c19a64"))
	draw_rect(Rect2(Vector2(-2, 1), Vector2(2, 2)), Color("d0ad74"))
	draw_rect(Rect2(Vector2(3, 2), Vector2(2, 2)), Color("d0ad74"))


func _draw_night_moss() -> void:
	# A low, damp blue-green cluster reads differently from the upright herbs.
	draw_rect(Rect2(Vector2(-10, 5), Vector2(20, 3)), Color("35443d"))
	draw_rect(Rect2(Vector2(-9, 1), Vector2(18, 6)), Color("344b42"))
	draw_rect(Rect2(Vector2(-7, -1), Vector2(7, 5)), Color("426456"))
	draw_rect(Rect2(Vector2(-2, -4), Vector2(8, 7)), Color("3c5b50"))
	draw_rect(Rect2(Vector2(4, -2), Vector2(7, 5)), Color("496c5b"))
	draw_rect(Rect2(Vector2(-6, 0), Vector2(3, 2)), Color("7e9b74"))
	draw_rect(Rect2(Vector2(0, -3), Vector2(3, 2)), Color("9aac7c"))
	draw_rect(Rect2(Vector2(6, -1), Vector2(3, 2)), Color("83a287"))
