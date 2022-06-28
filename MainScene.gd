extends Node2D

func _ready():
	hide()
	
	$CollectHoverBox.call("hide")
	$CollectArrow.connect("mouse_entered", $CollectHoverBox, "show")
	$CollectArrow.connect("mouse_exited", $CollectHoverBox, "hide")
	
	$BookHoverBox.call("hide")
	$BookArrow.connect("mouse_entered", $BookHoverBox, "show")
	$BookArrow.connect("mouse_exited", $BookHoverBox, "hide")

func showScene():
	show()

func hideScene():
	hide()
	
func _process(delta):
	pass
