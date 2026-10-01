extends Node2D

const MAP_SIZE := Vector2(2400, 1088)
const TILE_SIZE := 16
const WALL_THICKNESS := 16.0
const ATLAS_COLUMNS := 4.0
const ATLAS_ROWS := 4.0
const DECORATION_ATLAS: Texture2D = preload("res://assets/tilesets/moor_vegetation_atlas_ai_20261001.png")
const ENVIRONMENT_ATLAS: Texture2D = preload("res://assets/sprites/moor_environment_atlas_ai_20261001.png")

@export var area_id: StringName = &"Schilfufer"

var _blocking_rects: Array[Rect2] = []
var _ferry_plank_lowered := false
var _reed_ring_progress := 0
var _reed_ring_solved := false
var _ferry_gate_shape: CollisionShape2D
var _ferry_gate_rect := Rect2(Vector2(1444, 662), Vector2(12, 36))


func _ready() -> void:
	add_to_group("world_areas")
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2(0.0, MAP_SIZE.y - WALL_THICKNESS), Vector2(MAP_SIZE.x, WALL_THICKNESS)))
	_add_solid_rect(Rect2(Vector2.ZERO, Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	_add_solid_rect(Rect2(Vector2(MAP_SIZE.x - WALL_THICKNESS, 0.0), Vector2(WALL_THICKNESS, MAP_SIZE.y)))
	for pool in _water_collision_rects():
		_add_solid_rect(pool)
	for thicket in _solid_thickets():
		_add_solid_rect(thicket)
	_add_ferry_gate()
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
	return _main_route_points()




func get_save_data() -> Dictionary:
	return {
		"ferry_plank_lowered": _ferry_plank_lowered,
		"reed_ring_solved": _reed_ring_solved,
	}


func can_restore_save_data(data: Variant) -> bool:
	if typeof(data) != TYPE_DICTIONARY:
		return false
	for key in ["ferry_plank_lowered", "reed_ring_solved"]:
		if data.has(key) and typeof(data[key]) != TYPE_BOOL:
			return false
	return true


func restore_save_data(data: Dictionary) -> void:
	_ferry_plank_lowered = bool(data.get("ferry_plank_lowered", false))
	_reed_ring_solved = bool(data.get("reed_ring_solved", false))
	_reed_ring_progress = 0
	_sync_region_state()


func lower_ferry_plank() -> String:
	if _ferry_plank_lowered:
		return "Die Fährenplanke ist bereits dauerhaft abgesenkt."
	_ferry_plank_lowered = true
	_sync_region_state()
	return "Du senkst die Fährenplanke. Sie verbindet nun C2 mit D4 und bleibt offen."


func activate_reed_marker(sequence_number: int) -> String:
	if _reed_ring_solved:
		return "Die drei Marksteine leuchten ruhig. Die Kräuterlichtung bleibt zugänglich."
	if sequence_number != _reed_ring_progress + 1:
		_reed_ring_progress = 0
		return "Die Marksteine erlöschen. Folge den eingeritzten Zeichen von eins bis drei."
	_reed_ring_progress += 1
	if _reed_ring_progress < 3:
		return "Der Markstein rastet ein. Folge dem nächsten Zeichen."
	_reed_ring_solved = true
	_sync_region_state()
	return "Die drei Marksteine öffnen eine verborgene Kräuterlichtung."


func _sync_region_state() -> void:
	if _ferry_gate_shape != null:
		_ferry_gate_shape.set_deferred("disabled", _ferry_plank_lowered)
	if _ferry_plank_lowered:
		_blocking_rects.erase(_ferry_gate_rect)
	elif not _blocking_rects.has(_ferry_gate_rect):
		_blocking_rects.append(_ferry_gate_rect)
	var secret_herb := get_node_or_null("NachtmoosSchilfufer") as Area2D
	if secret_herb != null:
		secret_herb.visible = _reed_ring_solved and not bool(secret_herb.call("is_collected"))
		secret_herb.set_deferred("monitoring", _reed_ring_solved and not bool(secret_herb.call("is_collected")))
		secret_herb.set_deferred("monitorable", _reed_ring_solved and not bool(secret_herb.call("is_collected")))
	queue_redraw()


func _add_ferry_gate() -> void:
	var body := StaticBody2D.new()
	body.name = "RaisedFerryPlankBlocker"
	body.position = _ferry_gate_rect.position + _ferry_gate_rect.size / 2.0
	var shape := RectangleShape2D.new()
	shape.size = _ferry_gate_rect.size
	_ferry_gate_shape = CollisionShape2D.new()
	_ferry_gate_shape.name = "CollisionShape2D"
	_ferry_gate_shape.shape = shape
	body.add_child(_ferry_gate_shape)
	add_child(body)


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
	_draw_wetlands()
	_draw_path_network()
	_draw_landmarks()
	_draw_reeds_and_flowers()
	_draw_path_details()
	_draw_entry_and_rest_point()


func _draw_wetlands() -> void:
	var pools := _water_pools()
	for index in range(pools.size()):
		var pool: Rect2 = pools[index]
		var bank := pool.grow(8.0)
		draw_colored_polygon(_pool_polygon(bank, index), Color("73794b"))
		draw_colored_polygon(_pool_polygon(pool, index), Color("385e56"))
		draw_colored_polygon(_pool_polygon(pool.grow(-7.0), index), Color("4d7565"))
		var ripple_center := pool.position + pool.size * Vector2(0.58, 0.36)
		draw_line(ripple_center, ripple_center + Vector2(20, 0), Color("9db17c"), 2.0)
		draw_line(ripple_center + Vector2(8, 4), ripple_center + Vector2(25, 4), Color("71917a"), 1.0)
		var lily_position := pool.position + pool.size * Vector2(0.3, 0.72)
		draw_ellipse(lily_position, 7.0, 4.0, Color("80934f"))
		draw_line(lily_position, lily_position + Vector2(4, -3), Color("526b45"), 1.0)


func _pool_polygon(rect: Rect2, variation: int) -> PackedVector2Array:
	var shapes := [
		[Vector2(0.14, 0.02), Vector2(0.79, 0.0), Vector2(0.98, 0.22), Vector2(0.94, 0.72), Vector2(0.72, 0.98), Vector2(0.22, 0.94), Vector2(0.02, 0.68), Vector2(0.05, 0.24)],
		[Vector2(0.06, 0.2), Vector2(0.3, 0.02), Vector2(0.84, 0.08), Vector2(0.99, 0.4), Vector2(0.82, 0.88), Vector2(0.6, 1.0), Vector2(0.16, 0.86), Vector2(0.0, 0.54)],
		[Vector2(0.18, 0.0), Vector2(0.74, 0.04), Vector2(1.0, 0.28), Vector2(0.9, 0.78), Vector2(0.68, 0.94), Vector2(0.3, 1.0), Vector2(0.0, 0.7), Vector2(0.04, 0.24)],
	]
	var points := PackedVector2Array()
	var shape: Array = shapes[variation % shapes.size()]
	for point in shape:
		points.append(rect.position + Vector2(point.x * rect.size.x, point.y * rect.size.y))
	return points



func _draw_path_network() -> void:
	_draw_track(_main_route_points(), 74.0)
	_draw_track(PackedVector2Array([Vector2(1200, 408), Vector2(1010, 426), Vector2(850, 530), Vector2(720, 680), Vector2(720, 408)]), 54.0)
	_draw_track(PackedVector2Array([Vector2(1680, 680), Vector2(1520, 764), Vector2(1360, 884), Vector2(1200, 952), Vector2(1200, 680)]), 54.0)
	_draw_track(PackedVector2Array([Vector2(1680, 680), Vector2(1900, 680), Vector2(2110, 680), Vector2(2210, 748), Vector2(2240, 850), Vector2(2160, 952)]), 48.0)
	_draw_track(PackedVector2Array([Vector2(1680, 680), Vector2(1780, 580), Vector2(1760, 500), Vector2(1740, 475)]), 40.0)
	_draw_track(PackedVector2Array([Vector2(1200, 408), Vector2(1200, 540), Vector2(1200, 680), Vector2(1360, 680)]), 42.0)
	_draw_track(PackedVector2Array([Vector2(1540, 680), Vector2(1600, 790), Vector2(1680, 952)]), 42.0)
	_draw_track(PackedVector2Array([Vector2(1200, 952), Vector2(1260, 952), Vector2(1350, 990)]), 36.0)

func _main_route_points() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(2220, 952), Vector2(2040, 952), Vector2(1860, 952), Vector2(1680, 952),
		Vector2(1680, 820), Vector2(1680, 680), Vector2(1680, 550), Vector2(1540, 520),
		Vector2(1320, 520), Vector2(1200, 550), Vector2(1200, 680),
		Vector2(1200, 540), Vector2(1200, 408), Vector2(1035, 408), Vector2(870, 408),
		Vector2(720, 408), Vector2(560, 408), Vector2(400, 408), Vector2(240, 408),
		Vector2(240, 270), Vector2(240, 136),
	])

