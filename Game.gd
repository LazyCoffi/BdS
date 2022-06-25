extends Node

var mainMenu
var continueMenu
var settingMenu

signal startSignal

func _ready():
	mainMenu = $Interface/MainMenu
	continueMenu = $Interface/ContinueMenu
	settingMenu = $Interface/SettingMenu
		
	setConnects()	
	
	## temp test area
	test()	
	
func test():
	var node = $Content/System/Data/Words
	var blocks = node.call("getDictTreeByWord", "wood")
	for block in blocks:
		print(block)

#-connections-#

func setStartButtonConnect():
	var startButton = $Interface/MainMenu/Menu/StartContainer/StartButton
	if not startButton.is_connected("pressed", self, "toStartScene"):
		startButton.connect("pressed", self, "toStartScene")
		
func setContinueButtonConnect():
	var continueButton = $Interface/MainMenu/Menu/ContinueContainer/ContinueButtonButton
	if not continueButton.is_connected("pressed", self, "toContinueScene"):
		continueButton.connect("pressed", self, "toContinueScene")

func setSettingButtonConnect():
	var settingButton = $Interface/MainMenu/Menu/SettingContainer/SettingButton
	if not settingButton.is_connected("pressed", self, "toSettingScene"):
		settingButton.connect("pressed", self, "toSettingScene")

func setExitButtonConnect():
	var exitButton = $Interface/MainMenu/Menu/ExitContainer/ExitButton
	if not exitButton.is_connected("pressed", self, "gameExitDialog"):
		exitButton.connect("pressed", self, "gameExitDialog")

func setExitDialogConnect():
	var exitDialog = $Interface/ExitDialog
	if not exitDialog.is_connected("confirmed", self, "gameExit"):
		exitDialog.connect("confirmed", self, "gameExit")

func setConnects():
	setStartButtonConnect()
	setExitButtonConnect()
	setExitDialogConnect()
	
	connect("startSignal", $Content, "startGame")
	
#-functions-#
	
func toStartScene():
	emit_signal("startSignal")
	hideAllNodes()

func toContinueMenu():
	hideAllNodes()
	continueMenu.show()

func toSettingMenu():
	hideAllNodes()
	settingMenu.show()

func gameExitDialog():
	$Interface/ExitDialog.popup()

func gameExit():
	get_tree().quit()

func hideAllNodes():
	mainMenu.hide()
	continueMenu.hide()
	settingMenu.hide()
