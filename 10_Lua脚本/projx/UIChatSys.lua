--- 2018.05.09
--- add by gus
--- 系统消息滚动条
UIChatSys = {}
UIChatTopSysView = BaseView:new("UI/Prefab/UIPrefab/","UIChatTopSys")



--- 退出游戏事件
local function MsgNetErrorYesHD()
	NetworkAlertUI.RestartGame()
end





local label = nil
local labelPosition = nil
local dataSys = {}
local isPlayAnim = false
--- 头文件
local animPlayOverHD
local animPlay
local timerAnimPlay


function UIChatSys.ClearData()
	dataSys = {}
end


local function timerCall(funHD, t)
	if nil ~= timerAnimPlay then
		if timerAnimPlay.running then
			timerAnimPlay:Stop()
		end
		timerAnimPlay = nil
	end
	if t <= 0 then
		funHD()
		return
	end
	
	timerAnimPlay = Timer.New(funHD, t, 1, true)
	timerAnimPlay:Start()
end

--重启游戏，重置部分全局数据
function UIChatTopSysView.clearOnReload( ... )
	-- body
	--print("UIChatTopSysView.clearOnReload")
end


---
--- 初始化活动数据
---
function UIChatTopSysView.init()
	label = UIChatTopSysView.page.transform:Find("Top/label"):GetComponent("UILabel")
	if nil == labelPosition then
		labelPosition = label.transform.localPosition
	end
end




--- 动画结束事件
animPlayOverHD = function()
	isPlayAnim = false
	if #dataSys <= 0 then
		UIChatTopSysView:hide()
		return
	end
	local temp = dataSys[1]
	table.remove(dataSys, 1)
	--- 如果消息没广播完 继续插到末尾
	if temp.sysMsgShowCount < temp.sysMsgShowCountMax then
		table.insert(dataSys, temp)
	else
		--- 后一次展示的时候看看是不是应该退出游戏
		if temp.sysMsgOverQuit == "1" then
			local info = 
			{
				UIAlert.UIAlertInfo.New(30, ManagerCsv.GetInstance():GetNameStatic("服务器维护中..."), 4),
				UIAlert.UIAlertInfo.New(24, ManagerCsv.GetInstance():GetNameStatic("（开服时间请注意公告）"), 10)
			}
			NetworkAlertUI.ShowMsgAlert(ManagerCsv.GetInstance():GetNameStatic("停服"), ManagerCsv.GetInstance():GetNameStatic("返回"), info, MsgNetErrorYesHD)
		end
	end
	if #dataSys <= 0 then
		UIChatTopSysView:hide()
		return
	end
	--- 筛选出最近应该广播的消息
	--- print(dataSys[1].sysMsgTimeLoop.Length) C# 数组从 0开始！！！！真让人神经啊
	local t = 0
	
	--
	if dataSys[1].sysMsgTimeLoop.Length == 1 then
		--- 标准计时
		if dataSys[1].sysMsgTimeBegin > GUtilTime.serverTime then
			t = dataSys[1].sysMsgTimeBegin - GUtilTime.serverTime
		else
			t = math.max(dataSys[1].sysMsgShowCount * dataSys[1].sysMsgTimeLoop[0] - (GUtilTime.serverTime - dataSys[1].sysMsgTimeBegin), 0)
		end
	elseif dataSys[1].sysMsgTimeLoop.Length > 1 then
	--
		--- 数组计时 WILL DONE
		for tempI = 0, dataSys[1].sysMsgTimeLoop.Length - 1, 1 do
			if  dataSys[1].sysMsgTimeEnd - dataSys[1].sysMsgTimeLoop[tempI] > GUtilTime.serverTime then
				t = dataSys[1].sysMsgTimeEnd - dataSys[1].sysMsgTimeLoop[tempI] - GUtilTime.serverTime
				--- print("tempI="..tempI)
				break
			end
		end
	end
	local i = 1
	if t > 0 then
		for index, value in ipairs(dataSys) do
			if i ~= index then
				--- 如果能播的直接播并返回
				if dataSys[1].sysMsgTimeLoop.Length == 1 and value.sysMsgShowCountWill > value.sysMsgShowCount and value.sysMsgTimeBegin <= GUtilTime.serverTime then
					i = index
					t = 0
					break
				end
				--- 找一个时间最短的
				local tempT = 0
				--if value.sysMsgTimeLoop.Length > 0 then
				--
				if value.sysMsgTimeLoop.Length == 1 then
					--- 标准区间计时
					if value.sysMsgTimeBegin > GUtilTime.serverTime then
						tempT = value.sysMsgTimeBegin - GUtilTime.serverTime
					else
						tempT = math.max(value.sysMsgShowCount * value.sysMsgTimeLoop[0] - (GUtilTime.serverTime - value.sysMsgTimeBegin), 0)
					end
				elseif value.sysMsgTimeLoop.Length > 1 then
					--- 数组区间计时 WILL DONE
					for tempI = 0, value.sysMsgTimeLoop.Length - 1, 1 do
						if value.sysMsgTimeEnd - value.sysMsgTimeLoop[tempI] > GUtilTime.serverTime then
							tempT = value.sysMsgTimeEnd - value.sysMsgTimeLoop[tempI] - GUtilTime.serverTime
							break
						end
					end
				end
				if tempT < t then
					i = index
					t = tempT
				end
				
			end
		end
	end
	--- 如果第一个不是最小的 换位置
	if i ~= 1 then
		temp = dataSys[i]
		table.remove(dataSys, i)
		table.insert(dataSys, 1, temp)
	end
	
	
	
	--- 如果还有消息播放 如果没有消息， 不播放
	if t > 1 then
		UIChatTopSysView:hide()
	end
	--print("Next Msg >> "..t)
	--print("dataSys[1].sysMsgShowCount = "..dataSys[1].sysMsgShowCount)
	--print("dataSys[1].sysMsgShowCountMax = "..dataSys[1].sysMsgShowCountMax)
	--print("dataSys[1].sysMsgShowCountWill = "..dataSys[1].sysMsgShowCountWill)
	--print("dataSys[1].sysMsgTimeBegin = "..dataSys[1].sysMsgTimeBegin)
	--print("dataSys[1].sysMsgTimeEnd = "..dataSys[1].sysMsgTimeEnd)
	--print("GUtilTime.serverTime = "..GUtilTime.serverTime)
	timerCall(animPlay, t)
