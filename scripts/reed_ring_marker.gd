extends "res://scripts/interactable.gd"

@export_range(1, 3) var sequence_number := 1


func interact() -> String:
	return get_parent().activate_reed_marker(sequence_number)