func _draw_track(points: PackedVector2Array, width: float) -> void:
	draw_polyline(points, Color("596347"), width + 12.0, false)
	draw_polyline(points, Color("b1a172"), width, false)
	draw_polyline(points, Color("786c4c"), width - 10.0, false)
	draw_polyline(points, Color("978761"), width - 22.0, false)
	for point in points:
		draw_circle(point, (width + 12.0) / 2.0, Color("596347"))
		draw_circle(point, width / 2.0, Color("b1a172"))
		draw_circle(point, (width - 10.0) / 2.0, Color("786c4c"))
		draw_circle(point, (width - 22.0) / 2.0, Color("978761"))
	_draw_track_surface_details(points, width)


func _draw_track_surface_details(points: PackedVector2Array, width: float) -> void:
	for index in range(points.size() - 1):
		var start: Vector2 = points[index]
		var finish: Vector2 = points[index + 1]
		var segment := finish - start
		var sample_count: int = maxi(1, int(segment.length() / 22.0))
		var across := segment.orthogonal().normalized()
		for sample_index in range(sample_count):
			var center := start.lerp(finish, float(sample_index) / float(sample_count))
			var sample_hash := int(center.x) * 17 + int(center.y) * 31 + index * 13
			var lane := float(posmod(sample_hash, 7) - 3) / 3.0
			var detail := center + across * lane * width * 0.22
			var pattern := posmod(sample_hash, 13)
			if pattern < 2:
				draw_rect(Rect2(detail, Vector2(4, 2)), Color("806e4f"))
				draw_rect(Rect2(detail + Vector2(1, 0), Vector2(2, 1)), Color("a0875b"))
			elif pattern == 5:
				draw_rect(Rect2(detail, Vector2(2, 1)), Color("c0a675"))


