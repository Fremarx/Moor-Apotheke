extends "res://scripts/interactable.gd"

signal encounter_defeated(enemy_name: String, drop_item_id: String)

enum EncounterState { IDLE, WARNING, ATTACK, RECOVERY, FLED, DEFEATED }

@export var drop_item_id: String = ""
@export var max_health: int = 2
@export var attack_windup_seconds: float = 1.0
@export var attack_recovery_seconds: float = 0.9
@export var attack_range: float = 72.0
@export var attack_half_width: float = 12.0
@export var can_attack_player: bool = true

var current_health: int = 2
var _state: EncounterState = EncounterState.IDLE
var _state_time_remaining: float = 0.0
var _attack_direction := Vector2.RIGHT
var _player: CharacterBody2D


func _ready() -> void:
	super._ready()
	add_to_group("optional_encounters")
	add_to_group("enemies")
	current_health = maxi(max_health, 1)
	_player = get_tree().get_first_node_in_group("players") as CharacterBody2D
	queue_redraw()


func _process(delta: float) -> void:
	if not visible:
		return
	if _state == EncounterState.IDLE:
		_try_begin_attack()
		return

	_state_time_remaining = maxf(0.0, _state_time_remaining - delta)
	match _state:
		EncounterState.WARNING:
			queue_redraw()
			if _state_time_remaining <= 0.0:
				_perform_attack()
		EncounterState.ATTACK:
			if _state_time_remaining <= 0.0:
				_set_state(EncounterState.RECOVERY, attack_recovery_seconds)
		EncounterState.RECOVERY:
			if _state_time_remaining <= 0.0:
				_set_state(EncounterState.IDLE)


func get_state_name() -> String:
	return EncounterState.keys()[_state]


func is_attack_warning_active() -> bool:
	return _state == EncounterState.WARNING


func is_defeated() -> bool:
	return _state == EncounterState.DEFEATED


func apply_staff_hit() -> bool:
	if _state == EncounterState.FLED or _state == EncounterState.DEFEATED or not visible:
		return false

	current_health = maxi(current_health - 1, 0)
	if current_health == 0:
		_set_state(EncounterState.DEFEATED)
		visible = false
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)
		encounter_defeated.emit(display_name, drop_item_id)
		return true

	_set_state(EncounterState.RECOVERY, 0.22)
	return true


func dismiss_safely(feedback: String) -> String:
	if _state == EncounterState.DEFEATED or _state == EncounterState.FLED:
		return "%s ist bereits weitergezogen." % display_name
	_set_state(EncounterState.FLED)
	visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	return feedback


func interact() -> String:
	return dismiss_safely("Du gehst an %s vorbei. Deine Fundstücke bleiben bei dir." % display_name)


func reset_encounter() -> void:
	current_health = maxi(max_health, 1)
	_set_state(EncounterState.IDLE)
	visible = true
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	_player = get_tree().get_first_node_in_group("players") as CharacterBody2D
	queue_redraw()


func _try_begin_attack() -> void:
	if not is_instance_valid(_player):
		_player = get_tree().get_first_node_in_group("players") as CharacterBody2D
	if not can_attack_player or not is_instance_valid(_player) or int(_player.get("current_hearts")) <= 0:
		return
	if global_position.distance_squared_to(_player.global_position) > pow(attack_range + 28.0, 2.0):
		return

	_attack_direction = (_player.global_position - global_position).normalized()
	if _attack_direction.is_zero_approx():
		_attack_direction = Vector2.DOWN
	_set_state(EncounterState.WARNING, clampf(attack_windup_seconds, 0.8, 1.2))


func _perform_attack() -> void:
	_set_state(EncounterState.ATTACK, 0.14)
	if not is_instance_valid(_player) or not _player.has_method("receive_enemy_attack"):
		return
	if _is_position_in_attack_lane(_player.global_position):
		_player.call("receive_enemy_attack", _attack_direction)


func _is_position_in_attack_lane(target_position: Vector2) -> bool:
	var offset := target_position - global_position
	var distance_along_attack := offset.dot(_attack_direction)
	var distance_across_attack := absf(offset.cross(_attack_direction))
	return (
		distance_along_attack >= 5.0
		and distance_along_attack <= attack_range
		and distance_across_attack <= attack_half_width + 7.0
	)


func _set_state(next_state: EncounterState, duration: float = 0.0) -> void:
	_state = next_state
	_state_time_remaining = maxf(duration, 0.0)
	queue_redraw()


func _draw() -> void:
	if _state == EncounterState.WARNING:
		_draw_attack_warning()
	if current_health < max_health and _state != EncounterState.DEFEATED:
		_draw_health_pips()


func _draw_attack_warning() -> void:
	var direction := _attack_direction.normalized()
	var side := direction.orthogonal() * attack_half_width
	var end_point := direction * attack_range
	var warning_fill := Color("d5a34e", 0.42)
	var warning_edge := Color("f0cf78", 0.92)
	draw_colored_polygon(PackedVector2Array([
		Vector2.ZERO + side,
		end_point + side,
		end_point - side,
		Vector2.ZERO - side,
	]), warning_fill)
	draw_line(side, end_point + side, warning_edge, 1.0)
	draw_line(-side, end_point - side, warning_edge, 1.0)
	for marker_index in range(1, 4):
		var marker_position := direction * (float(marker_index) * attack_range / 4.0)
		var marker_side := direction.orthogonal() * 3.0
		draw_line(marker_position - marker_side, marker_position + marker_side, warning_edge, 1.0)


func _draw_health_pips() -> void:
	for pip_index in range(maxi(max_health, 1)):
		var pip_color := Color("e0bd76") if pip_index < current_health else Color("493e33")
		draw_rect(Rect2(Vector2(-max_health * 3.0 + pip_index * 6.0, -29), Vector2(4, 3)), pip_color)
