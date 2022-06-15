extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var date
var words
var collectList = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	initCollectList()

func initCollectList():
	var file = File.new()
	if not file.file_exists("res://scripts/collect/collectList.json"):
		print("collectList文件不存在!")
		return
	file.open("res://scripts/collect/collectList.json", File.READ)
	
	collectList = parse_json(file.get_as_text())
	
func getCollectList():
	return collectList.keys()
	
func collect(word):
	var n = collectList[word]
	while n > 0:
		words.call("insertBlock", word)
		n -= 1
