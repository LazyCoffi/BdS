# 事件

最为复杂的脚本,控制整个游戏流程

为一个列表,其中包含一系列字典,每个字典代表一个事件

字典中每个参数意义如下

- eventName:事件名称,会成为弹出事件窗的标题
- preEvent:前置事件名称,若无则设为空字符串""
- success/failMessage:成功/失败事件文字,用于实现功能类事件的文字介绍
- type:分为static与random,分别为固定事件和随机事件,前者在固定日期每天开始时发生,后者按概率随机在某天开始时发生
- prob:static设为0,random则设置发生概率,范围为0~100
- occurDay,Month,Year:发生的年月日,设定从1789年开始,每月固定30天
- funcList:函数列表,分为判断函数,成功执行函数,失败执行函数
  - checkFuncName:用于判断的函数名,若判断成功则执行 成功执行函数, 否则执行 失败执行函数
    - trueTest:恒为真函数,一定返回true
    - blockTest:给定参数[block, requireNum],若玩家拥有requireNum个block,则返回true,否则返回false
    - randomTest:给定参数[prob],prob范围为[0,100],即prob%概率返回真
    - moneyTest:给定参数[value],若玩家现有金钱大于等于value则返回真
    - eventHappenedTest:给定参数[eventName],eventName对应的事件是否发生过
    - eventHappededListTest:给定参数[[eventName1, eventName2]],为一个列表，若所有对应事件都发生过则返回true
  -  checkFuncParams:传给checkFunc的参数,以列表形式传入
  - successFuncName:成功执行函数名,判断成功则被执行
    - messageEvent:给定参数[message],弹窗弹出标题为eventName,内容为message的弹窗
    - addBlockEvent:给定参数[block,blockNum],给玩家添加blockNum个block
    - addBlockListEvent:给定参数[{"key1":num1, "key2":num2},...],按提供的字典添加num1个key1,num2个key2...
    - deleteBlockListEvent:给定参数[{"key1":num1, "key2":num2},...],按提供的字典去除num1个key1,num2个key2...
    - addMoneyEvent:给定参数[value],获得value硬币
    - subMoneyEvent:给定参数[value],减少value硬币
    - addVictoryEvent:给定参数[victoryName],添加名为victoryName的胜利条件
    - setMissionEvent:给定参数[word, {"year": year, "month": month, "day": day}],分别为一个字符串和字典,设置期限在year-month-day的任务word
    - removeBlockEvent:给定参数[block,blockNum],移除玩家blockNum个block
    - addDictWordEvent:给定参数[word],解锁玩家word单词
    - checkVictory:无需参数[],检查所有现有胜利目标是否存在满足,若存在则直接结束游戏
    - gameoverEvent:游戏结束