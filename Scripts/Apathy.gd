extends TileMap


@onready var tilemap = $"."

const spreadTime = 1
const mapSize = Vector2(40, 22)
var atlasCoordsArray = Vector2i(randf_range(0, 3), randf_range(0,3))
var spawnerNumProbability = [1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,5]
var apathySeedSpawn = Vector2i(randf_range(0,40), randf_range(0,22))
var apathySeedCoords = []
var apathyCellCoords = []
var usedCells
var getAroundCells
var x
var y
var counter = 0
var apathyScore = 0
var spawnerNum = 0


func _ready():
	$Timer.start(spreadTime)
	generate_apathy_seeds()

func generate_apathy_seeds():
	for spawnerNum in spawnerNumProbability[randf_range(0,spawnerNumProbability.size())]:
		tilemap.set_cell(0, apathySeedSpawn, 1, atlasCoordsArray)
		apathySeedSpawn = Vector2i(randf_range(0,40), randf_range(0,22))
		x = apathySeedSpawn.x
		y = apathySeedSpawn.y
		apathySeedCoords.append(Vector2(x, y))
		apathyCellCoords.append(Vector2i(x, y))

func cell_spreader():
	for usedCells in tilemap.get_used_cells(0):
		apathyScore = tilemap.get_used_cells(0).size() - spawnerNum
		apathyCellCoords.append(usedCells)
		for getAroundCells in tilemap.get_surrounding_cells(usedCells):
			var cellData = tilemap.get_cell_source_id(0, getAroundCells)
			if randf_range(0, 100) <= 25 and cellData != 1:
				tilemap.set_cell(0, getAroundCells, 1, atlasCoordsArray)
				atlasCoordsArray = Vector2i(randf_range(0, 3), randf_range(0,3))

#func _process(delta):
	#print_debug($Timer.time_left)
	#print_debug(apathyScore)

func _input(event):
	if event.is_action_pressed("ui_accept") and Global.DEBUG:
		get_tree().reload_current_scene()

func _on_timer_timeout():
	cell_spreader()
	apathyCellCoords.clear()
	$Timer.start(spreadTime)
