extends Node2D

var trigger

signal nextDaySignal
signal transitionSignal

func _ready():
	$CreateBookmark.connect("pressed", self, "showCreateScene")
	$SplitBookmark.connect("pressed", self, "showSplitScene")
	$DictBookmark.connect("pressed", self, "showDictScene")
	$TreeBookmark.connect("pressed", self, "showTreeScene")
	
	$CreateBookmark.connect("mouse_entered", $CreateBookHoverBox, "show")
	$CreateBookmark.connect("mouse_exited", $CreateBookHoverBox, "hide")
	
	$SplitBookmark.connect("mouse_entered", $SplitBookHoverBox, "show")
	$SplitBookmark.connect("mouse_exited", $SplitBookHoverBox, "hide")
	
	$DictBookmark.connect("mouse_entered", $DictBookHoverBox, "show")
	$DictBookmark.connect("mouse_exited", $DictBookHoverBox, "hide")
	
	$TreeBookmark.connect("mouse_entered", $TreeBookHoverBox, "show")
	$TreeBookmark.connect("mouse_exited", $TreeBookHoverBox, "hide")
	
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

func showCreateScene():
	$Book/CreateScene.call("showScene")
	$Book/SplitScene.call("hideScene")
	$Book/DictScene.call("hideScene")
	$Book/TreeScene.call("hideScene")
	
func showSplitScene():
	$Book/CreateScene.call("hideScene")
	$Book/SplitScene.call("showScene")
	$Book/DictScene.call("hideScene")
	$Book/TreeScene.call("hideScene")

func showDictScene():
	$Book/CreateScene.call("hideScene")
	$Book/SplitScene.call("hideScene")
	$Book/DictScene.call("showScene")
	$Book/TreeScene.call("hideScene")

func showTreeScene():
	$Book/CreateScene.call("hideScene")
	$Book/SplitScene.call("hideScene")
	$Book/DictScene.call("hideScene")
	$Book/TreeScene.call("showScene")

func hideScene():
	MusicPlayer.soundPlay("DoorClose")
	if trigger == 1:
		emit_signal("nextDaySignal")
	hide()
