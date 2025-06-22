class_name Health
extends Node2D

const MIN_IMPACT_SPEED : int = 25
const AVG_IMPACT_SPEED : int = 160

signal healthChanged(newAmount : int)
signal tookDamage()

var max_health : int = 100
var current_health : int = 100
var repair_health : int = 1

@export var player_movement : PlayerMovement

var running = false

func _ready() -> void:
	print("Health initialised")
	get_parent().get_node("RigidBody2D").game_started_signal.connect(_game_started)
	
func _game_started():
	running = true 
	
func _take_damage(amount: int, source: String) -> void:
	if !running: return
	
	if source == "collision":
		if player_movement.linear_velocity.length() < MIN_IMPACT_SPEED:
			amount = 0
		else:
			amount = amount * player_movement.linear_velocity.length() / AVG_IMPACT_SPEED
	
	print("Took damage: " + str(amount))
	current_health -= amount
	if current_health <= 0:
		current_health = 0
		player_movement.can_move = false
		#queue_free()
	healthChanged.emit(current_health)
	if current_health > 0:
		tookDamage.emit()


func _on_repair_timer_timeout() -> void:
	if !running: return
	if current_health < max_health and player_movement.can_move:
		current_health += 1
		print("Repairing...")
		healthChanged.emit(current_health)

func is_alive() -> bool:
	return current_health > 0
