extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	var node = get_node("/GameContent/GameSystem/GameData/Date")
	node.nextDay();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
