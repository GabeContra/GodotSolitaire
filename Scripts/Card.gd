extends Area2D
class_name Card


#signals related to moving the card
signal dropped
signal grab_me(me)

#value affects the look of the card if face up and used for other conditions
var value = 0: get = get_value, set = set_value
var is_face_down : bool = true: get = get_face, set = set_face

#these are related to being able to move the card
var dragging = false: get = get_dragging, set = set_dragging
var moving = false
var grab_lock = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$CardSprite.set_card(Enums.Cards.BACK)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func lock_move():
	grab_lock = true

func unlock_move():
	grab_lock = false

func _input(event):
	if event is InputEventMouseMotion and dragging:
		moving = true
		self.position = event.position

func set_value(new_value: int):
	value = new_value
	if !is_face_down:
		$CardSprite.set_frame(new_value)
	else:
		$CardSprite.set_frame(Enums.Cards.BACK)

func get_value():
	return value

func set_face(face : bool):
	is_face_down = face
	set_value(value)

func get_face():
	return is_face_down

func set_dragging(val):
	dragging = val
	if val == true:
		z_index = 30
	elif val == false:
		z_index = 0

func get_dragging():
	return dragging
	
func letgo():
	print("dropped")

func _on_Card_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if !grab_lock:
				emit_signal("grab_me", self)
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			if !grab_lock:
				moving = false
				emit_signal("dropped")
