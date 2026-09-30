extends Node2D

@onready var _player: Node = $World/Player
@onready var _inventory: Node = $Inventory
@onready var _save_manager: Node = $SaveManager
@onready var _fenja_quest: Node = $Quest/FenjaQuest
@onready var _marten_quest: Node = $Quest/MartenQuest
@onready var _lene_quest: Node = $Quest/LeneQuest
@onready var _quest_board: Area2D = $World/TestMap/QuestBoard
@onready var _quest_board_panel: PanelContainer = $HUD/QuestBoardPanel
@onready var _fenja_accept_button: Button = $HUD/QuestBoardPanel/Content/FenjaRow/AcceptButton
@onready var _marten_accept_button: Button = $HUD/QuestBoardPanel/Content/MartenRow/AcceptButton
@onready var _lene_accept_button: Button = $HUD/QuestBoardPanel/Content/LeneRow/AcceptButton
@onready var _quest_board_close_button: Button = $HUD/QuestBoardPanel/Content/CloseButton
@onready var _inventory_count: Label = $HUD/InventoryCount
@onready var _reed_root_count: Label = $HUD/ReedRootCount
@onready var _dried_mint_count: Label = $HUD/DriedMintCount
@onready var _dried_reed_root_count: Label = $HUD/DriedReedRootCount
@onready var _tea_count: Label = $HUD/TeaCount
@onready var _infusion_count: Label = $HUD/InfusionCount
@onready var _night_moss_count: Label = $HUD/NightMossCount
@onready var _dried_night_moss_count: Label = $HUD/DriedNightMossCount
@onready var _night_potion_count: Label = $HUD/NightPotionCount
@onready var _coin_count: Label = $HUD/CoinCount
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
	_lene_quest.state_changed.connect(_on_lene_quest_state_changed)
	_quest_board.connect("open_requested", _on_quest_board_open_requested)
	_fenja_accept_button.pressed.connect(_on_fenja_accept_pressed)
	_marten_accept_button.pressed.connect(_on_marten_accept_pressed)
	_lene_accept_button.pressed.connect(_on_lene_accept_pressed)
	_quest_board_close_button.pressed.connect(_close_quest_board)
	_feedback_timer.timeout.connect(_on_feedback_timer_timeout)
	_fenja_quest.set_inventory(_inventory)
	_marten_quest.set_inventory(_inventory)
	_marten_quest.set_fenja_quest(_fenja_quest)
	_lene_quest.set_inventory(_inventory)
	_lene_quest.set_marten_quest(_marten_quest)

	for pickup in get_tree().get_nodes_in_group("item_pickups"):
		if pickup.has_signal("item_collected"):
			pickup.item_collected.connect(_inventory.add_item)

	for station in get_tree().get_nodes_in_group("processing_stations"):
		if station.has_method("set_inventory"):
			station.set_inventory(_inventory)
		if station.has_method("set_quest_state"):
			station.set_quest_state("fenja", str(_fenja_quest.get("state")))
			station.set_quest_state("marten", str(_marten_quest.get("state")))

	var quests_by_id := {"fenja": _fenja_quest, "marten": _marten_quest, "lene": _lene_quest}
	for quest_npc in get_tree().get_nodes_in_group("quest_npcs"):
		if quest_npc.has_method("set_quest"):
			var quest_id := str(quest_npc.get("quest_id"))
			if quests_by_id.has(quest_id):
				quest_npc.set_quest(quests_by_id[quest_id])

	_load_save_on_startup()
	_update_quest_status()
	_refresh_quest_board()


func _unhandled_input(event: InputEvent) -> void:
	if _quest_board_panel.visible and event.is_action_pressed("ui_cancel"):
		_close_quest_board()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("save_game"):
		save_game()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("load_game"):
		load_game()
		get_viewport().set_input_as_handled()


func save_game() -> bool:
	var pickups := _get_pickups_by_id()
	if pickups.is_empty():
		_on_interaction_completed("Speichern ist gerade nicht möglich.")
		return false

	var collected_pickups: Array[String] = []
	for pickup_id in pickups:
		if bool(pickups[pickup_id].call("is_collected")):
			collected_pickups.append(pickup_id)
	collected_pickups.sort()

	var save_data := {
		"version": 1,
		"player": {"x": _player.position.x, "y": _player.position.y},
		"inventory": _inventory.call("get_save_data"),
		"quests": {
			"fenja": str(_fenja_quest.get("state")),
			"marten": str(_marten_quest.get("state")),
			"lene": str(_lene_quest.get("state")),
		},
		"collected_pickups": collected_pickups,
	}
	if not bool(_save_manager.call("write_save_data", save_data)):
		_on_interaction_completed("Der Spielstand konnte nicht gespeichert werden.")
		return false

	_on_interaction_completed("Spielstand gespeichert.")
	return true


