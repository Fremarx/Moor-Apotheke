extends Node2D

const MAP_SIZE := Vector2(2400, 1088)
const TILE_SIZE := 16
const WALL_THICKNESS := 16.0
const DECORATION_ATLAS: Texture2D = preload("res://assets/tilesets/moor_vegetation_atlas_ai_20261001.png")
const ENVIRONMENT_ATLAS: Texture2D = preload("res://assets/sprites/moor_environment_atlas_ai_20261001.png")
const SHORTCUT_GATE_RECT := Rect2(Vector2(1036, 798), Vector2(18, 58))
const WORKGANG_GATE_RECT := Rect2(Vector2(1940, 934), Vector2(18, 56))

@export var area_id: StringName = &"AlterTorfstich"

var _blocking_rects: Array[Rect2] = []
var _shortcut_open := false
var _survey_progress := 0
var _survey_solved := false
var _shortcut_gate_shape: CollisionShape2D
var _workgang_gate_shape: CollisionShape2D


func _ready() -> void:
	add_to_group("world_areas")
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2(0.0, MAP_SIZE.y - WALL_THICKNESS), Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(MAP_SIZE.x - WALL_THICKNESS, 0.0), Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	for pool in _water_collision_rects():
		_add_solid_rect(pool)
	for obstacle in _solid_worksite_rects():
		_add_solid_rect(obstacle)
	_add_dynamic_gate("RaisedPeatStegBlocker", SHORTCUT_GATE_RECT, false)
	_add_dynamic_gate("SealedWorkgangBlocker", WORKGANG_GATE_RECT, true)
	_sync_region_state()


func get_map_bounds() -> Rect2:
	return Rect2(Vector2.ZERO, MAP_SIZE)


func get_traversable_tile_count() -> int:
	var count := 0
	for y in range(int(MAP_SIZE.y / TILE_SIZE)):
		for x in range(int(MAP_SIZE.x / TILE_SIZE)):
			var tile_rect := Rect2(Vector2(x * TILE_SIZE, y * TILE_SIZE), Vector2(TILE_SIZE, TILE_SIZE))
			var blocked := false
			for obstacle in _blocking_rects:
				if tile_rect.intersects(obstacle):
					blocked = true
					break
			if not blocked:
				count += 1
	return count


func get_main_route_points() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(36, 408), Vector2(240, 408), Vector2(480, 408), Vector2(720, 408),
		Vector2(720, 544), Vector2(720, 680), Vector2(960, 680), Vector2(1200, 680),
		Vector2(1440, 650), Vector2(1680, 680), Vector2(1680, 816), Vector2(1680, 952),
	])


func get_save_data() -> Dictionary:
	return {
		"shortcut_open": _shortcut_open,
		"survey_solved": _survey_solved,
	}


func can_restore_save_data(data: Variant) -> bool:
	if typeof(data) != TYPE_DICTIONARY:
		return false
	for key in ["shortcut_open", "survey_solved"]:
		if data.has(key) and typeof(data[key]) != TYPE_BOOL:
			return false
	return true


func restore_save_data(data: Dictionary) -> void:
	_shortcut_open = bool(data.get("shortcut_open", false))
	_survey_solved = bool(data.get("survey_solved", false))
	_survey_progress = 0
	_sync_region_state()


func lower_peat_shortcut() -> String:
	if _shortcut_open:
		return "Der Torfsteg ist bereits abgesenkt und bleibt offen."
	_shortcut_open = true
	_sync_region_state()
	return "Du senkst den Steg am Torfkran. Er verbindet nun A3 direkt mit D4."


func activate_survey_stake(sequence_number: int) -> String:
	if _survey_solved:
		return "Die Messpfähle markieren nun dauerhaft den sicheren alten Arbeitssteg."
	if sequence_number != _survey_progress + 1:
		_survey_progress = 0
		return "Die Markierung ist unter Torf verschwunden. Folge den Messpfählen von B4 über C4 nach D4."
	_survey_progress += 1
	if _survey_progress < 3:
		return "Der Messpfahl rastet ein. Suche den nächsten Pfahl in Sektor C4."
	_survey_solved = true
	_sync_region_state()
	return "Die Messpfähle legen den verschütteten Arbeitssteg frei."


