extends Node

signal state_changed(state: String)

const STATE_NOT_ACCEPTED := "not_accepted"
const STATE_ACTIVE := "active"
const STATE_COMPLETED := "completed"
const REWARD_COINS := 15

var state: String = STATE_NOT_ACCEPTED
var _inventory: Node
var _marten_quest: Node


func set_inventory(inventory: Node) -> void:
	_inventory = inventory


func set_marten_quest(marten_quest: Node) -> void:
	_marten_quest = marten_quest


func is_available() -> bool:
	return is_instance_valid(_marten_quest) and str(_marten_quest.get("state")) == "completed"


func can_accept() -> bool:
	return state == STATE_NOT_ACCEPTED and is_available()


func accept() -> bool:
	if not can_accept():
		return false
	_set_state(STATE_ACTIVE)
	return true


func interact() -> String:
	if not is_available():
		return "Bitte hilf zuerst Marten mit seinem Auftrag."

	if state == STATE_NOT_ACCEPTED:
		return "Nimm Lenes Bitte am Auftragsbrett an."

	if state == STATE_ACTIVE:
		if not is_instance_valid(_inventory):
			return "Lene braucht noch einen Nachttrank."
		if not bool(_inventory.call("remove_item", "night_potion", 1)):
			return "Lene braucht noch einen Nachttrank."

		_set_state(STATE_COMPLETED)
		_inventory.call("add_item", "coins", REWARD_COINS)
		return "Danke für den Nachttrank. Lenes Bitte ist erfüllt. Du erhältst %d Münzen." % REWARD_COINS

	return "Lene dankt dir noch einmal."


func _set_state(next_state: String) -> void:
	if state == next_state:
		return

	state = next_state
	state_changed.emit(state)
