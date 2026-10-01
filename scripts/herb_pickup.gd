extends "res://scripts/interactable.gd"

signal item_collected(item_id: String, amount: int)
signal resource_discovered(pickup_id: String, area_id: StringName, resource_id: String, display_name: String, location_name: String, rarity: StringName)

@export var item_id: String = "sump_mint"
@export var pickup_id: String = ""
@export var area_id: StringName = &""
@export var location_name: String = ""
@export var is_rare: bool = false

var _collected := false


func _ready() -> void:
	super._ready()
	add_to_group("item_pickups")


func interact() -> String:
	if _collected:
		return ""

	set_collected(true)
	item_collected.emit(item_id, 1)
	resource_discovered.emit(pickup_id, area_id, item_id, str(display_name), location_name, get_resource_rarity())
	return feedback_text


func get_pickup_id() -> String:
	return pickup_id


func get_area_id() -> StringName:
	return area_id


func get_location_name() -> String:
	return location_name

func get_resource_id() -> String:
	return item_id


func get_resource_rarity() -> StringName:
	return &"rare" if is_rare else &"common"


func is_collected() -> bool:
	return _collected


func set_collected(collected: bool) -> void:
	_collected = collected
	visible = not collected
	set_deferred("monitoring", not collected)
	set_deferred("monitorable", not collected)
