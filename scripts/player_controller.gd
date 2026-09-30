extends CharacterBody2D

signal interaction_hint_changed(prompt_text: String)
signal interaction_completed(feedback_text: String)

const FACING_FRONT := Vector2i(0, 0)
const FACING_LEFT := Vector2i(1, 0)
const FACING_BACK := Vector2i(0, 1)
const FACING_RIGHT := Vector2i(1, 1)

@export var move_speed: float = 82.0

@onready var _interaction_area: Area2D = $InteractionArea
@onready var _visual_sprite: Sprite2D = $Visual

var _current_interactable: Area2D


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	_update_facing(direction)
	velocity = direction * move_speed
	move_and_slide()
	_refresh_interactable_target()


func _update_facing(direction: Vector2) -> void:
	if direction.is_zero_approx():
		return

	if absf(direction.x) > absf(direction.y):
		_visual_sprite.frame_coords = FACING_RIGHT if direction.x > 0.0 else FACING_LEFT
	elif direction.y > 0.0:
		_visual_sprite.frame_coords = FACING_FRONT
	else:
		_visual_sprite.frame_coords = FACING_BACK


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
