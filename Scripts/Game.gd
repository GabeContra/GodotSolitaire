extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CardScene = preload("res://Scenes/Card.tscn")
var time = 0
var moving_card = null
var currentSelection = null


# Called when the node enters the scene tree for the first time.
func _ready():
	var deck : Array[int]
	for i in range(52):
		deck.push_back(i)
	deck.shuffle()
	var pileCount = 1
	for pile in $Piles.get_children():
		var i = 0
		while i < pileCount:
			var tempCard = CardScene.instantiate()
			# due to timing of sprite updates this needs to be added before value and face_down is set
			pile.add_card(tempCard)
			tempCard.is_face_down = false
			if i+1 < pileCount:
				tempCard.is_face_down = true
			tempCard.value = deck.pop_back()
			i += 1
		pileCount += 1
	$Stock.stock_cards = deck


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var seconds = int(time)
	var sec = seconds %60
	@warning_ignore("integer_division") var minutes = int(seconds / 60)
	@warning_ignore("integer_division") var hours = int(seconds / 3600)
	$UI/TopContainer/time.text = "%s:%s:%s" % [str(hours),str(minutes).pad_zeros(2), str(sec).pad_zeros(2)]
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func allow_to_move(card):
	if moving_card == null:
		moving_card = card
		moving_card.dragging = true
		moving_card.connect("dropped", Callable(self, "stop_moving"))
		
func stop_moving():
	if moving_card != null:
		moving_card.dragging = false
		moving_card.disconnect("dropped", Callable(self, "stop_moving"))
		moving_card = null

func attempt_to_draw_card() -> void:
	var card = $Stock.draw_card()
	if not card:
		return
	$Waste.add_to_waste(card)
	
func add_to_pile():
	pass

func add_to_waste():
	pass
	
func add_to_foundation():
	pass

func _on_Quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_Stock_draw_card(card_value):
	if card_value != null:
#		var tempCard = Card.instance()
#		tempCard.position =  $Stock.position
#		tempCard.is_face_down = false
#		tempCard.value = card_value
#		tempCard.unlock_move()
#		tempCard.connect("dropped", tempCard, "letgo")
#		tempCard.connect("grab_me", self, "allow_to_move")
#		tempCard.emit_signal("grab_me", tempCard)
#		$Cards.add_child(tempCard)
		$Waste.add_to_waste(card_value)


func _on_Waste_take_card(card_value):
	if card_value != null:
		var tempCard = CardScene.instantiate()
		tempCard.position =  $Waste.position
		tempCard.is_face_down = false
		tempCard.value = card_value
		tempCard.unlock_move()
		tempCard.connect("dropped", Callable(tempCard, "letgo"))
		tempCard.connect("grab_me", Callable(self, "allow_to_move"))
		tempCard.emit_signal("grab_me", tempCard)
		$Cards.add_child(tempCard)


func _on_draw_pressed() -> void:
	attempt_to_draw_card()
