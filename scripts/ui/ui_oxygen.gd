class_name UiOxygen
extends Panel

var bubble1 : Panel
var bubble2 : Panel
var bubble3 : Panel
var bubble4 : Panel
var bubble5 : Panel
var oxyProgress : ProgressBar
var currentOxygen : int = 90

func _ready() -> void:
	bubble1 = get_node("BubbleBox/Bubble1")
	bubble2 = get_node("BubbleBox/Bubble2")
	bubble3 = get_node("BubbleBox/Bubble3")
	bubble4 = get_node("BubbleBox/Bubble4")
	bubble5 = get_node("BubbleBox/Bubble5")
	oxyProgress = get_node("OxyProgress")

func update(newOxygen : int) -> void:
	if currentOxygen != newOxygen:
		if currentOxygen > 80 and newOxygen <= 80:
			bubble5.hide()
		elif currentOxygen <= 80 and newOxygen > 80:
			bubble5.show()
		
		if currentOxygen > 60 and newOxygen <= 60:
			bubble4.hide()
		elif currentOxygen <= 60 and newOxygen > 60:
			bubble4.show()
		
		if currentOxygen > 40 and newOxygen <= 40:
			bubble3.hide()
		elif currentOxygen <= 40 and newOxygen > 40:
			bubble3.show()
		
		if currentOxygen > 20 and newOxygen <= 20:
			bubble2.hide()
		elif currentOxygen <= 20 and newOxygen > 20:
			bubble2.show()
		
		if currentOxygen > 0 and newOxygen == 0:
			bubble1.hide()
		elif currentOxygen == 0 and newOxygen > 0:
			bubble1.show()
		
		currentOxygen = newOxygen
		oxyProgress.set_value_no_signal(currentOxygen)
