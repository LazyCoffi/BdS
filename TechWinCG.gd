extends Node2D

var gameScript = []
var colorDict = {
					"chocolate" : Color.chocolate,
					"orange" : Color.orange,
					"olive" : Color.olive
				}

signal nextLineSignal
signal cgEndSignal
signal transitionSignal

func _ready():
	hide()
	$ChattingBox/InvisiableButton.connect("pressed", self, "nextLine")

func startCG():
	initScript()
	show()
	MusicPlayer.play("CgScene")
	emit_signal("transitionSignal")
	nextLine()
	$Background/BackgroundAnimation.play("moving")

func initScript():
	var file = File.new()
	if not file.file_exists("res://scripts/script/techend_script.json"):
		print("script文件不存在!")
		return
	file.open("res://scripts/script/techend_script.json", File.READ)
	
	gameScript = parse_json(file.get_as_text())

func endCG():
	hide()

func nextLine():
	if gameScript.empty():
		endCG()
		emit_signal("cgEndSignal")
		return
	
	var line = gameScript.pop_front()
	var color = line["color"]
	var curText = line["text"]
	
	$ChattingBox/TextBox.clear()
	$ChattingBox/TextBox.push_color(colorDict[color])
	$ChattingBox/TextBox.append_bbcode(curText)
	$ChattingBox/TextBox.pop()
