extends Node2D

const INVENTORY_COLUMNS: Array = [
	[
		{
			"title": "FRISCHE KRÄUTER",
			"items": [
				["sump_mint", "Sumpfminze", "fresh"],
				["reed_root", "Schilfwurzel", "fresh"],
				["night_moss", "Nachtmoos", "fresh"],
			],
		},
		{
			"title": "GETROCKNET",
			"items": [
				["dried_sump_mint", "Getr. Sumpfminze", "dried"],
				["dried_reed_root", "Getr. Schilfwurzel", "dried"],
				["dried_night_moss", "Getr. Nachtmoos", "dried"],
			],
		},
	],
	[
		{
			"title": "HEILMITTEL",
			"items": [
				["calming_tea", "Beruhigungstee", "remedy"],
				["strengthening_infusion", "Stärkender Aufguss", "remedy"],
				["night_potion", "Nachttrank", "remedy"],
			],
		},
		{
			"title": "REGIONALE FUNDSTÜCKE",
			"items": [["peat_heart", "Torfherz", "special"]],
		},
		{
			"title": "MÜNZEN",
			"items": [["coins", "Münzen", "coin"]],
		},
	],
]

const AREA_DISPLAY_NAMES := {
	"Dorfplatz": "Dorfplatz",
	"Schilfufer": "Schilfufer",
	"AlterTorfstich": "Alter Torfstich",
}

@onready var _player: Node = $World/Player
@onready var _camera: Camera2D = $World/Player/Camera2D
@onready var _schilfufer: Node = $World/Schilfufer
@onready var _alter_torfstich: Node = $World/AlterTorfstich
@onready var _inventory: Node = $Inventory
@onready var _save_manager: Node = $SaveManager
@onready var _fenja_quest: Node = $Quest/FenjaQuest
@onready var _marten_quest: Node = $Quest/MartenQuest
@onready var _lene_quest: Node = $Quest/LeneQuest
@onready var _quest_board: Area2D = $World/TestMap/QuestBoard
@onready var _quest_board_panel: PanelContainer = $HUD/QuestBoardPanel
@onready var _inventory_dim: ColorRect = $HUD/InventoryDim
@onready var _inventory_window_panel: PanelContainer = $HUD/InventoryWindowPanel
@onready var _inventory_left_column: VBoxContainer = $HUD/InventoryWindowPanel/Content/Columns/LeftColumn
@onready var _inventory_right_column: VBoxContainer = $HUD/InventoryWindowPanel/Content/Columns/RightColumn
@onready var _inventory_columns: HBoxContainer = $HUD/InventoryWindowPanel/Content/Columns
@onready var _inventory_title: Label = $HUD/InventoryWindowPanel/Content/Header/Title
@onready var _inventory_help: Label = $HUD/InventoryWindowPanel/Content/HelpText
@onready var _inventory_page_button: Button = $HUD/InventoryWindowPanel/Content/Header/PageButton
@onready var _herb_book_page: ScrollContainer = $HUD/InventoryWindowPanel/Content/HerbBookPage
@onready var _herb_book_entries: VBoxContainer = $HUD/InventoryWindowPanel/Content/HerbBookPage/Entries
@onready var _inventory_window_close_button: Button = $HUD/InventoryWindowPanel/Content/Header/CloseButton
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

var _inventory_window_counts: Dictionary = {}
var _discovered_pickups: Dictionary = {}


