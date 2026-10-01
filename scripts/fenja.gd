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
