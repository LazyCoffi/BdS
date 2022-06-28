extends Node2D

func _ready():
	hide()
	
	$CollectHoverBox.call("hide")
	$CollectArrow.connect("mouse_entered", $CollectHoverBox, "show")
	$CollectArrow.connect("mouse_exited", $CollectHoverBox, "hide")
	
	$BookHoverBox.call("hide")
	$BookArrow.connect("mouse_entered", $BookHoverBox, "show")
	$BookArrow.connect("mouse_exited", $BookHoverBox, "hide")
	
	$MarketHoverBox.call("hide")
	$MarketArrow.connect("mouse_entered", $MarketHoverBox, "show")
	$MarketArrow.connect("mouse_exited", $MarketHoverBox, "hide")

func showScene():
	show()

func hideScene():
	$CollectHoverBox.call("hide")
	$BookHoverBox.call("hide")
	$MarketHoverBox.call("hide")
	hide()
	
func _process(delta):
	pass
