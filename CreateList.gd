extends Node2D

signal textSeletedSignal

func _ready():
	var words = $"/root/Data/Words"
	fillList(words.call("getBlocks"))

func fillList(list):
	$ItemList.clear()
	
	
	$ItemList.add_item("词块")
	$ItemList.set_item_selectable(0, false)
	$ItemList.add_item("数量")
	$ItemList.set_item_selectable(1, false)
	$ItemList.add_item("--")
	$ItemList.set_item_selectable(2, false)
	
	var idx = 3
	
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
