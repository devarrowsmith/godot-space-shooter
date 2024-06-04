extends Area2D

@export var speed: float = 200
@export var amplitude: float = 500  # Amplitude of the wave
@export var frequency: float = 5  # Frequency of the wave

var time_passed: float = 0.3

func _ready():
	var viewport_size = get_viewport().size
	var start_position = Vector2(viewport_size.x, viewport_size.y / 2)
	position = start_position

func _physics_process(delta):
	#position.x -= speed * delta
	
	time_passed += delta
	var wave_offset = sin(time_passed * frequency) * amplitude
	position -= Vector2(speed * delta, wave_offset * delta).rotated(rotation)
	
	#if position.x < -200:
		#queue_free()
