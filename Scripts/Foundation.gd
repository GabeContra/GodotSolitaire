extends Area2D


signal remove_card(card_value)


export(Global.Suits) var suit = Global.Suits.NONE
var cards = []
var card_over_me = false
var card_on_me : Card = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_to_foundation(card_value):
	if suit != Global.Suits.NONE:
		if card_value == card_value%13 + suit*13:
			cards.push_front(card_value)
			self.update_sprite()
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func card_dropped_on_me():
	if add_to_foundation(card_on_me.value):
		card_on_me.queue_free()
	card_on_me.disconnect("dropped", self, "card_dropped_on_me")
	card_on_me = null
	card_over_me = false


func update_sprite():
	if cards.empty():
		$Sprite.set_frame(Global.Cards.BACK)
	else:
		$Sprite.set_frame(cards[0])


func _on_Foundation_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("remove_card", cards.pop_front())
			self.update_sprite()


func _on_Foundation_area_entered(area : Area2D):
	if area.is_in_group("cards"):
		var card := area as Card
		card_over_me = true
		card_on_me = card
		card_on_me.connect("dropped", self, "card_dropped_on_me")


func _on_Foundation_area_exited(area):
	if area.is_in_group("cards"):
		card_over_me = false
		if card_on_me != null:
			card_on_me.disconnect("dropped", self, "card_dropped_on_me")
			card_on_me = null
