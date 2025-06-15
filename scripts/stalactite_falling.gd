class_name StalactiteFalling
extends Node2D

@export var triggerZone : Area2D
@export var delay : float = 0.5

@export var fallingPart : Obstacle
@export var timer : Timer

func _ready() -> void:
	triggerZone.connect("body_entered", _trigger)
	timer.wait_time = delay

func _trigger(body : Node2D) -> void:
	if body is PlayerMovement:
		timer.start()

func _on_timer_fall() -> void:
	fallingPart.freeze = false
