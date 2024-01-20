extends Node2D

var controllerAngle = Vector2.ZERO
var angleSave = Vector2.ZERO
var deadzone = 0.2
var controllerPosition: Vector2
var morphIndex : int
var morphArray = [null, "SwordMorph"]

func _ready():
	$".".play("Artifact")
	$".".offset += Vector2(32, 0)
	Global.isArtifactMorphed = false
	morphIndex = 0

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
	print_debug($"../Timer".time_left)

func _input(event):
	if !Global.isArtifactMorphed:
		if Input.get_action_raw_strength("ui_use_artifact"):
			$".".play("ArtifactMorph")
			Global.isArtifactMorphed = true
			$"../Timer".start(5)
	
	if Input.get_action_raw_strength("ui_artifact_morph_1") and !Global.isArtifactMorphed:
		$".".play("SwordMorph")
		morphIndex = 1
		Global.isArtifactMorphed = true
		$SwordCollider.show()
	elif Input.get_action_raw_strength("ui_artifact_morph_2") and !Global.isArtifactMorphed:
		#$".".play("SwordMorph")
		morphIndex = 2
		#Global.isArtifactMorphed = true
		#$SwordCollider.show()
		print_debug("2")
	elif Input.get_action_raw_strength("ui_artifact_morph_3") and !Global.isArtifactMorphed:
		#$".".play("SwordMorph")
		morphIndex = 3
		#Global.isArtifactMorphed = true
		#$SwordCollider.show()
		print_debug("3")

# Implement weapon swap with 1, 2, 3
# Implement timer for morph back
# Implement stab
# Implement slash
# Test particles

func _on_timer_timeout():
	Global.isArtifactMorphed = false
	$".".play_backwards(morphArray[morphIndex])

func _on_animation_finished():
	if !Global.isArtifactMorphed:
		$".".play("Artifact")
