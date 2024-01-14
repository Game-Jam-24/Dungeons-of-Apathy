extends TileMap


@onready var tilemap = $"."

const mapSize = Vector2(40, 22)
var atlasCoordsArray = Vector2i(randf_range(0, 3), randf_range(0,3))
var spawnerNumProbability = [1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,5]
var apathySeedSpawn = Vector2i(randf_range(0,40), randf_range(0,22))
var apathySeedCoords = []
var x
var y

func _ready():
	$Timer.start(1)
	generate_apathy_seeds()
	print_debug(apathySeedCoords)

func generate_apathy_seeds():
		for spawnerNum in spawnerNumProbability[randf_range(0,spawnerNumProbability.size())]:
			tilemap.set_cell(0, apathySeedSpawn, 4, atlasCoordsArray)
			apathySeedSpawn = Vector2i(randf_range(0,40), randf_range(0,22))
			x = apathySeedSpawn.x
			y = apathySeedSpawn.y
			apathySeedCoords.append(Vector2(x, y))

func _process(delta):
	if $Timer.is_stopped() == true:
		$Timer.start(1)
