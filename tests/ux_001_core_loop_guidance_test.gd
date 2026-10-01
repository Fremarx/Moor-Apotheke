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
	var fenja := main.get_node_or_null("World/TestMap/Fenja") as Node2D
	var herb := main.get_node_or_null("World/TestMap/Sumpfminze") as Node2D
	var rack := main.get_node_or_null("World/TestMap/Trockengestell") as Node2D
	var cauldron := main.get_node_or_null("World/TestMap/Braukessel") as Node2D
	var quest := main.get_node_or_null("Quest/FenjaQuest")
	var quest_board := main.get_node_or_null("World/TestMap/QuestBoard") as Area2D
	var board_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/FenjaRow/AcceptButton") as Button
	var board_close := main.get_node_or_null("HUD/QuestBoardPanel/Content/CloseButton") as Button
	var quest_status := main.get_node_or_null("HUD/QuestStatus") as Label
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(fenja != null, "Fenja exists")
	_check(herb != null, "the Sumpfminze exists")
	_check(rack != null, "the drying rack exists")
	_check(cauldron != null, "the brewing cauldron exists")
	_check(quest != null, "Fenja's quest exists")
	_check(quest_status != null, "the quest status HUD exists")
	_check(prompt != null, "the interaction prompt exists")
	if player == null or inventory == null or fenja == null or herb == null or rack == null or cauldron == null or quest == null or quest_board == null or board_button == null or board_close == null or quest_status == null or prompt == null:
		main.queue_free()
		_finish()
		return

	_check(not quest_status.visible, "the objective is hidden until the quest is accepted")

	await _move_near(player, quest_board)
	_press_e(player)
	_check(main.get_node("HUD/QuestBoardPanel").visible, "the board opens before the first request")
	board_button.emit_signal("pressed")
	board_close.emit_signal("pressed")
	_check(str(quest.get("state")) == "active", "accepting Fenja's request from the board starts the quest")
	_check(quest_status.text == "Sammle eine Sumpfminze.", "the first objective asks the player to collect mint")

	await _move_near(player, herb)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 1, "the player collects fresh Sumpfminze")
	_check(quest_status.text == "Trockne die Sumpfminze.", "collecting fresh mint advances the objective to drying")

	await _move_near(player, rack)
	_press_e(player)
	_check(int(inventory.call("get_count", "sump_mint")) == 0, "drying consumes the fresh mint")
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 1, "drying creates one dried mint")
	_check(quest_status.text == "Braue Beruhigungstee.", "drying advances the objective to brewing")

	await _move_near(player, cauldron)
	_press_e(player)
	_check(int(inventory.call("get_count", "dried_sump_mint")) == 0, "brewing consumes the dried mint")
	_check(int(inventory.call("get_count", "calming_tea")) == 1, "brewing creates one calming tea")
	_check(quest_status.text == "Bringe Fenja den Beruhigungstee.", "brewing advances the objective to tea delivery")

	await _move_near(player, fenja)
	_check(prompt.text.contains("Abgeben"), "Fenja offers tea hand-in")
	_press_e(player)
	_check(str(quest.get("state")) == "completed", "giving Fenja tea completes the quest")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "delivering tea consumes exactly one item")
	_check(quest_status.visible and quest_status.text == "Aufgabe erfüllt: Fenjas Bitte.", "the completion objective remains visible")

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
		print("UX-001 core loop guidance checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("UX-001 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
