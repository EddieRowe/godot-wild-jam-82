extends Area2D

var player : PlayerMovement
var health : UiHealth 
var energy : UiEnergy
var oxygen : Oxygen

var can_move : bool = true
signal finished_level()
var finished = false

func _ready() -> void:
	var particles : GPUParticles2D = get_node("GPUParticles2D")
	particles.restart()
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		player.health._full_repair()
		player.energy._recharge(player.energy.BATTERY_MAX)
		player.oxygen._refill_oxygen()		
    
    finished_level.emit()
		finished = true
				

func _input(event: InputEvent) -> void:
	if finished:
		if event.is_action_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://levels/level_2.tscn")
		

