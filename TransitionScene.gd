extends Node2D


func _ready():
	$TransistionBackground/AnimationPlayer.connect("animation_finished", self, "hideScene")
	hide()

func play():
	show()
	$TransistionBackground/AnimationPlayer.play("move")

func hideScene(AnimaName):
	hide()
