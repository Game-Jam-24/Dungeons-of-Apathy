extends Area2D

var animTrigger = false

func _on_body_entered(body):
	if !Player.isInDash:
		Player.speed += 200
		Player.movementAcceleration += 100
		$Timer.start(2)
		animTrigger = true
		$CollisionShape2D.queue_free()
		$Sprite2D/AnimationPlayer.play("SpeedPowerup")

func _on_timer_timeout():
	Player.speed -= 200
	Player.movementAcceleration -= 100
	queue_free()

func _process(delta):
	$Timer.time_left
	
