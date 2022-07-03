extends Node2D

func _ready():
	hide()

func showScene():
	$DictTree.call("fillTree")
	show()

func hideScene():
	hide()
