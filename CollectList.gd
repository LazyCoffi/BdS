extends Node2D

signal messageSignal
signal setTriggerSignal

var words
var hasCollected
var resourceDict

func _ready():
	words = $"/root/Data/Words"
	resourceDict = $"/root/Data/Words".call("getResourceDict")

func initList():
	fillList()
	hasCollected = false

func randn(a, b):
	randomize()
	return randi() % int(b - a + 1) + int(a)

func fillList():
	$ItemList.clear()
	
	$ItemList.add_item("资源词块")
	$ItemList.set_item_selectable(0, false)
	$ItemList.add_item("可收集数量")
	$ItemList.set_item_selectable(1, false)
	$ItemList.add_item("收集操作")
	$ItemList.set_item_selectable(2, false)
	
	var index = 3
	for key in resourceDict.keys():
		var listNode = resourceDict[key]
		$ItemList.add_item(key)
		$ItemList.set_item_selectable(index, false)
		index += 1
		
		var rangeStr;
		if listNode[2] == 0:
			rangeStr = str(listNode[1])
		else:
			rangeStr = str(listNode[1]) + "~" + str(listNode[2])
		
		$ItemList.add_item(rangeStr)
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
			var valueList = resourceDict[block]
			var num
			if valueList[2] == 0:
				num = int(valueList[1])
			else:
				num = randn(valueList[1], valueList[2])
			
			var message
			if valueList[0] == "coin":
				$"/root/Data/Money".call("addMoney", num)
				message = "已收集 " + str(num) + " 个硬币"
			elif valueList[0] == "item":
				$"/root/Data/Words".call("insertMultiBlocks", block, num)
				message = "已收集 " + str(num) + " 个" + block + " 词块"
			
			emit_signal("messageSignal", "收集资源", message)
			emit_signal("setTriggerSignal")
			hasCollected = true