func _draw_boardwalk_bridge(center: Vector2) -> void:
	draw_set_transform(center + Vector2(4, 5), 0.0, Vector2.ONE)
	draw_rect(Rect2(Vector2(-94, -24), Vector2(188, 48)), Color("4d4838"))
	draw_rect(Rect2(Vector2(-91, -21), Vector2(182, 42)), Color("785d3e"))
	draw_rect(Rect2(Vector2(-88, -18), Vector2(176, 36)), Color("a27c4d"))
	for plank in range(15):
		var x := -84.0 + plank * 12.0
		draw_line(Vector2(x, -17), Vector2(x, 16), Color("634d37"), 2.0)
		draw_line(Vector2(x + 2, -16), Vector2(x + 2, 15), Color("c09a5e"), 1.0)
	draw_line(Vector2(-88, -17), Vector2(88, -17), Color("d3b06d"), 2.0)
	draw_line(Vector2(-88, 17), Vector2(88, 17), Color("d3b06d"), 2.0)
	draw_set_transform(Vector2.ZERO)

func _draw_landmarks() -> void:
	_draw_willow_arch(Vector2(2150, 680))
	_draw_reed_ring(Vector2(1240, 596))
	_draw_ferry_mast(Vector2(720, 348))
	_draw_schnapper_water_sign(Vector2(1740, 475))
	_draw_marker_stones(Vector2(1200, 952))
	if _ferry_plank_lowered:
		_draw_boardwalk_bridge(Vector2(1450, 680))
	else:
		_draw_raised_ferry_plank(Vector2(1450, 680))
	if _reed_ring_solved:
		_draw_secret_clearing(Vector2(1350, 990))

