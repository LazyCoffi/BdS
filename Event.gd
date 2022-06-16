extends Node


# 事件结构:
# {事件名，事件类型，发生年，月，日, 发生概率, 结果列表[事件函数[函数名，参数...]}

var date

var curEventQueue = []
var eventList = []

# TODO: 完善事件体系
# TODO: 定义各类信号
signal addBlockSignal			# 添加词块信号 (词块, 数量)
signal removeBlockSignal		# 删除词块信号 (词块, 数量)
signal addDictSignal			# 添加条目信号 (词块)
signal gameoverSignal			# 游戏结束信号


func _ready():
	pass # Replace with function body.

func randn(l, r):			# 返回[l, r]随机数
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
				eventList.push_back(event)
		else:
			if compDate(event):
				eventList.push_back(event)

func isEventListEmpty():
	return eventList.empty()

func popEvent():
	var event = eventList.pop_front()
	var eventName = event["name"]
	var funcList = event["funcList"]
	for funcNode in funcList:
		var funcName = funcNode.pop_front()
		emit_signal(funcName, funcNode)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
