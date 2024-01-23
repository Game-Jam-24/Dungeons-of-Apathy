extends TileMap

@onready var tilemap = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tilemap.get_cell_atlas_coords(0, get_global_mouse_position())
