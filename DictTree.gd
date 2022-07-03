extends Tree

var dictTree = {}
var isUnlocked = {}
var root

func _ready():
	dictTree = $"/root/Data/Words".call("getTreeDict")
	isUnlocked = $"/root/Data/Words".call("getUnlockDict")
	fillTree()
	
func fillTree():
	clear()
	root = create_item()
	root.set_text(0, "Root")
	dfsCreate(root)

func dfsCreate(u):
	var curWord = u.get_text(0)
	var wordList = dictTree[curWord]
	for word in wordList:
		var v = create_item(u)
		v.set_text(0, word)
		if dictTree.has(word) and isUnlocked.has(word):
			dfsCreate(v)
	
	
