extends CharacterBody3D

@onready var head = $head

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# How fast the player moves in meters per second.
@export var speed = 14
# How fast the player jumps in meters per second.
@export var jump_velocity = 4.5
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var mouse_sensitivity = 0.25
var target_velocity = Vector3.ZERO
var lerp_speed = 10.0
var direction = Vector3.ZERO

func _ready():
	Input.set("mouse_mode", Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x =clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		
	if Input.is_action_just_pressed("echap"):
		Input.set("mouse_mode", Input.MOUSE_MODE_VISIBLE)
		
	if event is InputEventMouseButton:
		Input.set("mouse_mode", Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_back")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta * lerp_speed)
	# Moving the Character
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()
