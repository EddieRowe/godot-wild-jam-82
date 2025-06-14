extends RigidBody2D
class_name PlayerMovement

var move_speed = 80
@export var health : Health

var can_move : bool = true

func _ready() -> void:
	gravity_scale = 0.1
	
func _input(event: InputEvent) -> void:
	if !can_move:
		return
	
	var impulse = Vector2(0, -1) 	
	var left_impulse = Vector2(-1, 0)
	var right_impulse = Vector2(1, 0)
	
	if event.is_action("ui_up"):
		apply_impulse(impulse*move_speed)
		
	if event.is_action("ui_left"):
		apply_impulse(left_impulse*move_speed)
	
	if event.is_action("ui_right"):
		apply_impulse(right_impulse*move_speed)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Obstacle"):
		health._take_damage(body.damage)
	
	
