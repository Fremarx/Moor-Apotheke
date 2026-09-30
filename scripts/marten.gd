extends "res://scripts/interactable.gd"

var quest_id: String = "marten"
var _quest: Node


func _ready() -> void:
	super._ready()
	add_to_group("quest_npcs")


func set_quest(quest: Node) -> void:
	_quest = quest


func get_prompt_text() -> String:
	if not is_instance_valid(_quest):
		return "[E] Sprechen: Marten"

	if not bool(_quest.call("is_available")):
		return "[E] Sprechen: Marten"

	var quest_state := str(_quest.get("state"))
	if quest_state == "not_accepted":
		return "[E] Sprechen: Marten"
	if quest_state == "active":
		return "[E] Abgeben: Stärkender Aufguss"
	return "[E] Sprechen: Marten"


func interact() -> String:
	if not is_instance_valid(_quest):
		return "Marten ist gerade beschäftigt."
	return str(_quest.call("interact"))


func _draw() -> void:
	# A brown cap and peat spade distinguish Marten in the graybox.
	draw_rect(Rect2(Vector2(-9, 10), Vector2(18, 3)), Color("3f4535"))
	draw_rect(Rect2(Vector2(-6, 7), Vector2(5, 5)), Color("45423a"))
	draw_rect(Rect2(Vector2(1, 7), Vector2(5, 5)), Color("45423a"))
	draw_rect(Rect2(Vector2(-7, -1), Vector2(14, 10)), Color("745b3c"))
	draw_rect(Rect2(Vector2(-5, 0), Vector2(10, 7)), Color("927247"))
	draw_rect(Rect2(Vector2(-2, 0), Vector2(4, 7)), Color("4d513a"))
	draw_rect(Rect2(Vector2(-4, -10), Vector2(8, 9)), Color("c2a17c"))
	draw_rect(Rect2(Vector2(-5, -12), Vector2(10, 4)), Color("4e4233"))
	draw_rect(Rect2(Vector2(-7, -9), Vector2(3, 5)), Color("4e4233"))
	draw_rect(Rect2(Vector2(4, -9), Vector2(3, 5)), Color("4e4233"))
	draw_rect(Rect2(Vector2(-7, -15), Vector2(14, 4)), Color("765a38"))
	draw_rect(Rect2(Vector2(-4, -17), Vector2(9, 3)), Color("8a6a40"))
	draw_rect(Rect2(Vector2(-3, -7), Vector2(2, 2)), Color("39352d"))
	draw_rect(Rect2(Vector2(2, -7), Vector2(2, 2)), Color("39352d"))
	draw_line(Vector2(8, -2), Vector2(10, 10), Color("594b36"), 2.0)
	draw_line(Vector2(7, 10), Vector2(12, 10), Color("a9a083"), 2.0)
