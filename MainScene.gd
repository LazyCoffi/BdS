extends Node2D

signal transitionSignal

func _ready():
	hide()
	
	$CollectHoverBox.call("hide")
	$CollectArrow.connect("mouse_entered", $CollectHoverBox, "show")
	$CollectArrow.connect("mouse_exited", $CollectHoverBox, "hide")
	
	$BookHoverBox.call("hide")
	$BookArrow.connect("mouse_entered", $BookHoverBox, "show")
	$BookArrow.connect("mouse_exited", $BookHoverBox, "hide")
	
	$MarketHoverBox.call("hide")
	$MarketArrow.connect("mouse_entered", $MarketHoverBox, "show")
	$MarketArrow.connect("mouse_exited", $MarketHoverBox, "hide")
	
	$CatHoverBox.call("hide")
	$InvisiableButton.connect("mouse_entered", $CatHoverBox, "show")
	$InvisiableButton.connect("mouse_exited", $CatHoverBox, "hide")
	
	$InvisiableButton.connect("pressed", self, "sound")

func showScene():
	show()
	emit_signal("transitionSignal")
	MusicPlayer.play("MainScene")

func hideScene():
	$CollectHoverBox.call("hide")
	$BookHoverBox.call("hide")
	$MarketHoverBox.call("hide")
	$CatHoverBox.call("hide")
	hide()

func sound():
	MusicPlayer.soundPlay("Cat")