func _draw_willow_arch(center: Vector2) -> void:
	draw_rect(Rect2(center + Vector2(-58, -28), Vector2(14, 92)), Color("604a35"))
	draw_rect(Rect2(center + Vector2(-56, -28), Vector2(8, 84)), Color("987248"))
	draw_rect(Rect2(center + Vector2(44, -36), Vector2(16, 100)), Color("584733"))
	draw_rect(Rect2(center + Vector2(47, -32), Vector2(9, 88)), Color("a07a48"))
	draw_polyline(PackedVector2Array([center + Vector2(-52, -20), center + Vector2(-36, -54), center + Vector2(-6, -66), center + Vector2(20, -58), center + Vector2(52, -24)]), Color("594632"), 11.0)
	_draw_atlas_sprite(center + Vector2(-26, -66), Vector2i(2, 0), Vector2(70, 54))
	_draw_atlas_sprite(center + Vector2(26, -70), Vector2i(3, 0), Vector2(64, 50))
	draw_rect(Rect2(center + Vector2(-10, 16), Vector2(20, 4)), Color("d0b16e"))


func _draw_reed_ring(center: Vector2) -> void:
	draw_circle(center + Vector2(0, 4), 52.0, Color("566047"), false, 4.0)
	draw_circle(center, 47.0, Color("c0a773"), false, 3.0)
	draw_circle(center, 37.0, Color("6b7148"), false, 2.0)
	for stone in [
		center + Vector2(-43, -16), center + Vector2(-24, -41), center + Vector2(11, -45),
		center + Vector2(42, -15), center + Vector2(36, 27), center + Vector2(0, 43),
		center + Vector2(-34, 29),
	]:
		draw_rect(Rect2(stone, Vector2(9, 6)), Color("777858"))
		draw_rect(Rect2(stone + Vector2(2, -2), Vector2(5, 2)), Color("c3b27c"))
	for reed in [
		center + Vector2(-66, -6), center + Vector2(-58, 32), center + Vector2(-15, -58),
		center + Vector2(52, -43), center + Vector2(67, 14), center + Vector2(13, 61),
	]:
		_draw_atlas_sprite(reed, Vector2i(0, 0), Vector2(34, 40))


func _draw_ferry_mast(center: Vector2) -> void:
	draw_rect(Rect2(center + Vector2(-9, -66), Vector2(14, 122)), Color("4c4737"))
	draw_rect(Rect2(center + Vector2(-6, -62), Vector2(7, 112)), Color("98734a"))
	draw_rect(Rect2(center + Vector2(-48, -36), Vector2(92, 10)), Color("5b4b38"))
	draw_rect(Rect2(center + Vector2(-44, -33), Vector2(84, 5)), Color("bd955b"))
	draw_line(center + Vector2(4, -54), center + Vector2(45, -28), Color("d1b578"), 3.0)
	draw_colored_polygon(PackedVector2Array([
		center + Vector2(10, -60), center + Vector2(40, -50), center + Vector2(12, -38),
	]), Color("d5b66d"))
	draw_rect(Rect2(center + Vector2(-27, 54), Vector2(12, 7)), Color("82704c"))
	draw_rect(Rect2(center + Vector2(16, 54), Vector2(13, 7)), Color("82704c"))
	draw_polyline(PackedVector2Array([center + Vector2(-22, 57), center + Vector2(-8, 61), center + Vector2(20, 61)]), Color("c6a568"), 2.0)


func _draw_schnapper_water_sign(center: Vector2) -> void:
	draw_ellipse(center, 54.0, 28.0, Color("517365"), false, 2.0)
	draw_ellipse(center + Vector2(3, 2), 37.0, 18.0, Color("9bad77"), false, 1.0)
	draw_ellipse(center + Vector2(7, 1), 19.0, 10.0, Color("385a43"))
	draw_circle(center + Vector2(11, -2), 2.0, Color("e4ce83"))
	draw_circle(center + Vector2(11, -2), 1.0, Color("27382f"))
	draw_line(center + Vector2(-48, -26), center + Vector2(-38, -26), Color("e4d18b"), 2.0)
	draw_line(center + Vector2(-43, -31), center + Vector2(-43, -21), Color("e4d18b"), 2.0)

