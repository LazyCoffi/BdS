extends Node2D

var isShow
signal nextEventSignal

func _ready():
	hide()
	
	$TextureRect/Button/ButtonText.text = "确认"
	$TextureRect/Button.connect("pressed", self, "nextDialog")

func showDialog(title, message):
	$TextureRect/DialogTitle.text = title
	$TextureRect/DialogText.text = message
	$AnimationPlayer.play("show")
	show()
	isShow = true

func nextDialog():
	emit_signal("nextEventSignal")

func closeDialog():
	isShow = false
	$AnimationPlayer.play("hide")
	hide()
