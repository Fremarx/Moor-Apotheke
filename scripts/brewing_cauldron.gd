extends "res://scripts/interactable.gd"

const STRENGTHENING_RECIPE: Resource = preload("res://resources/recipes/strengthening_infusion.tres")
const CALMING_TEA_RECIPE: Resource = preload("res://resources/recipes/calming_tea.tres")

var _recipes: Array[Resource] = [STRENGTHENING_RECIPE, CALMING_TEA_RECIPE]
var _inventory: Node
var _quest_states: Dictionary = {}


func _ready() -> void:
	super._ready()
	add_to_group("processing_stations")


func set_inventory(inventory: Node) -> void:
	_inventory = inventory


func set_quest_state(quest_id: String, state: String) -> void:
	if quest_id.is_empty():
		return
	_quest_states[quest_id] = state


func interact() -> String:
	if not is_instance_valid(_inventory):
		return "Der Braukessel ist gerade nicht erreichbar."

	for recipe in _recipes:
		if not _is_recipe_unlocked(recipe):
			continue
		var brewed := bool(_inventory.call(
			"craft_items",
			recipe.get("ingredients"),
			recipe.get("result_item_id"),
			1
		))
		if brewed:
			return str(recipe.get("success_feedback"))

	if int(_inventory.call("get_count", "dried_reed_root")) > 0:
		if _is_recipe_unlocked(STRENGTHENING_RECIPE):
			return str(STRENGTHENING_RECIPE.get("missing_feedback"))
		return str(STRENGTHENING_RECIPE.get("locked_feedback"))

	return str(CALMING_TEA_RECIPE.get("missing_feedback"))


func _is_recipe_unlocked(recipe: Resource) -> bool:
	var required_quest_id := str(recipe.get("required_quest_id"))
	if required_quest_id.is_empty():
		return true
	return str(_quest_states.get(required_quest_id, "")) == str(recipe.get("required_quest_state"))


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
