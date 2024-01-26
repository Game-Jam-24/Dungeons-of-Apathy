extends Node2D

func _input(event):
	if Input.get_action_raw_strength("ui_dash"):
		get_tree().change_scene_to_file("res://HubWorld.tscn")

