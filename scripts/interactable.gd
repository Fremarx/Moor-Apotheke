extends Area2D

@export var display_name: String = "Objekt"
@export var action_verb: String = "Untersuchen"
@export_multiline var feedback_text: String = ""


func _ready() -> void:
	add_to_group("interactables")


func get_prompt_text() -> String:
	return "[E] %s: %s" % [action_verb, display_name]


func interact() -> String:
	if not feedback_text.is_empty():
		return feedback_text
	return "Du untersuchst: %s." % display_name
