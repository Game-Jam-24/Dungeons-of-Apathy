extends CanvasLayer

@onready var player = $".."
@onready var healthBar = $".".get_child(0)
@onready var staminaBar = $".".get_child(1)
@onready var LoreCounter = $".".get_child(2).get_node("Counter")

func _ready():
	healthBar.max_value = Player.maxHealth
	staminaBar.max_value = Player.maxStamina
	LoreCounter.text = str(0)
	update()

func update():
	healthBar.value = player.health
	staminaBar.value = player.stamina
	LoreCounter.text = str(Player.collectableCounter)

func _process(_delta):
	update()
