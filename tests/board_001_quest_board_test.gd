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
	var board := main.get_node_or_null("World/TestMap/QuestBoard") as Area2D
	var fenja := main.get_node_or_null("World/TestMap/Fenja") as Area2D
	var marten := main.get_node_or_null("World/TestMap/Marten") as Area2D
	var fenja_quest := main.get_node_or_null("Quest/FenjaQuest")
	var marten_quest := main.get_node_or_null("Quest/MartenQuest")
	var lene_quest := main.get_node_or_null("Quest/LeneQuest")
	var panel := main.get_node_or_null("HUD/QuestBoardPanel") as Control
	var fenja_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/FenjaRow/AcceptButton") as Button
	var marten_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/MartenRow/AcceptButton") as Button
	var lene_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/LeneRow/AcceptButton") as Button
	var close_button := main.get_node_or_null("HUD/QuestBoardPanel/Content/CloseButton") as Button
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label

	_check(player != null, "the player exists")
	_check(inventory != null, "the inventory exists")
	_check(board != null, "the quest board exists as an interactable")
	_check(fenja != null, "Fenja still exists for tea hand-in")
	_check(marten != null, "Marten still exists for infusion hand-in")
	_check(fenja_quest != null, "Fenja's quest exists")
	_check(marten_quest != null, "Marten's quest exists")
	_check(lene_quest != null, "Lene's quest exists")
	_check(panel != null, "the quest board panel exists")
	_check(fenja_button != null, "Fenja's board action exists")
	_check(marten_button != null, "Marten's board action exists")
	_check(lene_button != null, "Lene's board action exists")
	_check(close_button != null, "the board close action exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(feedback != null, "interaction feedback exists")
	if player == null or inventory == null or board == null or fenja == null or marten == null or fenja_quest == null or marten_quest == null or lene_quest == null or panel == null or fenja_button == null or marten_button == null or lene_button == null or close_button == null or prompt == null or feedback == null:
		main.queue_free()
		_finish()
		return

	_check(not panel.visible, "the quest board starts closed")
	await _move_near(player, board)
	_check(prompt.text.contains("Auftragsbrett"), "the board prompt explains its use")
	_press_e(player)
	_check(panel.visible, "interacting with the board opens the quest list")
	_check(fenja_button.has_focus(), "focus starts on first available request")
	_check(not player.is_physics_processing(), "player movement pauses while the list is open")
	_check(not player.is_processing_unhandled_input(), "world interactions pause while the list is open")
	_check(not fenja_button.disabled and fenja_button.text == "Annehmen", "Fenja's first request is available")
	_check(marten_button.disabled and marten_button.text == "Gesperrt", "Marten's request is locked until Fenja is helped")
	_check(lene_button.disabled and lene_button.text == "Gesperrt", "Lene's request is locked until Marten is helped")

	var cancel := InputEventAction.new()
	cancel.action = "ui_cancel"
	cancel.pressed = true
	main.call("_unhandled_input", cancel)
	_check(not panel.visible, "Escape closes the quest list")
	_check(player.is_physics_processing(), "closing the list restores player movement")
	_check(player.is_processing_unhandled_input(), "closing the list restores world interactions")

	await _move_near(player, fenja)
	_press_e(player)
	_check(str(fenja_quest.get("state")) == "not_accepted", "speaking with Fenja no longer accepts her request")
	_check(feedback.text.contains("Auftragsbrett"), "Fenja directs unaccepted requests to the board")

	await _move_near(player, board)
	_press_e(player)
	fenja_button.emit_signal("pressed")
	_check(str(fenja_quest.get("state")) == "active", "the board accepts Fenja's available request")
	_check(fenja_button.disabled and fenja_button.text == "In Arbeit", "the board marks an accepted request as active")
	_check(str(marten_quest.get("state")) == "not_accepted", "accepting Fenja does not also accept Marten")
	close_button.emit_signal("pressed")
	_check(not panel.visible and player.is_physics_processing(), "the close button dismisses the list and restores movement")

	inventory.call("add_item", "calming_tea", 1)
	await _move_near(player, fenja)
	_press_e(player)
	_check(str(fenja_quest.get("state")) == "completed", "Fenja still receives her tea directly")
	_check(int(inventory.call("get_count", "calming_tea")) == 0, "Fenja receives exactly one tea")

	await _move_near(player, board)
	_press_e(player)
	_check(marten_button.has_focus(), "focus advances to Martens newly available request")
	_check(not marten_button.disabled and marten_button.text == "Annehmen", "Marten's request unlocks after Fenja is helped")
	_check(lene_button.disabled, "Lene's request remains locked until Marten is helped")
	marten_button.emit_signal("pressed")
	_check(str(marten_quest.get("state")) == "active", "the board accepts Marten's unlocked request")
	close_button.emit_signal("pressed")

	inventory.call("add_item", "strengthening_infusion", 1)
	await _move_near(player, marten)
	_press_e(player)
	_check(str(marten_quest.get("state")) == "completed", "Marten still receives his infusion directly")
	_check(int(inventory.call("get_count", "strengthening_infusion")) == 0, "Marten receives exactly one infusion")

	await _move_near(player, board)
	_press_e(player)
	_check(lene_button.has_focus(), "focus advances to Lenes newly available request")
	_check(not lene_button.disabled and lene_button.text == "Annehmen", "Lene's request unlocks after Marten is helped")
	lene_button.emit_signal("pressed")
	_check(str(lene_quest.get("state")) == "active", "the board accepts Lene's unlocked request")
	_check(lene_button.disabled and lene_button.text == "In Arbeit", "the board displays Lene's active request")

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
		print("BOARD-001 quest board checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("BOARD-001 check failed: " + failure)
	quit(1)
