extends Node
#
##const DEBUG = true
##const CELL_SIZE = Vector2(32, 32)
## Enum to represent directions
##enum Direction { UP, DOWN, LEFT, RIGHT }
#
### Internal Properties
#var __config: ConfigFile = ConfigFile.new()
#var __level_id: int = 0
#var __min_rooms: int
#var __max_rooms: int
#var __room_min_size: int
#var __room_max_size: int
### Properties
#var level_name: String
#var level_matrix: Array = []
#
#func _init() -> void:
	#self.__load_config()
#
### Function that initializes the level based on a config.
#func load_level(i: int) -> void:
	#self.__get_level_configs(i)
#
	## Clear level matrix and establish matrix based on max_rooms
	#self.level_matrix.clear()
	#self.level_matrix.resize(self.max_rooms)
	#for _a in range(self.max_rooms):
		#self.level_matrix.append([].resize(self.max_rooms))
	#
	## Create n rooms, where n is a random in between min_rooms and max_rooms.
	## When a room is finished, add it to the level_matrix
	#for _r in range(randi_range(self.min_rooms,self.max_rooms)):
		#var new_room = self.__generate_room()
		#var pos = self.__get_random_unoccupied_position()
		#self.level_matrix[pos.x][pos.y] = new_room
		#self.__connect_adjacent_rooms(new_room)
#
### Internal function for loading level config.
#func __load_config() -> void:
	#var err = self.config.load("res://Configs/levels.cfg")
	#if err != OK:
		#if Global.DEBUG:
			#print_debug("levels.cfg could not be loaded.")
		#return
#
### Internal function for setting internal properties for level generation.
#func __get_level_configs(i: int) -> void:
	#var level_key = str("level", i)
	#self.level_name      = self.__config.get_value(level_key, "level_name")
	#self.__min_rooms     = self.__config.get_value(level_key, "min_rooms")
	#self.__max_rooms     = self.__config.get_value(level_key, "max_rooms")
	#self.__room_min_size = self.__config.get_value(level_key, "room_min_size")
	#self.__room_max_size = self.__config.get_value(level_key, "room_max_size")
	#if Global.DEBUG:
		#print_debug(str(level_key," loaded from levels.cfg\n\rlevel_name: ", self.level_name,
						#"\n\rmin_rooms: ", self.__min_rooms, "\n\rmax_rooms: ", self.__max_rooms,
						#"\n\rroom_min_size: ", self.__room_min_size, "\n\rroom_max_size: ", self.__room_max_size))
#
### Internal function for room generation
#func __generate_room() -> Room:
	#var size = Vector2i(randi_range(self.__room_min_size, self.__room_max_size), randi_range(self.__room_min_size, self.__room_max_size))
	#var room = Room.new(size)
	#
	##for x in range(room.size.x):
		##for y in range(room.size.y):
			##room.tilemap.set_cell(0, Vector2i(x, y), -1)
			## tilemap.set_cell(x, y, your_generated_tile_index)
#
	#return room
#
### Internal function for determining if a position is adjacent to a room.
#func __get_random_unoccupied_position(first: bool = false) -> Vector2i:
	#var pos = Vector2i(randi_range(0, self.__max_rooms - 1), randi_range(0, self.__max_rooms - 1))
	#if first:
		#while level_matrix[pos.x][pos.y] != null or not self.__is_adjacent_to_room(pos):
			#pos = Vector2i(randi_range(0, self.__max_rooms - 1), randi_range(0, self.__max_rooms - 1))
	#return pos
#
### Internal function for determining if a position is adjacent to a room.
#func __is_adjacent_to_room(pos: Vector2i) -> bool:
	#for dir in Global.Direction.values():
		#var new_x = pos.x + get_direction_offset(dir)[0]
		#var new_y = pos.y + get_direction_offset(dir)[1]
		#if is_within_matrix_bounds(new_x, new_y) and level_matrix[new_x][new_y] != null:
			#return true
	#return false
