UIPlotAndCheckpoint = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIPlotAndCheckpoint",AssetsManager.AssetsType.LuaAssets4)

local this = UIPlotAndCheckpoint

local function ClickClose( ... )
	-- body
	this:destory()
	MainScenePanelAdd.UpdateRed()
end

local function CallBack( ... )
	-- body
	if this:isNil() then
		return
	end

	local data994 = UIActivitiesModel.GetServerDataAllByID( 994 )
	local data995 = UIActivitiesModel.GetServerDataAllByID( 995 )

	local Item = this.page.transform:Find('Item')
	local ScrollView = this.page.transform:Find('ScrollView'):GetComponent('UIScrollView')
	local GridPlot = ScrollView.transform:Find('GridPlot'):GetComponent('UIGrid')
	local GridLevel = ScrollView.transform:Find('GridLevel'):GetComponent('UIGrid')

	local function SetData( data,Grid )
		-- body
		for i,reward in ipairs(data.activity_items) do
			local item = NGUITools.AddChild(Grid.gameObject,Item.gameObject)

			item.gameObject:SetActive(true)
			local state = reward["status"]

			local rewards = reward["rewards"]
			local condition = item.transform:Find("Condition")
			condition:GetComponent("UILabel").text = reward["desc"]
			local trans = item.transform:Find("icons")
			for k, v  in pairs(rewards) do
				local id = v["id"]
				local types = v["type"]
				local count = v["num"]
				local value = v["value"]
				local desc = v["desc"]
				WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(id,tostring(types),count,trans,value,0.5)
			end
			local button = item.transform:Find("button")
			local buttonSprite = button:GetComponent("UISprite")
			local lbl = button:Find("Label"):GetComponent("UILabel")
			if state == 1 then																				--1：未达成		2：领取		3：已领取
				buttonSprite.spriteName = "Button_L_Normal"
				lbl.text = ManagerCsv.GetInstance():GetNameStatic('OperateNotCanGet')--"未达成"
				lbl.color = Color.New(90/255,120/255,150/255)
			elseif state == 2 then
				buttonSprite.spriteName = "Button_Y_Normal"
				lbl.text = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')--"领取"
				lbl.color = Color.New(78/255,48/255,22/255)
				UIEventListener.Get(button.gameObject).onClick = function()
					local roleid = tostring(WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():RoleID())
					local baseid = tostring(data.id)
					local serial = i
					local msgParams = {roleid = roleid,baseid = baseid,serial = serial}
					Utils.SendMessage(ActivityModel.getCode(tonumber(baseid),data.type),msgParams, function(response)
						local bytes = response.bytes
						local LuaNetProxy = LuaNetProxy.New()
						data.activity_items[i].status = 3
						LuaNetProxy:Callback(bytes)
						buttonSprite.spriteName = "Button_Event_Finish"
						lbl.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--"已领取"
						lbl.color = Color.New(31/255,198/255,44/255)
						UIEventListener.Get(button.gameObject).onClick = function ( ... )
							-- body
						end
					end)                                                            				  --向服务器发送领取请求之后，服务器返回一个表示领取是否成功的标记flag，如果flag == true,则表示领取成功，否则表示领取失败
				end
			elseif state == 3 then
				buttonSprite.spriteName = "Button_Event_Finish"
				lbl.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--"已领取"
				lbl.color = Color.New(31/255,198/255,44/255)
			end
		end
	end
	SetData(data994,GridPlot)
	SetData(data995,GridLevel)
	GridPlot:Reposition()
	GridLevel:Reposition()
end

function this.init( ... )
	-- body

	UIEventListener.Get(this.page.transform:Find('TopRight/Close').gameObject).onClick = ClickClose
	UIActivitiesModel.RequestActivitiesData( CallBack )
end