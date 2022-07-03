extends Node2D

var trigger
signal nextDaySignal
signal transitionSignal

func _ready():
	hide()
	
	$BuyButton.connect("pressed", $MarketList, "fillBuyList")
	$SellButton.connect("pressed", $MarketList, "fillSellList")
	$MarketList/ItemList.connect("item_selected", $MarketList, "selected")
	
	$ExitArrow.connect("mouse_entered", $ExitHoverBox, "show")
	$ExitArrow.connect("mouse_exited", $ExitHoverBox, "hide")
	
	$MarketList.connect("setTriggerSignal", self, "setTrigger")

func setTrigger():
	trigger = 1

func showScene():
	MusicPlayer.play("MarketScene")
	MusicPlayer.soundPlay("Walk")
	emit_signal("transitionSignal")
	$MarketList.call("initList")
	show()
	trigger = 0

func hideScene():
	MusicPlayer.soundPlay("Walk")
	if trigger == 1:
		emit_signal("nextDaySignal")
	hide()
