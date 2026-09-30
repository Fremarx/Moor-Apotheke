extends Node

signal state_changed(state: String)

const STATE_NOT_ACCEPTED := "not_accepted"
const STATE_ACTIVE := "active"
const STATE_COMPLETED := "completed"
const REWARD_COINS := 10

var state: String = STATE_NOT_ACCEPTED
var _inventory: Node
var _fenja_quest: Node


func set_inventory(inventory: Node) -> void:
	_inventory = inventory


func set_fenja_quest(fenja_quest: Node) -> void:
	_fenja_quest = fenja_quest


func is_available() -> bool:
	return is_instance_valid(_fenja_quest) and str(_fenja_quest.get("state")) == "completed"


func can_accept() -> bool:
	return state == STATE_NOT_ACCEPTED and is_available()


func accept() -> bool:
	if not can_accept():
		return false
	_set_state(STATE_ACTIVE)
	return true


func interact() -> String:
	if not is_available():
		return "Bitte hilf zuerst Fenja mit ihrer Bitte."

	if state == STATE_NOT_ACCEPTED:
		return "Nimm Martens Bitte am Auftragsbrett an."

	if state == STATE_ACTIVE:
		if not is_instance_valid(_inventory):
			return "Marten braucht noch einen stärkenden Aufguss."
		if not bool(_inventory.call("remove_item", "strengthening_infusion", 1)):
			return "Marten braucht noch einen stärkenden Aufguss."

		_set_state(STATE_COMPLETED)
		_inventory.call("add_item", "coins", REWARD_COINS)
		return "Danke für den stärkenden Aufguss. Martens Bitte ist erfüllt. Du erhältst %d Münzen." % REWARD_COINS

	return "Marten dankt dir noch einmal."


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
