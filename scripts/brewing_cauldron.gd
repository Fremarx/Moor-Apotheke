extends "res://scripts/interactable.gd"

const NIGHT_POTION_RECIPE: Resource = preload("res://resources/recipes/night_potion.tres")
const STRENGTHENING_RECIPE: Resource = preload("res://resources/recipes/strengthening_infusion.tres")
const CALMING_TEA_RECIPE: Resource = preload("res://resources/recipes/calming_tea.tres")

var _recipes: Array[Resource] = [NIGHT_POTION_RECIPE, STRENGTHENING_RECIPE, CALMING_TEA_RECIPE]
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

	var night_potion_unlocked := _is_recipe_unlocked(NIGHT_POTION_RECIPE)
	var has_night_potion_ingredient := int(_inventory.call("get_count", "dried_night_moss")) > 0 or (
		night_potion_unlocked and int(_inventory.call("get_count", "dried_reed_root")) > 0
	)
	if has_night_potion_ingredient:
		if night_potion_unlocked:
			return str(NIGHT_POTION_RECIPE.get("missing_feedback"))
		return str(NIGHT_POTION_RECIPE.get("locked_feedback"))

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
