class_name UiEnergy
extends Panel

var energyProgress : ProgressBar
var energyText : RichTextLabel
var currentEnergy : int = 55

func _ready() -> void:
	energyProgress = get_node("EnergyBox/EnergyProgress")
	energyText = get_node("EnergyBox/EnergyText")

func update(newEnergy : int) -> void:
	if currentEnergy != newEnergy:
		currentEnergy = newEnergy
		energyProgress.value = currentEnergy
		energyText.text = str(currentEnergy) + "%"
