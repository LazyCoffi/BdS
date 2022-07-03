extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getTimeStr():
	var time = OS.get_time()
	var date = OS.get_date()
	var timeStr = "%s-%s-%s %s:%s:%s" % [str(date["year"]), str(date["month"]), str(date["day"]), 
								   str(time["hour"]), str(time["minute"]), str(time["second"])]
	return timeStr

func newSave():
	var timeStr = getTimeStr()
	var json = parseScript("save/saveList.json")
	var index = json.size()
	var saveDict = {}
	var saveName = "Save" + str(index)
	saveDict["saveName"] = saveName
	saveDict["saveTime"] = timeStr
	json.append(saveDict)
	
	writeScript("save/saveList.json", json)
	
	return saveName

func saveData(saveName):
	var savePath = "save/" + saveName + ".json"
	var file = File.new()
	var timeStr = getTimeStr()
	var json = {}
	
	json["SaveName"] = saveName
	json["SaveTime"] = timeStr
	json["DateData"] = $Date.call("saveData")
	json["WordsData"] = $Words.call("saveData")
	json["MoneyData"] = $Money.call("saveData")
	
	writeScript(savePath, json)

func loadData(saveName):
	var savePath = "save/" + saveName + ".json"
	var json = parseScript(savePath)
	$Date.call("loadData", json["DateData"])
	$Words.call("loadData", json["WordsData"])
	$Money.call("loadData", json["MoneyData"])
	
func writeScript(scriptPath, json):
	var file = File.new()
	var path = "res://scripts/" + scriptPath
	file.open(path, File.WRITE)
	file.store_string(JSON.print(json))
	file.close()

func parseScript(scriptPath):
	var file = File.new()
	var path = "res://scripts/" + scriptPath
	if not file.file_exists(path):
		print(scriptPath + "文件不存在!")
		return
	file.open(path, File.READ)
	var jsonStr = file.get_as_text()
	file.close()
	return parse_json(jsonStr)	
