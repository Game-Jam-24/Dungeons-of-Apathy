extends Node

var tilemap: TileMap

func _ready() -> void:
	$".".add_child(tilemap)

func _init() -> void:
	tilemap = __init_tileset()
	var tiles: Array
	var randx: int = randi_range(5,15)
	var randy: int = randi_range(5,15)
	for x in range(randx):
		for y in range(randy):
			tiles.append(Vector2i(x,y))
	tilemap.set_cells_terrain_connect(0,tiles,1,0)

func __init_tileset() -> TileMap:
	var new_tilemap = TileMap.new()
	new_tilemap.set_rendering_quadrant_size(Global.CELL_SIZE)
	# TODO: Tileset can be set by config as well, eventually
	new_tilemap.tile_set = preload("res://Assets/Tileset/SimpleTileset.tres")
	return new_tilemap



#var size: Vector2i
#var matrix_position: Vector2i
#var doors: Array
#var connected_rooms: Dictionary
#
#
#func _init(init_size: Vector2i) -> void:
	#self.size = init_size
	#self.doors = []
	#self.connected_rooms = {}
#
## Function for establishing a tilemap instance, with the appropriate configurations
#func instance_tilemap() -> TileMap:
	#var new_tilemap = TileMap.new()
	#new_tilemap.cell_size = Global.CELL_SIZE
	# TODO: Tileset can be set by config as well, eventually
	#new_tilemap.tile_set = preload("res://Assets/Tileset/SimpleTileset.tres")
	#return new_tilemap
#
## Function to connect two rooms bidirectionally
#func connect_rooms(other_room: Room, direction: Global.Direction) -> void:
	#if not self.connected_rooms.has(other_room):
		#self.connected_rooms[direction] = other_room
		#other_room.connect_rooms(self, get_opposite_direction(direction))
#
## Function to get the opposite direction
#func get_opposite_direction(direction: Global.Direction) -> Global.Direction:
	#assert(direction != null, "Value cannot be null")
	#match direction:
		#Global.Direction.UP:
			#return Global.Direction.DOWN
		#Global.Direction.DOWN:
			#return Global.Direction.UP
		#Global.Direction.LEFT:
			#return Global.Direction.RIGHT
		#Global.Direction.RIGHT:
			#return Global.Direction.LEFT
	#return Global.Direction.UP  # Default fallback
