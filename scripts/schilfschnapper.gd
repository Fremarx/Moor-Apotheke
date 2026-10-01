extends "res://scripts/interactable.gd"

var _driven_off := false


func _ready() -> void:
	super._ready()
	add_to_group("optional_encounters")


func interact() -> String:
	if _driven_off:
		return "Der Schilfschnapper ist zurück ins Wasser geflüchtet."
	_driven_off = true
	visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	return "Du scheuchst den Schilfschnapper ins Wasser. Deine Kräuter bleiben bei dir."

func reset_encounter() -> void:
	_driven_off = false
	visible = true
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
