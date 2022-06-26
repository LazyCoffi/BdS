extends Node2D

signal textSeletedSignal

func _ready():
	$ItemList.add_item("Gouba")
	$ItemList.add_item("10")
	$ItemList.add_item("Gouba")
	$ItemList.add_item("20")
	$ItemList.connect("item_selected", self, "seleted")

func fillList(list):
	$ItemList.clear()
	for listNode in list:
		$ItemList.add_item(listNode[0])
		$ItemList.add_item(listNode[1])

func seleted(index):
	if index % 2 == 0:
		emit_signal("textSeletedSignal", $ItemList.call("get_item_text"))
