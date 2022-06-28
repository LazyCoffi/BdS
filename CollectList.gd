extends Node2D

signal messageSignal

var words
var hasCollected

func _ready():
	words = $"/root/Data/Words"

func initList():
	fillList()
	hasCollected = false

func fillList():
	var resourceList = words.call("getResourceList")
	
	$ItemList.add_item("资源词块")
	$ItemList.set_item_selectable(0, false)
	$ItemList.add_item("可收集数量")
	$ItemList.set_item_selectable(1, false)
	$ItemList.add_item("收集操作")
	$ItemList.set_item_selectable(2, false)
	
	var index = 3
	for listNode in resourceList:
		$ItemList.add_item(listNode[0])
		$ItemList.set_item_selectable(index, false)
		index += 1
		
		$ItemList.add_item(str(listNode[1]))
		$ItemList.set_item_selectable(index, false)
		index += 1
		
		$ItemList.add_item("收集")
		$ItemList.set_item_selectable(index, true)
		index += 1

func setUnselectable():
	$ItemList.set_item_selectable()

func selected(index):
	if index % 3 == 2:
		if hasCollected:
			var message = "今天已经收集得够多了,回家吧"
			emit_signal("messageSignal", "收集资源", message)
		else:
			var block = $ItemList.get_item_text(index - 2)
			var blockNum = $ItemList.get_item_text(index - 1)
			words.insertMultiBlocks(block, blockNum.to_int())
			var message = "已收集 " + blockNum + " 个" + block + " 词块"
			emit_signal("messageSignal", "收集资源", message)
			hasCollected = true
