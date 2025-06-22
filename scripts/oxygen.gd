class_name Oxygen
extends Node2D

const LIMIT_MAX : int = 100
const LIMIT_MIN : int = 0
const CONSUMPTION_RATE : int = 3
const DROWN_RATE : int = 5

@export var health : Health
signal oxygenChanged(newAmount : int)

var initOxygen : int = 90
var currentOxygen : int = 0

func _ready() -> void:
	print("Oxygen initialised")
	currentOxygen = initOxygen

func _consume_oxygen(amount: int) -> void:
	print("Consume "+str(amount))
	currentOxygen += amount
	if currentOxygen >= LIMIT_MAX:
		currentOxygen = LIMIT_MAX
	oxygenChanged.emit(currentOxygen)

func _on_breath_timer_timeout() -> void:
	if health.is_alive():
		if currentOxygen > LIMIT_MIN:
			print("Breathing...")
			currentOxygen -= CONSUMPTION_RATE
			oxygenChanged.emit(currentOxygen)
		else:
			print("Drowning...")
			health._take_damage(DROWN_RATE)

func _collect_oxygen(source: OxygenSource) -> void:
	_consume_oxygen(source.oxygen)
	source.pop()
