extends Node

onready var player = $MusicPlayer
onready var soundPlayer = $SoundPlayer
var musicDict = {}

func _ready():
	musicDict = parseScript("music/musicList.json")

func getResource(musicName):
	return load("res://asserts/audio/" + musicDict[musicName])

func play(musicName):
	player.stop()
	var music = getResource(musicName)
	player.stream = music
	player.play()

func soundPlay(musicName):
	var sound = getResource(musicName)
	sound.loop = false
	soundPlayer.stream = sound
	soundPlayer.play()

func stop(musicName):
	player.stop()

func parseScript(scriptPath):
	var file = File.new()
	var path = "res://scripts/" + scriptPath
	if not file.file_exists(path):
		print(scriptPath + "文件不存在!")
		return
	file.open(path, File.READ)
	var jsonStr = file.get_as_text()
	file.close()
	return parse_json(jsonStr)	
