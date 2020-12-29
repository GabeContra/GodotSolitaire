extends Area2D


var value = 0 setget set_value, get_value
var is_face_down : bool = true
var is_stacked : bool = false
var _rng = RandomNumberGenerator.new()
var dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseMotion and dragging:
		self.position = event.position

func set_value(new_value):
	value = new_value
	if !is_face_down:
		$CardSprite.set_frame(new_value)

func get_value():
	return value

func _on_Card_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			dragging = true
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			dragging = false