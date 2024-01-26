extends Node2D

var controllerAngle = Vector2.ZERO
var deadzone = 0.2
var controllerPosition: Vector2
#var morphIndex : int = 0
#var morphAnim : bool
var morphArraySprite = ["SwordMorph", "ArtifactMorph"]
#var combatAnims1 = ["SwordSlash", "SwordStab"]

var cellsHit = [Global.cellsHit]
var apathyTilemap: TileMap
var animBugFix: bool

func _ready():
	$".".play("Artifact")
	Global.isArtifactMorphed = false
	$".".offset = Vector2(32, 0)
	$Area2D.monitoring = false
	animBugFix = false

func _physics_process(delta):
	controllerAngle = Input.get_vector("ui_controller_aim_-x", "ui_controller_aim_x", "ui_controller_aim_-y", "ui_controller_aim_y")

	if !Global.isArtifactMorphed:
		$".".rotate(0.035)
	else:
		if Global.isControllerConnected and controllerAngle.length() > deadzone:
			controllerPosition = controllerAngle + $".".global_position
			$".".global_rotation =  rotate_toward($".".global_rotation, $"..".get_angle_to(controllerPosition), delta * 7)
		elif !Global.isControllerConnected:
			$".".global_rotation = rotate_toward($".".global_rotation, $"..".get_angle_to(get_global_mouse_position()), delta * 7)
	
	if Input.is_action_just_pressed("ui_use_artifact_1"):
		Global.isArtifactMorphed = true
		$".".play("ArtifactMorph")
		await $".".animation_finished
		$Area2D.monitoring = true
		$".".play("SwordMorph")
		$Fire2.hide()
		$Fire.show()
		Player.speed = 100
		animBugFix = true
		print_debug("HOLDING DOWN")
	if (Input.is_action_just_released("ui_use_artifact_1") and animBugFix) or (Global.artifactStaminaRunout and Global.isArtifactMorphed):
		Global.isArtifactMorphed = false
		$Area2D.monitoring = false
		$".".play_backwards("SwordMorph")
		await $".".animation_finished
		$".".play("Artifact")
		$Fire.hide()
		$Fire2.show()
		Player.speed = 150
		Global.artifactStaminaRunout = false
		print_debug("IS RELEASED")

func apathy_colission(body: Node2D, body_rid: RID):
	apathyTilemap = body
	
	var apathy_cell_hit_coords = apathyTilemap.get_coords_for_body_rid(body_rid)
	var apathy_cell_hit_type_get = apathyTilemap.get_cell_tile_data(0, apathy_cell_hit_coords)
	var apathy_cell_hit_type = apathy_cell_hit_type_get.get_custom_data_by_layer_id(0)
	
	return [apathy_cell_hit_coords, apathy_cell_hit_type]

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is TileMap:
		cellsHit.clear()
		$"../HitCell".pitch_scale = randf_range(0.5, 1.5)
		$"../HitCell".play()
		cellsHit = apathy_colission(body, body_rid)
		Global.cellsHit = Vector2i(cellsHit[0].x, cellsHit[0].y)
		if cellsHit.is_empty():
			Global.cellsNotHit = true
		else:
			Global.cellsNotHit = false
