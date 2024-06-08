extends CharacterBody2D

@export var speed: float = 200
@export var amplitude: float = 500  # Amplitude of the wave
@export var frequency: float = 5  # Frequency of the wave
@export var health: int = 3  # Frequency of the wave

@onready var shield = $ShieldHitbox
@onready var weak_spot = $WeakSpotHitbox

var time_passed: float = 0.3

func _ready():
	var viewport_size = get_viewport().size
	var start_position = Vector2(viewport_size.x, viewport_size.y / 2)
	position = start_position

	weak_spot.connect("body_entered", Callable(self, "_on_weak_spot_body_entered"))
	shield.connect("body_entered", Callable(self, "_on_shield_body_entered"))
	
	
func _physics_process(delta):
	#position.x -= speed * delta
	
	time_passed += delta
	var wave_offset = sin(time_passed * frequency) * amplitude
	position -= Vector2(speed * delta, wave_offset * delta).rotated(rotation)
	#if position.x < -200:
		#queue_free()
		
func _take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
		
