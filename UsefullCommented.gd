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
