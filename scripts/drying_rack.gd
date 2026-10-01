extends "res://scripts/interactable.gd"

var _inventory: Node


func _ready() -> void:
	super._ready()
	add_to_group("processing_stations")


func set_inventory(inventory: Node) -> void:
	_inventory = inventory


func interact() -> String:
	if not is_instance_valid(_inventory):
		return "Das Trockengestell ist gerade nicht erreichbar."

	var mint_processed := bool(_inventory.call("transfer_item", "sump_mint", "dried_sump_mint", 1))
	if mint_processed:
		return "Die Sumpfminze ist getrocknet."

	var reed_root_processed := bool(_inventory.call("transfer_item", "reed_root", "dried_reed_root", 1))
	if reed_root_processed:
		return "Die Schilfwurzel ist getrocknet."

	var night_moss_processed := bool(_inventory.call("transfer_item", "night_moss", "dried_night_moss", 1))
	if night_moss_processed:
		return "Das Nachtmoos ist getrocknet."

	return "Du brauchst frische Sumpfminze, eine frische Schilfwurzel oder frisches Nachtmoos zum Trocknen."
