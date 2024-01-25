extends CanvasLayer

@onready var player = $".."
@onready var healthBar = $".".get_child(0)
@onready var staminaBar = $".".get_child(1)

func _ready():
	healthBar.max_value = Player.maxHealth
	staminaBar.max_value = Player.maxStamina
	update()

func update():
	healthBar.value = player.health
	staminaBar.value = player.stamina

func _process(_delta):
	update()
