extends Node2D

var money
var words
var listState
var curList = []
var priceDict = {}

signal messageSignal
signal setTriggerSignal

func _ready():
	money = $"/root/Data/Money"
	words = $"/root/Data/Words"
	$"/root/Data/Date".connect("nextDaySignal", self, "fillBuyList")
	initMarketList()
	setBuyList()

func initList():
	fillBuyList()
	listState = 0

func setBuyList():
	var list = priceDict.keys()
	
	if $"/root/Data/Date".call("getTotalDays") % 7 == 1:
		list.shuffle()
		curList = list.slice(0, 7)

func sellBlock(block):
	var value = priceDict[block]
	var message = "已出售 " + block + " ,获得 " + str(value) + " 硬币"
	emit_signal("messageSignal", "出售物品", message)
	emit_signal("setTriggerSignal")
	money.call("addMoney", value)
	words.call("deleteBlock", block)
	
	refresh()

func buyBlock(block):
	var value = priceDict[block]
	if value > money.call("getMoney"):
		var message = "这个好像买不起"
		emit_signal("messageSignal", "购买物品", message)
	else:
		words.call("addWord", block)
		words.call("insertBlock", block)
		money.call("subMoney", value)
		var message = "用 " + str(value) + " 硬币购买了一个 " + block
		emit_signal("messageSignal", "购买物品", message)
		emit_signal("setTriggerSignal")
	
	refresh()

func fillBuyList():
	listState = 0
	
	$ItemList.clear()
	
	$ItemList.add_item("商品名称")
	$ItemList.add_item("商品价格")
	$ItemList.add_item("--")
	$ItemList.set_item_selectable(2, false)
	
	for key in curList:
		$ItemList.add_item(key)
		$ItemList.add_item(str(priceDict[key]))
		$ItemList.add_item("购买")

func fillSellList():
	listState = 1
	
	$ItemList.clear()
	
	$ItemList.add_item("物品名称")
	$ItemList.add_item("物品价格")
	$ItemList.add_item("--")
	$ItemList.set_item_selectable(2, false)
	
	var list = words.call("getBlocks")
	
	for listNode in list:
		var block = listNode[0]
		if not priceDict.has(block):
			continue
		$ItemList.add_item(block)
		$ItemList.add_item(str(priceDict[block]))
		$ItemList.add_item("出售")

func selected(index):
	var block = $ItemList.get_item_text(index - 2) 
	if index % 3 == 2:
		if listState == 0:
			buyBlock(block)
		elif listState == 1:
			sellBlock(block)
		
func refresh():
	if listState == 0:
		fillBuyList()
	elif listState == 1:
		fillSellList()

func initMarketList():
	priceDict = parseScript("market/priceList.json")
	
func parseScript(scriptPath):
	var file = File.new()
	var path = "res://scripts/" + scriptPath
	if not file.file_exists(path):
		print(scriptPath + "文件不存在!")
		return
	file.open(path, File.READ)
	return parse_json(file.get_as_text())