func load_game() -> bool:
	if not bool(_save_manager.call("has_save_file")):
		_on_interaction_completed("Kein Spielstand gefunden.")
		return false

	var save_data: Dictionary = _save_manager.call("read_save_data")
	if not _is_valid_save_data(save_data):
		_on_interaction_completed("Der Spielstand ist ungültig oder nicht unterstützt.")
		return false

	_apply_save_data(save_data)
	_on_interaction_completed("Spielstand geladen.")
	return true


func _load_save_on_startup() -> void:
	if not bool(_save_manager.call("has_save_file")):
		return

	var save_data: Dictionary = _save_manager.call("read_save_data")
	if _is_valid_save_data(save_data):
		_apply_save_data(save_data)


func _is_valid_save_data(save_data: Variant) -> bool:
	if typeof(save_data) != TYPE_DICTIONARY:
		return false
	if not _is_save_number(save_data.get("version")) or float(save_data["version"]) != 1.0:
		return false

	var saved_player: Variant = save_data.get("player")
	if typeof(saved_player) != TYPE_DICTIONARY or not saved_player.has("x") or not saved_player.has("y"):
		return false
	if not _is_save_number(saved_player["x"]) or not _is_save_number(saved_player["y"]):
		return false
	var saved_position := Vector2(float(saved_player["x"]), float(saved_player["y"]))
	if saved_position.x < 0.0 or saved_position.x > 640.0 or saved_position.y < 0.0 or saved_position.y > 360.0:
		return false

	if not bool(_inventory.call("validate_save_data", save_data.get("inventory"))):
		return false

	var saved_quests: Variant = save_data.get("quests")
	if typeof(saved_quests) != TYPE_DICTIONARY:
		return false
	if not saved_quests.has("fenja") or not saved_quests.has("marten") or not saved_quests.has("lene"):
		return false
	if not bool(_fenja_quest.call("can_restore_state", saved_quests["fenja"])):
		return false
	if not bool(_marten_quest.call("can_restore_state", saved_quests["marten"])):
		return false
	if not bool(_lene_quest.call("can_restore_state", saved_quests["lene"])):
		return false
	if str(saved_quests["marten"]) != "not_accepted" and str(saved_quests["fenja"]) != "completed":
		return false
	if str(saved_quests["lene"]) != "not_accepted" and str(saved_quests["marten"]) != "completed":
		return false

	var pickups := _get_pickups_by_id()
	if pickups.is_empty():
		return false
	var saved_pickups: Variant = save_data.get("collected_pickups")
	if typeof(saved_pickups) != TYPE_ARRAY:
		return false
	var seen_pickups: Dictionary = {}
	for pickup_id in saved_pickups:
		if typeof(pickup_id) != TYPE_STRING or not pickups.has(pickup_id) or seen_pickups.has(pickup_id):
			return false
		seen_pickups[pickup_id] = true
	return true


func _is_save_number(value: Variant) -> bool:
	if typeof(value) != TYPE_INT and typeof(value) != TYPE_FLOAT:
		return false
	return is_finite(float(value))


func _get_pickups_by_id() -> Dictionary:
	var pickups: Dictionary = {}
	for pickup in get_tree().get_nodes_in_group("item_pickups"):
		if not pickup.has_method("get_pickup_id") or not pickup.has_method("is_collected"):
			return {}
		var pickup_id: Variant = pickup.call("get_pickup_id")
		if typeof(pickup_id) != TYPE_STRING or str(pickup_id).is_empty() or pickups.has(pickup_id):
			return {}
		pickups[pickup_id] = pickup
	return pickups


func _apply_save_data(save_data: Dictionary) -> void:
	var saved_player: Dictionary = save_data["player"]
	_player.position = Vector2(float(saved_player["x"]), float(saved_player["y"]))
	_inventory.call("restore_from_save", save_data["inventory"])
	_fenja_quest.call("restore_state", save_data["quests"]["fenja"])
	_marten_quest.call("restore_state", save_data["quests"]["marten"])
	_lene_quest.call("restore_state", save_data["quests"]["lene"])

	var collected_pickups: Array = save_data["collected_pickups"]
	var pickups := _get_pickups_by_id()
	for pickup_id in pickups:
		pickups[pickup_id].call("set_collected", collected_pickups.has(pickup_id))

	_update_quest_status()
	_refresh_quest_board()
	_player.call("refresh_interactable_prompt")


