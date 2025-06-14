extends RigidBody2D
class_name PlayerMovement

var move_speed = 300
@export var health : Health
@export var oxygen : Oxygen
@export var energy : Energy
@export var sprite : Sprite2D

var can_move : bool = true

func _ready() -> void:
	gravity_scale = 0.1

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	var horizontal_movement = Input.get_axis("ui_left", "ui_right")
	var vertical_movement = Input.get_axis("ui_up", "ui_down")
	var movement = Vector2(horizontal_movement, vertical_movement)
	
	apply_force(movement * move_speed)
	
	_handle_flip_sprite(movement)
	
	energy._handle_lighting(Input.is_action_pressed("ui_accept"))

func _handle_flip_sprite(movement : Vector2):
	if movement.x < 0:
		sprite.flip_h = true
	elif movement.x > 0:
		sprite.flip_h = false

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Obstacle"):
		health._take_damage(body.damage)
	if body is OxygenSource:
		oxygen._collect_oxygen(body)
