extends Area2D

@export var speed : float = 1200
@export var damage: int = 1

func _ready() -> void:
	add_to_group("Bullets")
	connect("area_entered", Callable(self, "_on_Bullet_body_entered"))

func _process(delta : float) -> void:
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x:
		queue_free()
		
func _on_Bullet_body_entered(body):
	if body.name != "Player":
		queue_free()
