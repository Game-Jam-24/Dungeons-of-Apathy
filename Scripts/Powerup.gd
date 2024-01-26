extends Area2D

var animTrigger = false

func _on_body_entered(body):
	if !Player.isInDash:
		Player.speed += 150
		$Timer.start(2)
		animTrigger = true
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.play("default")
		$AnimatedSprite2D.hide()

func _on_timer_timeout():
	Player.speed -= 150
	queue_free()

func _process(delta):
	$Timer.time_left
	
