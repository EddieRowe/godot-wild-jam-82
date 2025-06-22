extends RigidBody2D
class_name PlayerMovement

const MOVE_SPEED : int = 300

@export var health : Health
@export var oxygen : Oxygen
@export var energy : Energy
@export var sprite : Sprite2D
@export var audio : SubmarineAudio
@export var propellor : AnimationPlayer
@export var bubble_stream : GPUParticles2D
@export var restart_timer : Timer
@export var electrocuted_timer : Timer
@export var rotation_speed : float = 0.1

var can_move : bool = true
var free_floating : bool = true
var game_started: bool = false
var level : int 
var my_texture : Texture

signal game_started_signal()

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
			bubble_stream.emitting = false
		return
	
	var horizontal_movement = Input.get_axis("ui_left", "ui_right")
	var vertical_movement = Input.get_axis("ui_up", "ui_down")
	var movement = Vector2(horizontal_movement, vertical_movement)
	
	if movement:
		free_floating = false
		if !game_started:
			freeze = false
			game_started = true
			game_started_signal.emit()
	
	if game_started:
		apply_central_force(movement * MOVE_SPEED)
		_handle_flip_sprite(movement)
	
	
	energy._handle_lighting(Input.is_action_pressed("ui_accept"))
	
	# also bad
	if movement.length() > 0:
		audio._start_sub_prop_audio()
		bubble_stream.emitting = true
		if !propellor.is_playing():
			propellor.play(("propellor_anim"))
	else:
		audio._stop_sub_prop_audio()
		bubble_stream.emitting = false
		if propellor.is_playing():
			propellor.stop()

func _handle_flip_sprite(movement : Vector2):
	# Flip sprite based on rotation
	#Clamped to +2PI as rotation can be infinite
	var rotation_clamped = abs(fmod(rotation, 2*PI))
	
	if rotation_clamped > PI/2 and rotation_clamped < 3*PI/2:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
		
func _look_follow(state: PhysicsDirectBodyState2D) -> void:
	var forward_local_axis: Vector2 = Vector2(1, 0) # Right-facing direction
	
	var forward_dir: Vector2 = Vector2(cos(rotation), sin(rotation)).normalized()
	var target_dir: Vector2 = linear_velocity.normalized()
	var angle_diff: float = forward_dir.angle_to(target_dir)
	var local_speed: float = clampf(rotation_speed, 0, abs(angle_diff))
	
	if abs(angle_diff) > 1e-4:
		# Determine turning direction: positive for counterclockwise, negative for clockwise
		var direction: float = sign(forward_dir.cross(target_dir))
		angular_velocity = direction * local_speed / state.step

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not free_floating and _eligible_velocity():
		_look_follow(state)

func _eligible_velocity() -> bool:
	var rnd : float = 0.01
	var above_limit = linear_velocity.length() > 100
	# Snapped will round to the nearest step (decimal place)
	var is_left = snappedf(linear_velocity.angle(),rnd) == snappedf(Vector2.LEFT.angle(),rnd)
	var is_right = snappedf(linear_velocity.angle(),rnd) == Vector2.RIGHT.angle()
	# This is to stop weird jumps when scraping across the floor
	return above_limit and not (is_left or is_right)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Obstacle") and body is not Jellyfish:
		free_floating = true
		health._take_damage(body.damage, "collision")
	
	if body is OxygenSource:
		oxygen._collect_oxygen(body)
	
	if body is EnergySource:
		energy.collect_energy(body)
	
	if body is Jellyfish:
		health._take_damage(body.damage, "jellyfish")
		
		#Make the submarine get electrocuted
		my_texture = load("res://art/submarine_electrocuted.png")
		sprite.texture = my_texture
		electrocuted_timer.start()
				
		
func _on_restart_level_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_sub_electrocuted_timer_timeout() -> void:
	my_texture = load("res://art/player_placeholder_.png")
	sprite.texture = my_texture
