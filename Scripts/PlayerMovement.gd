extends CharacterBody2D

var speed = Player.speed
var accel = Player.movementAcceleration


var input: Vector2

func get_input():
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input.normalized() #makes it so that when you go diagonally the speed doesn't stack

func _physics_process(delta):
	move_and_slide() #allows the player to move and to be able to slide along colliders (walls)

func _process(delta):
	input = get_input()
	
	velocity = lerp(velocity, input * speed, delta * accel) #smooths out the movement
	
	speed = Player.speed
	#if Global.DEBUG: #global toggleable debug
		#print_debug(input)
