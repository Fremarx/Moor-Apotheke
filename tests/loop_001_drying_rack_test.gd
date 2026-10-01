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
	var herb := main.get_node_or_null("World/TestMap/Sumpfminze") as Area2D
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var fresh_count := main.get_node_or_null("HUD/InventoryCount") as Label
	var dried_count := main.get_node_or_null("HUD/DriedMintCount") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(rack != null, "the drying rack exists")
	_check(herb != null, "the Sumpfminze pickup exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(fresh_count != null, "the fresh mint count exists")
	_check(dried_count != null, "the dried mint count exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or rack == null or herb == null or prompt == null or fresh_count == null or dried_count == null or feedback == null:
		_finish()
		return

	_check(int(inventory.call("get_count", "sump_mint")) == 0, "fresh mint starts at zero")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "dried mint starts at zero")
	_check(fresh_count.text == "Sumpfminze: 0", "the fresh mint HUD count starts at zero")
	_check(dried_count.text == "Getrocknete Minze: 0", "the dried mint HUD count starts at zero")

	await _move_near(player, rack)
	_check(prompt.text.contains("Trockengestell"), "the drying rack has an interaction prompt")
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "the rack does not change inventory without fresh mint")
	_check(feedback.text.contains("frische Sumpfminze"), "the rack explains that fresh mint is required")

	await _move_near(player, herb)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "the pickup adds one fresh mint")
	inventory.call("add_item", "sump_mint", 1)
	_check(int(inventory.call("get_count", "sump_mint")) == 2, "the test can prepare multiple fresh mint")

	await _move_near(player, rack)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "drying consumes exactly one fresh mint")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "drying produces exactly one dried mint")
	_check(fresh_count.text == "Sumpfminze: 1", "the HUD updates the fresh mint count")
	_check(dried_count.text == "Getrocknete Minze: 1", "the HUD updates the dried mint count")
	_check(feedback.text.contains("getrocknet"), "the HUD confirms the drying result")

	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "the rack can dry the remaining fresh mint")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 2, "a second drying keeps the one-to-one ratio")
	_check(fresh_count.text == "Sumpfminze: 0", "the HUD shows no fresh mint after the second drying")
	_check(dried_count.text == "Getrocknete Minze: 2", "the HUD shows both dried mints")
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 2, "the rack cannot produce dried mint without ingredients")
	_check(fresh_count.text == "Sumpfminze: 0", "the fresh mint HUD stays unchanged without supplies")
	_check(dried_count.text == "Getrocknete Minze: 2", "the dried mint HUD stays unchanged without supplies")
	_check(feedback.text.contains("frische Sumpfminze"), "the missing ingredient message returns after supplies run out")

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
		print("LOOP-001 drying rack checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("LOOP-001 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
