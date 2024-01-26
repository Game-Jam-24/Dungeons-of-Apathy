extends Node2D

var borders = Rect2(1,1,40,22)
@onready var tileMap = $TileMap 

func _ready():
	#randomize()
	generate_level() #generates level on scene load

func generate_level():
	var walker = Walker.new(borders.get_center(), borders) #creates a new instance of a Walker
	var map = walker.walk(500) #the distance the walker travels
	walker.queue_free() #deletes walker after it's complete
	tileMap.set_cells_terrain_connect(1, map, 0, -1) #creates a tileset terrain path alon the walker's path

func _input(event):
	if event.is_action_pressed("ui_accept") and Global.DEBUG: #global toggleable debug
		get_tree().reload_current_scene() #resets scene with ENTER
