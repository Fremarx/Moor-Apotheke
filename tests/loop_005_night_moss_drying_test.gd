extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var main := MAIN_SCENE.instantiate()
	root.add_child(main)
	await physics_frame
	await physics_frame

	var player := main.get_node_or_null("World/Player")
	var inventory := main.get_node_or_null("Inventory")
	var rack := main.get_node_or_null("World/TestMap/Trockengestell") as Area2D
	var night_moss := main.get_node_or_null("World/TestMap/Nachtmoos") as Area2D
	var mint_count := main.get_node_or_null("HUD/InventoryCount") as Label
	var reed_count := main.get_node_or_null("HUD/ReedRootCount") as Label
	var night_moss_count := main.get_node_or_null("HUD/NightMossCount") as Label
	var dried_mint_count := main.get_node_or_null("HUD/DriedMintCount") as Label
	var dried_reed_count := main.get_node_or_null("HUD/DriedReedRootCount") as Label
	var dried_night_moss_count := main.get_node_or_null("HUD/DriedNightMossCount") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(rack != null, "the drying rack exists")
	_check(night_moss != null, "the Nachtmoos pickup exists")
	_check(mint_count != null, "the fresh mint HUD count exists")
	_check(reed_count != null, "the fresh reed-root HUD count exists")
	_check(night_moss_count != null, "the fresh Nachtmoos HUD count exists")
	_check(dried_mint_count != null, "the dried mint HUD count exists")
	_check(dried_reed_count != null, "the dried reed-root HUD count exists")
	_check(dried_night_moss_count != null, "the dried Nachtmoos HUD count exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or rack == null or night_moss == null or mint_count == null or reed_count == null or night_moss_count == null or dried_mint_count == null or dried_reed_count == null or dried_night_moss_count == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(night_moss_count.text == "Nachtmoos: 0", "fresh Nachtmoos starts at zero")
	_check(dried_night_moss_count.text == "Getrocknetes Nachtmoos: 0", "dried Nachtmoos starts at zero")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 0, "the dried Nachtmoos inventory starts at zero")

	await _move_near(player, rack)
	_press_e(player)
	_check(int(inventory.call("get_count", "night_moss")) == 0, "the rack does not invent fresh Nachtmoos")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 0, "the rack produces no dried Nachtmoos without ingredients")
	_check(feedback.text.contains("Nachtmoos"), "the missing-ingredient message names Nachtmoos")

	await _move_near(player, night_moss)
	_press_e(player)
	_check(int(inventory.call("get_count", "night_moss")) == 1, "the player collects Nachtmoos for drying")
	inventory.call("add_item", "sump_mint", 1)
	inventory.call("add_item", "reed_root", 1)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "fresh mint is available")
	_check(int(inventory.call("get_count", "reed_root")) == 1, "fresh reed root is available")

	await _move_near(player, rack)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "Sumpfminze keeps first place in the rack order")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "the rack dries one Sumpfminze")
	_check(int(inventory.call("get_count", "reed_root")) == 1, "drying mint leaves reed root untouched")
	_check(int(inventory.call("get_count", "night_moss")) == 1, "drying mint leaves Nachtmoos untouched")

	_press_e(player)
	_check(int(inventory.call("get_count", "reed_root")) == 0, "Schilfwurzel remains second in the rack order")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 1, "the rack dries one Schilfwurzel")
	_check(int(inventory.call("get_count", "night_moss")) == 1, "drying reed root leaves Nachtmoos untouched")

	_press_e(player)
	_check(int(inventory.call("get_count", "night_moss")) == 0, "drying Nachtmoos consumes exactly one fresh plant")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 1, "drying Nachtmoos produces one dried plant")
	_check(night_moss_count.text == "Nachtmoos: 0", "the fresh Nachtmoos HUD count reaches zero")
	_check(dried_night_moss_count.text == "Getrocknetes Nachtmoos: 1", "the dried Nachtmoos HUD count updates")
	_check(mint_count.text == "Sumpfminze: 0", "the fresh mint HUD count stays separate")
	_check(reed_count.text == "Schilfwurzel: 0", "the fresh reed-root HUD count stays separate")
	_check(dried_mint_count.text == "Getrocknete Minze: 1", "the dried mint HUD count stays separate")
	_check(dried_reed_count.text == "Getrocknete Schilfwurzel: 1", "the dried reed-root HUD count stays separate")
	_check(feedback.text.contains("Nachtmoos") and feedback.text.contains("getrocknet"), "feedback confirms Nachtmoos drying")

	_press_e(player)
	_check(int(inventory.call("get_count", "dried_night_moss")) == 1, "repeated interaction cannot invent more dried Nachtmoos")
	_check(feedback.text.contains("Sumpfminze") and feedback.text.contains("Schilfwurzel") and feedback.text.contains("Nachtmoos"), "the empty-rack message lists all accepted plants")

	main.queue_free()
	_finish()


func _move_near(player: Node, target: Node2D) -> void:
	player.global_position = target.global_position + Vector2(6, 0)
	await physics_frame
	await physics_frame


func _press_e(player: Node) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = KEY_E
	event.pressed = true
	player.call("_unhandled_input", event)


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("LOOP-005 night-moss drying checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("LOOP-005 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
