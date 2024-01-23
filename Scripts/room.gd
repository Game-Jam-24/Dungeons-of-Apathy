extends Node

var player: PackedScene = preload("res://Scenes/Player.tscn")
var tilemap: TileMap

func _ready() -> void:
	$".".add_child(tilemap)

func _init() -> void:
	tilemap = __init_tileset()
	var tiles: Array
	var randx: int = randi_range(5,15)
	var randy: int = randi_range(5,15)
	# generate array of tile positions to update.
	for x in range(randx):
		for y in range(randy):
			tiles.append(Vector2i(x,y))
	tilemap.set_cells_terrain_connect(0,tiles,1,0)
	# Add a door randomly to a specified wall (e.g., UP)
	__add_door_to_wall(Global.Direction.DOWN)
	#__add_door_to_wall(Global.Direction.UP)
	#__add_door_to_wall(Global.Direction.RIGHT)
	#__add_door_to_wall(Global.Direction.DOWN)
	#__add_door_to_wall(Global.Direction.LEFT)

func _input(event):
	if event.is_action_pressed("ui_accept") and Global.DEBUG: #global toggleable debug
		get_tree().reload_current_scene() #resets scene with ENTER

## Function to connect two rooms bidirectionally
func connect_rooms(other_room: Node2D, direction: Global.Direction) -> void:
	if not self.connected_rooms.has(other_room):
		self.connected_rooms[direction] = other_room
		other_room.connect_rooms(self, __get_opposite_direction(direction))

## Function for establishing a tilemap instance, with the appropriate configurations
func __init_tileset() -> TileMap:
	var new_tilemap = TileMap.new()
	new_tilemap.set_rendering_quadrant_size(Global.CELL_SIZE)
	# TODO: Tileset can be set by config as well, eventually
	new_tilemap.tile_set = preload("res://Assets/Tileset/SimpleTileset.tres")
	return new_tilemap

func __add_door_to_wall(direction: Global.Direction) -> void:
	var wall_positions: Array = __get_wall_positions(direction)
	if wall_positions.size() > 0:
		var random_position: Vector2i = wall_positions[randi() % wall_positions.size()]
		tilemap.set_cell(0,random_position,1)
		#tilemap.set_cells_terrain_connect(0,[random_position],1,0)
		#__instance_door(random_position)
	else:
		print("No wall positions found for door placement.")

func __get_wall_positions(direction: Global.Direction) -> Array:
	var wall_positions: Array = []
	var map_size: Vector2i = tilemap.get_used_rect().size - Vector2i(1, 1)
	
	for i in range(1, map_size[direction]):
		var position: Vector2i
		match direction:
			Global.Direction.UP:
				position = Vector2i(i, 0)
			Global.Direction.DOWN:
				position = Vector2i(i, map_size.y - 1)
			Global.Direction.LEFT:
				position = Vector2i(0, i)
			Global.Direction.RIGHT:
				position = Vector2i(map_size.x - 1, i)
		wall_positions.append(position)
	
	return wall_positions

## Function to get the opposite direction
func __get_opposite_direction(direction: Global.Direction) -> Global.Direction:
	assert(direction != null, "Value cannot be null")
	match direction:
		Global.Direction.UP:
			return Global.Direction.DOWN
		Global.Direction.DOWN:
			return Global.Direction.UP
		Global.Direction.LEFT:
			return Global.Direction.RIGHT
		Global.Direction.RIGHT:
			return Global.Direction.LEFT
	return Global.Direction.UP  # Default fallback

func __instance_door(position: Vector2i, direction: Global.Direction = Global.Direction.UP) -> void:
	var door = preload("res://Scenes/Components/door.tscn").instantiate()
	var position_offset = Global.CELL_SIZE / 2
	# Set the door's position to the random position obtained earlier
	door.position = Vector2i(position.x * Global.CELL_SIZE + position_offset,
							position.y * Global.CELL_SIZE + position_offset)
	# Set rotation based on wall position
	match direction:
		Global.Direction.UP:
			door.rotation_degrees = 0
		Global.Direction.RIGHT:
			door.rotation_degrees = 90
		Global.Direction.DOWN:
			door.rotation_degrees = 180
		Global.Direction.LEFT:
			door.rotation_degrees = 270
	# Add the door instance as a child to the parent node
	tilemap.add_child(door)
