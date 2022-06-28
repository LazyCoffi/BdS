extends Node2D

func _ready():
	$CreateBookmark.connect("pressed", self, "showCreateScene")
	$SplitBookmark.connect("pressed", self, "showSplitScene")
	$DictBookmark.connect("pressed", self, "showDictScene")
	
	$CreateBookmark.connect("mouse_entered", $CreateBookHoverBox, "show")
	$CreateBookmark.connect("mouse_exited", $CreateBookHoverBox, "hide")
	
	$SplitBookmark.connect("mouse_entered", $SplitBookHoverBox, "show")
	$SplitBookmark.connect("mouse_exited", $SplitBookHoverBox, "hide")
	
	$DictBookmark.connect("mouse_entered", $DictBookHoverBox, "show")
	$DictBookmark.connect("mouse_exited", $DictBookHoverBox, "hide")
	
	$ExitArrow.connect("mouse_entered", $ExitHoverBox, "show")
	$ExitArrow.connect("mouse_exited", $ExitHoverBox, "hide")
	
	hide()

func showScene():
	show()
	showCreateScene()

func showCreateScene():
	$Book/CreateScene.call("showScene")
	$Book/SplitScene.call("hideScene")
	$Book/DictScene.call("hideScene")
	

func showSplitScene():
	$Book/CreateScene.call("hideScene")
	$Book/SplitScene.call("showScene")
	$Book/DictScene.call("hideScene")

func showDictScene():
	$Book/CreateScene.call("hideScene")
	$Book/SplitScene.call("hideScene")
	$Book/DictScene.call("showScene")

func hideScene():
	hide()
