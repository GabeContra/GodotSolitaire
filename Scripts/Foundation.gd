extends Area2D


signal add_card(card_value)

export(Global.Suits) var suit = Global.Suits.NONE
var cards = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_to_foundation(card_value):
	if suit != Global.Suits.NONE:
		if card_value == card_value%13 + suit*13:
			cards.push_front(card_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_sprite():
	if cards.empty():
		$Sprite.set_frame(Global.Cards.BACK)
	else:
		$Sprite.set_frame(cards[0])
