extends Area2D
class_name Pile

signal attempt_to_add(id: int)
var card_over_me = false
var card_on_me : Card = null
var CardScene : PackedScene = preload("res://Scenes/Card.tscn")
var attempttedCard : Card = null
@export var id : int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func add_card(card : Card):
	$Cards.add_child(card)
	card.position.y = ($Cards.get_child_count() - 1) * 25
	card.z_index = $Cards.get_child_count()

func add_enforced_card(card: Card) -> bool:
	if check_legality(card):
		add_card(card)
		return true
	else:
		print("Illegal add")
	return false

func check_legality(card: Card) -> bool:
	if not card:
		return false
	var value = card.value
	@warning_ignore("integer_division")
	var suit = value / 13
	var rank = value % 13
	# check case where pile is empty
	if $Cards.get_child_count() == 0 and rank == Enums.Ranks.KING:
		return true
	
	# regular rules for adding card on top of another
	var topCard = $Cards.get_child(-1)
	var topCardSuit = topCard.value / 13
	var topCardRank = topCard.value % 13
	if topCardSuit == Enums.Suits.SPADE or topCardSuit == Enums.Suits.CLUBS:
		if suit == Enums.Suits.HEART or suit == Enums.Suits.DIAMD:
			if topCardRank - 1 == rank:
				return true
		else:
			return false
	elif topCardSuit == Enums.Suits.HEART or topCardSuit == Enums.Suits.DIAMD:
		if suit == Enums.Suits.CLUBS or suit == Enums.Suits.SPADE:
			if topCardRank - 1 == rank:
				return true
		else:
			return false
	return false

func update_pile_sprites() -> void:
	var finalCard = $Cards.get_child(-1)
	if finalCard and finalCard.is_face_down:
		finalCard.is_face_down = false
	for cardObject in $Cards.get_children():
		cardObject.update_sprite()

func remove_top_card() -> Card:
	var topCard = $Cards.get_child(-1)
	$Cards.remove_child(topCard)
	return topCard


func _on_add_pressed() -> void:
	attempt_to_add.emit(id)
