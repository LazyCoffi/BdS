extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	$DictBench/BlockButton.connect("pressed", $DictList, "fillBlockDict")
	$DictBench/WordButton.connect("pressed", $DictList, "fillDict")
	$DictBench/ImportantButton.connect("pressed", $DictList, "fillImportantDict")

func showScene():
	show()
	$DictList.call("fillBlockDict")

func hideScene():
	hide()




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
