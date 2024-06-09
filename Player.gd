extends CharacterBody2D

# Declare member variables here
@export var speed = 400
@export var BulletScene : PackedScene

var start_position
var acceleration_factor = 0.075
var deceleration_factor = 0.05
var drift_factor = 0.025

func _ready():
	var viewport_size = get_viewport_rect().size
	start_position = Vector2(100, viewport_size.y / 2)
	position = start_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	if Input.is_action_just_pressed("shoot"):  # "ui_select" is the space bar by default
		fire_bullet()
	
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

func fire_bullet() -> void:
	var bullet_instance = BulletScene.instantiate()
	bullet_instance.position = self.position  # Set the bullet's initial position to the player's position
	get_parent().add_child(bullet_instance)  # Add the bullet to the scene tree
	var recoil = 100
	velocity.x -= recoil
