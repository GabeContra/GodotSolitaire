extends Area2D


signal remove_card(card_value)


@export var suit = Enums.Suits.NONE # (Global.Suits)
var cards = []
var card_over_me = false
var card_on_me : Card = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_to_foundation(card_value):
	if suit != Enums.Suits.NONE:
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
	card_on_me.disconnect("dropped", Callable(self, "card_dropped_on_me"))
	card_on_me = null
	card_over_me = false


func update_sprite():
	if cards.is_empty():
		$CardSprite.visible = false
	else:
		$CardSprite.visible = true
		$CardSprite.set_card(cards[0])


func _on_Foundation_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("remove_card", cards.pop_front())
			self.update_sprite()
