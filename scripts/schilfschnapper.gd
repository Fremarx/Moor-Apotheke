extends "res://scripts/enemy_encounter.gd"


func _ready() -> void:
	drop_item_id = "snapper_slime"
	max_health = 2
	attack_windup_seconds = 1.0
	attack_recovery_seconds = 0.9
	attack_range = 64.0
	attack_half_width = 12.0
	can_attack_player = true
	super._ready()


func interact() -> String:
	return dismiss_safely("Du scheuchst den Schilfschnapper ins Wasser. Deine Kräuter bleiben bei dir.")
