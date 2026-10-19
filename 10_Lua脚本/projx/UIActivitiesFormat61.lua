--活动模板61
--上面一张图，下面滑动列表显示奖励
UIActivitiesFormat61 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat61")
local this = UIActivitiesFormat61

local Texture
local Herald

local tHeraldPos = {Vector3.New(-262,32,0),Vector3.New(-262,-32,0),Vector3.New(264,32,0),Vector3.New(262,-32,0)}

function this.clear( ... )
	-- body
	Texture = nil
	Herald = nil
end

local function loadItems( data )
	-- body
	local ScrollView = this.page.transform:Find('RewardRoot/Scroll View')
	local Grid = ScrollView:Find('Grid')
	local child = this.page.transform:Find('RewardItem')
	local position = 0
	local UIGrid = Grid:GetComponent('UIGrid')
	local activity_id = data.id
	local childCount = Grid.transform.childCount
	Utils.destoryChild( Grid )
	--增加一个判断，保证必须是顺序领取
	local function order( index )
		-- body
		for i,v in ipairs(data.activity_items) do
			if v.status == 2 then
				return index == i
			end
		end
	end
	for i,reward in ipairs(data.activity_items) do
		local item = NGUITools.AddChild(Grid.gameObject,child.gameObject)
		-- if childCount < i then
		-- 	item = NGUITools.AddChild(Grid.gameObject,child.gameObject)
		-- else
		-- 	item = Grid.transform:GetChild(i - 1)
		-- end
		item.gameObject:SetActive(true)
		local state = reward["status"]
		item.transform.localPosition = Vector3(0,position,0)
		position = position - UIGrid.cellHeight

		local rewards = reward["rewards"]
		local condition = item.transform:Find("bg3/Sprite/Condition")
		condition:GetComponent("UILabel").text = reward["desc"]
		SetFontStyle(item.transform:Find("bg3/Sprite/Label"):GetComponent("UILabel"),255,255,255,fontNormal,22)
		local trans = item.transform:Find("bg3/icons")
		Utils.destoryChild( trans )
		for k, v  in pairs(rewards) do
			local id = v["id"]
			local types = v["type"]
			local count = v["num"]
			local value = v["value"]
			local desc = v["desc"]
			WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(id,tostring(types),count,trans,value,0.8)
			local button = item.transform:Find("bg3/button")
			local lbl = button:Find("Label")
			if state == 1 then																				--1：未达成		2：领取		3：已领取
				button:GetComponent("UISprite").spriteName = "Button_L_Normal"
				lbl:GetComponent("UILabel").text = ManagerCsv.GetInstance():GetNameStatic('OperateNotCanGet')--"未达成"
				SetFontStyle(lbl:GetComponent("UILabel"),90,120,150,fontNormal,30)
			elseif state == 2 then
				button:GetComponent("UISprite").spriteName = "Button_Y_Normal"
				lbl:GetComponent("UILabel").text = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')--"领取"
				SetFontStyle(lbl:GetComponent("UILabel"),78,48,22,fontNormal,30)
				UIEventListener.Get(button.gameObject).onClick = function()  												--向服务器发请求验证是否领取
					--只能顺序领
					if order(i) then
						local roleid = tostring(WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():RoleID())
						local baseid = tostring(activity_id)
						local serial = i
						local msgParams = {roleid = roleid,baseid = baseid,serial = serial}
						Utils.SendMessage(ActivityModel.getCode(tonumber(activity_id),data.type),msgParams, function(response)
							for key, value in ipairs(ActivityModel.ServerData) do
								if activity_id == value["id"] then
									value["activity_items"][i]["status"] = 3
									break
								end
							end
							reward.status = 3
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:Callback(bytes)
							button:GetComponent("UISprite").spriteName = "Button_Event_Finish"
							lbl:GetComponent("UILabel").text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--"已领取"
							SetFontStyle(lbl:GetComponent("UILabel"),31,198,44,fontItalic,30)
							
							if button:GetComponent("UIEventListener") then
								UnityEngine.GameObject.Destroy(button:GetComponent("UIEventListener"))
							end

							UIActivitiesButtons.updateRed(activity_id)
						end)
					else
						--提示必须顺序领取
						NetworkAlertUI.TryShowWarningTipByTag('ReceiveInturn')
					end                                                                 				  --向服务器发送领取请求之后，服务器返回一个表示领取是否成功的标记flag，如果flag == true,则表示领取成功，否则表示领取失败
				end
			elseif state == 3 then
				button:GetComponent("UISprite").spriteName = "Button_Event_Finish"
				lbl:GetComponent("UILabel").text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--"已领取"
				SetFontStyle(lbl:GetComponent("UILabel"),31,198,44,fontItalic,30)
			end
		end

		trans:GetComponent('UIGrid').enabled = true
	end
	UIGrid.enabled = true
	child.gameObject:SetActive(false)
	ScrollView:GetComponent('UIScrollView'):ResetPosition()
end

function this.hide2show( data )
	-- body
	Herald.Trs.gameObject:SetActive(data.desc_position > 0)
	if data.desc_position > 0 then
		Herald.Trs.localPosition = tHeraldPos[data.desc_position]
		Herald.Label.text = data.desc
	end
	Texture.mainTexture = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/Bg/" .. data.background)
	loadItems( data )
	Texture.transform:Find('Time'):GetComponent('UILabel').text = UIActivitiesModel.GetTimeStampByTime(data.starttime,data.endtime)
	--充值的累计值增加一个显示
	local Recharge = Texture.transform:Find('Recharge')
	Recharge.gameObject:SetActive(data.Recharge ~= nil)
	if data.Recharge then
		Recharge:Find('Num'):GetComponent('UILabel').text = data.Recharge
	end
end

function this.init( ... )
	-- body
	local data = ...

	Texture = this.page.transform:Find('Texture'):GetComponent('UITexture')

	Herald = {}
	Herald.Trs = Texture.transform:Find('Herald')
	Herald.Label = Herald.Trs:Find('content'):GetComponent('UILabel')
	--this.hide2show( data )
	UIActivitiesModel.RequestActivitiesData( UIActivitiesButtons.updateInfo )
end