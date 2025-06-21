class_name EnergySource
extends RigidBody2D

@export var energy_charge : int = 250
@export var is_single_use : bool = false

func dissipate() -> void:
	print("Zap!")
	queue_free()