func _ready() -> void:
	_player.connect("interaction_hint_changed", _on_interaction_hint_changed)
	_player.connect("interaction_completed", _on_interaction_completed)
	_inventory.item_count_changed.connect(_on_item_count_changed)
	_fenja_quest.state_changed.connect(_on_quest_state_changed)
	_marten_quest.state_changed.connect(_on_marten_quest_state_changed)
	_lene_quest.state_changed.connect(_on_lene_quest_state_changed)
	_quest_board.connect("open_requested", _on_quest_board_open_requested)
	_inventory_window_close_button.pressed.connect(_close_inventory_window)
	_inventory_page_button.pressed.connect(_toggle_inventory_page)
	_build_inventory_window()
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
		if pickup.has_signal("resource_discovered"):
			pickup.resource_discovered.connect(_on_resource_discovered)
		if pickup.has_signal("item_collected"):
			pickup.item_collected.connect(_inventory.add_item)

	for transition in get_tree().get_nodes_in_group("map_transitions"):
		if transition.has_signal("transition_requested"):
			transition.transition_requested.connect(_on_map_transition_requested)

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
	_sync_torfstich_access()
	_refresh_inventory_window()
	_update_quest_status()
	_refresh_quest_board()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if _inventory_window_panel.visible:
			_close_inventory_window()
		elif _quest_board_panel.visible:
			_close_quest_board()
		else:
			return
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("toggle_inventory"):
		if not _quest_board_panel.visible:
			if _inventory_window_panel.visible:
				_close_inventory_window()
			else:
				_open_inventory_window()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("toggle_herb_book"):
		if not _quest_board_panel.visible:
			_toggle_herb_book()
		get_viewport().set_input_as_handled()
	elif _quest_board_panel.visible or _inventory_window_panel.visible:
		return
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
	var discovered_pickups: Array[String] = []
	for pickup_id in _discovered_pickups:
		discovered_pickups.append(str(pickup_id))
	discovered_pickups.sort()

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
		"discovered_pickups": discovered_pickups,
		"schilfufer": _schilfufer.call("get_save_data"),
		"alter_torfstich": _alter_torfstich.call("get_save_data"),
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

	var saved_schilfufer: Variant = save_data.get("schilfufer", {})
	if not bool(_schilfufer.call("can_restore_save_data", saved_schilfufer)):
		return false
	var saved_torfstich: Variant = save_data.get("alter_torfstich", {})
	if not bool(_alter_torfstich.call("can_restore_save_data", saved_torfstich)):
		return false

	var saved_player: Variant = save_data.get("player")
	if typeof(saved_player) != TYPE_DICTIONARY or not saved_player.has("x") or not saved_player.has("y"):
		return false
	if not _is_save_number(saved_player["x"]) or not _is_save_number(saved_player["y"]):
		return false
	var saved_position := Vector2(float(saved_player["x"]), float(saved_player["y"]))
	if not _is_valid_world_position(saved_position):
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

	var saved_discoveries: Variant = save_data.get("discovered_pickups", saved_pickups)
	if typeof(saved_discoveries) != TYPE_ARRAY:
		return false
	var seen_discoveries: Dictionary = {}
	for pickup_id in saved_discoveries:
		if typeof(pickup_id) != TYPE_STRING or not pickups.has(pickup_id) or seen_discoveries.has(pickup_id):
			return false
		seen_discoveries[pickup_id] = true
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
		if not pickup.has_method("get_area_id") or not pickup.has_method("get_location_name") or not pickup.has_method("get_resource_id") or not pickup.has_method("get_resource_rarity"):
			return {}
		var pickup_id: Variant = pickup.call("get_pickup_id")
		var area_id := StringName(pickup.call("get_area_id"))
		var location_name := str(pickup.call("get_location_name"))
		var resource_id := str(pickup.call("get_resource_id"))
		var rarity := StringName(pickup.call("get_resource_rarity"))
		if typeof(pickup_id) != TYPE_STRING or str(pickup_id).is_empty() or pickups.has(pickup_id):
			return {}
		if area_id.is_empty() or location_name.is_empty() or resource_id.is_empty() or (rarity != &"common" and rarity != &"rare"):
			return {}
		pickups[pickup_id] = pickup
	return pickups


