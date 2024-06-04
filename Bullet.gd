extends Area2D

@export var speed = 1600

func _physics_process(delta):
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x:
		queue_free()

func _on_Bullet_body_entered(body):
	if body.name == "Enemy":
		body.queue_free()
		queue_free()
