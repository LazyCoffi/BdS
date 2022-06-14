extends Node

var mainMenu
var continueMenu
var settingMenu

func _ready():
	mainMenu = $GameInterface/MainMenu
	continueMenu = $GameInterface/ContinueMenu
	settingMenu = $GameInterface/SettingMenu
	
	setConnects()	
	toMainMenu()

func _process(delta):
	pass

#-connections-#

func setStartButtonConnect():
	var startButton = $GameInterface/MainMenu/Menu/StartContainer/StartButton
	if not startButton.is_connected("pressed", self, "toStartScene"):
		startButton.connect("pressed", self, "toStartScene")
		
func setContinueButtonConnect():
	var continueButton = $GameInterface/MainMenu/Menu/ContinueContainer/ContinueButtonButton
	if not continueButton.is_connected("pressed", self, "toContinueScene"):
		continueButton.connect("pressed", self, "toContinueScene")

func setSettingButtonConnect():
	var settingButton = $GameInterface/MainMenu/Menu/SettingContainer/SettingButton
	if not settingButton.is_connected("pressed", self, "toSettingScene"):
		settingButton.connect("pressed", self, "toSettingScene")

func setExitButtonConnect():
	var exitButton = $GameInterface/MainMenu/Menu/ExitContainer/ExitButton
	if not exitButton.is_connected("pressed", self, "gameExitDialog"):
		exitButton.connect("pressed", self, "gameExitDialog")

func setExitDialogConnect():
	var exitDialog = $GameInterface/ExitDialog
	if not exitDialog.is_connected("confirmed", self, "gameExit"):
		exitDialog.connect("confirmed", self, "gameExit")

func setConnects():
	setStartButtonConnect()
	setExitButtonConnect()
	setExitDialogConnect()
	
#-functions-#
	
func toMainMenu():
	hideAllNodes()
	mainMenu.show()

func toContinueMenu():
	hideAllNodes()
	continueMenu.show()

func toSettingMenu():
	hideAllNodes()
	settingMenu.show()

func gameExitDialog():
	$GameInterface/ExitDialog.popup()

func gameExit():
	get_tree().quit()
	
func hideAllNodes():
	mainMenu.hide()
	continueMenu.hide()
	settingMenu.hide()
