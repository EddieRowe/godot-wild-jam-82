class_name GameOverlay
extends Panel

func _ready() -> void:
	var player : PlayerMovement = get_parent().get_parent().get_node("Player/RigidBody2D")
	var health : UiHealth = get_node("UiBox/UiHealth")
	var oxygen : UiOxygen = get_node("UiBox/UiOxygen")
	var energy : UiEnergy = get_node("UiBox/UiEnergy")
	
	player.health.healthChanged.connect(health.update)
	player.oxygen.oxygenChanged.connect(oxygen.update)
	player.energy.energyChanged.connect(energy.update)
	
	# Init values
	health.update(player.health.current_health)
	oxygen.update(player.oxygen.currentOxygen)
	energy.update(player.energy.get_energy_perc())
