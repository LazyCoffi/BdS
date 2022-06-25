extends Node2D

signal nextEventSignal

func _ready():
	hide()
	
	$TextureRect/Button/ButtonText.text = "确认"
	$TextureRect/Button.connect("pressed", self, "nextDialog")

func showDialog(title, message):
	$TextureRect/DialogTitle.text = title
	$TextureRect/DialogText.text = message
	show()

func nextDialog():
	emit_signal("nextEventSignal")

func closeDialog():
	hide()
