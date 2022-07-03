extends Node


# --- 游戏的核心系统节点,声明游戏内容所需节点 --- #

var date
var words
var event
var dialog
var saveName
var timerLock

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
	
	$Scene/MainScene/CollectArrow.connect("pressed", self, "showCollectScene")
	$Scene/CollectScene/ExitArrow.connect("pressed", self, "hideCollectScene")
	
	$Scene/MainScene/MarketArrow.connect("pressed", self, "showMarketScene")
	$Scene/MarketScene/ExitArrow.connect("pressed", self, "hideMarketScene")
	
	$Scene/BookScene.connect("transitionSignal", $Scene/TransitionScene, "play")
	$Scene/CollectScene.connect("transitionSignal", $Scene/TransitionScene, "play")
	$Scene/MarketScene.connect("transitionSignal", $Scene/TransitionScene, "play")
	$OpeningCG.connect("transitionSignal", $Scene/TransitionScene, "play")
	$Scene/MainScene.connect("transitionSignal", $Scene/TransitionScene, "play")
	
	$Scene/BookScene.connect("nextDaySignal", self, "nextDay")
	$Scene/CollectScene.connect("nextDaySignal", self, "nextDay")
	$Scene/MarketScene.connect("nextDaySignal", self, "nextDay")

func eventConnect():
	$Scene/BookScene/Book/CreateScene/CreateBench.connect("messageSignal", $System/Workflow/Event, "pushMessageEvent")
	$Scene/BookScene/Book/SplitScene/SplitBench.connect("messageSignal", $System/Workflow/Event, "pushMessageEvent")
	$Scene/CollectScene/CollectList.connect("messageSignal", $System/Workflow/Event, "pushMessageEvent")
	$Scene/MarketScene/MarketList.connect("messageSignal", $System/Workflow/Event, "pushMessageEvent")
	$"/root/Data/Words".connect("messageSignal", $System/Workflow/Event, "pushMessageEvent")
	
	$Scene/Dialog.connect("nextEventSignal", event, "popEvent")
	event.connect("messageSignal", dialog, "showDialog")
	event.connect("eventEndSignal", dialog, "closeDialog")
	event.connect("eventEndSignal", self, "unlockTimer")
	
	$System/EventTimer.connect("timeout", self, "tryPop")

func tryPop():
	if timerLock == 1:
		return
	
	if not event.call("isEventQueueEmpty"):
		timerLock = 1
		event.call("popEvent")

func unlockTimer():
	timerLock = 0

func playCG():
	$OpeningCG.call("startCG")

func showBookScene():
	$Scene/MainScene.call("hideScene")
	$Scene/BookScene.call("showScene")

func hideBookScene():
	$Scene/BookScene.call("hideScene")
	$Scene/MainScene.call("showScene")

func showCollectScene():
	$Scene/MainScene.call("hideScene")
	$Scene/CollectScene.call("showScene")

func hideCollectScene():
	$Scene/CollectScene.call("hideScene")
	$Scene/MainScene.call("showScene")

func showMarketScene():
	$Scene/MainScene.call("hideScene")
	$Scene/MarketScene.call("showScene")

func hideMarketScene():
	$Scene/MarketScene.call("hideScene")
	$Scene/MainScene.call("showScene")

func startGame():
	date.call("setDate", 1789, 1, 1)
	event.call("prepareEvents")
	$System/EventTimer.start(0.5)
	saveName = $"/root/Data".call("newSave")
	$"/root/Data".call("saveData", saveName)
	$Scene/MainScene.call("showScene")

func loadGame(saveName_):
	event.call("prepareEvents")
	$System/EventTimer.start(1)
	saveName = saveName_
	$"/root/Data".call("loadData", saveName)
	$Scene/MainScene.call("showScene")

func nextDay():
	$"/root/Data".call("saveData", saveName)
	$"/root/Data/Date".call("nextDay")
	MusicPlayer.soundPlay("Bell")
	event.call("prepareEvents")
