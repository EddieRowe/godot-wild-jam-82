extends Node


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_load_level1() 

func _on_timer_timeout() -> void:
	_load_level1() 

func _load_level1() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
