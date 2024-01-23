extends AnimatedSprite2D

var morph = false

func _ready():
	$".".play("Artifact")
	$".".offset += Vector2(32, 0)

func _process(delta):
	if !morph: 
		$".".global_rotation_degrees += 2

func _input(event):
	if Input.get_action_raw_strength("ui_use_artifact"):
		$".".play("Morph animation")
		morph = true
