extends Node2D

signal refreshListSignal
signal messageSignal

var words
var value
var valueList = []
var curWord = ""

func _ready():
	words = $"/root/Data/Words"
	curWord = ""
	value = 0
	valueList.clear()
	$CurrentWord.text = curWord
	$NumWindow/NumText.text = str(value) + " / " + str(value / 2 + 1)

func textSelected(block):
	if words.call("getBlockNum", block) <= 0:
		return
	
	if not curWord.empty():
		words.call("insertBlock", curWord)
	
	words.call("deleteBlock", block)
	
	curWord = block
	
	refresh()

func valueSelected(block):
	if words.call("getBlockNum", block) <= 0:
		return
	
	words.call("deleteBlock", block)
	
	value += 1
	valueList.append(block)
	
	refresh()
	
func reset():
	if not curWord.empty():
		words.call("insertBlock", curWord)
		curWord = ""
	
	if not valueList.empty():
		while not valueList.empty():
			var block = valueList.pop_back()
			words.call("insertBlock", block)
		value = 0
	
	refresh()

func cutWord():
	if curWord.empty() or value / 2 <= 0:
		reset()
		return
	
	var blockList = words.call("cutWord", curWord, value / 2 + 1)
	var message = "成功分解为["
	for block in blockList:
		if block != blockList.back():
			message += block + ", "
		else:
			message += block
	message += "]"
	emit_signal("messageSignal", "分解成功!", message)
	
	words.call("insertFromList", blockList)
	
	curWord = ""
	value = 0
	valueList.clear()
	
	refresh()
	
func refresh():
	$NumWindow/NumText.text = str(value) + " / " + str(value / 2 + 1)
	$CurrentWord.text = curWord
	emit_signal("refreshListSignal", words.call("getBlocks"))
