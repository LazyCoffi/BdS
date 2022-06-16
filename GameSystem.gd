extends Node


# --- 游戏的核心系统节点,声明游戏内容所需节点 --- #

var date
var words

func initNodes():
	$Interact/Collect.date = date
	$Interact/Collect.words = words
	
	$Workflow/Event.date = date

func initConnects():
	var event = $Workflow/Event
	date.connect("nextDaySignal", event, "prepareEvents")

func _ready():
	date = $Data/Date
	words = $Data/Words
	
	initNodes()
	initConnects()

	
