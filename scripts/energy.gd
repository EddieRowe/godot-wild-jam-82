class_name Energy
extends Node2D

const BATTERY_MAX : int = 1000
const BATTERY_MIN : int = 0
const CONSUMPTION_RATE : int = 1

@export var lightSource : PointLight2D
const LIGHTING_MAX : float = 1.8
const LIGHTING_MIN : float = 1.0
const VARIANCE : float = 0.04

signal energyChanged(newValue: int)

var currentEnergy : int = BATTERY_MAX
var currentLighting : float = LIGHTING_MIN

func _ready() -> void:
	print("Energy initialised")

func _handle_lighting(illuminate: bool):
	if illuminate and currentEnergy > BATTERY_MIN:
		# LIGHTING
		if currentLighting < LIGHTING_MAX:
			currentLighting += VARIANCE
		
		# BATTERY
		currentEnergy -= CONSUMPTION_RATE
		if currentEnergy <= BATTERY_MIN:
			currentEnergy = BATTERY_MIN
		energyChanged.emit(get_energy_perc())
	else:
		if currentLighting > LIGHTING_MIN:
			currentLighting -= VARIANCE
	
	lightSource.scale = Vector2(currentLighting, currentLighting)

func _recharge(amount : int) -> void:
	currentEnergy += amount
	if currentEnergy >= BATTERY_MAX:
		currentEnergy = BATTERY_MAX
	energyChanged.emit(get_energy_perc())

func collect_energy(source: EnergySource) -> void:
	_recharge(source.energy_charge)
	if source.is_single_use:
		source.dissipate()

func get_energy_perc() -> int:
	var decimal = float(currentEnergy) / float(BATTERY_MAX)
	return int(decimal * 100)
