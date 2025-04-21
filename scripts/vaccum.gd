extends Area3D

func _ready():
	self.connect("body_entered", vanish)

func vanish(body: Node3D):
	body.queue_free()
