extends Area2D


signal remove_card(card_value)


@export var suit = Enums.Suits.NONE # (Global.Suits)
var cards : Array[Card]
var current_value = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	update_sprite()

func add_to_foundation(card : Card) -> bool:
	if suit != Enums.Suits.NONE:
		if card.value == current_value%13 + suit*13:
			cards.push_back(card)
			current_value += 1
			self.update_sprite()
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_sprite():
	if cards.is_empty():
		$CardSprite.set_card(Enums.Cards.FOUND_SPADE + suit)
	else:
		$CardSprite.set_card(cards[0])


func _on_Foundation_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Foundation clicked")
			self.update_sprite()
