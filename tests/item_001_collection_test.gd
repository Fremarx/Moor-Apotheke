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
	var pickup := main.get_node_or_null("World/TestMap/Sumpfminze") as Area2D
	var inventory := main.get_node_or_null("Inventory")
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var count_label := main.get_node_or_null("HUD/InventoryCount") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(pickup != null, "the Sumpfminze pickup exists")
	_check(inventory != null, "the inventory exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(count_label != null, "the inventory count is visible in the HUD")
	_check(feedback != null, "interaction feedback exists")
	if player == null or pickup == null or inventory == null or prompt == null or count_label == null or feedback == null:
		_finish()
		return

	_check(int(inventory.call("get_count", "sump_mint")) == 0, "the initial inventory count is zero")
	_check(count_label.text == "Sumpfminze: 0", "the HUD starts with zero Sumpfminze")
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "E outside range does not collect the plant")

	player.global_position = pickup.global_position + Vector2(6, 0)
	await physics_frame
	await physics_frame
	_check(prompt.visible, "the pickup prompt appears in range")
	_check(prompt.text.contains("Sumpfminze"), "the prompt names Sumpfminze")
	_check(prompt.text.contains("Sammeln"), "the prompt explains the collection action")
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "collecting adds one Sumpfminze")
	_check(count_label.text == "Sumpfminze: 1", "the HUD updates after collecting")
	_check(feedback.visible and feedback.text.contains("sammelst"), "the HUD confirms the pickup")
	_check(not pickup.visible, "the collected plant disappears")

	await physics_frame
	await physics_frame
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "the same plant cannot be collected twice")
	inventory.call("add_item", "", 1)
	inventory.call("add_item", "sump_mint", 0)
	inventory.call("add_item", "sump_mint", -1)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "invalid inventory additions do not change the count")

	main.queue_free()
	_finish()


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
		print("ITEM-001 collection checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("ITEM-001 check failed: " + failure)
	quit(1)
