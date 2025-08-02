extends Control


@export var suit = Enums.Suits.NONE # (Global.Suits)
var cards : Array[Card]
var current_value = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	update_sprite()

func add_to_foundation(card : Card) -> bool:
	if check_legality(card.value):
		cards.push_back(card)
		current_value += 1
		self.update_sprite()
		return true
	return false

func check_legality(cardValue : int) -> bool:
	if suit != Enums.Suits.NONE:
		if cardValue == current_value%13 + suit*13:
			return true
	return false

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if !data is Card: 
		return false
	var cardData := data as Card
	return check_legality(cardData.value)

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if !data is Card: 
		return
	var cardData := data as Card
	add_to_foundation(cardData)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_sprite():
	if cards.is_empty():
		$CardSprite.set_card(Enums.Cards.FOUND_SPADE + suit)
	else:
		$CardSprite.set_card(cards[-1].value)
