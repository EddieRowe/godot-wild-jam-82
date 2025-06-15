class_name UiHealth
extends Panel

const WAVE_CODE : String = "[wave]"
const SHAKE_CODE : String = "[shake]"
const SHAKE_BOUND : int = 30

var healthText : RichTextLabel
var currentHealth : int = 100

func _ready() -> void:
	healthText = get_node("HealthText")

func update(newHealth : int) -> void:
	if currentHealth != newHealth:
		currentHealth = newHealth
		var formatString = "%s[b]%d "
		var textResult : String
		if currentHealth <= SHAKE_BOUND:
			textResult = formatString % [SHAKE_CODE, currentHealth]
		else:
			textResult = formatString % [WAVE_CODE, currentHealth]
		healthText.text = textResult
