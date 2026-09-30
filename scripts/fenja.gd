extends "res://scripts/interactable.gd"

var quest_id: String = "fenja"
var _quest: Node


func _ready() -> void:
	super._ready()
	add_to_group("quest_npcs")


func set_quest(quest: Node) -> void:
	_quest = quest


func get_prompt_text() -> String:
	if not is_instance_valid(_quest):
		return "[E] Sprechen: Fenja"

	var quest_state := str(_quest.get("state"))
	if quest_state == "not_accepted":
		return "[E] Sprechen: Fenja"
	if quest_state == "active":
		return "[E] Abgeben: Beruhigungstee"
	return "[E] Sprechen: Fenja"


func interact() -> String:
	if not is_instance_valid(_quest):
		return "Fenja ist gerade beschäftigt."
	return str(_quest.call("interact"))


func _draw() -> void:
	# A small graybox villager uses the same restrained palette as the test map.
	draw_rect(Rect2(Vector2(-9, 9), Vector2(18, 3)), Color("344338"))
	draw_rect(Rect2(Vector2(-7, -1), Vector2(14, 12)), Color("43564a"))
	draw_rect(Rect2(Vector2(-6, 0), Vector2(12, 9)), Color("60715b"))
	draw_rect(Rect2(Vector2(-4, 2), Vector2(8, 6)), Color("bdab83"))
	draw_rect(Rect2(Vector2(-4, -11), Vector2(8, 9)), Color("d5b18a"))
	draw_rect(Rect2(Vector2(-5, -12), Vector2(10, 4)), Color("544238"))
	draw_rect(Rect2(Vector2(-6, -9), Vector2(2, 7)), Color("544238"))
	draw_rect(Rect2(Vector2(4, -9), Vector2(2, 7)), Color("544238"))
	draw_rect(Rect2(Vector2(-5, -14), Vector2(10, 3)), Color("66735c"))
	draw_rect(Rect2(Vector2(-3, -8), Vector2(2, 2)), Color("3c332d"))
	draw_rect(Rect2(Vector2(2, -8), Vector2(2, 2)), Color("3c332d"))
	draw_rect(Rect2(Vector2(-6, 10), Vector2(5, 2)), Color("39352e"))
	draw_rect(Rect2(Vector2(1, 10), Vector2(5, 2)), Color("39352e"))
