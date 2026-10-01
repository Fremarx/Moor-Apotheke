extends SceneTree

const MAP_SCENE: PackedScene = preload("res://scenes/world/test_map.tscn")
const WORKSTATIONS: Texture2D = preload("res://assets/sprites/workstations_ai_20261001.png")
const VILLAGERS: Texture2D = preload("res://assets/sprites/villagers_ai_20261001.png")
const HERBS: Texture2D = preload("res://assets/sprites/herb_pickups_ai_20261001.png")

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var map := MAP_SCENE.instantiate()
	root.add_child(map)
	await process_frame

	_check_visual(map, NodePath("Braukessel/Visual"), WORKSTATIONS, 1, "cauldron")
	_check_visual(map, NodePath("Trockengestell/Visual"), WORKSTATIONS, 0, "drying rack")
	_check_visual(map, NodePath("QuestBoard/Visual"), WORKSTATIONS, 2, "quest board")
	_check_visual(map, NodePath("Fenja/Visual"), VILLAGERS, 0, "Fenja")
	_check_visual(map, NodePath("Marten/Visual"), VILLAGERS, 1, "Marten")
	_check_visual(map, NodePath("Lene/Visual"), VILLAGERS, 2, "Lene")
	_check_visual(map, NodePath("Sumpfminze/Visual"), HERBS, 0, "sump mint")
	_check_visual(map, NodePath("Schilfwurzel/Visual"), HERBS, 1, "reed root")
	_check_visual(map, NodePath("Nachtmoos/Visual"), HERBS, 2, "night moss")

	var pickup := map.get_node("Sumpfminze")
	var pickup_visual := pickup.get_node("Visual") as Sprite2D
	pickup.call("set_collected", true)
	await process_frame
	_check(not pickup_visual.is_visible_in_tree(), "collected plant hides its sprite with its Area2D")
	pickup.call("set_collected", false)
	await process_frame
	_check(pickup_visual.is_visible_in_tree(), "restored plant shows its sprite again")

	map.queue_free()
	await process_frame
	_finish()


func _check_visual(
	map: Node,
	node_path: NodePath,
	expected_texture: Texture2D,
	expected_frame: int,
	label: String
) -> void:
	var visual := map.get_node_or_null(node_path) as Sprite2D
	_check(visual != null, label + " has a Sprite2D visual")
	if visual == null:
		return
	_check(visual.texture == expected_texture, label + " uses its approved atlas")
	_check(visual.hframes == 3 and visual.vframes == 1, label + " uses the 3-cell atlas layout")
	_check(visual.frame == expected_frame, label + " selects its matching atlas cell")


func _check(condition: bool, assertion: String) -> void:
	if condition:
		return
	_failures.append(assertion)
	push_error("VIS-003 failed: " + assertion)


func _finish() -> void:
	if _failures.is_empty():
		print("VIS-003 visual atlas checks passed.")
	else:
		push_error("VIS-003 had " + str(_failures.size()) + " failure(s).")
	quit(1 if not _failures.is_empty() else 0)

func _process(_delta: float) -> bool:
	return false
