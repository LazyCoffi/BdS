# 事件

最为复杂的脚本,控制整个游戏流程

为一个列表,其中包含一系列字典,每个字典代表一个事件

字典中每个参数意义如下

- eventName:事件名称,会成为弹出事件窗的标题
- type:分为static与random,分别为固定事件和随机事件,前者在固定日期每天开始时发生,后者按概率随机在某天开始时发生
- prob:static设为0,random则设置发生概率,范围为0~100
- occurDay,Month,Year:发生的年月日,设定从1789年开始,每月固定30天
- funcList:函数列表,分为判断函数,成功执行函数,失败执行函数
  - checkFuncName:用于判断的函数名,若判断成功则执行 成功执行函数, 否则执行 失败执行函数
    - trueTest:恒为真函数,一定返回true
    - blockTest:给定参数[block, requireNum],若玩家拥有requireNum个block,则返回true,否则返回false
  -  checkFuncParams:传给checkFunc的参数,以列表形式传入
  - successFuncName:成功执行函数名,判断成功则被执行
    - messageEvent:给定参数[message],弹窗弹出标题为eventName,内容为message的弹窗
    - addBlockEvent:给定参数[block,blockNum],给玩家添加blockNum个block
    - setMissionEvent:给定参数[word, {"year": year, "month": month, "day": day}],分别为一个字符串和字典,设置期限在year-month-day的任务word
    - removeBlockEvent:给定参数[block,blockNum],移除玩家blockNum个block
    - addDictWordEvent:给定参数[word],解锁玩家word单词
    - gameoverEvent:游戏结束