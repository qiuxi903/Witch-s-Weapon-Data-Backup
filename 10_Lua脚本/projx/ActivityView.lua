---
--- Created by old_yang
--- DateTime: 2017/9/6 18:27
---
ActivityView = BaseView:new("UI/Prefab/Activity/","Activity")

UIFrame = WaterBell.ProjX.View.UIFrame
local root = nil
local left = nil
local right = nil
local activityData = nil;
local ActivityItems = {}	--保存右侧所有活动条目
local GameObject = UnityEngine.GameObject
local Resources =  UnityEngine.Resources
local Color = UnityEngine.Color
local data = {}
local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
local FontStyle = UnityEngine.FontStyle
local fontNormal = FontStyle.Normal
local fontBold = FontStyle.Bold
local fontItalic = FontStyle.Italic
local timers = {}	--保存次界面所有定时器，在ui关闭时清空

--退出清理一些数据
local function onClose( ... )
	activityData = nil
	ActivityView:destory()
	for i,v in ipairs(timers) do
		v:Stop()
	end
	timers = {}
	ActivityModel.checkAllRed2CSharp( data )
	AwardUtils.GetInstance():ActivityUnloadResource()
end

--重启游戏，重置部分全局数据
function ActivityView.clearOnReload( ... )
	-- body
	print("ActivityView.clearOnReload")
	last_selected_activity_id = nil
end

---
--- 初始化活动数据
---
function ActivityView.init()
	activityData = function (list)
		if #data >= 1 then
			Remove(data)
		end

		for key,value in ipairs( list) do
			table.insert(data,key,value)
		end
		InitView()
	end
	ActivityModel:RegisterCallback(activityData)
	ActivityModel:getActivities(true)
end

---
--- 初始化活动界面
---
function InitView()
	local m_root = GameObject.Find("UI Root (3D)").transform
	root = m_root:Find("Activity").transform
	left = root:Find("Left/Detail").transform
	right = root:Find("Right/").transform
	root.gameObject:SetActive(true)
	local back = root:Find("Left/Base/Button_Return_Normal").transform
	UIEventListener.Get(back.gameObject).onClick = onClose
	LoadAllActivityPanels()
	LoadActivityItems()
	ActivityView.checkGetPower()
end




function LoadAllActivityPanels()
	if left == nil then
		left = GameObject.Find("UI Root (3D)/Activity(Clone)/Left/Detail").transform
		AwardUtils.GetInstance().HideObj(left)
	end

	--local panel_id = data[1]["panel_id"]
	--GeActivityPanel(panel_id)
end

local function updateRed( ... )
	-- body
	local obj = ...
	local activity_id = tonumber(Utils.split(obj.name,"_")[2])
	obj.transform:Find("Red").gameObject:SetActive(ActivityModel.isRed(data,activity_id))
end

