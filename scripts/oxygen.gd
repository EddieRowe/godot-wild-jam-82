class_name Oxygen
extends Node2D

const LIMIT_MAX : int = 100
const LIMIT_MIN : int = 0
const CONSUMPTION_RATE : int = 1

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

func _on_breath_timer_timeout() -> void:
	if currentOxygen > LIMIT_MIN:
		currentOxygen -= CONSUMPTION_RATE
		print("Breathing...")
