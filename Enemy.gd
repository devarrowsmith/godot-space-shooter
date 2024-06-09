extends CharacterBody2D

@export var speed: float = 200
@export var amplitude: float = 500  # Amplitude of the wave
@export var frequency: float = 5  # Frequency of the wave
@export var health: int = 3  # Frequency of the wave

@onready var weak_spot = $WeakSpot
@onready var shield = $Shield

var time_passed: float = 0.3

func _ready():
	var viewport_size = get_viewport().size
	var start_position = Vector2(viewport_size.x, viewport_size.y / 2)
	position = start_position

	weak_spot.connect("area_entered", Callable(self, "_on_weak_spot_area_entered"))
	shield.connect("area_entered", Callable(self, "_on_shield_area_entered"))	

	#weak_spot.connect("area_entered", Callable(self, "_on_weak_spot_area_entered"))
	#shield.connect("area_entered", Callable(self, "_on_shield_area_entered"))
	
	
func _physics_process(delta):
	#position.x -= speed * delta
	
	time_passed += delta
	var wave_offset = sin(time_passed * frequency) * amplitude
	position -= Vector2(speed * delta, wave_offset * delta).rotated(rotation)

func _on_weak_spot_area_entered(area):
	if area is Area2D:
		if area.is_in_group("Bullets"):
			print("Weak spot hit!")
			var damage = area.damage
			_take_damage(damage)

func _on_shield_area_entered(area):
	print("Shield hit!")

func _take_damage(damage):
	health -= damage
	print("Health remaining:")
	print(health)
	if health <= 0:
		queue_free()
