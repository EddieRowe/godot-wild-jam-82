extends RigidBody2D

var move_speed = 100
@export var health : Health

func _ready() -> void:
	gravity_scale = 0.1
	
func _input(event: InputEvent) -> void:
	var impulse = Vector2(0, -1) 	
	var left_impulse = Vector2(-1, 0)
	var right_impulse = Vector2(1, 0)
	
	if event.is_action("ui_up"):
		apply_impulse(impulse*move_speed)
		
	if event.is_action("ui_left"):
		apply_impulse(left_impulse*move_speed)
	
	if event.is_action("ui_right"):
		apply_impulse(right_impulse*move_speed)


func _on_body_entered(body: Node) -> void:
	health._take_damage(50)
	
