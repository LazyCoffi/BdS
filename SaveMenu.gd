extends Control


func _ready():
	hide()
	
	$ExitArrow.connect("mouse_entered", $ExitHoverBox, "show")
	$ExitArrow.connect("mouse_exited", $ExitHoverBox, "hide")
	$SaveList/ItemList.connect("item_selected", $SaveList, "selected")

func showScene():
	show()
	$SaveList.call("initList")

func hideScene():
	hide()
