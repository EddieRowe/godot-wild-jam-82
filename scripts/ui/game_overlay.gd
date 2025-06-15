class_name GameOverlay
extends Panel

var player : RigidBody2D
var health : UiHealth
var oxygen : UiOxygen
var energy : UiEnergy

func _ready() -> void:
	player = get_parent().get_parent().get_node("Player/RigidBody2D")
	health = get_node("UiBox/UiHealth")
	oxygen = get_node("UiBox/UiOxygen")
	energy = get_node("UiBox/UiEnergy")

func _physics_process(delta: float) -> void:
	health.update(player.health.current_health)
	oxygen.update(player.oxygen.currentOxygen)
	energy.update(player.energy.get_energy_perc())
