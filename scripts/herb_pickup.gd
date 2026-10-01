extends "res://scripts/interactable.gd"

signal item_collected(item_id: String, amount: int)

@export var item_id: String = "sump_mint"
@export var pickup_id: String = ""

var _collected := false


func _ready() -> void:
	super._ready()
	add_to_group("item_pickups")


func interact() -> String:
	if _collected:
		return ""

	set_collected(true)
	item_collected.emit(item_id, 1)
	return feedback_text


func get_pickup_id() -> String:
	return pickup_id


func is_collected() -> bool:
	return _collected


func set_collected(collected: bool) -> void:
	_collected = collected
	visible = not collected
	set_deferred("monitoring", not collected)
	set_deferred("monitorable", not collected)
