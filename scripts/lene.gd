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
