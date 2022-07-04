extends TextureRect

func _ready():
	refresh()

func refresh():
	$Date.text = $"/root/Data/Date".call("getDateStr")
	$MissionWord.text = $"/root/Data/Words".call("getMissionWord")
	$MissionDate.text = $"/root/Data/Date".call("getMissionDateStr")
	$Money.text = str($"/root/Data/Money".call("getMoney"))
