extends Area2D

var animTrigger = false

func _on_body_entered(body):
	Player.speed += 600
	$Timer.start(3)
	animTrigger = true
	$CollisionShape2D.queue_free()
	$Sprite2D/AnimationPlayer.play("SpeedPowerup")

func _on_timer_timeout():
	Player.speed = 200
	queue_free()

func _process(delta):
	$Timer.time_left
