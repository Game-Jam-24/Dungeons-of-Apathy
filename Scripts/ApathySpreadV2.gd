extends TileMap

@onready var dungeon: TileMap
@onready var tilemap: TileMap = $"."

const dungeon_tile_size: Vector2i = Vector2i(32,32)
const apathy_tile_size: Vector2i = Vector2i(16,16)
const dungeon_floor_atlas_coord: Vector2i = Vector2i(7,5)


@export var spreadTime = 0.2
const mapSize = Vector2(40, 22)
var atlasCoordsArray = Vector2i(randf_range(0, 3), randf_range(0,3))
var spawnerNumProbability = [1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,5]
var apathySeedSpawn = Vector2i(randf_range(0,40), randf_range(0,22))
var apathySeedCoords = []
var apathyCellCoords = []
var usedCells
var x
var y
var counter = 0
var apathyScore = 0
var spawnerNum = 0
var cellType: Vector2i
var cellsHit = Vector2i(0,0)


func _ready():
	if get_parent():
		dungeon = $".."
	else:
		dungeon = TileMap.new()
		dungeon.set_rendering_quadrant_size(dungeon_tile_size.x)
	$Timer.start(spreadTime)
	cellType = Vector2i(0,0)
	#generate_apathy_seeds()
	

#func generate_apathy_seeds():
	#for spawnerNum in spawnerNumProbability[randf_range(0,spawnerNumProbability.size())]:
		#tilemap.set_cell(0, apathySeedSpawn, 1, atlasCoordsArray)
		#apathySeedSpawn = Vector2i(randf_range(0,40), randf_range(0,22))
		#x = apathySeedSpawn.x
		#y = apathySeedSpawn.y
		#apathySeedCoords.append(Vector2(x, y))
		#apathyCellCoords.append(Vector2i(x, y))

func cell_spreader():
	for usedCells in tilemap.get_used_cells(0):
		apathyScore = tilemap.get_used_cells(0).size() - spawnerNum
		apathyCellCoords.append(usedCells)
		for nearCell in tilemap.get_surrounding_cells(usedCells):
			var dungeon_tile_position = __get_dungeon_tile_position(nearCell)
			# Proceed if the dungeon tile is a floor. this check is made by comparing the atlas coords of the tile position to a defined atlas coord that represents a floor.
			if dungeon.get_cell_atlas_coords(0,dungeon_tile_position) == dungeon_floor_atlas_coord:
				# Proceed by a % chance and if the cell referenced isn't already occupied by apathy.
				if randf_range(0, 100) <= 50 and tilemap.get_cell_source_id(0, nearCell) != 2:
					tilemap.set_cell(0, nearCell, 2, cellType)
					#print_debug(apathyScore)
			
			#print_debug(dungeon.get_cell_atlas_coords(0,dungeon_tile_position))
			#print_debug(str("Apathy Tile ",nearCell," on Dungeon Tile ",dungeon_tile_position))
			
	if apathyScore > 100 and apathyScore < 300:
		cellType = Vector2i(1,0)
		spreadTime = 1
	elif apathyScore >= 300:
		cellType = Vector2i(2,0)
		spreadTime = 3

func _process(delta):
	cellsHit = Vector2i(Global.cellsHit.x, Global.cellsHit.y)
	
	if !Global.cellsNotHit:
		tilemap.erase_cell(0, cellsHit)

#func _input(event):
	#if event.is_action_pressed("ui_accept") and Global.DEBUG:
		#get_tree().reload_current_scene()

func _on_timer_timeout():
	cell_spreader()
	apathyCellCoords.clear()
	$Timer.start(spreadTime)

## Function to get the position of the corresponding dungeon tile from the apathy tile position
func __get_dungeon_tile_position(apathy_tile_position: Vector2i) -> Vector2i:
	var dungeon_tile_position = Vector2i(
		int(apathy_tile_position.x / 2),
		int(apathy_tile_position.y / 2)
	)
	return dungeon_tile_position
