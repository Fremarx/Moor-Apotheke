extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const INVENTORY_SCRIPT = preload("res://scripts/inventory.gd")

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
	var quest := main.get_node_or_null("Quest/FenjaQuest")
	var dried_mint_count := main.get_node_or_null("HUD/DriedMintCount") as Label
	var dried_reed_count := main.get_node_or_null("HUD/DriedReedRootCount") as Label
	var tea_count := main.get_node_or_null("HUD/TeaCount") as Label
	var infusion_count := main.get_node_or_null("HUD/InfusionCount") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(cauldron != null, "the brewing cauldron exists")
	_check(fenja != null, "Fenja exists")
	_check(quest != null, "Fenja's quest exists")
	_check(dried_mint_count != null, "the dried mint HUD count exists")
	_check(dried_reed_count != null, "the dried reed-root HUD count exists")
	_check(tea_count != null, "the calming tea HUD count exists")
	_check(infusion_count != null, "the strengthening infusion HUD count exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or cauldron == null or fenja == null or quest == null or dried_mint_count == null or dried_reed_count == null or tea_count == null or infusion_count == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(infusion_count.text == "Stärkender Aufguss: 0", "the strengthening infusion HUD starts at zero")
	_check(str(quest.get("state")) == "not_accepted", "Fenja's quest starts locked")

	await _move_near(player, cauldron)
	_press_e(player)
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "brewing without ingredients produces no tea")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 0, "brewing without ingredients produces no infusion")

	inventory.call("add_item", "dried_sump_mint", 1)
	inventory.call("add_item", "dried_reed_root", 1)
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "the unlocked start recipe consumes one dried mint")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 1, "the locked infusion leaves dried reed root untouched")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "the start recipe still makes one calming tea")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 0, "the infusion remains locked before Fenja's quest")
	_check(tea_count.text == "Beruhigungstee: 1", "the calming tea HUD updates before the unlock")
	_check(feedback.text.contains("Beruhigungstee"), "the cauldron confirms the available start recipe")

	_press_e(player)
	_check(int(inventory.call("get_count", "dried_reed_root")) == 1, "a locked recipe consumes no root")
	_check(feedback.text.contains("Fenjas Auftrag"), "the cauldron explains how to unlock the infusion")

	await _move_near(player, fenja)
	_press_e(player)
	_check(str(quest.get("state")) == "active", "talking to Fenja accepts her request")
	_press_e(player)
	_check(str(quest.get("state")) == "completed", "handing Fenja the tea completes her request")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "Fenja consumes the calming tea")

	inventory.call("add_item", "dried_sump_mint", 1)
	_check(dried_mint_count.text == "Getrocknete Minze: 1", "the dried mint HUD updates for the infusion")
	await _move_near(player, cauldron)
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "brewing the infusion consumes one dried mint")
	_check(int(inventory.call("get_count", "dried_reed_root")) == 0, "brewing the infusion consumes one dried reed root")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 1, "brewing creates one strengthening infusion")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "brewing the infusion does not create calming tea")
	_check(dried_mint_count.text == "Getrocknete Minze: 0", "the dried mint HUD reaches zero")
	_check(dried_reed_count.text == "Getrocknete Schilfwurzel: 0", "the dried reed-root HUD reaches zero")
	_check(infusion_count.text == "Stärkender Aufguss: 1", "the infusion HUD updates")
	_check(feedback.text.contains("Stärkende Aufguss"), "the cauldron confirms the infusion result")

	_check_atomic_crafting_contract()

	main.queue_free()
	_finish()


func _check_atomic_crafting_contract() -> void:
	var test_inventory := INVENTORY_SCRIPT.new() as Node
	_check(test_inventory.has_method("craft_items"), "inventory exposes multi-ingredient crafting")
	if not test_inventory.has_method("craft_items"):
		test_inventory.free()
		return

	test_inventory.call("add_item", "dried_sump_mint", 1)
	var ingredients := {"dried_sump_mint": 1, "dried_reed_root": 1}
	_check(not bool(test_inventory.call("craft_items", ingredients, "strengthening_infusion", 1)), "missing ingredients prevent crafting")
	_check(int(test_inventory.call("get_count", "dried_sump_mint")) == 1, "a failed multi-ingredient craft consumes no mint")
	_check(int(test_inventory.call("get_count", "dried_reed_root")) == 0, "a failed multi-ingredient craft does not create root")
	_check(int(test_inventory.call("get_count", "strengthening_infusion")) == 0, "a failed multi-ingredient craft creates no result")

	test_inventory.call("add_item", "dried_reed_root", 1)
	_check(bool(test_inventory.call("craft_items", ingredients, "strengthening_infusion", 1)), "crafting succeeds when all ingredients are present")
	_check(int(test_inventory.call("get_count", "dried_sump_mint")) == 0, "successful crafting consumes its mint")
	_check(int(test_inventory.call("get_count", "dried_reed_root")) == 0, "successful crafting consumes its root")
	_check(int(test_inventory.call("get_count", "strengthening_infusion")) == 1, "successful crafting adds one result")
	test_inventory.free()


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
		print("LOOP-004 strengthening infusion checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("LOOP-004 check failed: " + failure)
	quit(1)