#
#
#func __is_within_matrix_bounds(x: int, y: int) -> bool:
	#return x >= 0 and x < max_rooms and y >= 0 and y < max_rooms
#
#func __connect_adjacent_rooms(room: Room) -> void:
	#var directions = room.Direction
	#for dir in directions:
		#var new_x = room.pos_x + get_direction_offset(dir)[0]
		#var new_y = room.pos_y + get_direction_offset(dir)[1]
		#if is_within_matrix_bounds(new_x, new_y):
			#var adjacent_room = level_matrix[new_x][new_y]
			#if adjacent_room != null:
				#room.connect_rooms(adjacent_room, dir)
#
#
#func get_random_unoccupied_position_adjacent_to_existing() -> Vector2i:
	#var existing_positions = get_existing_room_positions()
	#while true:
		#var adjacent_pos = existing_positions[randi() % existing_positions.size()]
		#var direction = Global.Direction.values()[randi() % Global.Direction.values().size()]
		#var new_pos = adjacent_pos + get_direction_offset(direction)
		## Return if position is within bounds of level and not already holdng a room.s
		#if is_within_matrix_bounds(new_pos.x, new_pos.y) and level_matrix[new_pos.x][new_pos.y] == null:
			#return new_pos
	#return Vector2i.ZERO
#
#func get_existing_room_positions() -> Array:
	#var positions = []
	#for x in range(level_matrix.size()):
		#for y in range(level_matrix[0].size()):
			#if level_matrix[x][y] != null:
				#positions.append(Vector2i(x, y))
	#return positions
#
#
#
#
#func get_direction_offset(direction: Global.Direction) -> Vector2i:
	#match direction:
		#Global.Direction.UP: return Vector2i.UP
		#Global.Direction.DOWN: return Vector2i.DOWN
		#Global.Direction.LEFT: return Vector2i.LEFT
		#Global.Direction.RIGHT: return Vector2i.RIGHT
	#return Vector2i.ZERO
#
#
#
#
#
##
	#### Create n rooms, where n is a random in between min_rooms and max_rooms.
	#### When a room is finished, add it to the level_matrix
	##for r:int in randi_range(min_rooms,max_rooms):
		##var tilemap = instance_tilemap()
		##for x in range(randi_range(room_min_size, room_max_size)):
			##for y in range(randi_range(room_min_size, room_max_size)):
				##tilemap.set_cell(0,Vector2i(x,y),-1)
				###tilemap.set_cell(x, y, your_generated_tile_index)
##
		##var new_room = Room.new(tilemap)
		### Randomly choose a position in the matrix
		##var rx = randi() % max_rooms
		##var ry = randi() % max_rooms
		### Ensure the chosen position is not occupied
		##if r != 0:
			##while level_matrix[rx][ry] != null:
				##rx = randi() % max_rooms
				##ry = randi() % max_rooms
		### Place the room in the matrix
		##new_room.pos_x = rx
		##new_room.pos_y = ry
		##level_matrix[rx][ry] = new_room
		##connect_adjacent_rooms(new_room)
##
##
#### Function to connect a room to adjacent rooms
##func connect_adjacent_rooms(room: Room) -> void:
	##var directions = room.Direction
	##for dir in directions:
		##var new_x = room.pos_x + get_direction_offset(dir)[0]
		##var new_y = room.pos_y + get_direction_offset(dir)[1]
		### Check if the adjacent position is within the matrix bounds
		##if new_x >= 0 and new_x < max_rooms and new_y >= 0 and new_y < max_rooms:
			##var adjacent_room = level_matrix[new_x][new_y]
			### If an adjacent room exists, connect them
			##if adjacent_room != null:
				##room.connect_rooms(adjacent_room, dir)
##
### Function to get the offset for a given direction
##func get_direction_offset(direction: Global.Direction) -> Variant:
	##match direction:
		##Global.Direction.UP: return Vector2i.UP
		##Global.Direction.DOWN: return Vector2i.DOWN
		##Global.Direction.LEFT: return Vector2i.LEFT
		##Global.Direction.RIGHT: return Vector2i.RIGHT
	##return false
