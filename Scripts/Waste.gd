extends Area2D

signal take_card(value)

var waste_cards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_to_waste(value : int):
	waste_cards.push_back(value)
	self.update_sprite()

func update_sprite():
	if waste_cards.is_empty():
		$CardSprite.visible = false
	else:
		$CardSprite.visible = true
		$CardSprite.set_card(waste_cards[-1])

func reset_waste():
	var reverse = waste_cards.invert()
	waste_cards.clear()
	return reverse

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Waste_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("take_card", waste_cards.pop_front())
			self.update_sprite()
