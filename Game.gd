extends Node2D

var running_node = 0
var scene_gui
var scene_firstScene

func _ready():
	hide_all_nodes()
	
	scene_gui = $Gui
	scene_firstScene = $FirstScene
	
	set_connects()
	
	scene_gui.show()

func _process(delta):
	pass

#-connections-#

func set_startButton_connect():
	$Gui/Menu/MarginContainer/StartButton.connect("pressed", self, "toFirstScene")

func set_exitButton_connect():
	$Gui/Menu/MarginContainer4/ExitButton.connect("pressed", self, "game_exit_dialog")

func set_exitDialog_connect():
	$Gui/ExitDialog.connect("confirmed", self, "game_exit")

func set_connects():
	set_startButton_connect()
	set_exitButton_connect()
	set_exitDialog_connect()
	
#-functions-#
	
func toFirstScene():
	hide_all_nodes()
	$FirstScene.show()

func game_exit_dialog():
	$Gui/ExitDialog.popup()

func game_exit():
	get_tree().quit()
	
func hide_all_nodes():
	var nodes = self.get_children()
	for node in nodes:
		node.hide()	
