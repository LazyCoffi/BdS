extends Node2D

signal refreshListSignal
signal createSuccessSignal
signal createFailSignal

var words
var curWord
var curWordList = []

func _ready():
	curWord = ""
	pass # Replace with function body.

func onSelected(block):
	words.call("deleteBlock", block)
	emit_signal("refreshListSignal")
	curWord += block
	curWordList.append(block)

func createWord():
	if words.call("hasWord", curWord):
		emit_signal("createSuccessSignal")
		words.call("insertWord", curWord)
		emit_signal("refreshListSignal")
	else:
		emit_signal("createFailSignal")
		words.call("insertFromList", curWordList)
		curWord = ""
		curWordList.clear()

func backspace():
	if not curWordList.empty():
		var block = curWordList.pop_back()
		curWord = curWord.left(curWord.size() - block.size())
	
