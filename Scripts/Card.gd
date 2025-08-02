extends Control
class_name Card


#value affects the look of the card if face up and used for other conditions
var value = 0: get = get_value, set = set_value
var is_face_down : bool = true: get = get_face, set = set_face


# Called when the node enters the scene tree for the first time.
func _ready():
	$CardSprite.set_card(Enums.Cards.BACK)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clicked card:", Enums.index_to_text(value))

func set_value(new_value: int) -> void:
	value = new_value
	update_sprite()

func update_sprite() -> void:
	if !is_face_down:
		$CardSprite.set_card(value)
	else:
		$CardSprite.set_card(Enums.Cards.BACK)

func get_value() -> int:
	return value

func set_face(face : bool):
	is_face_down = face
	update_sprite()

func get_face():
	return is_face_down
