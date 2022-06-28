extends Node2D

signal textSelectedSignal
signal valueSelectedSignal

func _ready():
	var words = $"/root/Data/Words"
	fillList(words.call("getBlocks"))

func fillList(list):
	$ItemList.clear()
	
	
	$ItemList.add_item("待选词块")
	$ItemList.set_item_selectable(0, false)
	$ItemList.add_item("数量")
	$ItemList.set_item_selectable(1, false)
	$ItemList.add_item("--")
	$ItemList.set_item_selectable(2, false)
	$ItemList.add_item("--")
	$ItemList.set_item_selectable(3, false)
	
	var idx = 4
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
		
		$ItemList.add_item("献祭")
		$ItemList.set_item_selectable(idx, true)
		idx += 1

func selected(index):
	if index % 4 == 2:
		$ItemList.unselect(index)
		emit_signal("textSelectedSignal", $ItemList.call("get_item_text", index - 2))
	if index % 4 == 3:
		$ItemList.unselect(index)
		emit_signal("valueSelectedSignal", $ItemList.call("get_item_text", index - 3))
