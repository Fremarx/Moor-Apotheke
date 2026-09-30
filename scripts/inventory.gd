extends Node

signal item_count_changed(item_id: String, amount: int)

var _items: Dictionary[String, int] = {}


func add_item(item_id: String, amount: int = 1) -> void:
	if item_id.is_empty() or amount <= 0:
		return

	var next_count := get_count(item_id) + amount
	_items[item_id] = next_count
	item_count_changed.emit(item_id, next_count)


func get_count(item_id: String) -> int:
	return _items.get(item_id, 0)
