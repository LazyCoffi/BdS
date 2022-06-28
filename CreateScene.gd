extends Node2D

var words

func _ready():
	hide()
	$CreateList/ItemList.connect("item_selected", $CreateList, "selected")
	$CreateList.connect("textSeletedSignal", $CreateBench, "textSelected")
	$CreateBench/ConfirmButton.connect("pressed", $CreateBench, "create")
	$CreateBench/BackspaceButton.connect("pressed", $CreateBench, "backspace")
	$CreateBench.connect("refreshListSignal", $CreateList, "fillList")

func showScene():
	$CreateBench.call("refresh")
	show()

func hideScene():
	hide()
	$CreateBench.call("reset")
