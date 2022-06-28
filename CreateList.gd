extends Node2D

signal textSeletedSignal

func _ready():
	var words = $"/root/Data/Words"
	fillList(words.call("getBlocks"))

func fillList(list):
	$ItemList.clear()
	var idx = 0
	for listNode in list:
		
		$ItemList.add_item(listNode[0])
		$ItemList.set_item_selectable(idx, false)
		idx += 1
		
		$ItemList.add_item(str(listNode[1]))
		$ItemList.set_item_selectable(idx, false)
		idx += 1
		
		$ItemList.add_item("添加")
		$ItemList.set_item_selectable(idx, true)
		idx += 1

func selected(index):
	if index % 3 == 2:
		$ItemList.unselect(index)
		emit_signal("textSeletedSignal", $ItemList.call("get_item_text", index - 2))
