extends Area2D

var animTrigger = false

func _on_body_entered(body):
	if !Player.isInDash:
<<<<<<< Updated upstream
		Player.speed = 1100
=======
		Player.speed += 150
>>>>>>> Stashed changes
		Player.movementAcceleration += 100
		$Timer.start(3)
		animTrigger = true
		$CollisionShape2D.queue_free()
		$Sprite2D/AnimationPlayer.play("SpeedPowerup")

func _on_timer_timeout():
<<<<<<< Updated upstream
	Player.speed = 500
=======
	Player.speed -= 150
>>>>>>> Stashed changes
	Player.movementAcceleration -= 100
	queue_free()

func _process(delta):
	$Timer.time_left
	
