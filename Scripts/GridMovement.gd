extends CharacterBody2D

var playerPos = Vector2.ZERO
var speed = Player.gridSpeed

func _input(event):
	if event.is_action_pressed("ui_right_grid"):
		playerPos.x += speed
	elif event.is_action_pressed("ui_left_grid"):
		playerPos.x -= speed
	elif event.is_action_pressed("ui_down_grid"):
		playerPos.y += speed
	elif event.is_action_pressed("ui_up_grid"):
		playerPos.y -= speed
	
	self.position = Vector2(playerPos)

func _process(delta):
	print_debug(playerPos)
