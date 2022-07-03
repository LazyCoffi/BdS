extends Node

var mainMenu
var continueMenu
var settingMenu

signal startSignal

func _ready():
	toMainMenu()
	$Interface/MainMenu/StartButton.connect("pressed", self, "startGame")
	$Interface/MainMenu/SaveButton.connect("pressed", self, "toSaveMenu")
	$Interface/MainMenu/ExitButton.connect("pressed", self, "gameExit")
	$Interface/SaveMenu/ExitArrow.connect("pressed", self, "toMainMenu")
	$Interface/SaveMenu/SaveList.connect("loadGameSignal", self, "loadGame")
	
#-functions-#
	
func startGame():
	hideAllNodes()
	$Content.call("playCG")

func loadGame(saveName):
	hideAllNodes()
	$Content.call("loadGame", saveName)

func toMainMenu():
	hideAllNodes()
	$Interface/MainMenu.call("showScene")

func toSaveMenu():
	hideAllNodes()
	$Interface/SaveMenu.call("showScene")

func gameExitDialog():
	$Interface/ExitDialog.popup()

func gameExit():
	get_tree().quit()

func hideAllNodes():
	$Interface/MainMenu.call("hideScene")
	$Interface/SaveMenu.call("hideScene")
