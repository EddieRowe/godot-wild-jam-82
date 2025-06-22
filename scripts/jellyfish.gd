extends RigidBody2D
class_name Jellyfish

@export var speed : int = 10
var player : PlayerMovement
var ui_energy : UiEnergy 
@export var animation_player : AnimationPlayer
@export var movement_animation_name : String
@export var damage : int = 15

func _ready() -> void:
	player = get_parent().get_parent().get_node("Player/RigidBody2D")
	animation_player.play(movement_animation_name)
	
	# Connect the signal from Area2D
	var detector = get_node("Area2D")
	if detector is Area2D:
		if not detector.body_entered.is_connected(_on_area_2d_body_entered):
			detector.body_entered.connect(_on_area_2d_body_entered)
	else:
		push_error("Area2D not found or not an Area2D node.")


func _physics_process(delta: float) -> void:
	player = get_parent().get_parent().get_node("Player/RigidBody2D")
	var move_direction =  player.global_position - global_position
	apply_central_force(move_direction.normalized() * speed)



#func _on_body_entered(body: Node) -> void:
	#if body is PlayerMovement:
		#body.health._take_damage(damage)		
		#
		#print("Energy Fully Charged")
		#player.energy.currentEnergy = 100
		#
		#ui_energy = get_parent().get_parent().get_node("CanvasLayer/GameOverlay/UiBox/UiEnergy")
		#player.energy.energyChanged.connect(ui_energy.update)
		#ui_energy.update(player.energy.currentEnergy)
		#
	#print(body)
	#print("body entered")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerMovement:
		#body.health._take_damage(damage)		
		
		print("Energy Fully Charged")
		player = get_parent().get_parent().get_node("Player/RigidBody2D")
		player.energy.currentEnergy = player.energy.BATTERY_MAX
		
		player.energy._recharge(player.energy.BATTERY_MAX)
		
