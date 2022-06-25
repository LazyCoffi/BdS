extends Node


# 事件结构:
# {事件名, 事件类型, 发生年, 月, 日, 发生概率, 结果列表[事件函数[函数名，参数...]}

var date
var words

var curEventQueue = []
var eventList = []

# TODO: 完善事件体系
# TODO: 定义各类信号
signal addBlockSignal			# 添加词块信号 (词块, 数量)
signal removeBlockSignal		# 删除词块信号 (词块, 数量)
signal addDictSignal			# 添加条目信号 (词块)
signal gameoverSignal			# 游戏结束信号
signal messageSignal			# 发送消息事件
signal eventEndSignal

func _ready():
	initEvents()

func randn(l, r):				# 返回[l, r]随机数
	randomize()
	return l + randi() % (r - l + 1)

func initEvents():
	var file = File.new()
	if not file.file_exists("res://scripts/events/eventList.json"):
		print("eventList文件不存在!")
		return
	file.open("res://scripts/events/eventList.json", File.READ)
	
	eventList = parse_json(file.get_as_text())

func compDate(event):
	var day = date.call("getDay")
	var mouth = date.call("getMouth")
	var year = date.call("getYear")
	
	return day == event["occurDay"] and \
		   mouth == event["occurMouth"] and \
		   year == event["occurYear"]

func prepareEvents():
	for event in eventList:
		if event["type"] == "random":
			var p = event["prob"]
			if randn(0,100) < p:
				curEventQueue.push_back(event)
		else:
			if compDate(event):
				curEventQueue.push_back(event)

func isEventQueueEmpty():
	return curEventQueue.empty()

func popEvent():
	if curEventQueue.empty():
		emit_signal("eventEndSignal")
		return
	
	var event = curEventQueue.pop_front()
	var eventName = event["eventName"]
	var funcNode = event["funcList"]
	if self.call(funcNode["checkFuncName"], funcNode["checkFuncParams"]):
		self.call(funcNode["successFuncName"], eventName, funcNode["successFuncParams"])
	else:
		self.call(funcNode["failFuncName"], eventName, funcNode["failFuncParams"])

## eventFunctions

func trueTest(params):
	return true
	
func BlockTest(params):
	var block = params.pop_front()
	var requireNum = params.pop_front()
	if words.words[block] >= requireNum:
		return true
	else:
		return false

func messageEvent(eventName, params):
	var message = params.pop_front()
	print(message)
	emit_signal("messageSignal", eventName, message)

func addBlockEvent(eventName, params):
	var block = params.pop_front()
	var blockNum = params.pop_front()
	words.call("insertMultiBlocks", block, blockNum)
	var message = "获得" + str(blockNum) + "个" + block
	emit_signal("messageSignal", eventName, message)
	
func removeBlockEvent(eventName, params):
	var block = params.pop_front()
	var blockNum = params.pop_front()
	blockNum = min(blockNum, words.call("getBlockNum", block))
	words.call("deleteMultiBlocks", block, blockNum)
	var message = "失去" + str(blockNum) + "个" + block
	emit_signal("messageSignal", eventName, message)

func addDictWordEvent(eventName, params):
	var word = params.pop_front()
	var message = ""
	if words.call("hasWord", word):
		message = "获得单词" + word + "! 但好像你已经拥有了"
	else:
		words.call("addWord", word)
		if words.call("isImportantWord", word):
			message = "获得重要单词" + word
	
	emit_signal("messageSignal", eventName, message)

func gameoverEvent(eventName, params):
	var gameoverMessage = params.pop_front()
	emit_signal("gameoverSignal", eventName, gameoverMessage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
