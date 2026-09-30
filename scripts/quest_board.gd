extends "res://scripts/interactable.gd"

signal open_requested


func _ready() -> void:
	super._ready()


func get_prompt_text() -> String:
	return "[E] Ansehen: Auftragsbrett"


func interact() -> String:
	open_requested.emit()
	return "Du liest die Bewohneraufträge."


func _draw() -> void:
	draw_rect(Rect2(Vector2(-10, 8), Vector2(20, 3)), Color("344238"))
	draw_rect(Rect2(Vector2(-2, 2), Vector2(4, 12)), Color("604a35"))
	draw_rect(Rect2(Vector2(-11, -13), Vector2(22, 17)), Color("493c2d"))
	draw_rect(Rect2(Vector2(-9, -11), Vector2(18, 13)), Color("b59b6a"))
	draw_rect(Rect2(Vector2(-7, -9), Vector2(14, 9)), Color("e0d5b9"))
	draw_rect(Rect2(Vector2(-6, -8), Vector2(3, 2)), Color("73845f"))
	draw_rect(Rect2(Vector2(-1, -8), Vector2(7, 1)), Color("79664b"))
	draw_rect(Rect2(Vector2(-6, -4), Vector2(12, 1)), Color("79664b"))
	draw_rect(Rect2(Vector2(-6, -1), Vector2(9, 1)), Color("79664b"))
	draw_rect(Rect2(Vector2(-8, -12), Vector2(16, 1)), Color("806543"))
