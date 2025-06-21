extends RigidBody2D

var speed : int = 10
var player : PlayerMovement
@export var animation_player : AnimationPlayer
@export var movement_animation_name : String
@export var damage : int = 15

func _ready() -> void:
	player = get_parent().get_parent().get_node("Player/RigidBody2D")
	animation_player.play(movement_animation_name)

func _physics_process(delta: float) -> void:
	var move_direction =  player.global_position - global_position
	apply_central_force(move_direction.normalized() * speed)

func _on_body_entered(body: Node) -> void:
	if body is PlayerMovement:
		body.health._take_damage(100)
