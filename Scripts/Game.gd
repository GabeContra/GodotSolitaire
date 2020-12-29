extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var Card
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
#	for i in range(52):
#		var tempCard = Card.instance()
#		tempCard.value = i
#		tempCard.position.x = $Position2D.position.x + 60*(i % 13)
#		tempCard.position.y = $Position2D.position.y + 100*(i%4)
#		$Cards.add_child(tempCard)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var seconds = int(time)
	var sec = seconds %60
	var minutes = int(seconds / 60)
	var hours = int(seconds / 3600)
	$Control/HBoxContainer/time.text = "%s:%s:%s" % [str(hours),str(minutes).pad_zeros(2), str(sec).pad_zeros(2)]
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
	

func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Stock_draw_card(card_value):
	if card_value != null:
		var tempCard = Card.instance()
		tempCard.position =  $Stock.position
		tempCard.dragging = true
		tempCard.is_face_down = false
		tempCard.value = card_value
		$Cards.add_child(tempCard)
