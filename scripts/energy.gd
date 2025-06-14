class_name Energy
extends Node2D

const BATTERY_MAX : int = 1000
const BATTERY_MIN : int = 0
const CONSUMPTION_RATE : int = 1

@export var lightSource : PointLight2D
const LIGHTING_MAX : float = 1.8
const LIGHTING_MIN : float = 1.0
const VARIANCE : float = 0.04

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
		
	else:
		if currentLighting > LIGHTING_MIN:
			currentLighting -= VARIANCE
	
	lightSource.scale = Vector2(currentLighting, currentLighting)
