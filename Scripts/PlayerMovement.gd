extends CharacterBody2D

#var colission : KinematicCollision2D
#var collided = false
var apathyTilemap: TileMap
#var cell
#var tile_id

var onApathyArray = []

var dead = false
var speed = Player.speed
var accel = Player.movementAcceleration
var stamina = Player.stamina
var isSprinting = Player.isSprinting
var health = Player.health
var input: Vector2
var stopWalk = false
var tile1: bool
var tile2: bool
var tile3: bool
var isOnApathy: bool = false
var apathyLayerID = 0

func _ready():
	$StaminaRecovery.start(0.17)
	$SprintExhaustion.start(0.08)
	$ArtifactUseExhaustion.start(0.1)
	$ApathyDamageTicker.start(0.1)
	apathyTilemap = get_parent().get_parent().get_node("Apathy")
	Global.artifactStaminaRunout = false
	

func get_input():
	
	
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("ui_dash") and stamina >= 30 and $DashDuration.is_stopped():
		stamina -= 30
		$DashDuration.start(0.2)
		$Audio/Dash.play()
	if Input.get_action_strength("ui_sprint") and Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"):
		isSprinting = true
	else:
		isSprinting = false
	
	if !(Input.is_action_just_pressed("ui_dash") or Input.get_action_strength("ui_sprint")) and Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") and !Global.isArtifactMorphed:
		if !$Audio/Walking.playing:
			$Audio/Walking.pitch_scale = randf_range(0.9, 1.1)
			$Audio/Walking.play()
	else:
		$Audio/Walking.stop()
	
	return input.normalized() #makes it so that when you go diagonally the speed doesn't stack

func player_death():
	if dead == true:
		Player.collectableCounter = 0
		get_tree().reload_current_scene()
		#get_tree().change_scene_to_file("res://Death.tscn")

func _physics_process(delta):
	move_and_slide() #allows the player to move and to be able to slide along colliders (walls)
	
	if !$DashDuration.is_stopped():
		$Area2D.monitoring = true
		Player.isInDash = true
		speed += 500
	
	if stamina > 0 and isSprinting:
		speed += 50
		if !$Audio/Sprinting.playing and !Global.isArtifactMorphed:
			$Audio/Sprinting.pitch_scale = randf_range(0.9, 1.1)
			$Audio/Sprinting.play()
	elif stamina < 0:
		stamina = 0
	else:
		speed -= 50
		$Audio/Sprinting.stop()
	
	if !stopWalk:
		$Sprite2D/AnimationTree.set("parameters/BlendSpace2D/blend_position", velocity)
	
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	if Input.is_action_just_pressed("ui_use_artifact_1") and !stopWalk:
		$Sprite2D/AnimationPlayer.play("fighting")
		$Sprite2D/AnimationPlayer.queue("fighting idle")
		$Sprite2D/AnimationTree.active = false
		stopWalk = true
	if (Input.is_action_just_released("ui_use_artifact_1") and stopWalk) or (Global.artifactStaminaRunout and Global.isArtifactMorphed):
		$Sprite2D/AnimationPlayer.play_backwards("fighting")
		await $Sprite2D/AnimationPlayer.animation_finished
		$Sprite2D/AnimationTree.active = true
		stopWalk = false
		Global.artifactStaminaRunout = false

func _process(delta):
	if health <= 0 and dead == false:
		dead = true
		player_death()
	
	if stamina <= 0:
		Global.artifactStaminaRunout = true
	
	input = get_input()
	
	velocity = lerp(velocity, input * speed, delta * accel) #smooths out the movement
	
	speed = Player.speed
	
	if stamina > Player.stamina:
		stamina = Player.stamina

func _on_stamina_recovery_timeout():
	if stamina < Player.maxStamina and !isSprinting and !Player.isInDash and !Global.isArtifactMorphed:
		stamina += 4

func _on_dash_duration_timeout():
	Player.isInDash = false
	speed -= 500
	#accel -= 100

func _on_sprint_exhaustion_timeout():
	if isSprinting:
		stamina -= 4

func _on_artifact_use_exhaustion_timeout():
	if Global.isArtifactMorphed:
		stamina -= 1

func _apathy_colission(body: Node2D, body_rid: RID):
	apathyTilemap = body
	
	var apathy_cell_hit_coords = apathyTilemap.get_coords_for_body_rid(body_rid)
	var apathy_cell_hit_type_get = apathyTilemap.get_cell_tile_data(apathyLayerID, apathy_cell_hit_coords)
	var apathy_cell_hit_type = apathy_cell_hit_type_get.get_custom_data_by_layer_id(apathyLayerID)
	return [apathy_cell_hit_coords, apathy_cell_hit_type]

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !Global.isArtifactMorphed:
		if body.is_in_group("Apathy"):
			if _apathy_colission(body, body_rid).back() == 1:
				tile1 = true
				isOnApathy = true
				onApathyArray.append(_apathy_colission(body, body_rid).back())
			if _apathy_colission(body, body_rid).back() == 2:
				tile2 = true
				isOnApathy = true
				onApathyArray.append(_apathy_colission(body, body_rid).back())
			if _apathy_colission(body, body_rid).back() == 3:
				tile3 = true
				isOnApathy = true
				onApathyArray.append(_apathy_colission(body, body_rid).back())

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if !Global.isArtifactMorphed:
		if body.is_in_group("Apathy"):
			if _apathy_colission(body, body_rid).back() == 1:
				tile1 = false
				isOnApathy = false
				onApathyArray.erase(_apathy_colission(body, body_rid).back())
			if _apathy_colission(body, body_rid).back() == 2:
				tile2 = false
				isOnApathy = false
				onApathyArray.erase(_apathy_colission(body, body_rid).back())
			if _apathy_colission(body, body_rid).back() == 3:
				tile3 = false
				isOnApathy = false
				onApathyArray.erase(_apathy_colission(body, body_rid).back())


func _on_apathy_damage_ticker_timeout():
	if !onApathyArray.is_empty():
		if onApathyArray.max() < 2:
			speed -= 100
			health -= 1
			$Audio/BeingHit.play()
		elif onApathyArray.max() == 2:
			speed -= 200
			health -= 4
			$Audio/BeingHit.play()
		elif onApathyArray.max() == 3:
			speed -= 500
			health -= 6
		else:
			speed = Player.speed
