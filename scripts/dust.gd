extends RigidBody3D

@onready var vaccum_marker = get_tree().get_first_node_in_group("vaccum_marker")

var dir = Vector3.ZERO
var speed = 100

func _physics_process(delta):
	if Input.is_action_pressed("vaccum"):
		if vaccum_marker.global_position.distance_to(global_position) < 2:
			dir = (vaccum_marker.global_position - global_position).normalized()
			linear_velocity = dir * speed * delta
