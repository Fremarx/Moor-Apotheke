extends Node2D

@onready var _player: Node = $World/Player
@onready var _inventory: Node = $Inventory
@onready var _inventory_count: Label = $HUD/InventoryCount
@onready var _dried_mint_count: Label = $HUD/DriedMintCount
@onready var _tea_count: Label = $HUD/TeaCount
@onready var _interaction_prompt: Label = $HUD/InteractionPrompt
@onready var _interaction_feedback: Label = $HUD/InteractionFeedback
@onready var _feedback_timer: Timer = $HUD/FeedbackTimer


func _ready() -> void:
	_player.connect("interaction_hint_changed", _on_interaction_hint_changed)
	_player.connect("interaction_completed", _on_interaction_completed)
	_inventory.item_count_changed.connect(_on_item_count_changed)
	_feedback_timer.timeout.connect(_on_feedback_timer_timeout)

	for pickup in get_tree().get_nodes_in_group("item_pickups"):
		if pickup.has_signal("item_collected"):
			pickup.item_collected.connect(_inventory.add_item)

	for station in get_tree().get_nodes_in_group("processing_stations"):
		if station.has_method("set_inventory"):
			station.set_inventory(_inventory)


func _on_interaction_hint_changed(prompt_text: String) -> void:
	_interaction_prompt.text = prompt_text
	_interaction_prompt.visible = not prompt_text.is_empty()


func _on_interaction_completed(feedback_text: String) -> void:
	if feedback_text.is_empty():
		return

	_interaction_feedback.text = feedback_text
	_interaction_feedback.show()
	_feedback_timer.start()


func _on_item_count_changed(item_id: String, amount: int) -> void:
	if item_id == "sump_mint":
		_inventory_count.text = "Sumpfminze: %d" % amount
	elif item_id == "dried_sump_mint":
		_dried_mint_count.text = "Getrocknete Minze: %d" % amount
	elif item_id == "calming_tea":
		_tea_count.text = "Beruhigungstee: %d" % amount


func _on_feedback_timer_timeout() -> void:
	_interaction_feedback.hide()
