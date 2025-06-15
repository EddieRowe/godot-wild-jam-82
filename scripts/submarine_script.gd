extends RigidBody2D
class_name PlayerMovement

var move_speed = 300
@export var health : Health
@export var oxygen : Oxygen
@export var energy : Energy
@export var sprite : Sprite2D
@export var audio : SubmarineAudio
@export var propellor : AnimationPlayer
@export var restart_timer : Timer

var can_move : bool = true

func _ready() -> void:
	gravity_scale = 0.1

func _physics_process(delta: float) -> void:
	if !can_move:
		audio._stop_sub_prop_audio() # bad
		if propellor.is_playing():
			propellor.stop()
		if restart_timer.is_stopped():
			restart_timer.start()
			propellor.get_parent().get_parent().texture = load("res://art/player_crushed_placeholder_.png")
			propellor.get_parent().texture = null
			var fake_prop = load("res://prefabs/propellor_rigidbody.tscn")
			var fake_prop_instance = fake_prop.instantiate()
			propellor.get_parent().get_parent().add_child(fake_prop_instance)
			fake_prop_instance.position = propellor.get_parent().position
		return
	
	var horizontal_movement = Input.get_axis("ui_left", "ui_right")
	var vertical_movement = Input.get_axis("ui_up", "ui_down")
	var movement = Vector2(horizontal_movement, vertical_movement)
	
	apply_central_force(movement * move_speed)
	
	_handle_flip_sprite(movement)
	
	energy._handle_lighting(Input.is_action_pressed("ui_accept"))
	
	# also bad
	if movement.length() > 0:
		audio._start_sub_prop_audio()
		if !propellor.is_playing():
			propellor.play(("propellor_anim"))
	else:
		audio._stop_sub_prop_audio()
		if propellor.is_playing():
			propellor.stop()

func _handle_flip_sprite(movement : Vector2):
	if movement.x < 0:
		sprite.flip_h = true
		propellor.get_parent().position.x = 60.0
	elif movement.x > 0:
		sprite.flip_h = false
		propellor.get_parent().position.x = -60.0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Obstacle"):
		health._take_damage(body.damage)
	if body is OxygenSource:
		oxygen._collect_oxygen(body)
	if body.is_in_group("LevelComplete"):
		get_parent().queue_free()
		


func _on_restart_level_timer_timeout() -> void:
	get_tree().reload_current_scene()
