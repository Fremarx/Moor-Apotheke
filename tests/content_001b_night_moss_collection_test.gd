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
	var pickup := main.get_node_or_null("World/TestMap/Nachtmoos") as Area2D
	var inventory := main.get_node_or_null("Inventory")
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var night_moss_count := main.get_node_or_null("HUD/NightMossCount") as Label
	var mint_count := main.get_node_or_null("HUD/InventoryCount") as Label
	var reed_root_count := main.get_node_or_null("HUD/ReedRootCount") as Label

	_check(player != null, "the player exists")
	_check(pickup != null, "the Nachtmoos pickup exists at the old peat dock")
	_check(inventory != null, "the inventory exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(night_moss_count != null, "the Nachtmoos HUD count exists")
	_check(mint_count != null, "the Sumpfminze HUD count exists")
	_check(reed_root_count != null, "the Schilfwurzel HUD count exists")
	if player == null or pickup == null or inventory == null or prompt == null or night_moss_count == null or mint_count == null or reed_root_count == null:
		main.queue_free()
		_finish()
		return

	_check(str(pickup.get("item_id")) == "night_moss", "the pickup has its own night-moss item id")
	_check(str(pickup.get("display_name")) == "Nachtmoos", "the pickup is named Nachtmoos")
	_check(int(inventory.call("get_count", "night_moss")) == 0, "the Nachtmoos inventory starts at zero")
	_check(night_moss_count.text == "Nachtmoos: 0", "the HUD starts with zero Nachtmoos")
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "the Sumpfminze inventory starts independently at zero")
	_check(int(inventory.call("get_count", "reed_root")) == 0, "the Schilfwurzel inventory starts independently at zero")

	player.global_position = pickup.global_position + Vector2(40, 0)
	_press_e(player)
	_check(int(inventory.call("get_count", "night_moss")) == 0, "E outside range does not collect the plant")

	player.global_position = pickup.global_position + Vector2(6, 0)
	await physics_frame
	await physics_frame
	_check(prompt.visible, "the pickup prompt appears in range")
	_check(prompt.text.contains("Nachtmoos"), "the prompt names Nachtmoos")
	_check(prompt.text.contains("Sammeln"), "the prompt explains the collection action")
	_press_e(player)
	_check(int(inventory.call("get_count", "night_moss")) == 1, "collecting adds one night moss")
	_check(night_moss_count.text == "Nachtmoos: 1", "the Nachtmoos HUD updates after collecting")
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "collecting Nachtmoos does not change Sumpfminze")
	_check(mint_count.text == "Sumpfminze: 0", "the Sumpfminze HUD count remains independent")
	_check(int(inventory.call("get_count", "reed_root")) == 0, "collecting Nachtmoos does not change Schilfwurzel")
	_check(reed_root_count.text == "Schilfwurzel: 0", "the Schilfwurzel HUD count remains independent")
	_check(not pickup.visible, "the collected plant disappears")

	await physics_frame
	await physics_frame
	_press_e(player)
	_check(int(inventory.call("get_count", "night_moss")) == 1, "the same plant cannot be collected twice")
	_check(night_moss_count.text == "Nachtmoos: 1", "repeated interaction does not change the HUD count")

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
		print("CONTENT-001b night-moss collection checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("CONTENT-001b check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
