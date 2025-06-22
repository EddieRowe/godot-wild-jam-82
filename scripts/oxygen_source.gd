class_name OxygenSource
extends RigidBody2D

const OXYGEN_SCALE : int = 15
@export var bubbleSize : int = 1
@export var isStatic : bool = false
var oxygen : int

func _ready() -> void:
	oxygen = bubbleSize * OXYGEN_SCALE
	get_node("CollisionShape2D").apply_scale(Vector2i(bubbleSize, bubbleSize))
	get_node("Sprite2D").apply_scale(Vector2i(bubbleSize, bubbleSize))
	freeze = isStatic

func pop() -> void:
	print("Pop!")
	queue_free()
