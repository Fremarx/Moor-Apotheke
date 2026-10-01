extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://sys_01_test.json"
const RETURN_POSITION := Vector2(560, 184)

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_remove_test_save()
	var main: Node = await _create_main()
	var pickups: Dictionary = main.call("_get_pickups_by_id")
	_check(pickups.size() == 18, "all eighteen existing resource spots keep unique save IDs")

	var area_totals: Dictionary = {}
	for pickup_id in pickups:
		var pickup: Node = pickups[pickup_id]
		var area_id := StringName(pickup.call("get_area_id")) if pickup.has_method("get_area_id") else &""
		var location_name := str(pickup.call("get_location_name")) if pickup.has_method("get_location_name") else ""
		var resource_id := str(pickup.call("get_resource_id")) if pickup.has_method("get_resource_id") else ""
		var rarity := StringName(pickup.call("get_resource_rarity")) if pickup.has_method("get_resource_rarity") else &""
		_check(not area_id.is_empty(), "%s has a fixed area ID" % pickup_id)
		_check(not resource_id.is_empty(), "%s has a fixed resource ID" % pickup_id)
		_check(rarity == &"common" or rarity == &"rare", "%s has a valid rarity" % pickup_id)
		if not area_totals.has(area_id):
			area_totals[area_id] = {"common": 0, "rare": 0}
		if rarity == &"common" or rarity == &"rare":
			area_totals[area_id][str(rarity)] += 1
	for area_id in [&"Dorfplatz", &"Schilfufer", &"AlterTorfstich"]:
		var counts: Dictionary = area_totals.get(area_id, {})
		_check(int(counts.get("common", 0)) >= 2, "%s has at least two common resource spots" % area_id)
		_check(int(counts.get("rare", 0)) >= 1, "%s has at least one rare resource spot" % area_id)

	_check(InputMap.has_action("toggle_herb_book"), "the herb book has a named input action")
	_check(_action_uses_key("toggle_herb_book", KEY_H), "H is bound to the herb book")

	var book_entries: Array = main.call("get_discovered_resources") if main.has_method("get_discovered_resources") else []
	_check(book_entries.is_empty(), "undiscovered resources are hidden from the herb book")

	var reed_area := main.get_node_or_null("World/Schilfufer")
	var mint := main.get_node_or_null("World/Schilfufer/SumpfminzeSchilfufer") as Area2D
	var player := main.get_node_or_null("World/Player") as CharacterBody2D
	_check(reed_area != null and mint != null and player != null, "the test can reach the Schilfufer resource spot")
	if reed_area != null and mint != null and player != null:
		mint.call("interact")
		book_entries = main.call("get_discovered_resources") if main.has_method("get_discovered_resources") else []
		_check(book_entries.size() == 1, "collecting a resource records one discovery")
		if book_entries.size() == 1:
			_check(str(book_entries[0].get("pickup_id")) == "schilfufer_sump_mint", "the book stores the exact resource spot")
			_check(str(book_entries[0].get("area_id")) == "Schilfufer", "the book shows the discovered area")
			_check(str(book_entries[0].get("resource_id")) == "sump_mint", "the book shows the stable resource ID")
			_check(str(book_entries[0].get("location_name")) == "Uferwiesen", "the book names the specific location")

		var book_action := InputEventAction.new()
		book_action.action = "toggle_herb_book"
		book_action.pressed = true
		main.call("_unhandled_input", book_action)
		var book_page := main.get_node_or_null("HUD/InventoryWindowPanel/Content/HerbBookPage") as Control
		var book_rows := book_page.get_node_or_null("Entries") as VBoxContainer if book_page != null else null
		_check(book_page != null and book_page.visible, "H opens the herb book page")
		_check(book_rows != null and _container_contains_text(book_rows, "Sumpfminze"), "the discovered plant appears in the page")

		var legacy_save := {
			"version": 1,
			"player": {"x": 80.0, "y": 90.0},
			"inventory": {},
			"quests": {"fenja": "not_accepted", "marten": "not_accepted", "lene": "not_accepted"},
			"collected_pickups": [],
			"schilfufer": {},
		}
		_check(bool(main.call("_is_valid_save_data", legacy_save)), "version-one saves without the new discovery field remain valid")

		for pickup in pickups.values():
			pickup.call("set_collected", true)
		var snapper := main.get_node_or_null("World/Schilfufer/Schilfschnapper") as Area2D
		var wuehler := main.get_node_or_null("World/AlterTorfstich/Moorwuehler") as Area2D
		var irrlicht := main.get_node_or_null("World/AlterTorfstich/Irrlicht") as Area2D
		if snapper != null:
			snapper.call("interact")
		if wuehler != null:
			wuehler.call("interact")
		if irrlicht != null:
			irrlicht.call("interact")
		player.global_position = reed_area.to_global(Vector2(1000, 408))
		main.call("_on_map_transition_requested", &"Dorfplatz", RETURN_POSITION, "Rückkehrtest")

		_check(player.global_position.is_equal_approx(RETURN_POSITION), "the return transition places the player in the village")
		for pickup_id in pickups:
			_check(not bool(pickups[pickup_id].call("is_collected")), "%s regrows on return to the village" % pickup_id)
		_check(not bool(mint.call("is_collected")) and mint.visible, "a discovered plant is visible and collectible again")
		var secret_moss := main.get_node_or_null("World/Schilfufer/NachtmoosSchilfufer") as Area2D
		_check(secret_moss != null and not secret_moss.visible, "the locked secret resource stays hidden while spots reset")
		_check(snapper != null and snapper.visible, "the Schilfschnapper returns on village entry")
		_check(wuehler != null and wuehler.visible, "the Moorwühler returns on village entry")
		_check(irrlicht != null and irrlicht.visible, "the Irrlicht returns on village entry")

		_check(bool(main.call("save_game")), "the return state with permanent discoveries can be saved")
		var save_data: Dictionary = main.get_node("SaveManager").call("read_save_data")
		_check(save_data.get("collected_pickups", []).is_empty(), "the returned save records regrown spots as available")
		_check(save_data.get("discovered_pickups", []).has("schilfufer_sump_mint"), "the returned save retains the discovery separately")

		main.queue_free()
		await process_frame
		var reloaded_main: Node = await _create_main()
		book_entries = reloaded_main.call("get_discovered_resources") if reloaded_main.has_method("get_discovered_resources") else []
		_check(book_entries.size() == 1, "startup loading restores the discovered resource")
		var reloaded_mint := reloaded_main.get_node("World/Schilfufer/SumpfminzeSchilfufer") as Area2D
		_check(reloaded_mint.visible and not bool(reloaded_mint.call("is_collected")), "startup loading keeps a regrown resource available")
		reloaded_main.queue_free()
		await process_frame
	else:
		main.queue_free()
		await process_frame

	_remove_test_save()
	_finish()


func _create_main() -> Node:
	var main := MAIN_SCENE.instantiate()
	main.get_node("SaveManager").set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame
	return main


func _action_uses_key(action_name: StringName, keycode: Key) -> bool:
	for event in InputMap.action_get_events(action_name):
		if event is InputEventKey and (event as InputEventKey).physical_keycode == keycode:
			return true
	return false


func _container_contains_text(container: VBoxContainer, expected_text: String) -> bool:
	for child in container.get_children():
		if child is Label and (child as Label).text.contains(expected_text):
			return true
	return false


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("SYS-01 resource regrowth checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("SYS-01 check failed: " + failure)
	quit(1)


func _process(_delta: float) -> bool:
	return false