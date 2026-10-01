extends Area2D

signal transition_requested(destination_area: StringName, destination_position: Vector2, feedback_text: String)

@export var destination_area: StringName = &""
@export var destination_position: Vector2 = Vector2.ZERO
@export_multiline var feedback_text: String = ""


func _ready() -> void:
	add_to_group("map_transitions")
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		transition_requested.emit(destination_area, destination_position, feedback_text)