---
---	加载所有的活动条目，并填充到右侧下拉列表中
---
function LoadActivityItems()
	local grid = right:Find("SelectFaghting_Frame_Prepare_2/Scroll View/UIGrid"):GetComponent("UIGrid")
	local path = "UI/Prefab/Activity/ActivityItem"

	local i = #ActivityItems
	while i > 0 do
		table.remove(ActivityItems,i)
		GameObject:Destroy(i)
		i = i - 1
	end

	local grid_trans = grid.transform
	for i = 1, grid_trans.childCount do
		local child = grid_trans:GetChild(i - 1)
		GameObject.Destroy(child.gameObject)
	end
	--排序规则，1.是否置顶 2.开始时间最小 3.id
	table.sort(data, function (a,b)
		if a.stick == b.stick then
			return tonumber(a["id"]) <  tonumber(b["id"])
		else
			return a.stick > b.stick
		end
	end)

	--data = unique(data, true)
	local distance = 0
	for key, value in ipairs(data) do
		if value.show_type == ActivityModel.ShowType.Yunying then
			local activityItem = GameObject.Instantiate(AssetsManager.LoadResourceForLua(path))  --加载UIPrefab资源【需要先打包到ab中，故此处不能直接这样写】
			--local activityItem = GameObject.Instantiate(Resources.Load(path))
			--local activityItem = NGUITools.AddChild(grid.gameObject,Resources.Load(path))
			activityItem.transform:Find("Label"):GetComponent("UILabel").text = value["name"]
			local activityName ="activity" .. value["panel_id"] .. "_" .. value["id"]
			activityItem.name = activityName
			activityItem.transform:Find("Label"):GetComponent("UILabel").text = SegmentationLabel(activityItem.transform:Find("Label"):GetComponent("UILabel").text)
			--local uib = activityItem:GetComponent("UIButton")
			--local button = activityItem.transform:Find("Button").gameObject
			local mark = value["mark"]
			if mark == 0 then
				activityItem.transform:Find("Mask").gameObject:SetActive(false)
			else
				activityItem.transform:Find("Mask").gameObject:SetActive(true)
				activityItem.transform:Find("Mask"):GetComponent("UISprite").spriteName = "Label_Activity_" .. mark
			end
			updateRed(activityItem)
			--uib.tweenTarget = button
			--UIEventListener.Get(activityItem).onClick = ActivityItemOnClick
			--UIEventListener.Get(activityItem).onSelect = ActivityItemOnSelect
			UIEventListener.Get(activityItem).onClick = ActivityItemOnClick
			activityItem.transform.parent = grid.transform
			activityItem.transform.localPosition = UnityEngine.Vector3(0,distance,0)
			distance = distance - grid.cellHeight
			activityItem.transform.localScale = UnityEngine.Vector3(1,1,1)
			table.insert(ActivityItems, activityItem)
		end
	end


	--[[
	table.sort(ActivityItems, function (a,b)
		local id_a = GetStrByChar(a.name,"_",true)
		local id_b = GetStrByChar(b.name,"_",true)
		return tonumber(id_a) < tonumber(id_b)
	end)
	--]]

	--grid.repositionNow = true
	--grid:Reposition()
	--scroll.restrictWithinPanel = true
	grid.transform.parent:GetComponent('UIScrollView'):ResetPosition()
	local id = 1
	if last_selected_activity_id then
		id = last_selected_activity_id
		if id > #ActivityItems then
			id = #ActivityItems
		end
	end
	ActivityItemOnClick(ActivityItems[id])
end

---
---	右侧活动项选中事件响应代码
---
function ActivityItemOnClick(gameObject)
	for i,v in pairs(ActivityItems) do
		if gameObject == v then
			local name = gameObject.name
			local activity = nil
			local panel_id = GetStrByChar(name,"_",false)
			panel_id = GetStrByChar(panel_id, "y", true)
			local activity_id = tonumber(Utils.split(name,"_")[2])
			last_selected_activity_id = i
			for key, value in ipairs(data) do
				if activity_id == value["id"] then
					activity = value
					break
				end
			end
			ShowActivityDetailPanel(activity)
			local child = v.transform:Find("Button")
			child.gameObject:GetComponent("UISprite").spriteName = "Button_Tab_Sellected_Normal"
			--在这里处理活动项文本颜色
			local label = v.transform:Find("Label"):GetComponent("UILabel")
			--SetFontStyle(label,46,46,46,fontItalic,30)

			local color = Color.New(0.27,0.27,0.27)
			label.color = color
		else
			local child = v.transform:Find("Button")
			child.gameObject:GetComponent("UISprite").spriteName = "Button_Tab_Normal_Normal"
			--在这里处理活动项文本颜色
			local label = v.transform:Find("Label"):GetComponent("UILabel")
			--SetFontStyle(label,73,73,7d,fontItalic,30)
			local color = Color.New(0.45,0.45,0.49)
			label.color = color
		end
	end

end

