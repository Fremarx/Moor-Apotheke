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
	var herb := main.get_node_or_null("World/TestMap/Sumpfminze") as Area2D
	var rack := main.get_node_or_null("World/TestMap/Trockengestell") as Area2D
	var cauldron := main.get_node_or_null("World/TestMap/Braukessel") as Area2D
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var fresh_count := main.get_node_or_null("HUD/InventoryCount") as Label
	var dried_count := main.get_node_or_null("HUD/DriedMintCount") as Label
	var tea_count := main.get_node_or_null("HUD/TeaCount") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(herb != null, "the Sumpfminze pickup exists")
	_check(rack != null, "the drying rack exists")
	_check(cauldron != null, "the brewing cauldron exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(fresh_count != null, "the fresh mint HUD count exists")
	_check(dried_count != null, "the dried mint HUD count exists")
	_check(tea_count != null, "the calming tea HUD count exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or herb == null or rack == null or cauldron == null or prompt == null or fresh_count == null or dried_count == null or tea_count == null or feedback == null:
		_finish()
		return

	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "dried mint starts at zero")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "calming tea starts at zero")
	_check(tea_count.text == "Beruhigungstee: 0", "the tea HUD count starts at zero")

	await _move_near(player, cauldron)
	_check(prompt.text.contains("Beruhigungstee"), "the cauldron offers the calming tea recipe")
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "brewing without dried mint leaves fresh mint unchanged")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "brewing without dried mint consumes nothing")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "brewing without dried mint produces nothing")
	_check(feedback.text.contains("getrocknete Sumpfminze"), "the cauldron explains which ingredient is missing")

	await _move_near(player, herb)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "the player collects fresh Sumpfminze")

	await _move_near(player, rack)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "drying consumes the fresh mint")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "drying provides the brewing ingredient")

	await _move_near(player, cauldron)
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "brewing consumes exactly one dried mint")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "brewing produces exactly one calming tea")
	_check(int(inventory.call("get_count", "water")) == 0, "the cauldron does not store unlimited water as inventory")
	_check(fresh_count.text == "Sumpfminze: 0", "the fresh mint HUD remains correct")
	_check(dried_count.text == "Getrocknete Minze: 0", "the dried mint HUD updates after brewing")
	_check(tea_count.text == "Beruhigungstee: 1", "the tea HUD updates after brewing")
	_check(feedback.text.contains("fertig"), "the cauldron confirms that the tea is ready")

	_press_e(player)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "brewing again without an ingredient consumes nothing")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "brewing again without an ingredient creates no extra tea")
	_check(tea_count.text == "Beruhigungstee: 1", "the tea HUD remains unchanged without an ingredient")
	_check(feedback.text.contains("getrocknete Sumpfminze"), "the missing ingredient feedback returns")

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
		print("LOOP-002 brewing checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("LOOP-002 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