func _draw_marker_stones(center: Vector2) -> void:
	var markers := [center + Vector2(-30, 0), center + Vector2(0, 0), center + Vector2(30, 0)]
	for index in range(markers.size()):
		var marker: Vector2 = markers[index]
		draw_rect(Rect2(marker + Vector2(-12, 3), Vector2(25, 17)), Color("5d5c45"))
		draw_colored_polygon(PackedVector2Array([
			marker + Vector2(-11, 5), marker + Vector2(-5, -6), marker + Vector2(9, -9),
			marker + Vector2(13, 5), marker + Vector2(10, 10), marker + Vector2(-10, 11),
		]), Color("a29a6c"))
		for mark in range(index + 1):
			draw_line(marker + Vector2(-4 + mark * 5, -2), marker + Vector2(-4 + mark * 5, 2), Color("ead69a"), 2.0)

func _draw_reeds_and_flowers() -> void:
	var positions: Array[Vector2] = [
		Vector2(48, 195), Vector2(100, 187), Vector2(308, 188), Vector2(470, 190), Vector2(560, 202),
		Vector2(810, 70), Vector2(920, 174), Vector2(1030, 186), Vector2(1260, 80), Vector2(1390, 174),
		Vector2(1720, 186), Vector2(1815, 197), Vector2(2000, 194), Vector2(2290, 205), Vector2(2360, 234),
		Vector2(350, 328), Vector2(450, 317), Vector2(625, 300), Vector2(850, 314), Vector2(970, 322),
		Vector2(1320, 304), Vector2(1450, 316), Vector2(1790, 306), Vector2(1940, 316), Vector2(2320, 560),
		Vector2(2360, 618), Vector2(100, 610), Vector2(330, 625), Vector2(500, 650), Vector2(890, 626),
		Vector2(1060, 610), Vector2(1440, 625), Vector2(1770, 615), Vector2(1990, 625), Vector2(2280, 833),
		Vector2(60, 816), Vector2(426, 904), Vector2(526, 884), Vector2(822, 912), Vector2(1010, 886),
		Vector2(1380, 912), Vector2(1580, 904), Vector2(1780, 876), Vector2(2070, 898), Vector2(2310, 905),
		Vector2(440, 1058), Vector2(680, 1030), Vector2(1000, 1042), Vector2(1480, 1044), Vector2(1780, 1035),
	]
	var plant_cells: Array[Vector2i] = [
		Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0),
		Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 3), Vector2i(3, 3),
	]
	for index in range(positions.size()):
		var target_size := Vector2(46, 44)
		if index % 4 == 2:
			target_size = Vector2(38, 34)
		elif index % 5 == 3:
			target_size = Vector2(36, 32)
		_draw_atlas_sprite(positions[index], plant_cells[index % plant_cells.size()], target_size)
	for flower in [
		Vector2(270, 330), Vector2(560, 760), Vector2(900, 455), Vector2(1030, 820),
		Vector2(1320, 840), Vector2(1910, 450), Vector2(2050, 748), Vector2(460, 735),
		Vector2(1450, 245), Vector2(870, 1000), Vector2(1990, 990), Vector2(2350, 470),
	]:
		_draw_atlas_sprite(flower, Vector2i(3, 0), Vector2(27, 25))
	for rock in [
		Vector2(575, 486), Vector2(930, 740), Vector2(1370, 478), Vector2(1975, 735),
		Vector2(375, 710), Vector2(1815, 920), Vector2(815, 750), Vector2(2260, 500),
	]:
		_draw_atlas_sprite(rock, Vector2i(2, 1), Vector2(42, 34))


func _draw_path_details() -> void:
	for stone in [
		Vector2(2090, 984), Vector2(1940, 920), Vector2(1810, 984), Vector2(1644, 884),
		Vector2(1716, 770), Vector2(1570, 654), Vector2(1400, 708), Vector2(1276, 614),
		Vector2(1236, 486), Vector2(1090, 436), Vector2(908, 376), Vector2(770, 453),
		Vector2(690, 378), Vector2(352, 439), Vector2(218, 339),
	]:
		draw_rect(Rect2(stone, Vector2(7, 3)), Color("665b43"))
		draw_rect(Rect2(stone + Vector2(2, -2), Vector2(4, 2)), Color("d1b875"))


