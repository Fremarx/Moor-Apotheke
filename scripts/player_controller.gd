extends CharacterBody2D

signal interaction_hint_changed(prompt_text: String)
signal interaction_completed(feedback_text: String)
signal health_changed(current_hearts: int, maximum_hearts: int)
signal defeated
signal herb_staff_attack_requested(origin: Vector2, direction: Vector2)

const FACING_FRONT := Vector2i(0, 0)
const FACING_LEFT := Vector2i(1, 0)
const FACING_BACK := Vector2i(0, 1)
const FACING_RIGHT := Vector2i(1, 1)

@export var move_speed: float = 82.0
@export var max_hearts: int = 3
@export_range(0.0, 2.0, 0.05) var damage_invulnerability_seconds: float = 0.8
@export var dodge_speed: float = 220.0
@export var dodge_duration_seconds: float = 0.15
@export var dodge_recovery_seconds: float = 0.4
@export var herb_staff_recovery_seconds: float = 0.45

@onready var _interaction_area: Area2D = $InteractionArea
@onready var _visual_sprite: Sprite2D = $Visual

var current_hearts: int = 3
var last_safe_waypoint := Vector2.ZERO
var _current_interactable: Area2D
var _facing_direction := Vector2.DOWN
var _invulnerability_remaining := 0.0
var _dodge_remaining := 0.0
var _dodge_recovery_remaining := 0.0
var _dodge_direction := Vector2.DOWN
var _staff_recovery_remaining := 0.0
var _staff_swing_remaining := 0.0
var _knockback_velocity := Vector2.ZERO
var _is_defeated := false


func _ready() -> void:
	add_to_group("players")
	current_hearts = maxi(max_hearts, 1)
	last_safe_waypoint = global_position
	health_changed.emit(current_hearts, max_hearts)


func _physics_process(delta: float) -> void:
	_invulnerability_remaining = maxf(0.0, _invulnerability_remaining - delta)
	_dodge_recovery_remaining = maxf(0.0, _dodge_recovery_remaining - delta)
	_staff_recovery_remaining = maxf(0.0, _staff_recovery_remaining - delta)
	_staff_swing_remaining = maxf(0.0, _staff_swing_remaining - delta)
	_knockback_velocity = _knockback_velocity.move_toward(Vector2.ZERO, 300.0 * delta)
	_visual_sprite.visible = _invulnerability_remaining <= 0.0 or int(Time.get_ticks_msec() / 90) % 2 == 0
	if _staff_swing_remaining > 0.0:
		queue_redraw()

	if _is_defeated:
		velocity = Vector2.ZERO
		return

	if _dodge_remaining > 0.0:
		_dodge_remaining = maxf(0.0, _dodge_remaining - delta)
		velocity = _dodge_direction * dodge_speed + _knockback_velocity
		if _dodge_remaining <= 0.0:
			_dodge_recovery_remaining = dodge_recovery_seconds
	else:
		var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
		_update_facing(direction)
		velocity = direction * move_speed + _knockback_velocity

	move_and_slide()
	_refresh_interactable_target()


func _draw() -> void:
	if _staff_swing_remaining <= 0.0:
		return
	var angle := _facing_direction.angle()
	draw_arc(Vector2.ZERO, 27.0, angle - 0.66, angle + 0.66, 10, Color("f3cf7c"), 2.0, true)


func _update_facing(direction: Vector2) -> void:
	if direction.is_zero_approx():
		return

	_facing_direction = direction.normalized()
	if absf(direction.x) > absf(direction.y):
		_visual_sprite.frame_coords = FACING_RIGHT if direction.x > 0.0 else FACING_LEFT
	elif direction.y > 0.0:
		_visual_sprite.frame_coords = FACING_FRONT
	else:
		_visual_sprite.frame_coords = FACING_BACK


func set_facing_direction(direction: Vector2) -> void:
	_update_facing(direction)


func get_facing_direction() -> Vector2:
	return _facing_direction


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("herb_staff_attack"):
		use_herb_staff()
	elif event.is_action_pressed("dodge"):
		dodge()
	elif event.is_action_pressed("interact"):
		try_interact()


func use_herb_staff() -> bool:
	if _is_defeated or _staff_recovery_remaining > 0.01:
		return false
	_staff_recovery_remaining = herb_staff_recovery_seconds
	_staff_swing_remaining = 0.14
	queue_redraw()
	herb_staff_attack_requested.emit(global_position, _facing_direction)
	return true


func set_herb_staff_cooldown(seconds: float) -> void:
	_staff_recovery_remaining = maxf(seconds, 0.0)


func dodge(direction: Vector2 = Vector2.ZERO) -> bool:
	if _is_defeated or _dodge_remaining > 0.0 or _dodge_recovery_remaining > 0.0:
		return false
	var dodge_direction := direction.normalized()
	if dodge_direction.is_zero_approx():
		dodge_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dodge_direction.is_zero_approx():
		dodge_direction = _facing_direction
	_dodge_direction = dodge_direction.normalized()
	_dodge_remaining = dodge_duration_seconds
	_invulnerability_remaining = maxf(_invulnerability_remaining, dodge_duration_seconds + 0.05)
	return true


func receive_enemy_attack(attack_direction: Vector2) -> bool:
	if _is_defeated or _invulnerability_remaining > 0.0 or _dodge_remaining > 0.0:
		return false
	current_hearts = maxi(current_hearts - 1, 0)
	_invulnerability_remaining = damage_invulnerability_seconds
	var push_direction := attack_direction.normalized()
	if push_direction.is_zero_approx():
		push_direction = -_facing_direction
	_knockback_velocity = push_direction * 74.0
	health_changed.emit(current_hearts, max_hearts)
	if current_hearts <= 0:
		_is_defeated = true
		defeated.emit()
	return true


func set_last_safe_waypoint(waypoint: Vector2) -> void:
	last_safe_waypoint = waypoint


func get_last_safe_waypoint() -> Vector2:
	return last_safe_waypoint


func recover_after_defeat() -> void:
	global_position = last_safe_waypoint
	velocity = Vector2.ZERO
	_knockback_velocity = Vector2.ZERO
	_dodge_remaining = 0.0
	_is_defeated = false
	current_hearts = maxi(max_hearts, 1)
	_invulnerability_remaining = maxf(damage_invulnerability_seconds, 0.8)
	_visual_sprite.visible = true
	health_changed.emit(current_hearts, max_hearts)
	set_physics_process(true)
	set_process_unhandled_input(true)


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
