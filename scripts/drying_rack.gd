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

	return "Du brauchst frische Sumpfminze oder eine frische Schilfwurzel zum Trocknen."


func _draw() -> void:
	draw_rect(Rect2(Vector2(-14, 6), Vector2(28, 3)), Color("46513d"))
	draw_line(Vector2(-11, -2), Vector2(-13, 7), Color("654d37"), 3.0)
	draw_line(Vector2(11, -2), Vector2(13, 7), Color("654d37"), 3.0)
	draw_rect(Rect2(Vector2(-11, -4), Vector2(22, 4)), Color("765a3d"))
	draw_line(Vector2(-9, -4), Vector2(-9, -10), Color("765a3d"), 2.0)
	draw_line(Vector2(9, -4), Vector2(9, -10), Color("765a3d"), 2.0)
	draw_line(Vector2(-9, -9), Vector2(9, -9), Color("92724a"), 2.0)
	draw_line(Vector2(-7, -7), Vector2(-3, -3), Color("74804d"), 2.0)
	draw_line(Vector2(-1, -7), Vector2(2, -3), Color("899657"), 2.0)
	draw_line(Vector2(5, -7), Vector2(7, -3), Color("a1a763"), 2.0)
	draw_rect(Rect2(Vector2(-6, -7), Vector2(2, 2)), Color("bac078"))