func _draw_entry_and_rest_point() -> void:
	var entry := Vector2(2220, 952)
	draw_rect(Rect2(entry + Vector2(-13, 34), Vector2(5, 44)), Color("574732"))
	draw_rect(Rect2(entry + Vector2(8, 34), Vector2(5, 44)), Color("574732"))
	draw_rect(Rect2(entry + Vector2(-18, 32), Vector2(36, 6)), Color("bb965e"))
	draw_rect(Rect2(entry + Vector2(-14, 24), Vector2(28, 7)), Color("dbb66f"))
	draw_rect(Rect2(Vector2(2310, 1006), Vector2(38, 6)), Color("654b34"))
	draw_rect(Rect2(Vector2(2314, 994), Vector2(30, 13)), Color("ac7e4b"))
	draw_rect(Rect2(Vector2(2316, 992), Vector2(26, 5)), Color("d0a568"))
	draw_rect(Rect2(Vector2(2312, 1019), Vector2(5, 13)), Color("5a4934"))
	draw_rect(Rect2(Vector2(2340, 1019), Vector2(5, 13)), Color("5a4934"))
	draw_rect(Rect2(Vector2(2190, 910), Vector2(6, 50)), Color("624a35"))
	draw_rect(Rect2(Vector2(2180, 906), Vector2(25, 9)), Color("d0ad69"))
	draw_rect(Rect2(Vector2(2184, 908), Vector2(17, 4)), Color("805d3a"))


func _water_pools() -> Array[Rect2]:
	return [
		Rect2(52, 44, 236, 122), Rect2(572, 54, 188, 136), Rect2(1050, 55, 210, 105),
		Rect2(1508, 28, 190, 138), Rect2(2068, 40, 230, 148), Rect2(390, 346, 182, 110),
		Rect2(1305, 324, 120, 70), Rect2(1550, 325, 178, 112), Rect2(2140, 310, 200, 96),
		Rect2(80, 656, 220, 118), Rect2(982, 600, 116, 110), Rect2(1360, 610, 180, 140),
		Rect2(2280, 780, 108, 88), Rect2(90, 910, 235, 130), Rect2(960, 930, 168, 112),
		Rect2(1420, 990, 118, 72),
	]

func _water_collision_rects() -> Array[Rect2]:
	var blockers: Array[Rect2] = []
	for pool in _water_pools():
		if pool.position.is_equal_approx(Vector2(1360, 610)):
			var inner := pool.grow(-12.0)
			blockers.append(Rect2(inner.position, Vector2(inner.size.x, 38.0)))
			blockers.append(Rect2(inner.position + Vector2(0.0, 74.0), Vector2(inner.size.x, 42.0)))
		else:
			blockers.append(pool.grow(-12.0))
	return blockers

func _solid_thickets() -> Array[Rect2]:
	return [
		Rect2(470, 502, 30, 42), Rect2(1444, 470, 38, 34), Rect2(2008, 766, 34, 42),
		Rect2(846, 744, 30, 36), Rect2(1844, 914, 36, 32),
	]



func _draw_raised_ferry_plank(center: Vector2) -> void:
	draw_rect(Rect2(center + Vector2(-7, -22), Vector2(14, 44)), Color("4d4838"))
	draw_rect(Rect2(center + Vector2(-4, -20), Vector2(8, 40)), Color("a27c4d"))
	draw_line(center + Vector2(-3, -14), center + Vector2(3, -14), Color("d3b06d"), 2.0)


func _draw_secret_clearing(center: Vector2) -> void:
	draw_ellipse(center + Vector2(0, 8), 68.0, 35.0, Color("596347"))
	draw_ellipse(center, 62.0, 31.0, Color("9ca268"))
	for offset in [Vector2(-34, 2), Vector2(-8, -8), Vector2(22, 5), Vector2(42, -6)]:
		_draw_atlas_sprite(center + offset, Vector2i(1, 0), Vector2(34, 38))


func _draw_atlas_sprite(center: Vector2, cell: Vector2i, target_size: Vector2) -> void:
	var atlas_size := Vector2(DECORATION_ATLAS.get_size())
	var cell_size := atlas_size / Vector2(ATLAS_COLUMNS, ATLAS_ROWS)
	var source_position := Vector2(float(cell.x) * cell_size.x, float(cell.y) * cell_size.y)
	draw_texture_rect_region(
		DECORATION_ATLAS,
		Rect2(center - target_size / 2.0, target_size),
		Rect2(source_position, cell_size),
		Color.WHITE,
		false,
		true
	)


func _draw_environment_sprite(source: Rect2, destination: Rect2) -> void:
	draw_texture_rect_region(ENVIRONMENT_ATLAS, destination, source, Color.WHITE, false, true)
