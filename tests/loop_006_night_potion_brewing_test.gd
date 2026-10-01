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
	var cauldron := main.get_node_or_null("World/TestMap/Braukessel") as Area2D
	var fenja := main.get_node_or_null("World/TestMap/Fenja") as Area2D
	var marten := main.get_node_or_null("World/TestMap/Marten") as Area2D
	var fenja_quest := main.get_node_or_null("Quest/FenjaQuest")
	var marten_quest := main.get_node_or_null("Quest/MartenQuest")
	var fresh_moss_count := main.get_node_or_null("HUD/NightMossCount") as Label
	var dried_moss_count := main.get_node_or_null("HUD/DriedNightMossCount") as Label
	var dried_root_count := main.get_node_or_null("HUD/DriedReedRootCount") as Label
	var potion_count := main.get_node_or_null("HUD/NightPotionCount") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(cauldron != null, "the brewing cauldron exists")
	_check(fenja != null, "Fenja exists")
	_check(marten != null, "Marten exists")
	_check(fenja_quest != null, "Fenja's quest exists")
	_check(marten_quest != null, "Marten's quest exists")
	_check(fresh_moss_count != null, "the fresh Nachtmoos HUD count exists")
	_check(dried_moss_count != null, "the dried Nachtmoos HUD count exists")
	_check(dried_root_count != null, "the dried reed-root HUD count exists")
	_check(potion_count != null, "the Nachttrank HUD count exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or cauldron == null or fenja == null or marten == null or fenja_quest == null or marten_quest == null or fresh_moss_count == null or dried_moss_count == null or dried_root_count == null or potion_count == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(potion_count.text == "Nachttrank: 0", "the Nachttrank HUD starts at zero")
	_check(int(inventory.call("get_count", "night_potion")) == 0, "the Nachttrank inventory starts at zero")
	_check(fresh_moss_count.text == "Nachtmoos: 0", "fresh Nachtmoos remains a separate count")
	_check(dried_moss_count.text == "Getrocknetes Nachtmoos: 0", "dried Nachtmoos starts at zero")

	inventory.call("add_item", "dried_reed_root", 2)
	inventory.call("add_item", "dried_night_moss", 2)
	_check(dried_root_count.text == "Getrocknete Schilfwurzel: 2", "the dried reed-root HUD reflects recipe ingredients")
	_check(dried_moss_count.text == "Getrocknetes Nachtmoos: 2", "the dried Nachtmoos HUD reflects recipe ingredients")

	await _move_near(player, cauldron)
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 2, "the locked recipe consumes no dried reed root")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 2, "the locked recipe consumes no dried Nachtmoos")
	_check(int(inventory.call("get_count", "night_potion")) == 0, "the locked recipe produces no Nachttrank")
	_check(feedback.text.contains("Martens Auftrag"), "the cauldron explains that Marten's request unlocks the Nachttrank")

	inventory.call("add_item", "calming_tea", 1)
	main.call("_on_fenja_accept_pressed")
	_check(str(fenja_quest.get("state")) == "active", "Fenja's request can be accepted")
	await _move_near(player, fenja)
	_press_e(player)
	_check(str(fenja_quest.get("state")) == "completed", "Fenja's request can be completed before Marten's")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "Fenja receives her tea")

	main.call("_on_marten_accept_pressed")
	_check(str(marten_quest.get("state")) == "active", "Marten's request can be accepted")
	await _move_near(player, marten)
	_press_e(player)
	_check(str(marten_quest.get("state")) == "active", "Marten's request remains active without an infusion")
	inventory.call("add_item", "strengthening_infusion", 1)
	_press_e(player)
	_check(str(marten_quest.get("state")) == "completed", "Marten's request can be completed")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 0, "Marten receives exactly one infusion")
	_check(bool(inventory.call("remove_item", "dried_night_moss", 2)), "the missing-ingredient case removes Nachtmoos before brewing")

	await _move_near(player, cauldron)
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 2, "a missing Nachtmoos does not partially consume reed root")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 0, "the missing-ingredient case stays empty")
	_check(int(inventory.call("get_count", "night_potion")) == 0, "a missing ingredient produces no Nachttrank")
	_check(feedback.text.contains("getrocknetes Nachtmoos"), "the cauldron names the missing Nachttrank ingredient")
	inventory.call("add_item", "dried_night_moss", 2)
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 1, "the first Nachttrank consumes one dried reed root")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 1, "the first Nachttrank consumes one dried Nachtmoos")
	_check(int(inventory.call("get_count", "night_potion")) == 1, "the first brew produces one Nachttrank")
	_check(dried_root_count.text == "Getrocknete Schilfwurzel: 1", "the dried reed-root HUD updates after brewing")
	_check(dried_moss_count.text == "Getrocknetes Nachtmoos: 1", "the dried Nachtmoos HUD updates after brewing")
	_check(potion_count.text == "Nachttrank: 1", "the Nachttrank HUD updates after brewing")
	_check(feedback.text.contains("Nachttrank"), "the cauldron confirms the Nachttrank")

	_press_e(player)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 0, "the second brew consumes the remaining dried reed root")
	_check(int(inventory.call("get_count", "dried_night_moss")) == 0, "the second brew consumes the remaining dried Nachtmoos")
	_check(int(inventory.call("get_count", "night_potion")) == 2, "a second E press produces exactly one additional Nachttrank")
	_check(potion_count.text == "Nachttrank: 2", "the Nachttrank HUD shows two")

	_press_e(player)
	_check(int(inventory.call("get_count", "night_potion")) == 2, "brewing without ingredients cannot invent another Nachttrank")
	_check(fresh_moss_count.text == "Nachtmoos: 0", "brewing does not change fresh Nachtmoos")

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
		print("LOOP-006 night-potion brewing checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("LOOP-006 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
