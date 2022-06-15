extends Node


# --- 游戏的核心系统节点,声明游戏内容所需节点 --- #

var date
var words

func _ready():
	date = $Data/Date
	words = $Data/Words
	
	$Interact/Collect.date = date
	$Interact/Collect.words = words