func _apply_save_data(save_data: Dictionary) -> void:
	var saved_player: Dictionary = save_data["player"]
	_player.position = Vector2(float(saved_player["x"]), float(saved_player["y"]))
	_configure_camera_for_position(_player.global_position)
	_inventory.call("restore_from_save", save_data["inventory"])
	_fenja_quest.call("restore_state", save_data["quests"]["fenja"])
	_marten_quest.call("restore_state", save_data["quests"]["marten"])
	_lene_quest.call("restore_state", save_data["quests"]["lene"])

	var collected_pickups: Array = save_data["collected_pickups"]
	var pickups := _get_pickups_by_id()
	for pickup_id in pickups:
		pickups[pickup_id].call("set_collected", collected_pickups.has(pickup_id))
	_discovered_pickups.clear()
	var discovered_ids: Array = save_data.get("discovered_pickups", collected_pickups)
	for pickup_id in discovered_ids:
		var pickup: Node = pickups[pickup_id]
		_on_resource_discovered(
			str(pickup.call("get_pickup_id")),
			StringName(pickup.call("get_area_id")),
			str(pickup.call("get_resource_id")),
			str(pickup.get("display_name")),
			str(pickup.call("get_location_name")),
			StringName(pickup.call("get_resource_rarity"))
		)
	_schilfufer.call("restore_save_data", save_data.get("schilfufer", {}))
	_alter_torfstich.call("restore_save_data", save_data.get("alter_torfstich", {}))
	_sync_torfstich_access()

	_update_quest_status()
	_refresh_quest_board()
	_player.call("refresh_interactable_prompt")


func _on_quest_board_open_requested() -> void:
	if _inventory_window_panel.visible:
		return

	_refresh_quest_board()
	_quest_board_panel.show()
	_interaction_prompt.hide()
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
	if not _inventory_window_panel.visible:
		_player.set_physics_process(true)
		_player.set_process_unhandled_input(true)
		_player.call_deferred("refresh_interactable_prompt")


func _open_inventory_window() -> void:
	if _quest_board_panel.visible:
		return

	_show_inventory_page()
	_refresh_inventory_window()
	_inventory_dim.show()
	_inventory_window_panel.show()
	_interaction_prompt.hide()
	_player.set_physics_process(false)
	_player.set_process_unhandled_input(false)
	_inventory_window_close_button.grab_focus()


func _close_inventory_window() -> void:
	_show_inventory_page()
	_inventory_window_panel.hide()
	_inventory_dim.hide()
	_inventory_window_close_button.release_focus()
	if not _quest_board_panel.visible:
		_player.set_physics_process(true)
		_player.set_process_unhandled_input(true)
		_player.call_deferred("refresh_interactable_prompt")


func _toggle_herb_book() -> void:
	if _inventory_window_panel.visible and _herb_book_page.visible:
		_close_inventory_window()
		return
	if not _inventory_window_panel.visible:
		_open_inventory_window()
	_show_herb_book_page()


func _toggle_inventory_page() -> void:
	if _herb_book_page.visible:
		_show_inventory_page()
	else:
		_show_herb_book_page()


func _show_inventory_page() -> void:
	_inventory_title.text = "Inventar"
	_inventory_help.text = "Frische Zutaten, Vorräte und fertige Mittel"
	_inventory_page_button.text = "Kräuterbuch"
	_inventory_columns.show()
	_herb_book_page.hide()


func _show_herb_book_page() -> void:
	_inventory_title.text = "Kräuterbuch"
	_inventory_help.text = "Entdeckte Sammelstellen aus den Moorgebieten"
	_inventory_page_button.text = "Vorräte"
	_inventory_columns.hide()
	_herb_book_page.show()
	_refresh_herb_book_page()


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

	var window_count_label := _inventory_window_counts.get(item_id) as Label
	if window_count_label != null:
		window_count_label.text = str(amount)

	_update_quest_status()


func _on_resource_discovered(
	pickup_id: String,
	area_id: StringName,
	resource_id: String,
	resource_name: String,
	location_name: String,
	rarity: StringName
) -> void:
	if pickup_id.is_empty() or area_id.is_empty() or location_name.is_empty() or resource_id.is_empty():
		return
	if rarity != &"common" and rarity != &"rare":
		return
	_discovered_pickups[pickup_id] = {
		"pickup_id": pickup_id,
		"area_id": str(area_id),
		"resource_id": resource_id,
		"display_name": resource_name,
		"location_name": location_name,
		"rarity": str(rarity),
	}
	_refresh_herb_book_page()