func _sync_region_state() -> void:
	if _shortcut_gate_shape != null:
		_shortcut_gate_shape.set_deferred("disabled", _shortcut_open)
	if _workgang_gate_shape != null:
		_workgang_gate_shape.set_deferred("disabled", _survey_solved)
	_set_blocked_rect(SHORTCUT_GATE_RECT, not _shortcut_open)
	_set_blocked_rect(WORKGANG_GATE_RECT, not _survey_solved)
	var hidden_workgang := get_node_or_null("HiddenWorkgang") as Area2D
	if hidden_workgang != null:
		hidden_workgang.visible = _survey_solved
		hidden_workgang.set_deferred("monitoring", _survey_solved)
		hidden_workgang.set_deferred("monitorable", _survey_solved)
	queue_redraw()


func _set_blocked_rect(rect: Rect2, blocked: bool) -> void:
	if blocked and not _blocking_rects.has(rect):
		_blocking_rects.append(rect)
	elif not blocked:
		_blocking_rects.erase(rect)


func _add_dynamic_gate(node_name: String, rect: Rect2, secret_gate: bool) -> void:
	var body := StaticBody2D.new()
	body.name = node_name
	body.position = rect.position + rect.size / 2.0
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	var collision := CollisionShape2D.new()
	collision.name = "CollisionShape2D"
	collision.shape = shape
	body.add_child(collision)
	add_child(body)
	if secret_gate:
		_workgang_gate_shape = collision
	else:
		_shortcut_gate_shape = collision
	_blocking_rects.append(rect)


func _add_solid_rect(rect: Rect2) -> void:
	_blocking_rects.append(rect)
	var body := StaticBody2D.new()
	body.position = rect.position + rect.size / 2.0
	var collision := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	collision.shape = shape
	body.add_child(collision)
	add_child(body)


func _draw() -> void:
	_draw_peat_pits()
	_draw_path_network()
	_draw_floor_marks()
	_draw_landmarks()
	_draw_vegetation()
	_draw_workgang()


func _draw_peat_pits() -> void:
	var pools := _water_collision_rects()
	for index in range(pools.size()):
		var pool: Rect2 = pools[index]
		draw_rect(pool.grow(8.0), Color("514533"))
		draw_rect(pool, Color("243c3c"))
		draw_rect(pool.grow(-6.0), Color("31534d"))
		var ripple_y := pool.position.y + 26.0 + float(index % 3) * 17.0
		for ripple_index in range(3):
			var ripple_x := pool.position.x + 18.0 + float(ripple_index) * 44.0 + float(index % 2) * 10.0
			if ripple_x + 22.0 < pool.end.x - 8.0:
				draw_line(Vector2(ripple_x, ripple_y), Vector2(ripple_x + 20.0, ripple_y), Color("729087"), 1.0)
				draw_rect(Rect2(Vector2(ripple_x + 7.0, ripple_y + 5.0), Vector2(9, 1)), Color("536e63"))
		for bank_x in [pool.position.x + 7.0, pool.end.x - 19.0]:
			_draw_atlas_sprite(Vector2(bank_x, pool.position.y + 3.0), Vector2i(0, 0), Vector2(26, 28))


func _draw_path_network() -> void:
	_draw_track(get_main_route_points(), 76.0)
	_draw_track(PackedVector2Array([
		Vector2(720, 408), Vector2(900, 330), Vector2(1180, 330), Vector2(1430, 420),
		Vector2(1440, 560), Vector2(1200, 680),
	]), 48.0)
	_draw_track(PackedVector2Array([
		Vector2(720, 680), Vector2(560, 742), Vector2(360, 820), Vector2(235, 900),
		Vector2(430, 950), Vector2(720, 940), Vector2(910, 820), Vector2(720, 680),
	]), 48.0)
	_draw_track(PackedVector2Array([
		Vector2(720, 680), Vector2(840, 740), Vector2(1020, 798), Vector2(1230, 830),
		Vector2(1460, 865), Vector2(1680, 952),
	]), 38.0)
	_draw_track(PackedVector2Array([
		Vector2(1680, 680), Vector2(1760, 550), Vector2(1910, 510), Vector2(2110, 560),
		Vector2(2200, 680), Vector2(1960, 705), Vector2(1680, 680),
	]), 46.0)
	_draw_wooden_steg(Vector2(890, 778), Vector2(1280, 838), 34.0, _shortcut_open)


