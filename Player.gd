extends Area2D

# Declare member variables here
@export var speed = 400
@export var bullet_scene: PackedScene

var start_position = Vector2(100, 100)
var acceleration_factor = 0.075
var deceleration_factor = 0.05
var drift_factor = 0.025
var velocity = Vector2()

func _ready():
	var viewport_size = get_viewport_rect().size
	var start_position = Vector2(100, viewport_size.y / 2)
	position = start_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_vector = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	input_vector = input_vector.normalized()
	
	# Calculate the target velocity
	var target_velocity = input_vector * speed
	
	# Determine if accelerating or decelerating
	if target_velocity.length() > velocity.length():
		# Accelerating
		velocity = velocity.lerp(target_velocity, acceleration_factor)
	else:
		# Decelerating
		velocity = velocity.lerp(target_velocity, deceleration_factor)
	
	# Apply drift effect
	if input_vector != Vector2():
		velocity = velocity.lerp(target_velocity, drift_factor)
	
	# Move the player
	position += velocity * delta
