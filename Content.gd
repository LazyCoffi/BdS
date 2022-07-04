extends Node


# --- 游戏的核心系统节点,声明游戏内容所需节点 --- #

var date
var words
var event
var dialog
var saveName
var timerLock

signal returnMenuSignal
signal gameExitSignal

func _ready():
	date = $"/root/Data/Date"
	words = $"/root/Data/Words"
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
	
	$Scene/MainScene/MenuButton.connect("pressed", $Scene/DialogMenu, "showScene")
	$Scene/DialogMenu/ButtonRect/MenuButton.connect("pressed", self, "returnMainMenu")
	$Scene/DialogMenu/ButtonRect/ExitButton.connect("pressed", self, "exitGame")
	
	$Scene/BookScene.connect("nextDaySignal", self, "nextDay")
	$Scene/CollectScene.connect("nextDaySignal", self, "nextDay")
	$Scene/MarketScene.connect("nextDaySignal", self, "nextDay")

func eventConnect():
	$Scene/BookScene/Book/CreateScene/CreateBench.connect("messageSignal", Event, "pushMessageEvent")
	$Scene/BookScene/Book/SplitScene/SplitBench.connect("messageSignal", Event, "pushMessageEvent")
	$Scene/CollectScene/CollectList.connect("messageSignal", Event, "pushMessageEvent")
	$Scene/MarketScene/MarketList.connect("messageSignal", Event, "pushMessageEvent")
	$"/root/Data/Words".connect("messageSignal", Event, "pushMessageEvent")
	
	Event.connect("gameEndSignal", self, "gameEnd")
	
	$Scene/Dialog.connect("nextEventSignal", Event, "popEvent")
	Event.connect("messageSignal", dialog, "showDialog")
	Event.connect("eventEndSignal", dialog, "closeDialog")
	Event.connect("eventEndSignal", self, "unlockTimer")
	
	$EventTimer.connect("timeout", self, "tryPop")

func tryPop():
	if timerLock == 1:
		return
	
	if not Event.isEventQueueEmpty():
		timerLock = 1
		Event.popEvent()

func unlockTimer():
	timerLock = 0

func playCG():
	$OpeningCG.call("startCG")

func returnMainMenu():
	$Scene/MainScene.call("hideScene")
	$Scene/CollectScene.call("hideScene")
	$Scene/MarketScene.call("hideScene")
	$Scene/BookScene.call("hideScene")
	$Scene/Dialog.call("closeDialog")
	$Scene/TransitionScene.call("hideScene", "")
	$Scene/DialogMenu.call("hideScene")
	emit_signal("returnMenuSignal")

func exitGame():
	emit_signal("gameExitSignal")

func gameEnd(eventName):
	pass

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
	Event.initEvents()
	Event.prepareEvents()
	$EventTimer.start(0.5)
	saveName = $"/root/Data".call("newSave")
	$"/root/Data".call("saveData", saveName)
	$Scene/MainScene.call("showScene")

func loadGame(saveName_):
	Event.initEvents()
	Event.prepareEvents()
	$EventTimer.start(0.5)
	saveName = saveName_
	$"/root/Data".call("loadData", saveName)
	$Scene/MainScene.call("showScene")

func nextDay():
	$"/root/Data".call("saveData", saveName)
	$"/root/Data/Date".call("nextDay")
	MusicPlayer.soundPlay("Bell")
	Event.prepareEvents()