---
---	从所有活动主面板集合里取出指定名字的活动主面板
---
function GeActivityPanel(panel_id,activity_id)
	local index = 1
	if panel_id == 1 or panel_id == 2 then
		index = 1
	elseif panel_id == 3 or panel_id == 7 then
		index = 2
	elseif panel_id == 4 or panel_id == 5 then
		index = 3
	elseif panel_id == 6 then
		index = 4
	elseif panel_id == 8 then
		index = 2
	elseif panel_id == 9 then
		index = 5
	elseif panel_id == 10 then
		index = 6
	else 
		index = 2
	end

	--local  panel = left:GetChild(index)
	local panel = left:Find("Panel_" .. tostring(index))
	
	panel.localScale = Vector3(1,1,1)
	panel.localPosition = Vector3(0,0,0)
	for i = 1, left.childCount do
		--if i == index then
		--	left:GetChild(i - 1).gameObject:SetActive(true)
		--else
			left:GetChild(i - 1).gameObject:SetActive(false)
		--end
	end
	panel.gameObject:SetActive(true)
	return panel,index
end

local HeraldPosition1 = {Vector3(-430,131,0),Vector3(146,131,0),Vector3(-430,13,0),Vector3(146,13,0)}
local HeraldPosition2 = {Vector3(-430,131,0),Vector3(146,131,0),Vector3(-430,-185,0),Vector3(146,-185,0)}
local HeraldPosition3 = {Vector3(-430,131,0),Vector3(146,131,0),Vector3(-430,44,0),Vector3(146,44,0)}

local function getHeraldPosition( panel_id,index )
	local position = Vector3(0,0,0)
	if panel_id == 1 then
		position = HeraldPosition1[index]
	elseif panel_id == 2 then
		position = HeraldPosition2[index]
	elseif panel_id == 3 then
		position = HeraldPosition3[index]	
	end
	return position
end

