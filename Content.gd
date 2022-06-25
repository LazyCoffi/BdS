extends Node


# --- 游戏的核心系统节点,声明游戏内容所需节点 --- #

var date
var words
var event
var dialog

func initNodes():
	$System/Interact/Collect.date = date
	$System/Interact/Collect.words = words
	$System/Workflow/Event.date = date
	$System/Workflow/Event.words = words

func initConnects():
	
	date.connect("nextDaySignal", event, "prepareEvents")
	$Scene/Dialog.connect("nextEventSignal", event, "popEvent")
	event.connect("messageSignal", dialog, "showDialog")
	event.connect("eventEndSignal", dialog, "closeDialog")
	

func _ready():
	date = $System/Data/Date
	words = $System/Data/Words
	event = $System/Workflow/Event
	dialog = $Scene/Dialog
	
	initNodes()
	initConnects()

func startGame():
	date.call("setDate", 1789, 1, 1)
	event.call("prepareEvents")
	event.call("popEvent")
	
	# TODO:
	$Scene/FirstScene.call("showScene")
