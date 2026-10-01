extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var main := MAIN_SCENE.instantiate()
	root.add_child(main)
	await physics_frame
	await physics_frame

	var inventory := main.get_node_or_null("Inventory")
	var fenja := main.get_node_or_null("World/TestMap/Fenja")
	var marten := main.get_node_or_null("World/TestMap/Marten")
	var lene := main.get_node_or_null("World/TestMap/Lene")
	var fenja_quest := main.get_node_or_null("Quest/FenjaQuest")
	var marten_quest := main.get_node_or_null("Quest/MartenQuest")
	var lene_quest := main.get_node_or_null("Quest/LeneQuest")
	var coin_count := main.get_node_or_null("HUD/CoinCount") as Label

	_check(inventory != null, "the inventory exists")
	_check(fenja != null, "Fenja exists")
	_check(marten != null, "Marten exists")
	_check(lene != null, "Lene exists")
	_check(fenja_quest != null, "Fenja's quest exists")
	_check(marten_quest != null, "Marten's quest exists")
	_check(lene_quest != null, "Lene's quest exists")
	_check(coin_count != null, "the coin counter exists")
	if inventory == null or fenja == null or marten == null or lene == null or fenja_quest == null or marten_quest == null or lene_quest == null or coin_count == null:
		main.queue_free()
		_finish()
		return

	_check(int(inventory.call("get_count", "coins")) == 0, "the wallet starts empty")
	_check(coin_count.text == "Münzen: 0", "the HUD shows the empty wallet")

	_check(bool(fenja_quest.call("accept")), "Fenja's request can be accepted")
	var missing_tea_feedback: String = fenja.call("interact")
	_check(str(fenja_quest.get("state")) == "active", "Fenja's request stays active without tea")
	_check(not missing_tea_feedback.contains("Münzen"), "a failed hand-in gives no reward")
	_check(int(inventory.call("get_count", "coins")) == 0, "a failed hand-in leaves the wallet unchanged")

	inventory.call("add_item", "calming_tea", 1)
	var fenja_feedback: String = fenja.call("interact")
	_check(str(fenja_quest.get("state")) == "completed", "Fenja's tea completes her request")
	_check(fenja_feedback.contains("5 Münzen"), "Fenja tells the player about her five-coin reward")
	_check(int(inventory.call("get_count", "coins")) == 5, "Fenja awards five coins")
	_check(coin_count.text == "Münzen: 5", "the coin HUD updates after Fenja's reward")
	fenja.call("interact")
	_check(int(inventory.call("get_count", "coins")) == 5, "speaking to Fenja again does not award coins twice")

	_check(bool(marten_quest.call("accept")), "Marten's request unlocks after Fenja's completion")
	var missing_infusion_feedback: String = marten.call("interact")
	_check(str(marten_quest.get("state")) == "active", "Marten's request stays active without an infusion")
	_check(not missing_infusion_feedback.contains("Münzen"), "a failed Marten hand-in gives no reward")
	_check(int(inventory.call("get_count", "coins")) == 5, "a failed Marten hand-in leaves the wallet unchanged")
	inventory.call("add_item", "strengthening_infusion", 1)
	var marten_feedback: String = marten.call("interact")
	_check(str(marten_quest.get("state")) == "completed", "the infusion completes Marten's request")
	_check(marten_feedback.contains("10 Münzen"), "Marten tells the player about his ten-coin reward")
	_check(int(inventory.call("get_count", "coins")) == 15, "Marten's reward raises the wallet to fifteen coins")
	_check(coin_count.text == "Münzen: 15", "the coin HUD updates after Marten's reward")
	marten.call("interact")
	_check(int(inventory.call("get_count", "coins")) == 15, "speaking to Marten again does not award coins twice")

	_check(bool(lene_quest.call("accept")), "Lene's request unlocks after Marten's completion")
	var missing_potion_feedback: String = lene.call("interact")
	_check(str(lene_quest.get("state")) == "active", "Lene's request stays active without a potion")
	_check(not missing_potion_feedback.contains("Münzen"), "a failed Lene hand-in gives no reward")
	_check(int(inventory.call("get_count", "coins")) == 15, "a failed Lene hand-in leaves the wallet unchanged")
	inventory.call("add_item", "night_potion", 1)
	var lene_feedback: String = lene.call("interact")
	_check(str(lene_quest.get("state")) == "completed", "the potion completes Lene's request")
	_check(lene_feedback.contains("15 Münzen"), "Lene tells the player about her fifteen-coin reward")
	_check(int(inventory.call("get_count", "coins")) == 30, "Lene's reward raises the wallet to thirty coins")
	_check(coin_count.text == "Münzen: 30", "the coin HUD updates after Lene's reward")
	lene.call("interact")
	_check(int(inventory.call("get_count", "coins")) == 30, "speaking to Lene again does not award coins twice")

	main.queue_free()
	_finish()


func _check(condition: bool, description: String) -> void:
	if not condition:
		_failures.append(description)


func _finish() -> void:
	if _failures.is_empty():
		print("ECON-001 quest reward checks passed.")
		quit(0)
		return

	for failure in _failures:
		push_error("ECON-001 check failed: " + failure)
	quit(1)

func _process(_delta: float) -> bool:
	return false
