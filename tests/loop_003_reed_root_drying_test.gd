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
	var reed_pickup := main.get_node_or_null("World/TestMap/Schilfwurzel") as Area2D
	var mint_count := main.get_node_or_null("HUD/InventoryCount") as Label
	var reed_count := main.get_node_or_null("HUD/ReedRootCount") as Label
	var dried_mint_count := main.get_node_or_null("HUD/DriedMintCount") as Label
	var dried_reed_count := main.get_node_or_null("HUD/DriedReedRootCount") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(rack != null, "the drying rack exists")
	_check(reed_pickup != null, "the Schilfwurzel pickup exists")
	_check(mint_count != null, "the fresh mint HUD count exists")
	_check(reed_count != null, "the fresh reed-root HUD count exists")
	_check(dried_mint_count != null, "the dried mint HUD count exists")
	_check(dried_reed_count != null, "the dried reed-root HUD count exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or rack == null or reed_pickup == null or mint_count == null or reed_count == null or dried_mint_count == null or dried_reed_count == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(dried_reed_count.text == "Getrocknete Schilfwurzel: 0", "the dried reed-root HUD count starts at zero")
	_check(int(inventory.call("get_count", "reed_root")) == 0, "fresh reed root starts at zero")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 0, "dried reed root starts at zero")

	await _move_near(player, rack)
	_press_e(player)
	_check(int(inventory.call("get_count", "reed_root")) == 0, "the rack does not invent fresh reed root")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 0, "the rack does not produce without ingredients")
	_check(feedback.text.contains("Schilfwurzel"), "the rack names reed root as an accepted drying ingredient")

	await _move_near(player, reed_pickup)
	_press_e(player)
	inventory.call("add_item", "reed_root", 1)
	inventory.call("add_item", "sump_mint", 1)
	_check(int(inventory.call("get_count", "reed_root")) == 2, "the test prepares two fresh reed roots")
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "fresh Sumpfminze is also available")

	await _move_near(player, rack)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "the rack keeps the existing Sumpfminze-first order")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "the existing mint recipe still produces one dried mint")
	_check(int(inventory.call("get_count", "reed_root")) == 2, "drying mint leaves the reed-root stock unchanged")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 0, "drying mint produces no dried reed root")
	_check(feedback.text.contains("Sumpfminze") and feedback.text.contains("getrocknet"), "feedback identifies the mint that was dried")

	_press_e(player)
	_check(int(inventory.call("get_count", "reed_root")) == 1, "drying consumes exactly one fresh reed root")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 1, "drying produces exactly one dried reed root")
	_check(reed_count.text == "Schilfwurzel: 1", "the HUD updates the fresh reed-root count")
	_check(dried_reed_count.text == "Getrocknete Schilfwurzel: 1", "the HUD updates the dried reed-root count")
	_check(mint_count.text == "Sumpfminze: 0", "the mint HUD count remains at zero")
	_check(dried_mint_count.text == "Getrocknete Minze: 1", "the dried mint HUD count remains independent")
	_check(feedback.text.contains("Schilfwurzel") and feedback.text.contains("getrocknet"), "feedback identifies the reed root that was dried")

	_press_e(player)
	_check(int(inventory.call("get_count", "reed_root")) == 0, "the rack can dry the second reed root")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 2, "repeated drying keeps a one-to-one ratio")
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 2, "the rack cannot produce dried reed root without fresh stock")
	_check(dried_reed_count.text == "Getrocknete Schilfwurzel: 2", "the dried count remains unchanged without supplies")
	_check(feedback.text.contains("frische"), "the missing-ingredient message remains visible")

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
		print("LOOP-003 reed-root drying checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("LOOP-003 check failed: " + failure)
	quit(1)
