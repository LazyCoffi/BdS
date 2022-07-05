extends Node

var money
var priceDict = {}

signal moneyChangedSignal

func _ready():
	money = 0

func loadData(data):
	money = data["money"]
	priceDict = data["priceDict"]

func saveData():
	var data = {}
	data["money"] = money
	data["priceDict"] = priceDict
	
	return data

func setMoney(value):
	money = value

func getMoney():
	return money
	
func addMoney(value):
	money += value
	emit_signal("moneyChangedSignal")

func subMoney(value):
	money = money - value
	emit_signal("moneyChangedSignal")
	
func addRandomMoney(a, b):
	addMoney(randn(a, b))
	emit_signal("moneyChangedSignal")

func subRandomMoney(a, b):
	subMoney(randn(a, b))
	emit_signal("moneyChangedSignal")
	
func randn(a, b):
	randomize()
	return randi() % int(b - a + 1) + int(a)

func sellBlock(block):
	addMoney(priceDict[block])

func initMarketList():
	priceDict = parseScript("market/priceList.json")
	
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
