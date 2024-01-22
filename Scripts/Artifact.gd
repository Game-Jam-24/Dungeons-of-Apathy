extends Node2D

var fire
var controllerAngle = Vector2.ZERO
var angleSave = Vector2.ZERO
var deadzone = 0.2
var controllerPosition: Vector2
var morphIndex : int = 0
var morphAnim : bool
var morphArraySprite = ["SwordMorph", "ArtifactMorph"]
#var combatAnims1 = ["SwordSlash", "SwordStab"]

func _ready():
	$".".play("Artifact")
	Global.isArtifactMorphed = false
	morphAnim = false
	$".".offset = Vector2(32, 0)
	morphIndex = 1
	fire = $Fire
	$Area2D.monitoring = false

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
	
	if Input.is_action_just_pressed("ui_use_artifact_1"):
		for i in range (0,2):
			if !morphAnim:
				Global.isArtifactMorphed = true
				$".".play("ArtifactMorph")
				morphAnim = true
			else:
				await $".".animation_finished
				$".".play("SwordMorph")
				$Area2D.monitoring = true
				$Fire2.hide()
				$Fire.show()
				morphAnim = false
		print_debug("HOLDING DOWN")
	if Input.is_action_just_released("ui_use_artifact_1"):
		for i in range (0,2):
			if !morphAnim:
				Global.isArtifactMorphed = false
				$".".play_backwards("SwordMorph")
				morphAnim = true
			else:
				await $".".animation_finished
				$".".play("Artifact")
				$Area2D.monitoring = false
				$Fire.hide()
				$Fire2.show()
				morphAnim = false
		print_debug("IS RELEASED")

	##for artifact morph on scene start
	#while Input.is_action_just_pressed("ui_use_artifact_1") and !Global.isArtifactMorphed:
		#for i in range (0,2):
			#if !morphAnim:
				#$".".play("ArtifactMorph")
				#morphAnim = true
				#morphIndex = 1
			#else:
				#$".".play(morphArraySprite[morphIndex - 1])
				#Global.isArtifactMorphed = true
				#$"../Timer".start(5)
	#artifact use 1
	#if Input.is_action_just_pressed("ui_use_artifact_1") and Global.isArtifactMorphed and !$".".is_playing():
		#$"../Timer".start(5)
		#if morphIndex == 1:
			#$AnimationPlayer.play("SwordSlash")
		##elif morphIndex == 2:
			##pass
		##elif morphIndex == 3:
			##pass
		#Global.isArtifactMorphed = true
	##artifact use 2
	#elif Input.is_action_just_pressed("ui_use_artifact_2") and Global.isArtifactMorphed and !$".".is_playing():
		#$"../Timer".start(5)
		#if morphIndex == 1:
			#$AnimationPlayer.play("SwordStab")
		#elif morphIndex == 2:
			#pass
		#elif morphIndex == 3:
			#pass
		#Global.isArtifactMorphed = true
	
	#artifact morph to weapons slot 1
	#if Input.get_action_raw_strength("ui_artifact_morph_1") and !Global.isArtifactMorphed:
			#$".".play(morphArraySprite[morphIndex - 1])
		#Global.isArtifactMorphed = true
	##artifact morph to weapons slot 2
	#elif Input.get_action_raw_strength("ui_artifact_morph_2") and morphIndex != 2:
		#for i in range (0, 2):
			#morphIndex = 2
			#if morphIndex == 2:
				#$".".play(morphArraySprite[morphIndex - 1])
				#$"../Timer".start(5)
		#Global.isArtifactMorphed = true
	##artifact morph to weapons slot 3
	#elif Input.get_action_raw_strength("ui_artifact_morph_3") and morphIndex != 3:
		#for i in range (0, 2):
			#morphIndex = 3
			#if morphIndex == 3:
				#$".".play(morphArraySprite[morphIndex - 1])
				#$"../Timer".start(5)
		#Global.isArtifactMorphed = true

#timer for artifact use idle timeout
#func _on_timer_timeout():
	#Global.isArtifactMorphed = false
	#$".".play_backwards(morphArraySprite[morphIndex - 1])
	#morphAnim = false

#to reset animation to orbit if you are idle too much
#func _on_animation_finished():
	#if !Global.isArtifactMorphed:
		#$".".play("Artifact")


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index, ):
	print_debug("YA HIT SOMETHIN")
