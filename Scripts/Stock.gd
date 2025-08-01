extends Area2D


var stock_cards : Array[int]


# Called when the node enters the scene tree for the first time.
func _ready():
	$CardSprite.set_card(Enums.Cards.BACK)
#	for i in range(52):
#		stock_cards.push_back(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func  draw_card() -> int:
	return stock_cards.pop_back()

func add_to_stock(value):
	stock_cards.push_front(value)

func _on_Stock_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("draw_card", stock_cards.pop_front())
