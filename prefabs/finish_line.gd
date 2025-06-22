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

		player = body		
		player.health._full_repair()
		player.energy._recharge(player.energy.BATTERY_MAX)
		player.oxygen._refill_oxygen()		
						
					
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		# Restore oxygen for next level
		player.oxygen.currentOxygen = player.oxygen.LIMIT_MAX
		
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
