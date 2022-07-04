extends Node2D


func _ready():
	hide()
	$ButtonRect/BackButton.connect("pressed", self, "hideScene")

func showScene():
	show()

func hideScene():
	hide()
