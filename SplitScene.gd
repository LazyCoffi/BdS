extends Node2D

func _ready():
	hide()
	$SplitBench/ConfirmButton.connect("pressed", $SplitBench, "cutWord")
	$SplitBench/ResetButton.connect("pressed", $SplitBench, "reset")
	$SplitBench.connect("refreshListSignal", $SplitList, "fillList")
	$SplitList/ItemList.connect("item_selected", $SplitList, "selected")
	$SplitList.connect("textSelectedSignal", $SplitBench, "textSelected")
	$SplitList.connect("valueSelectedSignal", $SplitBench, "valueSelected")

func showScene():
	$SplitBench.call("refresh")
	show()

func hideScene():
	hide()
	$SplitBench.call("reset")
