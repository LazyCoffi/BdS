extends Node


# --- 游戏的核心系统节点,声明游戏内容所需节点 --- #

var date
var words
var event
var dialog

func _ready():
	date = $"/root/Data/Date"
	words = $"/root/Data/Words"
	event = $System/Workflow/Event
	dialog = $Scene/Dialog
	
	initConnects()

func initConnects():
	eventConnect()
	$OpeningCG.connect("cgEndSignal", self, "startGame")
	
	$Scene/MainScene/BookArrow.connect("pressed", self, "showBookScene")
	$Scene/BookScene/ExitArrow.connect("pressed", self, "hideBookScene")
	
	$Scene/BookScene/Book/CreateScene/CreateBench.connect("messageSignal", $Scene/Dialog, "showDialog")
	$Scene/BookScene/Book/SplitScene/SplitBench.connect("messageSignal", $Scene/Dialog, "showDialog")

func eventConnect():
	date.connect("nextDaySignal", event, "prepareEvents")
	$Scene/Dialog.connect("nextEventSignal", event, "popEvent")
	event.connect("messageSignal", dialog, "showDialog")
	event.connect("eventEndSignal", dialog, "closeDialog")

func playCG():
	$OpeningCG.call("startCG")

func showBookScene():
	$Scene/MainScene.call("hideScene")
	$Scene/BookScene.call("showScene")

func hideBookScene():
	$Scene/BookScene.call("hideScene")
	$Scene/MainScene.call("showScene")

func startGame():
	date.call("setDate", 1789, 1, 1)
	event.call("prepareEvents")
	event.call("popEvent")
	$Scene/MainScene.call("showScene")
	
func nextDay():
	event.call("prepareEvents")
	event.call("popEvent")
