extends Node2D

func _ready():
	hide()

func showScene():
	fillList()
	show()

func hideScene():
	hide()

func fillList():
	$VictoryList.clear()
	print(Event.getVictoryStr())
	$VictoryList.text = Event.getVictoryStr()
