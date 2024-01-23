#	var noise = FastNoiseLite.new()
#	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
#	noise.cellular_distance_function = FastNoiseLite.DISTANCE_EUCLIDEAN
#	noise.seed = randi_range(1, 999999999)
#
#	var cells = []
#	for x in mapSize.x:
#		for y in mapSize.y:
#			var noiseMap = noise.get_noise_2d(x, y)
#			if noiseMap > emptySpace:
#				cells.append(Vector2(x,y))
#var emptySpace = 0.01


#	THE ENTIRE ARTIFACT MORPH SCRIPT	vvv


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


#	THE ENTIRE ARTIFACT MORPH SCRIPT	^^^
