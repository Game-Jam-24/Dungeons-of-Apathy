extends Node

var config = ConfigFile.new()
var level_id = 0

var level_name: String
var min_rooms: int
var max_rooms: int
var room_min_size: int
var room_max_size: int

var level_matrix: Array = []

func _init() -> void:
	var err = config.load("res://Configs/levels.cfg")
	if err != OK:
		if Global.DEBUG:
			print_debug("levels.cfg could not be loaded.")
		return

func load_level(i: int) -> void:
	## Get Configs
	var level_key = str("level",i)
	level_name    = config.get_value(level_key, "level_name")
	min_rooms     = config.get_value(level_key, "min_rooms")
	max_rooms     = config.get_value(level_key, "max_rooms")
	room_min_size = config.get_value(level_key, "room_min_size")
	room_max_size = config.get_value(level_key, "room_max_size")
	if Global.DEBUG:
		print_debug(str(level_key," loaded from levels.cfg\n\rlevel_name: ",level_name,"\n\rmin_rooms: ",min_rooms,"\n\rmax_rooms: ",max_rooms,"\n\rroom_min_size: ",room_min_size,"\n\rroom_max_size: ",room_max_size))

	## Clear level matrix and establish matrix based on max_rooms
	level_matrix.clear()
	for a in range(max_rooms):
		level_matrix.append([].resize(max_rooms))

	## Create n rooms, where n is a random in between min_rooms and max_rooms.
	## When a room is finished, add it to the level_matrix
	for r:int in randi_range(min_rooms,max_rooms):
		var tilemap = instance_tilemap()
		for x in range(randi_range(room_min_size, room_max_size)):
			for y in range(randi_range(room_min_size, room_max_size)):
				tilemap.set_cell(0,Vector2i(x,y),-1)
				#tilemap.set_cell(x, y, your_generated_tile_index)

		var new_room = Room.new(tilemap)
		# Randomly choose a position in the matrix
		var rx = randi() % max_rooms
		var ry = randi() % max_rooms
		# Ensure the chosen position is not occupied
		if r != 0:
			while level_matrix[rx][ry] != null:
				rx = randi() % max_rooms
				ry = randi() % max_rooms
		# Place the room in the matrix
		new_room.pos_x = rx
		new_room.pos_y = ry
		level_matrix[rx][ry] = new_room
		connect_adjacent_rooms(new_room)

## Function for establishing a tilemap instance, with the appropriate configurations
func instance_tilemap() -> TileMap:
	var tilemap = TileMap.new()
	tilemap.cell_size = Global.CELL_SIZE
	## TODO: Tileset can be set by config as well, eventually
	tilemap.tile_set = preload("res://Assets/Tileset/SimpleTileset.tres")
	return tilemap

## Function to connect a room to adjacent rooms
func connect_adjacent_rooms(room: Room) -> void:
	var directions = room.Direction
	for dir in directions:
		var new_x = room.pos_x + get_direction_offset(dir)[0]
		var new_y = room.pos_y + get_direction_offset(dir)[1]
		# Check if the adjacent position is within the matrix bounds
		if new_x >= 0 and new_x < max_rooms and new_y >= 0 and new_y < max_rooms:
			var adjacent_room = level_matrix[new_x][new_y]
			# If an adjacent room exists, connect them
			if adjacent_room != null:
				room.connect_rooms(adjacent_room, dir)

# Function to get the offset for a given direction
func get_direction_offset(direction: Global.Direction) -> Variant:
	match direction:
		Global.Direction.UP: return Vector2i.UP
		Global.Direction.DOWN: return Vector2i.DOWN
		Global.Direction.LEFT: return Vector2i.LEFT
		Global.Direction.RIGHT: return Vector2i.RIGHT
	return false
