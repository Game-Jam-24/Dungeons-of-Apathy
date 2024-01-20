extends CharacterBody2D

# Implement Sprint Stamina depletion
# Implement Health
# Fix Speed Powerups

var speed = Player.speed
var accel = Player.movementAcceleration
var stamina = 100
var isSprinting = Player.isSprinting

var input: Vector2

func _ready():
	$StaminaRecovery.start(0.17)
	$SprintExhaustion.start(0.08)

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
		Player.isInDash = true
		speed = 1000
	
	if stamina > 0 and isSprinting:
		speed += 100
	else:
		speed -= 100
	
	move_and_slide() #allows the player to move and to be able to slide along colliders (walls)

func _process(delta):
	
	input = get_input()
	
	velocity = lerp(velocity, input * speed, delta * accel) #smooths out the movement
	
	speed = Player.speed
	
	#print_debug(stamina)
	#print_debug(velocity)

func _on_stamina_recovery_timeout():
	if stamina < 100 and !isSprinting and !Player.isInDash:
		stamina += 1


func _on_dash_duration_timeout():
	Player.isInDash = false
	speed -= 500
	accel -= 100

func _on_sprint_exhaustion_timeout():
	if isSprinting:
		stamina -= 1
