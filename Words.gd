extends Node

var words = {}				# 存储现有词块数目
var dict = {}				# 玩家可用字典
var importantDict = {}		# 重要单词
var dictTree = {}

func _ready():
	initDict()
	initImportantDict()
	initDictTree()

func insertBlock(block):
	if words.has(block):
		words[block] += 1
	else:
		words[block] = 1
		
func insertMultiBlocks(block, n):
	while n > 0:
		insertBlock(block)
		n -= 1
		
func deleteBlock(block):
	if not words.has(block) or words[block] <= 0:
		return
	
	words[block] -= 1

func deleteMultiBlocks(block, n):
	while n > 0:
		deleteBlock(block)
		n -= 1

func addWord(word):
	# TODO: 重要词汇获得提示
	dict[word] = 1

func randn(l, r):			# 返回[l, r]随机数
	randomize()
	return l + randi() % (r - l + 1)

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
		
func getWords():
	var curWords = []
	for key in words.keys():
		curWords.append([key, words[key]])

func getBlockNum(block):
	if not words.has(block):
		return 0
	return words[block]

func getAllDict():
	return dict.keys()
		
func getCurDict():
	var curDict = []
	for key in words.keys():
		if words[key] > 0:
			curDict.append(key)

func getDictTreeByWord(word):
	return dictTree[word]
	
func hasWord(word):
	if not dict.has(word) or dict[word] == 0:
		return false
	return true

func getImportantDict():
	var importDict = []
	for key in words.keys():
		if importantDict.has(key):
			importDict.append(key)

	return importDict

func isImportantWord(word):
	if importantDict.has(word):
		return true
	return false

func initDict():
	var file = File.new()
	if not file.file_exists("res://scripts/dicts/dict.json"):
		print("dict文件不存在!")
		return
	file.open("res://scripts/dicts/dict.json", File.READ)
	
	var json = parse_json(file.get_as_text())
	for word in json:
		dict[word] = 0

func initImportantDict():
	var file = File.new()
	if not file.file_exists("res://scripts/dicts/importantDict.json"):
		print("importantDict文件不存在!")
		return
	file.open("res://scripts/dicts/importantDict.json", File.READ)
	
	var json = parse_json(file.get_as_text())
	for word in json:
		importantDict[word] = 0

func initDictTree():
	var file = File.new()
	if not file.file_exists("res://scripts/dicts/dictTree.json"):
		print("dictTree文件不存在!")
		return
	file.open("res://scripts/dicts/dictTree.json", File.READ)
	
	dictTree = parse_json(file.get_as_text())

func cutWordsOp(word, n):
	if n >= len(word):
		# TODO: n不能大于等于len(word)
		return []
	
	return cutWord(word, n / 2)

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
