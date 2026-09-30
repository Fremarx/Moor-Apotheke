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
