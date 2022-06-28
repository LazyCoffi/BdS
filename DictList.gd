extends Node2D

var words

func _ready():
	words = $"/root/Data/Words"	

func fillBlockDict():
	var list = words.call("getBlocks")
	$ItemList.clear()
	$ItemList.add_item("现有词块")
	$ItemList.add_item("词块数量")
	for listNode in list:
		$ItemList.add_item(listNode[0])
		$ItemList.add_item(str(listNode[1]))

func fillDict():
	var list = words.call("getCurDict")
	$ItemList.clear()
	$ItemList.add_item("现有词条")
	$ItemList.add_item("现有词条")
	for listNode in list:
		$ItemList.add_item(listNode)

func fillImportantDict():
	var list = words.call("getImportantDict")
	$ItemList.clear()
	$ItemList.add_item("重要词条")
	$ItemList.add_item("重要词条")
	for listNode in list:
		$ItemList.add_item(listNode)
