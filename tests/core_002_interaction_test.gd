extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const INTERACTABLE_SCRIPT_PATH := "res://scripts/interactable.gd"

var _failures: Array[String] = []
var _feedback_message := ""


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_check(InputMap.has_action("interact"), "the interact input action is registered")

	var main := MAIN_SCENE.instantiate()
	root.add_child(main)
	await physics_frame
	await physics_frame

	var player := main.get_node_or_null("World/Player")
	var prompt := main.get_node_or_null("HUD/InteractionPrompt") as Label
	var feedback := main.get_node_or_null("HUD/InteractionFeedback") as Label
	var feedback_timer := main.get_node_or_null("HUD/FeedbackTimer") as Timer
	var probe := main.get_node_or_null("World/TestMap/InteractionProbe") as Area2D

	_check(player != null, "the player exists")
	_check(prompt != null, "the interaction prompt exists")
	_check(feedback != null, "the interaction feedback exists")
	_check(feedback_timer != null, "the interaction feedback timer exists")
	_check(probe != null, "the graybox interaction probe exists")

	if player == null or prompt == null or feedback == null or feedback_timer == null or probe == null:
		_finish()
		return

	_check(not prompt.visible, "the prompt is hidden when the player is out of range")
	player.global_position = probe.global_position + Vector2(6, 0)
	await physics_frame
	await physics_frame
	_check(prompt.visible, "the prompt appears inside interaction range")
	_check(prompt.text.contains("Kräuterprobe"), "the prompt names the nearby object")

	var interactable_script := load(INTERACTABLE_SCRIPT_PATH) as Script
	_check(interactable_script != null, "interactable contract script exists")
	if interactable_script == null:
		_finish()
		return

	var closer := Area2D.new()
	closer.set_script(interactable_script)
	closer.set("display_name", "Näherer Marker")
	closer.set("action_verb", "Untersuchen")
	closer.set("feedback_text", "Der nähere Marker reagiert.")
	closer.collision_layer = 2
	closer.collision_mask = 0
	var closer_shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 6.0
	closer_shape.shape = circle
	closer.add_child(closer_shape)
	main.get_node("World/TestMap").add_child(closer)
	closer.global_position = probe.global_position + Vector2(2, 0)
	await physics_frame
	await physics_frame
	_check(prompt.text.contains("Näherer Marker"), "the nearest overlapping object is selected")

	_feedback_message = ""
	if player.has_signal("interaction_completed"):
		player.connect("interaction_completed", _on_interaction_completed)
	else:
		_failures.append("the player reports completed interactions")
	_press_e(player)
	_check(_feedback_message == "Der nähere Marker reagiert.", "E triggers only the selected target")
	_check(feedback.visible, "interaction feedback appears in the HUD")
	_check(feedback.text == _feedback_message, "the HUD shows the selected target response")
	_check(not feedback_timer.is_stopped(), "the feedback timer starts after interaction")

	player.global_position = Vector2(320, 320)
	await physics_frame
	await physics_frame
	_check(not prompt.visible, "the prompt disappears after leaving range")
	_check(feedback.visible, "feedback remains visible when the target changes")
	_feedback_message = ""
	_press_e(player)
	_check(_feedback_message.is_empty(), "E does nothing when no target is in range")

	feedback_timer.emit_signal("timeout")
	_check(not feedback.visible, "feedback hides when its timer expires")

	player.global_position = Vector2(320, 320)
	var position_before_moving: Vector2 = player.global_position
	Input.action_press("move_right")
	await physics_frame
	await physics_frame
	await physics_frame
	Input.action_release("move_right")
	_check(player.global_position.x > position_before_moving.x, "movement still works with the interaction area enabled")

	_finish()


func _press_e(player: Node) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = KEY_E
	event.pressed = true
	player.call("_unhandled_input", event)


func _on_interaction_completed(message: String) -> void:
	_feedback_message = message


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("CORE-002 interaction checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("CORE-002 check failed: " + failure)
	quit(1)
