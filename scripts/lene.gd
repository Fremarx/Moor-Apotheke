extends "res://scripts/interactable.gd"

var quest_id: String = "lene"
var _quest: Node


func _ready() -> void:
	super._ready()
	add_to_group("quest_npcs")


func set_quest(quest: Node) -> void:
	_quest = quest


func get_prompt_text() -> String:
	if not is_instance_valid(_quest) or not bool(_quest.call("is_available")):
		return "[E] Sprechen: Lene"

	var quest_state := str(_quest.get("state"))
	if quest_state == "not_accepted":
		return "[E] Sprechen: Lene"
	if quest_state == "active":
		return "[E] Abgeben: Nachttrank"
	return "[E] Sprechen: Lene"


func interact() -> String:
	if not is_instance_valid(_quest):
		return "Lene ist gerade beschäftigt."
	return str(_quest.call("interact"))


func _draw() -> void:
	# A healer's layered teal dress, pale shawl and silver hair distinguish Lene.
	draw_rect(Rect2(Vector2(-9, 9), Vector2(18, 3)), Color("343d35"))
	draw_rect(Rect2(Vector2(-8, 1), Vector2(16, 10)), Color("394a43"))
	draw_rect(Rect2(Vector2(-7, 2), Vector2(14, 8)), Color("52695e"))
	draw_rect(Rect2(Vector2(-4, 3), Vector2(8, 7)), Color("c8b58c"))
	draw_rect(Rect2(Vector2(-7, -2), Vector2(14, 6)), Color("8c9b81"))
	draw_rect(Rect2(Vector2(-5, -10), Vector2(10, 9)), Color("c4a482"))
	draw_rect(Rect2(Vector2(-6, -11), Vector2(12, 5)), Color("777970"))
	draw_rect(Rect2(Vector2(-6, -8), Vector2(3, 6)), Color("777970"))
	draw_rect(Rect2(Vector2(3, -8), Vector2(3, 6)), Color("777970"))
	draw_rect(Rect2(Vector2(-6, -14), Vector2(12, 4)), Color("d2c8ad"))
	draw_rect(Rect2(Vector2(-3, -15), Vector2(6, 3)), Color("e0d6bd"))
	draw_rect(Rect2(Vector2(-3, -6), Vector2(2, 2)), Color("39352f"))
	draw_rect(Rect2(Vector2(2, -6), Vector2(2, 2)), Color("39352f"))
	draw_line(Vector2(0, -1), Vector2(0, 3), Color("73845f"), 2.0)
