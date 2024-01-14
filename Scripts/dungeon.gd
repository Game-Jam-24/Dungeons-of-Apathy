extends Node2D

var borders = Rect2(1,1,40,22)
@onready var tileMap = $TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(borders.get_center(), borders)
	var map = walker.walk(500)
	walker.queue_free()
	tileMap.set_cells_terrain_connect(1, map, 0, -1)

func _input(event):
	if event.is_action_pressed("ui_accept") and GlobalVariables.DEBUG:
		get_tree().reload_current_scene()