function ShowActivityDetailPanel(activity)
	local activity_id = activity["id"]
	local name = activity["name"]
	local title = activity["title"]
	local type = activity["type"]
	local startTime = activity["starttime"]
	local endTime = activity["endtime"]
	local closetime = activity["closeTime"]

	local panel_id = activity["panel_id"]
	local row_num = activity.row_num
	local panel,real_panel_id = GeActivityPanel(panel_id,tonumber(activity_id))
	panel.gameObject:SetActive(true)
	local background = activity["background"]
	local bg0 = panel:Find("bg0"):GetComponent("UITexture")
	AwardUtils.GetInstance():SetUITexture(bg0,background)

	local index = activity["desc_position"]
	local content = activity["desc"]

	local Herald = panel.parent.transform:Find('Herald')
	Herald.gameObject:SetActive(index > 0)
	if index > 0 then
		Herald.transform.localPosition = getHeraldPosition(real_panel_id,index)
		Herald:Find("content"):GetComponent("UILabel").text = content
	end

	local curEndTime = endTime - 1
	panel.parent.transform:Find("time").gameObject:SetActive(true)
	panel.parent.transform:Find("title").gameObject:SetActive(true)
	panel.parent.transform:Find("time_0").gameObject:SetActive(true)
	panel.parent.transform:Find("time"):GetComponent("UILabel").text = GetTimeStamp(startTime) .. "~" .. GetTimeStamp(curEndTime)
	panel.parent.transform:Find("title"):GetComponent("UILabel").text = SegmentationLabel(title)
	
	--如果时间大于三年显示永久开放
	local showForever = endTime - startTime >= 3 * 365 * 24 * 60 * 60 or endTime == startTime
	if showForever then
		panel.parent.transform:Find("time"):GetComponent("UILabel").text = "永久开放"
	end

	if panel_id == 1 or panel_id == 2 then				--签到【7日签到和14日签到】
		local signItems = {}   		--所有签到项的集合
		local signedItems = {}		--已签到项的集合，主要用于找出下一个未签到项
		local SignInButton = panel.transform:Find("bg2/button")
		local DaysSignRewardTag = activity["DaysSignRewardTag"]
		local DaysSignTime = activity["DaysSignTime"]
		local parent = panel.transform:Find("bg1/Scroll View/Grid/").transform
		Utils.destoryChild( parent )
		local obj = AssetsManager.LoadResourceForLua("UI/Prefab/Activity/Item")

		local activity_items = activity["activity_items"]
		-----------------获取所有签到项【prefab】-----------------
		local position = 0
		local UIGrid = parent:GetComponent('UIGrid')
		for i = 1, #activity_items do
			local child = NGUITools.AddChild(parent.gameObject,obj)
			child.transform.localPosition = Vector3(position,0,0)
			position = position +  UIGrid.cellWidth
			table.insert(signItems,child.transform)
		end
		-----------------获取所有签到项【prefab】-----------------

		for index , value in pairs(activity_items) do
			local rewards = value["rewards"]
			for key,m_value in pairs(rewards) do
				local reward_id = m_value["id"]
				local reward_num = m_value["num"]
				local reward_type = m_value["type"]
				local reward_value = m_value["value"]
				if signItems[index].transform:Find('UIResSpriteExObj(Clone)') then
					GameObject.Destroy(signItems[index].transform:Find('UIResSpriteExObj(Clone)').gameObject)
				end
				AwardUtils.GetInstance():LoadAwardSprite(reward_id,tostring(reward_type),reward_num,signItems[index],reward_value,0.8)
				signItems[index].transform:Find('UIResSpriteExObj(Clone)').transform.localPosition = Vector3(0,-7,0)
			end
			signItems[index]:Find("day"):GetComponent("UILabel").text = value.desc
		end

		--签到天数大于7的时候，显示出来后面的
		local scrollView = parent.parent.transform:GetComponent("UIScrollView")
		local delta = #activity_items > 7 and Mathf.Min((DaysSignRewardTag >= 4 and (DaysSignRewardTag-3)*2/#activity_items or 0),1) or 0
		scrollView:SetDragAmount(delta,0,false)

		for key , value in pairs(signItems) do
			local bg = value:Find("bg0"):GetComponent("UISprite")
			local outline = value:Find("outline"):GetComponent("UISprite")
			local isFinished = value:Find("isFinished"):GetComponent("UISprite")
			--local icon =  value:Find("icon"):GetComponent("UISprite")
			local bg1 = value:Find("bg1"):GetComponent("UISprite")
			local day = value:Find("day"):GetComponent("UILabel")
			--day.text = days[key]
			SetFontStyle(day,255,255,255,FontStyle.Italic,20)
			local index = key - 1
			if DaysSignRewardTag == 0 then		--表示首次签到
				if index == 0 then
					SignInButton:GetComponent("UISprite").spriteName = "Button_Y_Normal"
					bg.spriteName = "Frame_Card_BG_2"
					bg1.gameObject:SetActive(false)
					outline.gameObject:SetActive(true)
					isFinished.spriteName = "Icon_Project_Not _Ready"
					SignInButton:GetComponent("UIButton").enabled = true
					SetFontStyle(SignInButton.transform:Find("Label"):GetComponent("UILabel"),78,48,22,FontStyle.Normal,30)
					UIEventListener.Get(SignInButton.gameObject).onClick = function ()
						--向服务器发送签到验证请求，并接受服务器的响应
						local roleid = AwardUtils.GetInstance():RoleID()
						local baseid = tostring(activity_id)
						local msgParams = {roleid = tostring(roleid), baseid = tostring(baseid)}
						Utils.SendMessage(ActivityModel.getCode(activity_id,type),msgParams, function(response)
							for key, value in ipairs(data) do
								if activity_id == value["id"] then
									value["DaysSignTime"] = tonumber(os.time())
									value["DaysSignRewardTag"] = value["DaysSignRewardTag"] + 1
									break
								end
							end
							updateRed(ActivityItems[last_selected_activity_id])
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy.ondata = showCallBack
							LuaNetProxy:Callback(bytes)
							--local content = result[2]
							SignInButton:GetComponent("UIButton").enabled = false
							SignInButton:GetComponent("UISprite").spriteName = "Button_L_Normal"
							bg.spriteName = "Frame_Card_BG"
							outline.gameObject:SetActive(false)
							isFinished.spriteName = "Icon_Project_Done"
							SetFontStyle(SignInButton.transform:Find("Label"):GetComponent("UILabel"),90,120,150,FontStyle.Normal,30)
							if SignInButton:GetComponent("UIEventListener") then
								GameObject.Destroy(SignInButton:GetComponent("UIEventListener"))
							end
						end)
					end
				else
					bg.spriteName = "Frame_Card_BG_2"
					outline.gameObject:SetActive(false)
					isFinished.spriteName = "Icon_Project_Not _Ready"
					bg1.gameObject:SetActive(false)
				end
			else
				if index < DaysSignRewardTag then																		  --表示已经签到过
					bg.spriteName = "Frame_Card_BG"
					bg1.gameObject:SetActive(false)
					outline.gameObject:SetActive(false)
					isFinished.spriteName = "Icon_Project_Done"
					--SignInButton:GetComponent("UIButton").enaable = false
				elseif index == DaysSignRewardTag then																	  --表示可签到
					--local localDate= os.date("%Y:%m:%d")
					--local serviceDate = GetTimeStamp(DaysSignTime)
					--修改为距离上次签到时间大于24小时（60*60*24）
					local diff = Utils.getSeverTime() - DaysSignTime >= 60*60*24
					if diff == true then 			--表示可签到
						SignInButton:GetComponent("UIButton").enabled = true
						SignInButton:GetComponent("UISprite").spriteName = "Button_Y_Normal"
						outline.gameObject:SetActive(true)
						SetFontStyle(SignInButton.transform:Find("Label"):GetComponent("UILabel"),78,48,22,FontStyle.Normal,30)
						UIEventListener.Get(SignInButton.gameObject).onClick = function ()
							--向服务器发送签到验证请求，并接受服务器的响应
							local roleid = AwardUtils.GetInstance():RoleID()
							local baseid = tostring(activity_id)
							local msgParams = {roleid = tostring(roleid), baseid = tostring(baseid)}
							Utils.SendMessage(ActivityModel.getCode(activity_id,type),msgParams, function(response)
								for key, value in ipairs(data) do
									if activity_id == value["id"] then
										value["DaysSignTime"] = Utils.getSeverTime()
										value["DaysSignRewardTag"] = value["DaysSignRewardTag"] + 1
										break
									end
								end
								updateRed(ActivityItems[last_selected_activity_id])
								local bytes = response.bytes
								local LuaNetProxy = LuaNetProxy.New()
								LuaNetProxy.ondata = showCallBack
								LuaNetProxy:Callback(bytes)
								--local content = result[2]
								SignInButton:GetComponent("UIButton").enabled = false
								SignInButton:GetComponent("UISprite").spriteName = "Button_L_Normal"
								bg.spriteName = "Frame_Card_BG"
								outline.gameObject:SetActive(false)
								isFinished.spriteName = "Icon_Project_Done"
								SetFontStyle(SignInButton.transform:Find("Label"):GetComponent("UILabel"),90,120,150,FontStyle.Normal,30)
								if SignInButton:GetComponent("UIEventListener") then
									GameObject.Destroy(SignInButton:GetComponent("UIEventListener"))
								end
							end)                                                                                --向服务器发送签到请求之后，服务器返回一个表示签到是否成功的标记flag，如果flag == true,则表示签到成功，否则表示签到失败
						end
					else							--表示不可签到
						outline.gameObject:SetActive(false)
						SignInButton:GetComponent("UIButton").enabled = false
						SignInButton:GetComponent("UISprite").spriteName = "Button_L_Normal"
						SetFontStyle(SignInButton.transform:Find("Label"):GetComponent("UILabel"),90,120,150,FontStyle.Normal,30)
					end
					bg.spriteName = "Frame_Card_BG_2"
					bg1.gameObject:SetActive(false)
					isFinished.spriteName = "Icon_Project_Not _Ready"
				else																									--表示不可签到
					bg.spriteName = "Frame_Card_BG_2"
					outline.gameObject:SetActive(false)
					isFinished.spriteName = "Icon_Project_Not _Ready"
					bg1.gameObject:SetActive(false)
				end
			end
		end

		if DaysSignRewardTag >= #activity_items then
			SignInButton:GetComponent("UIButton").enabled = false
			SignInButton:GetComponent("UISprite").spriteName = "Button_L_Normal"
			SetFontStyle(SignInButton.transform:Find("Label"):GetComponent("UILabel"),90,120,150,FontStyle.Normal,30)

			if SignInButton:GetComponent("UIEventListener") then
				GameObject.Destroy(SignInButton:GetComponent("UIEventListener"))
			end
		end

		---
		---	总共有8种界面布局
		---
	elseif panel_id == 3 or panel_id == 7 then   				--多目标物【一般是任务类，比如抽奖，转盘,等美术素材】

	elseif panel_id == 4 or panel_id == 5  then --【4:领取 	5:兑换】
		local grid = panel.transform:Find("bg2/Scroll View/Grid")
		local UIGrid = grid:GetComponent("UIGrid")

		if grid ~= nil then
			AwardUtils.GetInstance():DeleteObj(grid)
		end
		UIGrid.repositionNow = true
		UIGrid.enabled = false
		local Rewards = activity["activity_items"]
		--local state = Rewards["status"]
		if Rewards ~= nil and #Rewards > 0 then
			local position = 0
			for index , reward in ipairs(Rewards) do
				local path = "UI/Prefab/Activity/RewardItem"
				local item = GameObject.Instantiate(AssetsManager.LoadResourceForLua(path))  --加载UIPrefab资源【需要先打包到ab中，故此处不能直接这样写】
				local state = reward["status"]
				--local item = GameObject.Instantiate(Resources.Load(path))
				item.transform.parent = grid
				item.transform.localPosition = Vector3(0,position,0)
				position = position - UIGrid.cellHeight
				item.transform.localScale = Vector3(1,1,1)
				item.name = "RewardItem_" .. index

				local rewards = reward["rewards"]
				local condition = item.transform:Find("bg3/Sprite/Condition")
				--SetFontStyle(condition:GetComponent("UILabel"),255,255,255,fontItalic,22)
				condition:GetComponent("UILabel").text = reward["desc"]
				SetFontStyle(item.transform:Find("bg3/Sprite/Label"):GetComponent("UILabel"),255,255,255,fontNormal,22)
				if #rewards > 0 then
					for k, v  in pairs(rewards) do
						local trans = item.transform:Find("bg3/icons")
						local id = v["id"]
						local types = v["type"]
						local count = v["num"]
						local value = v["value"]
						local desc = v["desc"]
						AwardUtils.GetInstance():LoadAwardSprite(id,tostring(types),count,trans,value,0.8)
						local button = item.transform:Find("bg3/button")
						local lbl = button:Find("Label")
						if state == 1 then																				--1：未达成		2：领取		3：已领取
							button:GetComponent("UISprite").spriteName = "Button_L_Normal"
							--button:GetComponent("UIButton").enabled = false
							lbl:GetComponent("UILabel").text = "未达成"
							SetFontStyle(lbl:GetComponent("UILabel"),90,120,150,fontNormal,30)
						elseif state == 2 then
							button:GetComponent("UISprite").spriteName = "Button_Y_Normal"
							--button:GetComponent("UIButton").enabled = true
							lbl:GetComponent("UILabel").text = "领取"
							SetFontStyle(lbl:GetComponent("UILabel"),78,48,22,fontNormal,30)
							UIEventListener.Get(button.gameObject).onClick = function()  												--向服务器发请求验证是否领取
								local roleid = tostring(AwardUtils.GetInstance():RoleID())
								local baseid = tostring(activity_id)
								local serial = index
								local msgParams = {roleid = roleid,baseid = baseid,serial = serial}
								Utils.SendMessage(ActivityModel.getCode(tonumber(activity_id),type),msgParams, function(response)
									for key, value in ipairs(data) do
										if activity_id == value["id"] then
											value["activity_items"][index]["status"] = 3
											break
										end
									end
									updateRed(ActivityItems[last_selected_activity_id])
									local bytes = response.bytes
									local LuaNetProxy = LuaNetProxy.New()
									LuaNetProxy.ondata = showCallBack
									LuaNetProxy:Callback(bytes)
									--local content = result[2]
									--button:GetComponent("UIButton").enabled = false
									button:GetComponent("UISprite").spriteName = "Button_Event_Finish"
									lbl:GetComponent("UILabel").text = "已领取"
									SetFontStyle(lbl:GetComponent("UILabel"),31,198,44,fontItalic,30)
									
									if button:GetComponent("UIEventListener") then
										GameObject.Destroy(button:GetComponent("UIEventListener"))
									end
								end)                                                                       				  --向服务器发送领取请求之后，服务器返回一个表示领取是否成功的标记flag，如果flag == true,则表示领取成功，否则表示领取失败
							end
						elseif state == 3 then
							--button:GetComponent("UIButton").enabled = false
							button:GetComponent("UISprite").spriteName = "Button_Event_Finish"
							lbl:GetComponent("UILabel").text = "已领取"
							SetFontStyle(lbl:GetComponent("UILabel"),31,198,44,fontItalic,30)
						end
					end
				end
			end
			--[[
			Timer.New(function ()
				UIGrid.repositionNow = true
				-- body
			end, 0.2, 1, true):Start()
			]]
			--grid:GetComponent("UIGrid").repositionNow = true
			grid.parent:GetComponent("UIScrollView"):ResetPosition()
		end
		--item.transform.parent = parent

	elseif panel_id == 6 then			--单一目标物【二选一】,选择类]

	elseif panel_id == 8 then																--预告	
		local button = panel.transform:Find('button')
		if activity.page_footer_button1 == 1 then
			button.transform:Find('Label'):GetComponent('UILabel').text = "前往"
			UIEventListener.Get(button.gameObject).onClick = 
			function ( ... )
				-- 1 去商店，2去抽卡 3 去任务
				if activity.page_footer_button_argument1 == 1 then
					AwardUtils.GetInstance():GoYunyingShop();
				elseif activity.page_footer_button_argument1 == 2 then	
					UIFrame.UISceneManager.getInstance():Goto(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.LOTTERY_SCENE:ToInt()))

				elseif activity.page_footer_button_argument1 == 3 then	

					UIFrame.UISceneManager.getInstance():Goto(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.TASK_SCENE:ToInt()))
				elseif activity.page_footer_button_argument1 == 4 then
					UnityEngine.Application.OpenURL('https://weibo.com/3739212854/GzkSL8MWu')
				else
					print("未定义页面id:" .. activity.page_footer_button_argument1)
					return
				end
				onClose()
			end
		elseif activity.page_footer_button1 == 2 then
			button.transform:Find('Label'):GetComponent('UILabel').text = "签到"
		elseif activity.page_footer_button1 == 3 then
			button.transform:Find('Label'):GetComponent('UILabel').text = "领取"
		elseif activity.page_footer_button1 == 4 then
			button.transform:Find('Label'):GetComponent('UILabel').text = "确认"
		end

		button.transform:GetComponent('UISprite').spriteName = "Button_Y_Normal"
		SetFontStyle(button.transform:Find("Label"):GetComponent("UILabel"),78,48,22,FontStyle.Normal,30)

		--领取体力
		if activity_id == ARData.GetStamina.baseid then
			if activity.CanReceive then
				button.transform:Find('Label'):GetComponent('UILabel').text = "领取"
				button.transform:GetComponent('UISprite').spriteName = "Button_Y_Normal"
				SetFontStyle(button.transform:Find("Label"):GetComponent("UILabel"),78,48,22,FontStyle.Normal,30)
				UIEventListener.Get(button.gameObject).onClick = function ( ... )
					-- body
					local roleid = tostring(AwardUtils.GetInstance():RoleID())
					local msgParams = {roleid = roleid}
					Utils.SendMessage(ActivityModel.getCode(tonumber(activity_id)),msgParams, function(response)
						button.transform:Find('Label'):GetComponent('UILabel').text = "已领取"
						button.transform:GetComponent('UISprite').spriteName = "Button_L_Normal"
						SetFontStyle(button.transform:Find("Label"):GetComponent("UILabel"),90,120,150,FontStyle.Normal,30)
						activity.CanReceive = false
						updateRed(ActivityItems[last_selected_activity_id])
						local LuaNetProxy = LuaNetProxy.New()
						LuaNetProxy:ShowStamina()

						if button:GetComponent("UIEventListener") then
							GameObject.Destroy(button:GetComponent("UIEventListener"))
						end
					end
					)
				end
			else
				button.transform:Find('Label'):GetComponent('UILabel').text = "未达成"
				button.transform:GetComponent('UISprite').spriteName = "Button_L_Normal"
				SetFontStyle(button.transform:Find("Label"):GetComponent("UILabel"),90,120,150,FontStyle.Normal,30)
			end
		end
	elseif panel_id == 9 then

	elseif panel_id == 10 then
		local Rewards = activity["activity_items"]
		local Slider = panel.transform:Find("Slider")
		local Width = Slider:GetComponent('UISprite').width
		local RewardItem = Slider:Find("RewardItem")
		local Reward = Slider:Find("Reward")
		Utils.destoryChild( Reward )
		if Rewards ~= nil and #Rewards > 0 then
			local child
			for index , reward in ipairs(Rewards) do
				print(reward.argument4)
				child = NGUITools.AddChild(Reward.gameObject,RewardItem.gameObject)
				child.transform.localPosition = Vector3(reward.argument4/activity.page_footer_bar_number*Width,0,0)
				child:SetActive(true)

				local tag = child.transform:Find('Tag'):GetComponent('UISprite')
				local status = reward["status"]
				local button = child.transform:Find('button')
				child.transform:Find('Value'):GetComponent('UILabel').text = reward.argument4

				button.gameObject:SetActive(status == 2)
				if status == 1 then
					if index == #Rewards then
						tag.spriteName = 'Node_Uncomplete_Final'
					else
						tag.spriteName = 'Node_Uncomplete'
					end
				elseif status == 2 then
					tag.spriteName = 'Node_Completed'

					UIEventListener.Get(button.gameObject).onClick = 
					function()
						local roleid = tostring(AwardUtils.GetInstance():RoleID())
						local baseid = tostring(activity_id)
						local serial = index
						local msgParams = {roleid = roleid,baseid = baseid,serial = serial}
						Utils.SendMessage(ActivityModel.getCode(tonumber(activity_id),type),msgParams, 
						function(response)
							for key, value in ipairs(data) do
								if activity_id == value["id"] then
									value["activity_items"][index]["status"] = 3
									break
								end
							end
							updateRed(ActivityItems[last_selected_activity_id])
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:Callback(bytes)
							tag.spriteName = 'Node_Received_Final'
							button.gameObject:SetActive(false)
						end)
					end
				elseif status == 3 then
					tag.spriteName = 'Node_Received_Final'
				end
			end
		end

		Slider:GetComponent('UISlider').value = activity.recharge/activity.page_footer_bar_number
		Slider:Find('Current'):GetComponent('UILabel').text = activity.recharge
	end
