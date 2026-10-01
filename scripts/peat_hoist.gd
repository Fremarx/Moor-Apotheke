extends "res://scripts/interactable.gd"


func interact() -> String:
	return get_parent().lower_peat_shortcut()
