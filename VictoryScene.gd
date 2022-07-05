extends Node2D

var selectedEnd

func _ready():
	$MiniDialog/ConfirmButton.connect("pressed", self, "playEnd")
	$MiniDialog/CancelButton.connect("pressed", $MiniDialog, "hide")
	$ItemList.connect("item_selected", self, "selected")
	hide()
	fillList()

func showScene():
	fillList()
	show()

func hideScene():
	hide()	

func fillList():
	$ItemList.clear()
	var nameList = Event.getCurVictoryNameList()
	$ItemList.add_item("结局名称")
	$ItemList.add_item("完成所需条件")
	$ItemList.add_item("--")
	for eventName in nameList:
		$ItemList.add_item(eventName)
		$ItemList.add_item(Event.getVictoryStr(eventName))
		$ItemList.add_item("进入结局")	

func selected(index):
	if index < 3:
		return
	if index % 3 == 2:
		selectedEnd = $ItemList.get_item_text(index - 2)
		$MiniDialog.call("showDialog")

func playEnd():
	Event.gameEnd(selectedEnd)
