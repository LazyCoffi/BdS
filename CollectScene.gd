extends Node2D


func _ready():
	hide()
	$CollectList/ItemList.connect("item_selected", $CollectList, "selected")
	$ExitArrow.connect("pressed", self, "hideScene")
	$ExitArrow.connect("mouse_entered", $ExitHoverBox, "show")
	$ExitArrow.connect("mouse_exited", $ExitHoverBox, "hide")

func showScene():
	show()
	$CollectList.call("initList")

func hideScene():
	hide()
