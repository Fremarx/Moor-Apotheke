extends Node

signal state_changed(state: String)

const STATE_NOT_ACCEPTED := "not_accepted"
const STATE_ACTIVE := "active"
const STATE_COMPLETED := "completed"

var state: String = STATE_NOT_ACCEPTED
var _inventory: Node


func set_inventory(inventory: Node) -> void:
	_inventory = inventory


func interact() -> String:
	if state == STATE_NOT_ACCEPTED:
		_set_state(STATE_ACTIVE)
		return "Fenja bittet dich um einen Beruhigungstee."

	if state == STATE_ACTIVE:
		if not is_instance_valid(_inventory):
			return "Fenja braucht noch einen Beruhigungstee."
		if not bool(_inventory.call("remove_item", "calming_tea", 1)):
			return "Fenja braucht noch einen Beruhigungstee."

		_set_state(STATE_COMPLETED)
		return "Danke für den Beruhigungstee. Fenjas Bitte ist erfüllt."

	return "Fenja dankt dir noch einmal."


func _set_state(next_state: String) -> void:
	if state == next_state:
		return

	state = next_state
	state_changed.emit(state)
