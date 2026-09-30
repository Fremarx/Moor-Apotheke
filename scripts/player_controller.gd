extends CharacterBody2D

@export var move_speed: float = 82.0


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()


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
