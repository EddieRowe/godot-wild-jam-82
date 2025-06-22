class_name Health
extends Node2D

signal healthChanged(newAmount : int)
signal tookDamage()

var max_health : int = 100
var current_health : int = 100
var repair_health : int = 1

@export var player_movement : PlayerMovement

var running = false

func _ready() -> void:
	print("health initialised")
	get_parent().get_node("RigidBody2D").game_started_signal.connect(_game_started)
	
func _game_started():
	running = true 
	
func _take_damage(amount: int, source: String) -> void:
	if !running: return
	
	if source == "collision":
		amount = amount * player_movement.linear_velocity.length()/90
	
	print("took damage" + str(amount))
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
		print("repairing")
		healthChanged.emit(current_health)

func is_alive() -> bool:
	return current_health > 0

func _full_repair() -> void:
	pass
	current_health = max_health
	print("Full health repair")
	healthChanged.emit(current_health)
