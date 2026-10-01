extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://map_02_routes_test.json"

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_remove_test_save()
	var main := MAIN_SCENE.instantiate()
	main.get_node("SaveManager").set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame

	var map := main.get_node("World/TestMap")
	var player := main.get_node("World/Player") as CharacterBody2D
	var schilfufer := map.get_node("EnterSchilfufer") as Area2D
	var routes := {
		"Nordwesten Schilfufer": schilfufer,
		"Nordosten Quellsenke": map.get_node("Nordausgang") as Marker2D,
		"Osten Torfstich": map.get_node("Ostausgang") as Marker2D,
		"Südwesten Nebelhain": map.get_node("GateNebelhain") as Area2D,
		"Südosten Wurzelhain": map.get_node("GateWurzelhain") as Area2D,
	}
	_check(routes.size() == 5, "the village defines all five routes from the world overview")
	_check(StringName(map.get("area_id")) == &"Dorfplatz", "all routes start in the logical Dorfplatz area")
	_check(StringName(schilfufer.get("destination_area")) == &"Schilfufer", "the northwest start route leads to the existing Schilfufer area")
	_check(schilfufer.position == Vector2(36, 64), "the open transition is on the northwest path")
	_check((map.get_node("Nordausgang") as Marker2D).position == Vector2(520, 98), "the northeast route reaches the pond bridge")
	_check((map.get_node("Ostausgang") as Marker2D).position == Vector2(520, 184), "the eastern route reaches the Torfstich gate")

	var locked_routes := [
		["GateQuellsenke", "Martens stärkender Aufguss"],
		["GateTorfstich", "Fenjas Beruhigungstee"],
		["GateNebelhain", "Lenes Nachttrank"],
		["GateWurzelhain", "Quellperle und Irrlichtstaub"],
	]
	for route_data: Array in locked_routes:
		var gate := map.get_node(str(route_data[0])) as Area2D
		_check(gate != null, "%s has a visible lock interaction" % str(route_data[0]))
		if gate == null:
			continue
		player.global_position = gate.global_position
		await physics_frame
		await physics_frame
		_check(player.get_current_interactable() == gate, "%s can be examined at its barrier" % str(route_data[0]))
		_check(player.try_interact(), "%s reports its lock condition" % str(route_data[0]))
		var feedback := str(main.get_node("HUD/InteractionFeedback").text)
		_check(feedback.contains(str(route_data[1])), "%s explains the concrete progression condition" % str(route_data[0]))

	await _check_blocked_route(player, map.get_node("GateQuellsenke"), "move_right", 574.0, false, "the pond bridge remains blocked at the Quellsenke gate")
	await _check_blocked_route(player, map.get_node("GateTorfstich"), "move_right", 576.0, false, "the eastern gate blocks the Torfstich path")
	await _check_blocked_route(player, map.get_node("GateNebelhain"), "move_left", 60.0, true, "the southwest gate blocks the Nebelhain path")
	await _check_blocked_route(player, map.get_node("GateWurzelhain"), "move_right", 574.0, false, "the southeast gate blocks the Wurzelhain path")

	main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _check_blocked_route(player: CharacterBody2D, gate: Area2D, action: StringName, threshold: float, greater: bool, description: String) -> void:
	player.global_position = gate.global_position
	await physics_frame
	Input.action_press(action)
	for _frame in range(40):
		await physics_frame
	Input.action_release(action)
	await physics_frame
	var stayed_on_near_side := (player.global_position.x > threshold) == greater
	_check(stayed_on_near_side, description)


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("MAP-02 route and lock checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("MAP-02 check failed: " + failure)
	quit(1)
