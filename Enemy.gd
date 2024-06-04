extends Area2D

@export var speed = 100

func _ready():
	var viewport_size = get_viewport().size
	var start_position = Vector2(viewport_size.x, viewport_size.y / 2)
	position = start_position

func _physics_process(delta):
	position.x -= speed * delta
	if position.x < -200:
		queue_free()
