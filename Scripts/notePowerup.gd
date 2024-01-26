extends Area2D

var animTrigger = false
var collision = false

func _on_body_entered(body):
	if !Player.isInDash:
		collision = true
		$Label.show()
		print_debug(collision)

func _on_body_exited(body):
	$Label.hide()
	collision = false
	print_debug(collision)

func _input(event):
	if collision == true and Input.is_action_just_pressed("ui_powerup_pickup") == true:
		Player.collectableCounter += 1
		print_debug("It worked my guy")
		$Timer.start(3)
		animTrigger = true
		$CollisionShape2D.queue_free()
		$Sprite2D/AnimationPlayer.play("SpeedPowerup")

func _on_timer_timeout():
	queue_free()
