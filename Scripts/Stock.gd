extends Control


var stock_cards : Array[int]
var CardSpriteScene = preload("res://Scenes/CardSprite.tscn")
var CardScene = preload("res://Scenes/Card.tscn")
var can_drag = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$CardSprite.set_card(Enums.Cards.BACK)
#	for i in range(52):
#		stock_cards.push_back(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var cardDragged = null
func _get_drag_data(_at_position: Vector2) -> Variant:
	if can_drag:
		var dragPreview := Control.new()
		var cardSprite = CardSpriteScene.instantiate()
		cardSprite.set_card(stock_cards[-1])
		cardSprite.position = Vector2(-25, -35)
		cardSprite.z_index = 99
		dragPreview.add_child(cardSprite)
		set_drag_preview(dragPreview)
		var card = CardScene.instantiate()
		card.value = stock_cards[-1]
		draw_card()
		return card
	return null


func draw_card():
	if stock_cards.is_empty():
		print("NO MORE STOCK")
		$CardSprite.visible = false
	return stock_cards.pop_back()

func add_to_stock(value):
	stock_cards.push_front(value)
	$CardSprite.visible = true
	
