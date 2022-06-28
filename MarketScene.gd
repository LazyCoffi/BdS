extends Node2D

func _ready():
	hide()
	
	$BuyButton.connect("pressed", $MarketList, "fillBuyList")
	$SellButton.connect("pressed", $MarketList, "fillSellList")
	$MarketList/ItemList.connect("item_selected", $MarketList, "selected")
	
	$ExitArrow.connect("mouse_entered", $ExitHoverBox, "show")
	$ExitArrow.connect("mouse_exited", $ExitHoverBox, "hide")

func showScene():
	$MarketList.call("initList")
	show()

func hideScene():
	hide()
