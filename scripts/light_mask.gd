extends PointLight2D

@export var player_rigidbody : RigidBody2D

func _process(delta: float) -> void:
	position = player_rigidbody.position
