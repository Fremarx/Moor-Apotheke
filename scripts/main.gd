extends Node2D

@onready var _player: Node = $World/Player
@onready var _inventory: Node = $Inventory
@onready var _fenja_quest: Node = $Quest/FenjaQuest
@onready var _marten_quest: Node = $Quest/MartenQuest
@onready var _inventory_count: Label = $HUD/InventoryCount
@onready var _reed_root_count: Label = $HUD/ReedRootCount
@onready var _dried_mint_count: Label = $HUD/DriedMintCount
@onready var _dried_reed_root_count: Label = $HUD/DriedReedRootCount
@onready var _tea_count: Label = $HUD/TeaCount
@onready var _infusion_count: Label = $HUD/InfusionCount
@onready var _night_moss_count: Label = $HUD/NightMossCount
@onready var _dried_night_moss_count: Label = $HUD/DriedNightMossCount
@onready var _quest_status: Label = $HUD/QuestStatus
@onready var _interaction_prompt: Label = $HUD/InteractionPrompt
@onready var _interaction_feedback: Label = $HUD/InteractionFeedback
@onready var _feedback_timer: Timer = $HUD/FeedbackTimer


func _ready() -> void:
	_player.connect("interaction_hint_changed", _on_interaction_hint_changed)
	_player.connect("interaction_completed", _on_interaction_completed)
	_inventory.item_count_changed.connect(_on_item_count_changed)
	_fenja_quest.state_changed.connect(_on_quest_state_changed)
	_marten_quest.state_changed.connect(_on_marten_quest_state_changed)
	_feedback_timer.timeout.connect(_on_feedback_timer_timeout)
	_fenja_quest.set_inventory(_inventory)
	_marten_quest.set_inventory(_inventory)
	_marten_quest.set_fenja_quest(_fenja_quest)

	for pickup in get_tree().get_nodes_in_group("item_pickups"):
		if pickup.has_signal("item_collected"):
			pickup.item_collected.connect(_inventory.add_item)

	for station in get_tree().get_nodes_in_group("processing_stations"):
		if station.has_method("set_inventory"):
			station.set_inventory(_inventory)
		if station.has_method("set_quest_state"):
			station.set_quest_state("fenja", str(_fenja_quest.get("state")))

	var quests_by_id := {"fenja": _fenja_quest, "marten": _marten_quest}
	for quest_npc in get_tree().get_nodes_in_group("quest_npcs"):
		if quest_npc.has_method("set_quest"):
			var quest_id := str(quest_npc.get("quest_id"))
			if quests_by_id.has(quest_id):
				quest_npc.set_quest(quests_by_id[quest_id])

	_update_quest_status()


func _on_interaction_hint_changed(prompt_text: String) -> void:
	_interaction_prompt.text = prompt_text
	_interaction_prompt.visible = not prompt_text.is_empty()


func _on_interaction_completed(feedback_text: String) -> void:
	if feedback_text.is_empty():
		return

	_interaction_feedback.text = feedback_text
	_interaction_feedback.show()
	_feedback_timer.start()


func _on_item_count_changed(item_id: String, amount: int) -> void:
	if item_id == "sump_mint":
		_inventory_count.text = "Sumpfminze: %d" % amount
	elif item_id == "reed_root":
		_reed_root_count.text = "Schilfwurzel: %d" % amount
	elif item_id == "dried_sump_mint":
		_dried_mint_count.text = "Getrocknete Minze: %d" % amount
	elif item_id == "dried_reed_root":
		_dried_reed_root_count.text = "Getrocknete Schilfwurzel: %d" % amount
	elif item_id == "calming_tea":
		_tea_count.text = "Beruhigungstee: %d" % amount
	elif item_id == "strengthening_infusion":
		_infusion_count.text = "Stärkender Aufguss: %d" % amount
	elif item_id == "night_moss":
		_night_moss_count.text = "Nachtmoos: %d" % amount
	elif item_id == "dried_night_moss":
		_dried_night_moss_count.text = "Getrocknetes Nachtmoos: %d" % amount

	_update_quest_status()


func _on_quest_state_changed(state: String) -> void:
	for station in get_tree().get_nodes_in_group("processing_stations"):
		if station.has_method("set_quest_state"):
			station.set_quest_state("fenja", state)
	_update_quest_status()
	_player.call("refresh_interactable_prompt")


func _on_marten_quest_state_changed(_state: String) -> void:
	_update_quest_status()
	_player.call("refresh_interactable_prompt")


func _update_quest_status() -> void:
	var quest_state := str(_fenja_quest.get("state"))
	var marten_state := str(_marten_quest.get("state"))
	if marten_state == "active":
		if int(_inventory.call("get_count", "strengthening_infusion")) > 0:
			_quest_status.text = "Bringe Marten den Stärkenden Aufguss."
		elif int(_inventory.call("get_count", "dried_sump_mint")) == 0:
			if int(_inventory.call("get_count", "sump_mint")) > 0:
				_quest_status.text = "Trockne die Sumpfminze für Marten."
			else:
				_quest_status.text = "Sammle eine Sumpfminze für Marten."
		elif int(_inventory.call("get_count", "dried_reed_root")) == 0:
			if int(_inventory.call("get_count", "reed_root")) > 0:
				_quest_status.text = "Trockne die Schilfwurzel für Marten."
			else:
				_quest_status.text = "Sammle eine Schilfwurzel für Marten."
		else:
			_quest_status.text = "Braue den Stärkenden Aufguss für Marten."
		_quest_status.show()
	elif marten_state == "completed":
		_quest_status.text = "Aufgabe erfüllt: Martens Bitte."
		_quest_status.show()
	elif quest_state == "active":
		if int(_inventory.call("get_count", "calming_tea")) > 0:
			_quest_status.text = "Bringe Fenja den Beruhigungstee."
		elif int(_inventory.call("get_count", "dried_sump_mint")) > 0:
			_quest_status.text = "Braue Beruhigungstee."
		elif int(_inventory.call("get_count", "sump_mint")) > 0:
			_quest_status.text = "Trockne die Sumpfminze."
		else:
			_quest_status.text = "Sammle eine Sumpfminze."
		_quest_status.show()
	elif quest_state == "completed":
		_quest_status.text = "Aufgabe erfüllt: Fenjas Bitte."
		_quest_status.show()
	else:
		_quest_status.hide()


func _on_feedback_timer_timeout() -> void:
	_interaction_feedback.hide()
