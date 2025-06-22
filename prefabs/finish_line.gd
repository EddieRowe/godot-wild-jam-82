extends Area2D

var can_move : bool = true
signal finished_level()

func _ready() -> void:
	var particles : GPUParticles2D = get_node("GPUParticles2D")
	particles.restart()
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#get_tree().change_scene_to_file("res://levels/level_2.tscn")
		finished_level.emit()