end

--- 动画展示信息
animPlay = function()

	--- 锁定播放锁定
	if isPlayAnim then
		return
	end
	--- 如果为空再创建
	UIChatTopSysView:show()
	--- 如果没创建 --- 5秒后重试
	if UIChatTopSysView:isNil() then
		timerCall(animPlay, 5)
		return
	end
	
	--- 如果为空再创建
	if #dataSys <= 0 then
		return
	end
	--- 设置个数
	if dataSys[1].sysMsgTimeLoop.Length == 1 then
		dataSys[1].sysMsgShowCount = dataSys[1].sysMsgShowCountWill
	else
		dataSys[1].sysMsgShowCount = dataSys[1].sysMsgShowCountWill - 1
	end
	isPlayAnim = true
	label.text = dataSys[1].infoLua
	label.transform.localPosition = labelPosition
	local xTween = label.printedSize.x + 500
	local t = xTween / 200
	TweenPosition.Begin(label.gameObject, t, label.transform.localPosition - Vector3(xTween, 0, 0))
	--- n 秒后播放下一个
	timerCall(animPlayOverHD, t)
end
	
--- 侦听事件 添加消息
function UIChatSYSHD(sData)
	--- 容错处理 判空返回
	if nil == sData then
		--print("nil == sData")
		return
	end
	if nil == sData.eventArgs then
		--print("nil == sData.eventArgs")
		return
	end
	if nil == sData.eventArgs.type then
		--print("nil == sData.eventArgs.type")
		return
	end
	if sData.eventArgs.type ~= ServerDataChatMngr.ServerDataChatType.System then
		--print("sData.eventArgs.type != ServerDataChatType.System")
		return
	end
	--- 这个消息已经结束了的 不广播
	if sData.eventArgs.sysMsgTimeEnd > 0 and sData.eventArgs.sysMsgTimeEnd < GUtilTime.serverTime then
		--- print("time out")
		return
	end
	--- 消息内容为空 这个就不播放了
	if nil == sData.eventArgs.infoLua or "" == sData.eventArgs.infoLua then
		--- print("send nil msg in sys channel!!!")
		return
	end
	
	--- 重复消息剔除
	for index, value in ipairs(dataSys) do
		if value.id == sData.eventArgs.id then
			return
		end
	end
	--- table.remove(dataSys, 1)
	--- dataSys / #dataSys 获得长度
	UIChatTopSysView:show()
	if isPlayAnim == false and sData.eventArgs.sysMsgTimeBegin <= GUtilTime.serverTime and sData.eventArgs.sysMsgTimeLoop.Length == 1 then
		table.insert(dataSys, 1, sData.eventArgs)
		animPlay()
	else
		--- 插队处理
		if #dataSys >= 2 then
			table.insert(dataSys, 2, sData.eventArgs)
		else
			table.insert(dataSys, sData.eventArgs)
		end
		--- 如果是播放完了 因为没到时间播放 则重新排序进行播放
		if isPlayAnim == false then
			animPlayOverHD()
		end
	end
end







--- 添加消息侦听
GUtilListener.addEventListener("ServerDataChatMngrListener", UIChatSYSHD)