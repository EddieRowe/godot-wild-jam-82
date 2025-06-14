class_name Health
extends Node2D


var max_health : int = 100
var current_health : int = 100
var repair_health : int = 1

@export var player_movement : PlayerMovement

func _ready() -> void:
	print("health initialised")
	
func _take_damage(amount: int) -> void:
	print("took damage" + str(amount))
	current_health -= amount
	if current_health <= 0:
		current_health = 0
		player_movement.can_move = false
		#queue_free()


func _on_repair_timer_timeout() -> void:
	if current_health < max_health and player_movement.can_move:
		current_health += 1
		print("repairing")

func is_alive() -> bool:
	return current_health > 0