func get_discovered_resources() -> Array[Dictionary]:
	var entries: Array[Dictionary] = []
	for pickup_id in _discovered_pickups:
		var entry: Dictionary = _discovered_pickups[pickup_id]
		entries.append(entry.duplicate(true))
	entries.sort_custom(func(left: Dictionary, right: Dictionary) -> bool:
		var left_area := str(left.get("area_id", ""))
		var right_area := str(right.get("area_id", ""))
		if left_area != right_area:
			return left_area < right_area
		var left_name := str(left.get("display_name", ""))
		var right_name := str(right.get("display_name", ""))
		if left_name != right_name:
			return left_name < right_name
		return str(left.get("pickup_id", "")) < str(right.get("pickup_id", ""))
	)
	return entries


func _refresh_herb_book_page() -> void:
	if _herb_book_entries == null:
		return
	for child in _herb_book_entries.get_children():
		_herb_book_entries.remove_child(child)
		child.queue_free()

	var entries := get_discovered_resources()
	if entries.is_empty():
		var empty_label := Label.new()
		empty_label.text = "Noch keine Fundstelle entdeckt. Sammle eine Pflanze, um sie hier zu notieren."
		empty_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		empty_label.add_theme_color_override("font_color", Color(0.72, 0.78, 0.68, 1))
		empty_label.add_theme_font_size_override("font_size", 9)
		_herb_book_entries.add_child(empty_label)
		return

	for entry in entries:
		var row := Label.new()
		var area_name := str(AREA_DISPLAY_NAMES.get(str(entry["area_id"]), entry["area_id"]))
		var rarity_label := "Selten" if str(entry["rarity"]) == "rare" else "Häufig"
		row.text = "%s — %s — %s · %s" % [area_name, str(entry["location_name"]), str(entry["display_name"]), rarity_label]
		row.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		row.add_theme_color_override("font_color", Color(0.88, 0.83, 0.68, 1))
		row.add_theme_font_size_override("font_size", 9)
		_herb_book_entries.add_child(row)


func _build_inventory_window() -> void:
	for category_data: Dictionary in INVENTORY_COLUMNS[0]:
		_add_inventory_category(_inventory_left_column, category_data)
	for category_data: Dictionary in INVENTORY_COLUMNS[1]:
		_add_inventory_category(_inventory_right_column, category_data)


func _add_inventory_category(parent: VBoxContainer, category_data: Dictionary) -> void:
	var category := VBoxContainer.new()
	category.add_theme_constant_override("separation", 2)
	parent.add_child(category)

	var heading := Label.new()
	heading.text = str(category_data["title"])
	heading.add_theme_color_override("font_color", Color(0.82, 0.72, 0.48, 1))
	heading.add_theme_font_size_override("font_size", 9)
	category.add_child(heading)

	for item_data: Array in category_data["items"]:
		var item_id := str(item_data[0])
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 5)
		category.add_child(row)

		var item_name := Label.new()
		item_name.text = str(item_data[1])
		item_name.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		item_name.add_theme_color_override("font_color", Color(0.88, 0.83, 0.68, 1))
		item_name.add_theme_font_size_override("font_size", 9)
		row.add_child(item_name)

		var count_label := Label.new()
		count_label.name = "Count_%s" % item_id
		count_label.custom_minimum_size = Vector2(22, 0)
		count_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		count_label.text = str(_inventory.call("get_count", item_id))
		count_label.add_theme_color_override("font_color", _inventory_count_color(str(item_data[2])))
		count_label.add_theme_font_size_override("font_size", 9)
		row.add_child(count_label)
		_inventory_window_counts[item_id] = count_label


func _inventory_count_color(tone: String) -> Color:
	match tone:
		"fresh":
			return Color(0.78, 0.87, 0.57, 1)
		"dried":
			return Color(0.87, 0.79, 0.59, 1)
		"coin":
			return Color(0.93, 0.8, 0.42, 1)
		_:
			return Color(0.92, 0.78, 0.55, 1)


func _refresh_inventory_window() -> void:
	for item_id in _inventory_window_counts:
		var count_label := _inventory_window_counts[item_id] as Label
		count_label.text = str(_inventory.call("get_count", str(item_id)))
	_refresh_herb_book_page()


