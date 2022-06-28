extends Node2D

var words

func _ready():
	words = $"/root/Data/Words"	

func fillBlockDict():
	var list = words.call("getBlocks")
	$ItemList.clear()
	for listNode in list:
		$ItemList.add_item(listNode[0])
		$ItemList.add_item(str(listNode[1]))

func fillDict():
	var list = words.call("getCurDict")
	$ItemList.clear()
	for listNode in list:
		$ItemList.add_item(listNode)

func fillImportantDict():
	var list = words.call("getImportantDict")
	$ItemList.clear()
	for listNode in list:
		$ItemList.add_item(listNode)
