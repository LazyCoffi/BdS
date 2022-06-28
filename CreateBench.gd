extends Node2D

signal refreshListSignal
signal messageSignal

var words
var curWord = ""
var curWordList = []

func _ready():
	words = $"/root/Data/Words"
	curWord = ""
	$CurrentWord.text = curWord
	curWordList.clear()

func textSelected(block):
	if words.call("getBlockNum", block) <= 0:
		return
	
	if (curWord + block).length() > 16:
		return
	
	words.call("deleteBlock", block)
	curWord += block
	curWordList.append(block)
	
	refresh()
	
func create():
	if curWord.empty():
		return
	
	if words.call("hasWord", curWord):
		words.call("insertBlock", curWord)
		var message = "成功合成[" + curWord + "]!" 
		emit_signal("messageSignal", "合成成功", message)
	else:
		words.call("insertFromList", curWordList)
		var message = "合成失败,不存在对应词条" 
		emit_signal("messageSignal", "合成失败", message)
	
	
	
	curWord = ""
	curWordList.clear()
	
	refresh()

func backspace():
	if not curWordList.empty():
		var block = curWordList.pop_back()
		curWord = curWord.left(curWord.length() - block.length())
		words.call("insertBlock", block)
		refresh()

func reset():
	for block in curWordList:
		words.call("insertBlock", block)
	
	curWordList.clear()
	curWord = ""
	
	refresh()

func refresh():
	$CurrentWord.text = curWord
	emit_signal("refreshListSignal", words.call("getBlocks"))
