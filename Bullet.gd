extends Area2D

@export var speed : float = 1200

func _ready() -> void:
	connect("area_entered", Callable(self, "_on_Bullet_area_entered"))

func _process(delta : float) -> void:
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x:
		queue_free()

func _on_Bullet_area_entered(body : Area2D) -> void:
	if body.name == "Enemy":
		body.queue_free()
		queue_free()
