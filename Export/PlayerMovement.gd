extends CharacterBody2D

var speed = GlobalVariables.speed
var accel = GlobalVariables.movementAcceleration

var input: Vector2

func get_input():
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input.normalized()

func _physics_process(delta):
	move_and_slide()

func _process(delta):
	input = get_input()
	
	velocity = lerp(velocity, input * speed, delta * accel)
	
	speed = GlobalVariables.speed
	print_debug(input)
