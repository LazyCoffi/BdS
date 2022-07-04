extends Node2D

var trigger

signal nextDaySignal
signal transitionSignal

func _ready():
	$CreateBookmark.connect("pressed", self, "showCreateScene")
	$SplitBookmark.connect("pressed", self, "showSplitScene")
	$DictBookmark.connect("pressed", self, "showDictScene")
	$TreeBookmark.connect("pressed", self, "showTreeScene")
	$VictoryBookmark.connect("pressed", self, "showVictoryScene")
	
	$CreateBookmark.connect("mouse_entered", $CreateBookHoverBox, "show")
	$CreateBookmark.connect("mouse_exited", $CreateBookHoverBox, "hide")
	
	$SplitBookmark.connect("mouse_entered", $SplitBookHoverBox, "show")
	$SplitBookmark.connect("mouse_exited", $SplitBookHoverBox, "hide")
	
	$DictBookmark.connect("mouse_entered", $DictBookHoverBox, "show")
	$DictBookmark.connect("mouse_exited", $DictBookHoverBox, "hide")
	
	$TreeBookmark.connect("mouse_entered", $TreeBookHoverBox, "show")
	$TreeBookmark.connect("mouse_exited", $TreeBookHoverBox, "hide")
	
	$VictoryBookmark.connect("mouse_entered", $VictoryBookHoverBox, "show")
	$VictoryBookmark.connect("mouse_exited", $VictoryBookHoverBox, "hide")
	
	$ExitArrow.connect("mouse_entered", $ExitHoverBox, "show")
	$ExitArrow.connect("mouse_exited", $ExitHoverBox, "hide")
	
	$Book/CreateScene/CreateBench.connect("setTriggerSignal", self, "setTrigger")
	$Book/SplitScene/SplitBench.connect("setTriggerSignal", self, "setTrigger")
	
	hide()

func showScene():
	show()
	MusicPlayer.play("BookScene")
	MusicPlayer.soundPlay("Door")
	emit_signal("transitionSignal")
	showCreateScene()
	trigger = 0

func setTrigger():
	trigger = 1

func hideAllScene():
	$Book/CreateScene.call("hideScene")
	$Book/SplitScene.call("hideScene")
	$Book/DictScene.call("hideScene")
	$Book/TreeScene.call("hideScene")
	$Book/VictoryScene.call("hideScene")

func showCreateScene():
	hideAllScene()
	$Book/CreateScene.call("showScene")
	
func showSplitScene():
	hideAllScene()
	$Book/SplitScene.call("showScene")

func showDictScene():
	hideAllScene()
	$Book/DictScene.call("showScene")

func showTreeScene():
	hideAllScene()
	$Book/TreeScene.call("showScene")

func showVictoryScene():
	hideAllScene()
	$Book/VictoryScene.call("showScene")
	
func hideScene():
	MusicPlayer.soundPlay("DoorClose")
	if trigger == 1:
		emit_signal("nextDaySignal")
	hide()
