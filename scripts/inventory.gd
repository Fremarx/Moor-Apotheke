extends Node

signal item_count_changed(item_id: String, amount: int)

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


func get_count(item_id: String) -> int:
	return _items.get(item_id, 0)


func _store_count(item_id: String, amount: int) -> void:
	if amount == 0:
		_items.erase(item_id)
	else:
		_items[item_id] = amount
