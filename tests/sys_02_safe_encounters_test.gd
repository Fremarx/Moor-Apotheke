extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const TEST_SAVE_PATH := "user://sys_02_safe_encounters_test.json"
const SAFE_TORFSTICH_POSITION := Vector2(80, 408)

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_remove_test_save()
	var main := MAIN_SCENE.instantiate()
	main.get_node("SaveManager").set("save_path", TEST_SAVE_PATH)
	root.add_child(main)
	await physics_frame
	await physics_frame

	var player := main.get_node("World/Player") as CharacterBody2D
	var inventory := main.get_node("Inventory")
	var heart_display := main.get_node_or_null("HUD/Hearts")
	var snapper := main.get_node("World/Schilfufer/Schilfschnapper") as Area2D
	var peat_area := main.get_node("World/AlterTorfstich")
	var wuehler := peat_area.get_node("Moorwuehler") as Area2D
	var wisp := peat_area.get_node("Irrlicht") as Area2D

	_check(player.is_in_group("players"), "the player is discoverable by encounter areas")
	_check(player.has_method("receive_enemy_attack"), "the player can take a protected enemy hit")
	_check(player.has_method("use_herb_staff"), "the player has a no-cost herb-staff action")
	_check(player.has_method("dodge"), "the player can perform a short evasive step")
	_check(heart_display != null, "the HUD visibly shows the player's hearts")
	_check(_int_property(player, "max_hearts") == 3, "the player starts with three hearts")
	_check(InputMap.has_action("herb_staff_attack"), "the herb-staff action has a named input")
	_check(InputMap.has_action("dodge"), "the dodge action has a named input")
	_check(_action_uses_key("herb_staff_attack", KEY_F), "F is bound to the herb staff")
	_check(_action_uses_key("dodge", KEY_SPACE), "Space is bound to dodge")
	_check(snapper.has_method("apply_staff_hit"), "the Schilfschnapper supports staff hits")
	_check(wuehler.has_method("apply_staff_hit"), "the Moorwühler supports staff hits")
	_check(wisp.has_method("apply_staff_hit"), "the Irrlicht supports staff hits")
	_check(_float_property(snapper, "attack_windup_seconds") >= 0.8 and _float_property(snapper, "attack_windup_seconds") <= 1.2, "the warning lasts about one second")
	_check(not _bool_property(wisp, "can_attack_player", true), "the Irrlicht remains a harmless guidance encounter")
	_check(heart_display != null and heart_display.has_method("set_hearts"), "heart display responds to player health changes")

	inventory.call("add_item", "sump_mint", 2)
	inventory.call("add_item", "coins", 11)
	var before_safe_pass: Dictionary = inventory.call("get_save_data")
	player.global_position = snapper.global_position
	await physics_frame
	await physics_frame
	_check(player.call("try_interact"), "the player can safely pass the Schilfschnapper")
	_check(not snapper.visible, "safe passage moves the Schilfschnapper aside")
	_check(inventory.call("get_save_data") == before_safe_pass, "safe passage gives no drop and removes no inventory")

	if snapper.has_method("reset_encounter"):
		snapper.call("reset_encounter")
	player.global_position = snapper.global_position + Vector2(-24, 0)
	if player.has_method("set_facing_direction"):
		player.call("set_facing_direction", Vector2.RIGHT)
	if player.has_method("set_herb_staff_cooldown"):
		player.call("set_herb_staff_cooldown", 0.0)
	if player.has_method("use_herb_staff"):
		_check(bool(player.call("use_herb_staff")), "the first staff swing is accepted")
		await physics_frame
		await physics_frame
		_check(not bool(player.call("use_herb_staff")), "the staff observes its brief recovery")
		await create_timer(0.5).timeout
		await physics_frame
		await physics_frame
		_check(bool(player.call("use_herb_staff")), "the staff is usable again after its brief recovery")
		await physics_frame
		await physics_frame
	_check(not snapper.visible, "two staff hits drive off an ordinary encounter")
	_check(int(inventory.call("get_count", "snapper_slime")) == 1, "a defeated Schilfschnapper drops exactly one matching ingredient")
	if snapper.has_method("apply_staff_hit"):
		snapper.call("apply_staff_hit")
	_check(int(inventory.call("get_count", "snapper_slime")) == 1, "a defeated enemy cannot yield the same drop twice")
	_check(bool(inventory.call("validate_save_data", {"snapper_slime": 1, "coins": 11})), "enemy ingredients are accepted by the existing save format")

	main.call("_on_map_transition_requested", &"AlterTorfstich", SAFE_TORFSTICH_POSITION, "Du betrittst den Alten Torfstich.")
	player = main.get_node("World/Player") as CharacterBody2D
	player.global_position = wuehler.global_position - Vector2(56, 0)
	await physics_frame
	await physics_frame
	_check(wuehler.has_method("is_attack_warning_active") and bool(wuehler.call("is_attack_warning_active")), "the Moorwühler shows a telegraphed lane before attacking")
	var hearts_before_dodge := _int_property(player, "current_hearts")
	_check(bool(player.call("dodge", Vector2.DOWN)), "the player can dodge during the warning")
	await create_timer(0.22).timeout
	_check(player.global_position.y > wuehler.global_position.y + 20.0, "the dodge moves the player out of the attack lane")
	player.global_position = wuehler.global_position + Vector2(0, 200)
	await create_timer(1.1).timeout
	_check(_int_property(player, "current_hearts") == hearts_before_dodge, "dodging the warned lane avoids the attack")

	player.global_position = wuehler.global_position - Vector2(56, 0)
	await physics_frame
	await physics_frame
	var found_warning := false
	for _frame in range(100):
		if wuehler.has_method("is_attack_warning_active") and bool(wuehler.call("is_attack_warning_active")):
			found_warning = true
			break
		await physics_frame
	_check(found_warning, "the Moorwühler warns again after recovering")
	if found_warning:
		await create_timer(float(wuehler.get("attack_windup_seconds")) + 0.12).timeout
	_check(_int_property(player, "current_hearts") == hearts_before_dodge - 1, "an unavoided enemy hit costs one heart")

	var before_defeat: Dictionary = inventory.call("get_save_data")
	if _has_property(player, "damage_invulnerability_seconds"):
		player.set("damage_invulnerability_seconds", 0.0)
	if _has_property(player, "_invulnerability_remaining"):
		player.set("_invulnerability_remaining", 0.0)
	if player.has_method("receive_enemy_attack"):
		player.call("receive_enemy_attack", Vector2.LEFT)
		player.call("receive_enemy_attack", Vector2.LEFT)
		player.call("receive_enemy_attack", Vector2.LEFT)
	await create_timer(0.55).timeout
	_check(player.global_position.is_equal_approx(peat_area.to_global(SAFE_TORFSTICH_POSITION)), "defeat returns the player to the Torfstich safe waypoint")
	_check(_int_property(player, "current_hearts") == 3, "the safe return restores all three hearts")
	_check(inventory.call("get_save_data") == before_defeat, "defeat preserves ingredients and coins")
	_check(heart_display != null and _int_property(heart_display, "current_hearts") == 3, "the visible heart display refreshes after recovery")

	var before_wisp: Dictionary = inventory.call("get_save_data")
	wisp.call("interact")
	_check(not wisp.visible, "following the true light safely dismisses the Irrlicht")
	_check(inventory.call("get_save_data") == before_wisp, "dismissing a harmless encounter gives no drop")
	wisp.call("reset_encounter")
	_check(bool(inventory.call("validate_save_data", {"peat_armor_flake": 1, "will_o_wisp_spark": 1})), "all planned starter enemy ingredients are valid saved inventory")

	main.queue_free()
	await process_frame
	_remove_test_save()
	_finish()


func _has_property(target: Object, property_name: String) -> bool:
	for property_info in target.get_property_list():
		if str(property_info["name"]) == property_name:
			return true
	return false


func _int_property(target: Object, property_name: String) -> int:
	return int(target.get(property_name)) if _has_property(target, property_name) else -1


func _float_property(target: Object, property_name: String) -> float:
	return float(target.get(property_name)) if _has_property(target, property_name) else -1.0


func _bool_property(target: Object, property_name: String, fallback: bool) -> bool:
	return bool(target.get(property_name)) if _has_property(target, property_name) else fallback

func _action_uses_key(action: StringName, physical_key: Key) -> bool:
	if not InputMap.has_action(action):
		return false
	for event in InputMap.action_get_events(action):
		if event is InputEventKey and event.physical_keycode == physical_key:
			return true
	return false


func _remove_test_save() -> void:
	if FileAccess.file_exists(TEST_SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("SYS-02 safe encounter checks passed.")
		quit(0)
		return
	for failure in _failures:
		push_error("SYS-02 check failed: " + failure)
	quit(1)
