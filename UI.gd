extends TextureRect

func _ready():
	refresh()
	$"/root/Data/Money".connect("moneyChangedSignal", self, "refresh")

func refresh():
	$Date.text = $"/root/Data/Date".call("getDateStr")
	$MissionWord.text = $"/root/Data/Words".call("getMissionWord")
	$MissionDate.text = $"/root/Data/Date".call("getMissionDateStr")
	$Money.text = str($"/root/Data/Money".call("getMoney"))
