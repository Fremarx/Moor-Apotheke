extends Node

signal state_changed(state: String)

const STATE_NOT_ACCEPTED := "not_accepted"
const STATE_ACTIVE := "active"
const STATE_COMPLETED := "completed"
const REWARD_COINS := 5

var state: String = STATE_NOT_ACCEPTED
var _inventory: Node


func set_inventory(inventory: Node) -> void:
	_inventory = inventory


func can_accept() -> bool:
	return state == STATE_NOT_ACCEPTED


func accept() -> bool:
	if not can_accept():
		return false
	_set_state(STATE_ACTIVE)
	return true


func interact() -> String:
	if state == STATE_NOT_ACCEPTED:
		return "Nimm Fenjas Bitte am Auftragsbrett an."

	if state == STATE_ACTIVE:
		if not is_instance_valid(_inventory):
			return "Fenja braucht noch einen Beruhigungstee."
		if not bool(_inventory.call("remove_item", "calming_tea", 1)):
			return "Fenja braucht noch einen Beruhigungstee."

		_set_state(STATE_COMPLETED)
		_inventory.call("add_item", "coins", REWARD_COINS)
		return "Danke für den Beruhigungstee. Fenjas Bitte ist erfüllt. Du erhältst %d Münzen." % REWARD_COINS

	return "Fenja dankt dir noch einmal."


func can_restore_state(saved_state: Variant) -> bool:
	return typeof(saved_state) == TYPE_STRING and str(saved_state) in [
		STATE_NOT_ACCEPTED,
		STATE_ACTIVE,
		STATE_COMPLETED,
	]


func restore_state(saved_state: Variant) -> bool:
	if not can_restore_state(saved_state):
		return false

	_set_state(str(saved_state))
	return true


func _set_state(next_state: String) -> void:
	if state == next_state:
		return

	state = next_state
	state_changed.emit(state)