func _main_route_points() -> PackedVector2Array:
	return get_main_route_points()


func _draw_track(points: PackedVector2Array, width: float) -> void:
	draw_polyline(points, Color("493d30"), width + 12.0, false)
	draw_polyline(points, Color("816d4d"), width, false)
	draw_polyline(points, Color("b09a6d"), width - 10.0, false)
	draw_polyline(points, Color("756247"), width - 24.0, false)
	for point in points:
		draw_circle(point, (width + 12.0) / 2.0, Color("493d30"))
		draw_circle(point, width / 2.0, Color("816d4d"))
		draw_circle(point, (width - 10.0) / 2.0, Color("b09a6d"))
		draw_circle(point, (width - 24.0) / 2.0, Color("756247"))
	_draw_track_surface_details(points, width)


func _draw_track_surface_details(points: PackedVector2Array, width: float) -> void:
	for index in range(points.size() - 1):
		var start: Vector2 = points[index]
		var finish: Vector2 = points[index + 1]
		var segment := finish - start
		var sample_count: int = maxi(1, int(segment.length() / 26.0))
		var across := segment.orthogonal().normalized()
		for sample_index in range(sample_count):
			var center := start.lerp(finish, float(sample_index) / float(sample_count))
			var sample_hash := int(center.x) * 17 + int(center.y) * 31 + index * 13
			var lane := float(posmod(sample_hash, 7) - 3) / 3.0
			var detail := center + across * lane * width * 0.22
			var pattern := posmod(sample_hash, 17)
			if pattern < 2:
				draw_rect(Rect2(detail, Vector2(4, 2)), Color("5f503c"))
				draw_rect(Rect2(detail + Vector2(1, 0), Vector2(2, 1)), Color("b29a6d"))
			elif pattern == 6:
				draw_rect(Rect2(detail, Vector2(2, 1)), Color("c4ad7d"))


func _draw_wooden_steg(start: Vector2, finish: Vector2, width: float, lowered: bool) -> void:
	var direction := (finish - start).normalized()
	var across := direction.orthogonal() * width / 2.0
	var shadow_offset := Vector2(0, 6)
	var plank_polygon := PackedVector2Array([
		start - across + shadow_offset, finish - across + shadow_offset,
		finish + across + shadow_offset, start + across + shadow_offset,
	])
	draw_colored_polygon(plank_polygon, Color("352d25"))
	draw_colored_polygon(PackedVector2Array([
		start - across, finish - across, finish + across, start + across,
	]), Color("6f5137") if lowered else Color("563f30"))
	var plank_count := int((finish - start).length() / 16.0)
	for plank in range(plank_count + 1):
		var center := start.lerp(finish, float(plank) / float(maxi(1, plank_count)))
		draw_line(center - across, center + across, Color("bb9460") if lowered else Color("886643"), 2.0)
	if not lowered:
		var midpoint := start.lerp(finish, 0.5)
		draw_rect(Rect2(midpoint + Vector2(-16, -22), Vector2(32, 16)), Color("493a2f"))
		draw_rect(Rect2(midpoint + Vector2(-13, -19), Vector2(26, 10)), Color("a27a4f"))


func _draw_floor_marks() -> void:
	var route := get_main_route_points()
	for y in range(48, int(MAP_SIZE.y) - 28, 40):
		for x in range(38, int(MAP_SIZE.x) - 30, 46):
			var point := Vector2(x + posmod(x * 3 + y, 9), y + posmod(y * 5 + x, 7))
			if _near_any_route(point, route, 108.0) or _inside_water(point):
				continue
			var pattern := posmod(x * 31 + y * 17, 37)
			if pattern == 0:
				draw_rect(Rect2(point, Vector2(3, 2)), Color("75634a"))
				draw_rect(Rect2(point + Vector2(1, -1), Vector2(2, 1)), Color("9b8058"))
			elif pattern == 11:
				draw_rect(Rect2(point, Vector2(2, 2)), Color("506149"))


