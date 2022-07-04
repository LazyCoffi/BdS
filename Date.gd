extends Node

var totalDays 		# 游戏进行的总天数
var year				# 游戏当前年份
var month 			# 游戏当前月份
var day				# 游戏当前日期
var missionDate = {}

func _ready():
	totalDays = 1;
	month = 1;
	day = 1;
	missionDate["year"] = 1
	missionDate["month"] = 1
	missionDate["day"] = 1
	
func loadData(data):
	totalDays = data["totalDays"]
	year = data["year"]
	month = data["month"]
	day = data["day"]
	missionDate = data["missionDate"]

func saveData():
	var data = {}
	data["totalDays"] = totalDays
	data["year"] = year
	data["month"] = month
	data["day"] = day
	data["missionDate"] = missionDate
	return data
	
func nextDay(): 			# 下一天
	totalDays += 1
	if day == 30:
		if month == 12:
			month = 1
			year += 1
		else:
			month += 1
		day = 1
	else:
		day += 1

func timePastByDay(n):		# 时间流逝n天
	if n <= 0:
		return
		
	while n > 0:
		nextDay()
		n -= 1

func getYear():
	return year

func getMonth():
	return month

func getDay():
	return day

func setMissionDate(year_, month_, day_):
	missionDate["year"] = year_
	missionDate["month"] = month_
	missionDate["day"] = day_

func getMissionDate():
	return missionDate

func getMissionDateStr():
	return str(missionDate["year"]) + "-" + str(missionDate["month"]) + "-" + str(missionDate["day"])

func getDateStr():
	return str(year) + "-" + str(month) + "-" + str(day)

func setDate(_year, _month, _day):
	year = _year
	month = _month
	day = _day
