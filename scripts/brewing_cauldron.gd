extends "res://scripts/interactable.gd"

var _inventory: Node


func _ready() -> void:
	super._ready()
	add_to_group("processing_stations")


func set_inventory(inventory: Node) -> void:
	_inventory = inventory


func interact() -> String:
	if not is_instance_valid(_inventory):
		return "Der Braukessel ist gerade nicht erreichbar."

	var brewed := bool(_inventory.call("transfer_item", "dried_sump_mint", "calming_tea", 1))
	if not brewed:
		return "Du brauchst getrocknete Sumpfminze für den Beruhigungstee."

	return "Der Beruhigungstee ist fertig."


func _draw() -> void:
	draw_rect(Rect2(Vector2(-14, 5), Vector2(28, 4)), Color("46513d"))
	draw_line(Vector2(-10, 1), Vector2(-12, 7), Color("654d37"), 2.0)
	draw_line(Vector2(10, 1), Vector2(12, 7), Color("654d37"), 2.0)
	draw_rect(Rect2(Vector2(-11, -5), Vector2(22, 12)), Color("405b54"))
	draw_rect(Rect2(Vector2(-12, -7), Vector2(24, 3)), Color("806448"))
	draw_line(Vector2(-13, -5), Vector2(-16, -2), Color("806448"), 3.0)
	draw_line(Vector2(13, -5), Vector2(16, -2), Color("806448"), 3.0)
	draw_line(Vector2(-5, -9), Vector2(-7, -13), Color("a6a985"), 1.0)
	draw_line(Vector2(3, -9), Vector2(4, -14), Color("a6a985"), 1.0)
	draw_rect(Rect2(Vector2(-5, -2), Vector2(3, 2)), Color("839579"))
	draw_rect(Rect2(Vector2(2, 1), Vector2(4, 2)), Color("a1ad85"))
