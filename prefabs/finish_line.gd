extends Area2D

var player : PlayerMovement
var health : UiHealth 
var energy : UiEnergy
var oxygen : Oxygen

var can_move : bool = true
signal finished_level()


func _ready() -> void:
	var particles : GPUParticles2D = get_node("GPUParticles2D")
	particles.restart()
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		finished_level.emit()

		player = get_parent().get_node("Player/RigidBody2D")
		
		player.health.current_health = player.health.max_health
		health = get_parent().get_node("CanvasLayer/GameOverlay/UiBox/UiHealth")
		health.update(player.health.current_health)
		
		player.energy.currentEnergy = player.energy.BATTERY_MAX				
		energy = get_parent().get_node("CanvasLayer/GameOverlay/UiBox/UiEnergy")
		energy.update(player.energy.currentEnergy)
		
		player.oxygen.currentOxygen = player.oxygen.LIMIT_MAX
				
					
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		# Restore oxygen for next level
		player.oxygen.currentOxygen = player.oxygen.LIMIT_MAX
		
		get_tree().change_scene_to_file("res://levels/level_2.tscn")

