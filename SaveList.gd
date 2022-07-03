extends Node2D

var saveList = []

signal loadGameSignal

func _ready():
	pass # Replace with function body.

func initList():
	saveList = parseScript("save/saveList.json")
	$ItemList.clear()
	$ItemList.add_item("存档名称")
	$ItemList.add_item("最后游玩时间")
	$ItemList.add_item("--")
	$ItemList.set_item_selectable(2, false)
	for saveInfo in saveList:
		$ItemList.add_item(saveInfo["saveName"])
		$ItemList.add_item(saveInfo["saveTime"])
		$ItemList.add_item("加载")
		

func parseScript(scriptPath):
	var file = File.new()
	var path = "res://scripts/" + scriptPath
	if not file.file_exists(path):
		print(scriptPath + "文件不存在!")
		return
	file.open(path, File.READ)
	return parse_json(file.get_as_text())

func loadSave(saveName):
	emit_signal("loadGameSignal", saveName)

func selected(index):
	if index % 3 == 2:
		loadSave($ItemList.get_item_text(index - 2))
		
