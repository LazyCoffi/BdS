extends Node


# 事件结构:
# {事件名, 事件类型, 发生年, 月, 日, 发生概率, 结果列表[事件函数[函数名，参数...]}

var date
var words

var curEventQueue = []
var eventList = []
var curVictoryEvents = {}
var victoryEventDict = {}

signal addBlockSignal			# 添加词块信号 (词块, 数量)
signal removeBlockSignal		# 删除词块信号 (词块, 数量)
signal addDictSignal			# 添加条目信号 (词块)
signal gameEndSignal			# 游戏结束信号
signal messageSignal			# 发送消息事件
signal eventEndSignal

func _ready():
	date = $"/root/Data/Date"
	words = $"/root/Data/Words"

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
	
	file.close()
	
	if not file.file_exists("res://scripts/events/victoryEvents.json"):
		print("victoryEvents文件不存在!")
		return
	file.open("res://scripts/events/victoryEvents.json", File.READ)
	
	victoryEventDict = parse_json(file.get_as_text())
	
	file.close()

func compDate(event):
	var day = date.call("getDay")
	var mouth = date.call("getMonth")
	var year = date.call("getYear")
	
	return day == event["occurDay"] and \
		   mouth == event["occurMonth"] and \
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

func pushMessageEvent(title, message):
	var event = {}
	event["eventName"] = title
	event["successMessage"] = ""
	event["failMessage"] = ""
	var funcList = {}
	funcList["checkFuncName"] = "trueTest"
	funcList["checkFuncParams"] = []
	funcList["successFuncName"] = "messageEvent"
	funcList["successFuncParams"] = [message]
	event["funcList"] = funcList
	curEventQueue.push_back(event)

func isEventQueueEmpty():
	return curEventQueue.empty()

func popEvent():
	if curEventQueue.empty():
		emit_signal("eventEndSignal")
		return
	
	var event = curEventQueue.pop_front()
	var eventName = event["eventName"]
	var successMessage = event["successMessage"] + "\n"
	var failMessage = event["failMessage"] + "\n"
	var funcNode = event["funcList"]
	if self.call(funcNode["checkFuncName"], funcNode["checkFuncParams"]):
		self.call(funcNode["successFuncName"], eventName, funcNode["successFuncParams"], successMessage)
	else:
		self.call(funcNode["failFuncName"], eventName, funcNode["failFuncParams"], failMessage)

## eventFunctions

func trueTest(params):
	return true
	
func blockTest(params):
	var block = params.pop_front()
	var requireNum = params.pop_front()
	if words.words[block] >= requireNum:
		return true
	else:
		return false

func randomTest(params):
	var prob = params.pop_front()
	if randn(0, 100) <= prob:
		return true
	else:
		return false

func checkVictorys(params):
	for vKey in curVictoryEvents.keys():
		var victoryEvent = curVictoryEvents[vKey]
		var flag = 1
		for key in victoryEvent.keys():
			if words.call("getBlockNum", key) < victoryEvent[key]:
				flag = 0
				break
		if flag == 1:
			emit_signal("gameWinSignal", vKey)
			break


func messageEvent(eventName, params, preMessage):
	var message = params.pop_front()
	emit_signal("messageSignal", eventName, preMessage + message)

func addBlockEvent(eventName, params, preMessage):
	var block = params.pop_front()
	var blockNum = params.pop_front()
	words.call("insertMultiBlocks", block, blockNum)
	var message = "获得" + str(blockNum) + "个" + block
	emit_signal("messageSignal", eventName, preMessage + message)

func setMissionEvent(eventName, params, preMessage):
	var missionWord = params.pop_front()
	var missionDate = params.pop_front()
	words.call("setMissionWord", missionWord)
	date.call("setMissionDate", missionDate)
	var message = "领主要求在 " + date.call("getMissionDateStr") + "前拿到一个 " + missionWord + " !"
	emit_signal("messageSignal", "新的要求", preMessage + message)

func removeBlockEvent(eventName, params, preMessage):
	var block = params.pop_front()
	var blockNum = params.pop_front()
	blockNum = min(blockNum, words.call("getBlockNum", block))
	words.call("deleteMultiBlocks", block, blockNum)
	var message = "失去" + str(blockNum) + "个" + block
	emit_signal("messageSignal", eventName, preMessage + message)

func addDictWordEvent(eventName, params, preMessage):
	var word = params.pop_front()
	var message = ""
	if words.call("hasWord", word):
		message = "获得单词" + word + "! 但好像你已经拥有了"
	else:
		words.call("addWord", word)
		if words.call("isImportantWord", word):
			message = "获得重要单词" + word
	
	emit_signal("messageSignal", eventName, message)
	
func addVictoryEvent(eventName, params, preMessage):
	var word = params.pop_front()
	curVictoryEvents[word] = victoryEventDict[word]
	var message = "胜利条件 " + word + " 已添加!"
	emit_signal("messageSignal", eventName, preMessage + message)

func gameoverEvent(eventName, params, preMessage):
	emit_signal("gameEndSignal", "loseGame")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