func _on_quest_state_changed(state: String) -> void:
	for station in get_tree().get_nodes_in_group("processing_stations"):
		if station.has_method("set_quest_state"):
			station.set_quest_state("fenja", state)
	_sync_torfstich_access()
	_update_quest_status()
	_refresh_quest_board()
	_player.call("refresh_interactable_prompt")


func _sync_torfstich_access() -> void:
	var village := get_node_or_null("World/TestMap")
	if village != null and village.has_method("set_torfstich_unlocked"):
		village.call("set_torfstich_unlocked", str(_fenja_quest.get("state")) == "completed")

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


func _is_valid_world_position(position: Vector2) -> bool:
	for area in get_tree().get_nodes_in_group("world_areas"):
		if not (area is Node2D) or not area.has_method("get_map_bounds"):
			continue
		var local_bounds: Rect2 = area.call("get_map_bounds")
		var world_bounds := Rect2(area.to_global(local_bounds.position), local_bounds.size)
		if world_bounds.has_point(position):
			return true
	return false


func _configure_camera_for_position(position: Vector2) -> void:
	for area in get_tree().get_nodes_in_group("world_areas"):
		if not (area is Node2D) or not area.has_method("get_map_bounds"):
			continue
		var local_bounds: Rect2 = area.call("get_map_bounds")
		var world_bounds := Rect2(area.to_global(local_bounds.position), local_bounds.size)
		if world_bounds.has_point(position):
			_configure_camera_for_area(StringName(area.get("area_id")))
			return
	_configure_camera_for_area(&"Dorfplatz")


func _configure_camera_for_area(destination_id: StringName) -> void:
	for area in get_tree().get_nodes_in_group("world_areas"):
		if not (area is Node2D) or StringName(area.get("area_id")) != destination_id:
			continue
		if not area.has_method("get_map_bounds"):
			return
		var local_bounds: Rect2 = area.call("get_map_bounds")
		var world_origin: Vector2 = (area as Node2D).to_global(local_bounds.position)
		_camera.limit_left = floori(world_origin.x)
		_camera.limit_top = floori(world_origin.y)
		_camera.limit_right = ceili(world_origin.x + local_bounds.size.x)
		_camera.limit_bottom = ceili(world_origin.y + local_bounds.size.y)
		_camera.force_update_scroll()
		return

func _get_area_id_at_position(position: Vector2) -> StringName:
	for area in get_tree().get_nodes_in_group("world_areas"):
		if not area is Node2D or not area.has_method("get_map_bounds"):
			continue
		var local_bounds: Rect2 = area.call("get_map_bounds")
		var world_bounds := Rect2(area.to_global(local_bounds.position), local_bounds.size)
		if world_bounds.has_point(position):
			return StringName(area.get("area_id"))
	return &""


func _respawn_resources_and_encounters() -> void:
	for pickup in get_tree().get_nodes_in_group("item_pickups"):
		if pickup.has_method("set_collected"):
			pickup.call("set_collected", false)
	for encounter in get_tree().get_nodes_in_group("optional_encounters"):
		if encounter.has_method("reset_encounter"):
			encounter.call("reset_encounter")
	for area in get_tree().get_nodes_in_group("world_areas"):
		if area.has_method("refresh_resource_visibility"):
			area.call("refresh_resource_visibility")


func _on_map_transition_requested(destination_id: StringName, destination_position: Vector2, feedback_text: String) -> void:
	for area in get_tree().get_nodes_in_group("world_areas"):
		if StringName(area.get("area_id")) != destination_id:
			continue
		var source_area_id := _get_area_id_at_position(_player.global_position)
		if destination_id == &"Dorfplatz" and source_area_id != &"Dorfplatz":
			_respawn_resources_and_encounters()
		_player.velocity = Vector2.ZERO
		_player.global_position = area.to_global(destination_position)
		_configure_camera_for_area(destination_id)
		_on_interaction_completed(feedback_text)
		return


func _on_feedback_timer_timeout() -> void:
	_interaction_feedback.hide()