func _on_quest_board_open_requested() -> void:
	_refresh_quest_board()
	_quest_board_panel.show()
	_player.set_physics_process(false)
	_player.set_process_unhandled_input(false)
	if not _fenja_accept_button.disabled:
		_fenja_accept_button.grab_focus()
	elif not _marten_accept_button.disabled:
		_marten_accept_button.grab_focus()
	elif not _lene_accept_button.disabled:
		_lene_accept_button.grab_focus()
	else:
		_quest_board_close_button.grab_focus()


func _close_quest_board() -> void:
	_quest_board_panel.hide()
	_fenja_accept_button.release_focus()
	_marten_accept_button.release_focus()
	_lene_accept_button.release_focus()
	_quest_board_close_button.release_focus()
	_player.set_physics_process(true)
	_player.set_process_unhandled_input(true)
	_player.call_deferred("refresh_interactable_prompt")


func _on_fenja_accept_pressed() -> void:
	_accept_quest_from_board(
		_fenja_quest,
		"Fenja bittet dich um einen Beruhigungstee.",
		"Fenjas Bitte kann gerade nicht angenommen werden."
	)


func _on_marten_accept_pressed() -> void:
	_accept_quest_from_board(
		_marten_quest,
		"Marten bittet dich um einen stärkenden Aufguss.",
		"Martens Bitte ist noch gesperrt. Hilf zuerst Fenja."
	)


func _on_lene_accept_pressed() -> void:
	_accept_quest_from_board(
		_lene_quest,
		"Lene bittet dich um einen Nachttrank.",
		"Lenes Bitte ist noch gesperrt. Hilf zuerst Marten."
	)


func _accept_quest_from_board(quest: Node, accepted_feedback: String, locked_feedback: String) -> void:
	if bool(quest.call("accept")):
		_on_interaction_completed(accepted_feedback)
	else:
		_on_interaction_completed(locked_feedback)
	_refresh_quest_board()


func _refresh_quest_board() -> void:
	if not is_node_ready():
		return
	_refresh_quest_row(_fenja_accept_button, _fenja_quest)
	_refresh_quest_row(_marten_accept_button, _marten_quest)
	_refresh_quest_row(_lene_accept_button, _lene_quest)


func _refresh_quest_row(button: Button, quest: Node) -> void:
	var state := str(quest.get("state"))
	if state == "active":
		button.text = "In Arbeit"
		button.disabled = true
	elif state == "completed":
		button.text = "Erledigt"
		button.disabled = true
	elif bool(quest.call("can_accept")):
		button.text = "Annehmen"
		button.disabled = false
	else:
		button.text = "Gesperrt"
		button.disabled = true


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
	if item_id == "coins":
		_coin_count.text = "Münzen: %d" % amount
	elif item_id == "sump_mint":
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
	elif item_id == "night_potion":
		_night_potion_count.text = "Nachttrank: %d" % amount

	_update_quest_status()


func _on_quest_state_changed(state: String) -> void:
	for station in get_tree().get_nodes_in_group("processing_stations"):
		if station.has_method("set_quest_state"):
			station.set_quest_state("fenja", state)
	_update_quest_status()
	_refresh_quest_board()
	_player.call("refresh_interactable_prompt")


func _on_lene_quest_state_changed(_state: String) -> void:
	_update_quest_status()
	_refresh_quest_board()
	_player.call("refresh_interactable_prompt")


func _on_marten_quest_state_changed(state: String) -> void:
	for station in get_tree().get_nodes_in_group("processing_stations"):
		if station.has_method("set_quest_state"):
			station.set_quest_state("marten", state)
	_update_quest_status()
	_refresh_quest_board()
	_player.call("refresh_interactable_prompt")


func _update_quest_status() -> void:
	var quest_state := str(_fenja_quest.get("state"))
	var marten_state := str(_marten_quest.get("state"))
	var lene_state := str(_lene_quest.get("state"))
	if lene_state == "active":
		if int(_inventory.call("get_count", "night_potion")) > 0:
			_quest_status.text = "Bringe Lene den Nachttrank."
		elif int(_inventory.call("get_count", "dried_reed_root")) == 0:
			if int(_inventory.call("get_count", "reed_root")) > 0:
				_quest_status.text = "Trockne die Schilfwurzel für Lene."
			else:
				_quest_status.text = "Sammle eine Schilfwurzel für Lene."
		elif int(_inventory.call("get_count", "dried_night_moss")) == 0:
			if int(_inventory.call("get_count", "night_moss")) > 0:
				_quest_status.text = "Trockne das Nachtmoos für Lene."
			else:
				_quest_status.text = "Sammle Nachtmoos für Lene."
		else:
			_quest_status.text = "Braue den Nachttrank für Lene."
		_quest_status.show()
	elif lene_state == "completed":
		_quest_status.text = "Aufgabe erfüllt: Lenes Bitte."
		_quest_status.show()
	elif marten_state == "active":
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
