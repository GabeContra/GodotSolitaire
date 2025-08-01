extends Area2D

var card_over_me = false
var card_on_me : Card = null
var num_of_cards : int = 0
var cards : Array[int]
var CardSpriteScene : PackedScene = preload("res://Scenes/CardSprite.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_card(card : int):
	var newCard : CardSprite = CardSpriteScene.instantiate()
	$Cards.add_child(newCard)
	num_of_cards += 1
	newCard.set_card(card)
	print("Adding card ", Enums.index_to_text(card))
	newCard.position.y = (num_of_cards - 1) * 50
	cards.push_back(card)
	
func remove_top_card() -> int:
	$Cards.remove_child($Cards.get_child(-1))
	num_of_cards -= 1
	return cards.pop_back()


func set_card():
	if card_on_me != null:
		card_on_me.position.x = self.position.x
		card_on_me.position.y = self.position.y + num_of_cards*25
		num_of_cards += 1
		cards.push_front(card_on_me)
		$SetArea.position.y +=25
		_on_Pile_area_exited(card_on_me)

func _on_Pile_area_entered(area):
	if area.is_in_group("cards"):
		var card := area as Card
		card_over_me = true
		card_on_me = card
		card_on_me.connect("dropped", Callable(self, "set_card"))


func _on_Pile_area_exited(area):
	if area.is_in_group("cards"):
		card_over_me = false
		if card_on_me != null:
			card_on_me.disconnect("dropped", Callable(self, "set_card"))
			card_on_me = null