func _near_any_route(point: Vector2, route: PackedVector2Array, margin: float) -> bool:
	for index in range(route.size() - 1):
		var closest := Geometry2D.get_closest_point_to_segment(point, route[index], route[index + 1])
		if point.distance_to(closest) < margin:
			return true
	return false


func _inside_water(point: Vector2) -> bool:
	for pool in _water_collision_rects():
		if pool.has_point(point):
			return true
	return false


func _draw_landmarks() -> void:
	_draw_environment_sprite(
		Rect2(1000.0, 0.0, 760.0, 520.0),
		Rect2(Vector2(72, 320), Vector2(150, 106))
	)
	_draw_atlas_sprite(Vector2(285, 884), Vector2i(2, 1), Vector2(48, 42))
	_draw_atlas_sprite(Vector2(418, 928), Vector2i(3, 1), Vector2(50, 36))
	_draw_atlas_sprite(Vector2(1458, 305), Vector2i(2, 1), Vector2(48, 42))
	_draw_atlas_sprite(Vector2(2040, 730), Vector2i(3, 1), Vector2(54, 38))
	_draw_atlas_sprite(Vector2(2260, 414), Vector2i(3, 0), Vector2(58, 58))
	_draw_torf_crane(Vector2(250, 408))
	_draw_broken_pump(Vector2(306, 948))
	_draw_worksite_sign(Vector2(82, 438))
	_draw_survey_stakes()


func _draw_torf_crane(center: Vector2) -> void:
	draw_rect(Rect2(center + Vector2(-25, 18), Vector2(52, 7)), Color("44362c"))
	draw_rect(Rect2(center + Vector2(-21, 14), Vector2(44, 5)), Color("9c7447"))
	draw_rect(Rect2(center + Vector2(-19, -32), Vector2(7, 49)), Color("523c2d"))
	draw_rect(Rect2(center + Vector2(13, -32), Vector2(7, 49)), Color("523c2d"))
	draw_rect(Rect2(center + Vector2(-19, -33), Vector2(39, 8)), Color("855c38"))
	draw_rect(Rect2(center + Vector2(-15, -31), Vector2(28, 3)), Color("bd9360"))
	draw_rect(Rect2(center + Vector2(-3, -24), Vector2(3, 26)), Color("302b25"))
	draw_rect(Rect2(center + Vector2(0, -3), Vector2(9, 8)), Color("6a4d34"))
	draw_rect(Rect2(center + Vector2(2, -1), Vector2(5, 3)), Color("a77d4c"))
	draw_line(center + Vector2(-14, -25), center + Vector2(-5, -16), Color("c09a67"), 2.0)
	draw_line(center + Vector2(16, -24), center + Vector2(24, -16), Color("c09a67"), 2.0)


func _draw_broken_pump(center: Vector2) -> void:
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-28, 16), center + Vector2(-24, -5), center + Vector2(-9, -14),
		center + Vector2(12, -10), center + Vector2(24, 2), center + Vector2(27, 18),
	]), Color("40372e"))
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(-22, 11), center + Vector2(-18, -2), center + Vector2(-7, -9),
		center + Vector2(10, -6), center + Vector2(18, 3), center + Vector2(20, 13),
	]), Color("5d6550"))
	draw_rect(Rect2(center + Vector2(-6, -2), Vector2(14, 9)), Color("483d31"))
	draw_rect(Rect2(center + Vector2(-3, 0), Vector2(8, 4)), Color("31514e"))
	draw_line(center + Vector2(-22, -12), center + Vector2(21, -12), Color("91704a"), 2.0)


func _draw_worksite_sign(origin: Vector2) -> void:
	draw_rect(Rect2(origin + Vector2(5, 11), Vector2(4, 20)), Color("42352a"))
	draw_rect(Rect2(origin, Vector2(64, 15)), Color("3d3229"))
	draw_rect(Rect2(origin + Vector2(3, 2), Vector2(58, 9)), Color("98744c"))
	draw_string(ThemeDB.fallback_font, origin + Vector2(7, 10), "TORFHOF", HORIZONTAL_ALIGNMENT_LEFT, 54.0, 6, Color("f0d8a2"))


