class_name EnergySource
extends RigidBody2D

@export var energy_charge : int = 250
@export var consume_count : int = 1

func dissipate() -> void:
	print("Zap!")
	queue_free()
