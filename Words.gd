extends Node

var words = {}				# 存储现有词块数目
var dict = {}				# 玩家可用字典
var importantDict = {}		# 重要单词
var resourceDict = {}
var dictTree = {}
var isUnlocked = {}
var missionWord

signal messageSignal

func _ready():
	initDict()
	initImportantDict()
	initResourceDict()
	initDictTree()
	
	missionWord = ""

func setMissionWord(word):
	missionWord = word

func getMissionWord():
	return missionWord

func loadData(data):
	words = data["words"]
	dict = data["dict"]
	importantDict = data["importantDict"]
	resourceDict = data["resourceDict"]
	dictTree = data["dictTree"]

func saveData():
	var data = {}
	data["words"] = words
	data["dict"] = dict
	data["importantDict"] = importantDict
	data["resourceDict"] = resourceDict
	data["dictTree"] = dictTree
	
	return data

func insertBlock(block):
	if words.has(block):
		words[block] += 1
	else:
		words[block] = 1
	
	if dictTree.has(block) and not isUnlocked.has(block):
		isUnlocked[block] = 0
		unlockDictTree(block)

func insertFromList(list):
	for block in list:
		insertBlock(block)

func insertMultiBlocks(block, n):
	while n > 0:
		insertBlock(block)
		n -= 1

func addWord(word):
	if not dict.has(word):
		return
	
	if dict[word] == 0 and importantDict.has(word):
		var message = "获得重要单词 " + word + " !"
		emit_signal("messageSignal", "解锁重要单词", message)
	
	dict[word] = 1
		
func deleteBlock(block):
	if not words.has(block) or words[block] <= 0:
		return
	
	words[block] -= 1

func deleteFromList(list):
	for block in list:
		deleteBlock(block)

func deleteMultiBlocks(block, n):
	while n > 0:
		deleteBlock(block)
		n -= 1

func unlockDictTree(word):
	var unlockList = dictTree[word]
	var message = "通过获得 " + word + " 解锁以下单词["
	for unlockWord in unlockList:
		if unlockWord == unlockList.back():
			message += unlockWord
		else:
			message += unlockWord + ", "
		addWord(unlockWord)

	message += "]"
	emit_signal("messageSignal", "解锁单词", message)

func getBlockNum(block):
	if not words.has(block):
		return 0
	return words[block]

func getBlocks():
	var curWords = []
	for key in words.keys():
		if words[key] > 0:
			curWords.append([key, words[key]])
	return curWords

func getAllDict():
	return dict.keys()
		
func getCurDict():
	var curDict = []
	for key in dict.keys():
		if dict.has(key) and dict[key] == 1:
			curDict.append(key)
	
	return curDict

func getDictTreeByWord(word):
	return dictTree[word]

func getImportantDict():
	var importDict = []
	for key in dict.keys():
		if dict[key] > 0 and importantDict.has(key):
			importDict.append(key)

	return importDict

func getTreeDict():
	return dictTree

func getUnlockDict():
	return isUnlocked

func getResourceDict():
	return resourceDict

func addResource(resource, resourceNum):
	if not resourceDict.has(resource):
		resourceDict[resource] = resourceNum


func hasWord(word):
	if not dict.has(word) or dict[word] == 0:
		return false
	return true

func isImportantWord(word):
	if importantDict.has(word):
		return true
	return false


func initDict():
	var json = parseScript("dicts/dict.json")
	for word in json:
		dict[word] = 0
	addWord("water")
	addWord("stone")
	addWord("wood")

func initImportantDict():
	var json = parseScript("dicts/importantDict.json")
	for word in json:
		importantDict[word] = 0

func initResourceDict():
	resourceDict = parseScript("collect/resourceList.json")
	
func initDictTree():
	dictTree = parseScript("dicts/dictTree.json")
	isUnlocked["Root"] = 1


func randn(a, b):			# 返回[l, r]随机数
	randomize()
	return randi() % (b - a + 1) + a

func cutWord(word, n):
	n = n - 1
	var blocks = []
	var siz = len(word)
	var l = 0
	var r = siz - n
	while n > 0:
		var mid = randn(l, r - 1)
		blocks.append(word.substr(l, mid - l + 1))
		n -= 1
		r = siz - n
		l = mid + 1
	
	blocks.append(word.substr(l, siz - l + 1))
	
	return blocks

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

func randomUnlockNormalDict():
	var wordArr = []
	for word in dict:
		if dict[word] != 1 and not importantDict.has(word):
			wordArr.append(word)
	
	var p = randn(0, len(wordArr) - 1)
	dict[wordArr[p]] = 1	
	return wordArr[p]

func randomUnlockImportantDict():
	var wordArr = []
	for word in dict:
		if dict[word] != 1 and importantDict.has(word):
			wordArr.append(word)
	
	var p = randn(0, len(wordArr) - 1)	
	dict[wordArr[p]] = 1
	return wordArr[p]

func generateNewDict(n):			# 使用n个词块添加一个条目
	if n < 4:
		return ""
	
	# TODO: dict已全部解锁时操作,重要条目获得提示
		
	var p = 5 + 2 * (n - 4)
	var q = randn(0, 100)
	if q < p:
		return randomUnlockNormalDict()
	else:
		return randomUnlockImportantDict()
