extends "res://scripts/interactable.gd"

signal open_requested


func _ready() -> void:
	super._ready()


func get_prompt_text() -> String:
	return "[E] Ansehen: Auftragsbrett"


func interact() -> String:
	open_requested.emit()
	return "Du liest die Bewohneraufträge."