end

--开启一个领取体力的检测，
--若是当前时间在领取时间内，则在结束时间拉取一次服务器数据
--若是当前时间不在领取时间内，则开启一个定时器，在下次开始的时候拉取服务器数据
function ActivityView.checkGetPower( ... )
	-- body
	local curData
	for key, value in ipairs(data) do
		if value.id == 999 then
			curData = value
			break
		end
	end
	if curData then
		local curTime = Utils.getSeverTime()
		local time
		if curTime < curData.EndTime and curTime > curData.StartTime then
			time = curData.EndTime - curTime
		else 
			time = curData.StartTime - curTime
		end
		print("领取体力定时刷新时间："..time)
		if time < 0 then
			return
		end
		local timer =  Timer.New(ActivityView.init, time, 1, true)
		table.insert(timers,timer)
		timer:Start()
	end
end



---
---	1.需求更改，暂时不用处理是否首次登录时弹出签到窗口;
---	2.抽奖类活动暂时没有资源，做法分代码实现和代码控制动画实现;
---	3.抽奖类概率暂时没有策划说明;
---	4.点击活动中领取奖励按钮之后是否弹出tip提示暂时没有策划说明;
---	5.领取奖励之后不用发邮件通知玩家了，直接弹出提示,并转存到背包里【这个操作有其他同事处理】
---