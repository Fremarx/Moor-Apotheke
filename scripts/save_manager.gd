extends Node

@export var save_path: String = "user://moor_apotheke_save.json"


func has_save_file() -> bool:
	return FileAccess.file_exists(save_path)


func write_save_data(save_data: Dictionary) -> bool:
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	if file == null:
		return false

	file.store_string(JSON.stringify(save_data, "\t", true, true))
	file.flush()
	var write_succeeded := file.get_error() == OK
	file.close()
	return write_succeeded


func read_save_data() -> Dictionary:
	if not has_save_file():
		return {}

	var file := FileAccess.open(save_path, FileAccess.READ)
	if file == null:
		return {}

	var json := JSON.new()
	var parse_error := json.parse(file.get_as_text())
	file.close()
	if parse_error != OK or typeof(json.data) != TYPE_DICTIONARY:
		return {}

	return json.data