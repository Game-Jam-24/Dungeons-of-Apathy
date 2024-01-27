extends Node2D

func _input(event):
	if event.is_action_pressed("ui_dash"):
		get_tree().change_scene_to_file("res://HubWorld.tscn")
	if event.is_action_pressed("ui_powerup_pickup"):
		get_tree().quit()

