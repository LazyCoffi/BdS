extends Node

var totalDays 		# 游戏进行的总天数
var year				# 游戏当前年份
var mouth 			# 游戏当前月份
var day				# 游戏当前日期

func _ready():
	totalDays = 1;
	mouth = 1;
	day = 1;
	
func nextDay(): 			# 下一天
	totalDays += 1
	if day == 30:
		if mouth == 12:
			mouth = 1
			year += 1
		else:
			mouth += 1
		day = 1
	else:
		day += 1

func timePastByDay(n):		# 时间流逝n天
	if n <= 0:
		return
		
	while n > 0:
		nextDay()
		n -= 1
