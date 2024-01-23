extends Node2D

var cursorImage = load("res://Assets/Sprites/Cursor.png")

func _ready():
	Input.set_custom_mouse_cursor(cursorImage)

func _input(event):
	if Global.isControllerConnected:
		Input.set_custom_mouse_cursor(null)
		Global.isControllerConnected = !Input.get_connected_joypads().is_empty()
	else:
		Input.set_custom_mouse_cursor(cursorImage)
		Global.isControllerConnected = !Input.get_connected_joypads().is_empty()
