extends Area2D

var card_over_me = false
var card_on_me : Card = null
var CardScene : PackedScene = preload("res://Scenes/Card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_card(card : Card):
	$Cards.add_child(card)
	card.position.y = ($Cards.get_child_count() - 1) * 50

func add_enforced_card(card: Card):
	add_card(card)

func check_legality(card: Card):
	var value = card.value
	@warning_ignore("integer_division")
	var suit = value / 13
	var rank = value % 13
	pass

func update_pile_sprites() -> void:
	for cardObject in $Cards.get_children():
		cardObject.update_sprite()

func remove_top_card() -> Card:
	var topCard = $Cards.get_child(-1)
	$Cards.remove_child(topCard)
	return topCard
