extends CharacterBody2D

# Implement Sprint Stamina depletion
# Implement Sprint

var speed = Player.speed
var accel = Player.movementAcceleration
var stamina = 100
var isSprinting: bool

var input: Vector2

func _ready():
	$StaminaRecovery.start(0.17)

func get_input():
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("ui_dash") and stamina >= 30 and $DashDuration.is_stopped():
		stamina -= 30
		accel += 100
		$DashDuration.start(0.2)
	
	if Input.get_action_strength("ui_sprint") and Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"):
		isSprinting = true
	else:
		isSprinting = false
	
	return input.normalized() #makes it so that when you go diagonally the speed doesn't stack

func _physics_process(delta):
	if !$DashDuration.is_stopped():
		speed += 500
	
	move_and_slide() #allows the player to move and to be able to slide along colliders (walls)

func _process(delta):
	
	input = get_input()
	
	velocity = lerp(velocity, input * speed, delta * accel) #smooths out the movement
	
	speed = Player.speed
	
	print_debug(stamina)

func _on_stamina_recovery_timeout():
	if !Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") and stamina < 100 and !Input.get_action_strength("ui_sprint"):
		stamina += 1


func _on_dash_duration_timeout():
	speed -= 500
	accel -= 100
