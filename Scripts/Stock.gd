extends Area2D


signal draw_card(card_value)
var stock_cards = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	for i in range(52):
#		stock_cards.push_back(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_to_stock(value):
	stock_cards.push_front(value)

func _on_Stock_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("draw_card", stock_cards.pop_front())
