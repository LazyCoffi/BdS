extends Node2D

var trigger

signal nextDaySignal
signal transitionSignal

func _ready():
	hide()
	$CollectList/ItemList.connect("item_selected", $CollectList, "selected")
	$ExitArrow.connect("mouse_entered", $ExitHoverBox, "show")
	$ExitArrow.connect("mouse_exited", $ExitHoverBox, "hide")
	$CollectList.connect("setTriggerSignal", self, "setTrigger")

func setTrigger():
	trigger = 1

func showScene():
	show()
	emit_signal("transitionSignal")
	MusicPlayer.play("CollectScene")
	MusicPlayer.soundPlay("Walk")
	$CollectList.call("initList")
	trigger = 0

func hideScene():
	MusicPlayer.soundPlay("Walk")
	if trigger == 1:
		emit_signal("nextDaySignal")
	hide()
