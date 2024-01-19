extends Node2D

var controllerAngle = Vector2.ZERO
var angleSave = Vector2.ZERO
var deadzone = 0.2
var controllerPosition: Vector2

func _ready():
	$".".play("Artifact")
	$".".offset += Vector2(32, 0)
	Global.isArtifactMorphed = false

func _physics_process(delta):
	controllerAngle = Input.get_vector("ui_controller_aim_-x", "ui_controller_aim_x", "ui_controller_aim_-y", "ui_controller_aim_y")

	if !Global.isArtifactMorphed:
		$".".rotate(0.035)
	else:
		if Global.isControllerConnected and controllerAngle.length() > deadzone:
			$".".global_rotation =  rotate_toward($".".global_rotation, $"..".get_angle_to(controllerPosition), delta * 9)
			controllerPosition = controllerAngle + $".".global_position
		elif !Global.isControllerConnected:
			$".".global_rotation = rotate_toward($".".global_rotation, $"..".get_angle_to(get_global_mouse_position()), delta * 9)
	#if controllerAngle.length() > 0.2:
		#angleSave = 

func _input(event):
	if Input.get_action_raw_strength("ui_use_artifact"):
		$".".play("Morph animation")
		Global.isArtifactMorphed = true

# Implement weapon swap with 1, 2, 3 and debug sticks
# Implement timer for morph back
# Implement stab
# Implement slash
# Test particles


func _on_timer_timeout():
	# insert from weapon to artifact morph
	Global.isArtifactMorphed = false