func _draw_survey_stakes() -> void:
	for center in [Vector2(720, 980), Vector2(1200, 980), Vector2(1680, 980)]:
		draw_rect(Rect2(center + Vector2(-5, -13), Vector2(10, 26)), Color("47392b"))
		draw_rect(Rect2(center + Vector2(-3, -15), Vector2(6, 19)), Color("9c7850"))
		draw_line(center + Vector2(-2, -10), center + Vector2(3, -10), Color("d0b272"), 2.0)


func _draw_vegetation() -> void:
	for center in [
		Vector2(455, 174), Vector2(880, 232), Vector2(1400, 245), Vector2(2120, 305),
		Vector2(500, 598), Vector2(1000, 938), Vector2(1460, 920), Vector2(2110, 920),
		Vector2(184, 610), Vector2(2218, 768), Vector2(2300, 1000),
	]:
		_draw_atlas_sprite(center, Vector2i(2, 1), Vector2(42, 40))
	for center in [Vector2(850, 532), Vector2(1540, 480), Vector2(1980, 744), Vector2(420, 310)]:
		_draw_atlas_sprite(center, Vector2i(3, 1), Vector2(44, 34))
	for center in [Vector2(555, 520), Vector2(1000, 478), Vector2(1900, 265), Vector2(2180, 845)]:
		_draw_atlas_sprite(center, Vector2i(0, 0), Vector2(38, 42))
	for center in [Vector2(925, 1012), Vector2(1525, 260), Vector2(2250, 566)]:
		_draw_atlas_sprite(center, Vector2i(0, 3), Vector2(38, 34))
	_draw_environment_sprite(
		Rect2(1170.0, 510.0, 604.0, 365.0),
		Rect2(Vector2(1880, 975), Vector2(96, 58))
	)


func _draw_workgang() -> void:
	if not _survey_solved:
		return
	draw_rect(Rect2(Vector2(1914, 918), Vector2(72, 94)), Color("302b27"))
	draw_rect(Rect2(Vector2(1921, 926), Vector2(58, 78)), Color("514431"))
	draw_rect(Rect2(Vector2(1927, 932), Vector2(46, 67)), Color("253332"))
	draw_rect(Rect2(Vector2(1935, 940), Vector2(30, 51)), Color("5b7867"))
	draw_rect(Rect2(Vector2(1940, 943), Vector2(2, 3)), Color("bfd596"))
	draw_rect(Rect2(Vector2(1962, 970), Vector2(3, 2)), Color("bfd596"))


func _draw_environment_sprite(source: Rect2, destination: Rect2) -> void:
	draw_texture_rect_region(ENVIRONMENT_ATLAS, destination, source, Color.WHITE, false)


func _draw_atlas_sprite(center: Vector2, cell: Vector2i, target_size: Vector2) -> void:
	var source := Rect2(float(cell.x) * 256.0, float(cell.y) * 256.0, 256.0, 256.0)
	var destination := Rect2(center - target_size / 2.0, target_size)
	draw_texture_rect_region(DECORATION_ATLAS, destination, source, Color.WHITE, false)


func _water_collision_rects() -> Array[Rect2]:
	return [
		Rect2(Vector2(510, 112), Vector2(286, 132)),
		Rect2(Vector2(1048, 98), Vector2(330, 150)),
		Rect2(Vector2(1780, 292), Vector2(270, 150)),
		Rect2(Vector2(118, 788), Vector2(205, 112)),
		Rect2(Vector2(505, 866), Vector2(150, 90)),
		Rect2(Vector2(2070, 842), Vector2(264, 154)),
	]


func _solid_worksite_rects() -> Array[Rect2]:
	return [
		Rect2(Vector2(434, 520), Vector2(52, 34)),
		Rect2(Vector2(1484, 352), Vector2(58, 32)),
		Rect2(Vector2(1994, 644), Vector2(54, 42)),
		Rect2(Vector2(318, 964), Vector2(34, 24)),
		Rect2(Vector2(1320, 738), Vector2(52, 30)),
	]
