extends Node

var words = {}				# 存储现有词块数目
var dict = {}				# 玩家可用字典
var importantDict = {}		# 重要单词

func _ready():
	pass 

func insertBlock(block):
	if words.has(block):
		words[block] += 1
	else:
		words[block] = 1
		
func deleteBlock(block):
	words[block] -= 1
	
func addWord(word):
	if (importantDict.has(word)):
		dict[word] = 2
	else:
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

func getAllDict():
	return dict.keys()
		
func getCurDict():
	var curDict = []
	for key in words.keys():
		if words[key] > 0:
			curDict.append(key)
			
func getImportantDict():
	var importDict = []
	for key in words.keys():
		if words[key] == 2:
			importDict.append(key)

func initDict():
	var file = File.new()
	if not file.file_exists("res://scripts/dicts/dict."):
		print("文件不存在!")
		return
	file.open("res://scripts/dicts", File.READ)
	
	var json = parse_json(file)
	for word in json:
		words[word] = 0


	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
