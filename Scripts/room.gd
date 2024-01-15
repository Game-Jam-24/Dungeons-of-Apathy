extends Node
class_name Room

var tilemap: TileMap
var pos_x: int
var pos_y: int
var connected_rooms: Dictionary = {}

func _init(tilemap: TileMap) -> void:
	tilemap = tilemap

# Function to connect two rooms bidirectionally
func connect_rooms(other_room: Room, direction: Global.Direction) -> void:
	if not connected_rooms.has(other_room):
		connected_rooms[direction] = other_room
		other_room.connect_rooms(self, get_opposite_direction(direction))

# Function to get the opposite direction
func get_opposite_direction(direction: Global.Direction) -> Variant:
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
	return false
