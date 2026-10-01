extends Node2D

const HEART_PATTERN := ["01100110", "11111111", "11111111", "01111110", "00111100", "00011000"]
const HEART_PIXEL_SIZE := 2.0
const HEART_SPACING := 4.0

var current_hearts: int = 3
var maximum_hearts: int = 3


func set_hearts(current: int, maximum: int) -> void:
	maximum_hearts = maxi(maximum, 1)
	current_hearts = clampi(current, 0, maximum_hearts)
	queue_redraw()


func _draw() -> void:
	for heart_index in range(maximum_hearts):
		var origin := Vector2(heart_index * (8.0 * HEART_PIXEL_SIZE + HEART_SPACING), 0.0)
		var filled := heart_index < current_hearts
		for row_index in range(HEART_PATTERN.size()):
			var row: String = HEART_PATTERN[row_index]
			for column_index in range(row.length()):
				if row.substr(column_index, 1) != "1":
					continue
				var color := Color("cf785f") if filled else Color("594b3d")
				if filled and row_index == 0:
					color = Color("f0c987")
				draw_rect(
					Rect2(origin + Vector2(column_index, row_index) * HEART_PIXEL_SIZE, Vector2.ONE * HEART_PIXEL_SIZE),
					color
				)
