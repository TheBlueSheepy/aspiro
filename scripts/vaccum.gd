extends Area3D

func _ready():
	self.connect("body_entered", vanish)

func vanish(body: Node3D):
	if Input.is_action_pressed("vaccum"):
		body.queue_free()
