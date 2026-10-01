extends Node

signal item_count_changed(item_id: String, amount: int)

const VALID_ITEM_IDS: Array[String] = [
	"sump_mint",
	"reed_root",
	"dried_sump_mint",
	"dried_reed_root",
	"calming_tea",
	"strengthening_infusion",
	"night_moss",
	"dried_night_moss",
	"night_potion",
	"peat_heart",
	"coins",
]

var _items: Dictionary[String, int] = {}


func add_item(item_id: String, amount: int = 1) -> void:
	if item_id.is_empty() or amount <= 0:
		return

	var next_count := get_count(item_id) + amount
	_store_count(item_id, next_count)
	item_count_changed.emit(item_id, next_count)


func remove_item(item_id: String, amount: int = 1) -> bool:
	if item_id.is_empty() or amount <= 0:
		return false

	var current_count := get_count(item_id)
	if current_count < amount:
		return false

	var next_count := current_count - amount
	_store_count(item_id, next_count)
	item_count_changed.emit(item_id, next_count)
	return true


func transfer_item(source_id: String, destination_id: String, amount: int = 1) -> bool:
	if source_id.is_empty() or destination_id.is_empty() or source_id == destination_id or amount <= 0:
		return false

	var source_count := get_count(source_id)
	if source_count < amount:
		return false

	var next_source_count := source_count - amount
	var next_destination_count := get_count(destination_id) + amount
	_store_count(source_id, next_source_count)
	_store_count(destination_id, next_destination_count)
	item_count_changed.emit(source_id, next_source_count)
	item_count_changed.emit(destination_id, next_destination_count)
	return true


func craft_items(ingredients: Dictionary, result_id: String, result_amount: int = 1) -> bool:
	if ingredients.is_empty() or result_id.is_empty() or result_amount <= 0:
		return false
	if ingredients.has(result_id):
		return false

	var ingredient_ids: Array[String] = []
	for raw_item_id in ingredients.keys():
		if typeof(raw_item_id) != TYPE_STRING:
			return false
		var item_id := str(raw_item_id)
		var required_amount: Variant = ingredients[raw_item_id]
		if item_id.is_empty() or typeof(required_amount) != TYPE_INT or int(required_amount) <= 0:
			return false
		if get_count(item_id) < int(required_amount):
			return false
		ingredient_ids.append(item_id)

	var changed_counts: Dictionary[String, int] = {}
	for item_id in ingredient_ids:
		var next_count := get_count(item_id) - int(ingredients[item_id])
		_store_count(item_id, next_count)
		changed_counts[item_id] = next_count

	var next_result_count := get_count(result_id) + result_amount
	_store_count(result_id, next_result_count)
	changed_counts[result_id] = next_result_count

	for item_id in changed_counts:
		item_count_changed.emit(item_id, changed_counts[item_id])
	return true


func get_count(item_id: String) -> int:
	return _items.get(item_id, 0)


func get_save_data() -> Dictionary:
	return _items.duplicate(true)


func validate_save_data(saved_items: Variant) -> bool:
	var normalized_items: Dictionary[String, int] = {}
	return _build_saved_items(saved_items, normalized_items)


func restore_from_save(saved_items: Variant) -> bool:
	var restored_items: Dictionary[String, int] = {}
	if not _build_saved_items(saved_items, restored_items):
		return false

	var changed_item_ids: Dictionary[String, bool] = {}
	for item_id in _items:
		changed_item_ids[item_id] = true
	for item_id in restored_items:
		changed_item_ids[item_id] = true

	_items = restored_items
	for item_id in changed_item_ids:
		item_count_changed.emit(item_id, get_count(item_id))
	return true


func _build_saved_items(saved_items: Variant, normalized_items: Dictionary[String, int]) -> bool:
	if typeof(saved_items) != TYPE_DICTIONARY:
		return false

	normalized_items.clear()
	for raw_item_id in saved_items:
		if typeof(raw_item_id) != TYPE_STRING:
			return false
		var item_id := str(raw_item_id)
		if not VALID_ITEM_IDS.has(item_id):
			return false

		var raw_amount: Variant = saved_items[raw_item_id]
		if typeof(raw_amount) != TYPE_INT and typeof(raw_amount) != TYPE_FLOAT:
			return false
		var numeric_amount := float(raw_amount)
		if not is_finite(numeric_amount) or numeric_amount < 0 or numeric_amount > 2147483647.0:
			return false
		if floor(numeric_amount) != numeric_amount:
			return false

		var amount := int(numeric_amount)
		if amount > 0:
			normalized_items[item_id] = amount
	return true


func _store_count(item_id: String, amount: int) -> void:
	if amount == 0:
		_items.erase(item_id)
	else:
		_items[item_id] = amount
