extends CharacterBody2D

signal interaction_hint_changed(prompt_text: String)
signal interaction_completed(feedback_text: String)

@export var move_speed: float = 82.0

@onready var _interaction_area: Area2D = $InteractionArea

var _current_interactable: Area2D


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()
	_refresh_interactable_target()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		try_interact()


func try_interact() -> bool:
	_refresh_interactable_target()
	if not is_instance_valid(_current_interactable):
		return false

	var feedback_text := str(_current_interactable.call("interact"))
	interaction_completed.emit(feedback_text)
	return true


func get_current_interactable() -> Area2D:
	if is_instance_valid(_current_interactable):
		return _current_interactable
	return null


func refresh_interactable_prompt() -> void:
	if is_instance_valid(_current_interactable):
		interaction_hint_changed.emit(str(_current_interactable.call("get_prompt_text")))


func _refresh_interactable_target() -> void:
	var nearest: Area2D
	var nearest_distance_squared := INF

	for area in _interaction_area.get_overlapping_areas():
		if not _is_interactable(area):
			continue

		var distance_squared := global_position.distance_squared_to(area.global_position)
		if nearest == null or distance_squared < nearest_distance_squared:
			nearest = area
			nearest_distance_squared = distance_squared

	if nearest == _current_interactable:
		return

	_current_interactable = nearest
	var prompt_text := ""
	if is_instance_valid(_current_interactable):
		prompt_text = str(_current_interactable.call("get_prompt_text"))
	interaction_hint_changed.emit(prompt_text)


func _is_interactable(area: Area2D) -> bool:
	return (
		area.is_in_group("interactables")
		and area.has_method("get_prompt_text")
		and area.has_method("interact")
	)


func _draw() -> void:
	# Simple block shapes keep the graybox readable before sprite art exists.
	draw_rect(Rect2(Vector2(-6, 7), Vector2(12, 3)), Color("26382d"))
	draw_rect(Rect2(Vector2(-7, -4), Vector2(14, 12)), Color("49382f"))
	draw_rect(Rect2(Vector2(-6, -5), Vector2(12, 11)), Color("c47742"))
	draw_rect(Rect2(Vector2(-5, -11), Vector2(10, 8)), Color("d8b58b"))
	draw_rect(Rect2(Vector2(-6, -13), Vector2(12, 4)), Color("334638"))
	draw_rect(Rect2(Vector2(-4, -15), Vector2(8, 3)), Color("455c40"))
	draw_rect(Rect2(Vector2(-3, -8), Vector2(2, 2)), Color("352f2a"))
	draw_rect(Rect2(Vector2(1, -8), Vector2(2, 2)), Color("352f2a"))
