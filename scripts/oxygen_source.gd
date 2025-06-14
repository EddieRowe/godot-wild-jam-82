class_name OxygenSource
extends RigidBody2D

@export var oxygen : int = 25

func pop() -> void:
	print("Pop!")
	#hide()
	queue_free()
