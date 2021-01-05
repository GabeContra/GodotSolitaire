extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		$ConfirmQuit.popup_centered()

func _on_Quit_pressed():
	$ConfirmQuit.popup_centered()
#	get_tree().quit()

func _on_Settings_pressed():
	get_tree().change_scene("res://Scenes/SettingsMenu.tscn")

func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_ConfirmQuit_confirmed():
	get_tree().quit()
