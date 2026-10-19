--包含多关卡挑战型数据的跳转界面

UIActivitiesFormat72 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat72")

local this = UIActivitiesFormat72
local data

local tModules

local strCallBack = 'UIActivitiesFormat72.back'

local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
local Status = ActivityModel.Status

function this.clear( ... )
	tModules = nil
end

function this.hide2show( ... )
	data = ...
end

local function GoLevel( ... )
	UIActivitiesButtons.close()
	UIActivitiesChallengeSelectLevel:show(data,1)
end

local function UpdataSignPanel( ... )
	-- body
	--加载条目，显示信息
	--从指定参数id 查找对应数据
	local DataOne = tModules.SignPanel.DataOne
	if not DataOne then
		print('没有对应活动数据，ID ：' .. data.NextActivityID)
		return
	end

	local count = #DataOne.activity_items
	local maxScore = DataOne.activity_items[1].argument1
	--判断当前是否是最后一个阶段
	--最后一个阶段可领取，其他阶段已领取
	local num = 0
	for i=1,count do
		if DataOne.activity_items[i].status == Status.status_received then
			num = num + 1
		end
	end
	local isEnd = num == count
	Utils.destoryChild( tModules.SignPanel.Grid )
	if isEnd then
		--如果已经是最后一个阶段，要显示签到的样式
		local DataTwo = tModules.SignPanel.DataTwo
		if not DataTwo then
			print('没有对应活动数据，ID ：' .. DataOne.activity_items[count].argument7)
			return
		end

		local child = tModules.SignPanel.Item1

		for i=1,#DataTwo.activity_items do
			local obj = NGUITools.AddChild(tModules.SignPanel.Grid.gameObject,child)
			obj.gameObject:SetActive(true)
			obj = obj.transform:Find('BG')

			obj:Find('Label'):GetComponent('UILabel').text = i

			local Button = obj:Find('Button').gameObject
			local Tag = obj:Find('Tag').gameObject
			local Mask = obj:Find('Mask').gameObject

			local item = DataTwo.activity_items[i]
			local pos = 0
			for j=1,#item.rewards do
				local reward = item.rewards[j]
				local trs = AwardUtils.GetInstance():LoadAwardSprite(reward.id,reward.type,reward.num,obj.transform:Find('AwardPos'),reward.value,0.5)
				trs.localPosition = Vector3(pos,0,0)
				pos = pos + 100 
			end
			
			local canSign = Utils.getSeverTime() - DataTwo.DaysSignTime >= 60 * 60 * 24 or DataTwo.DaysSignRewardTag == 0
			local signDay = DataTwo.DaysSignRewardTag + 1
			if signDay > #DataTwo.activity_items then
				canSign = false
			end

			if i < signDay then
				--已经签到的
				Button:SetActive(false)
				Tag:SetActive(true)
				Mask:SetActive(false)
			elseif i > signDay then
				--还没有签到的
				Button:SetActive(false)
				Tag:SetActive(false)
				Mask:SetActive(true)
			else
				--当前的天数
				if canSign then
					Button:SetActive(true)
					Tag:SetActive(false)
					Mask:SetActive(false)

					UIEventListener.Get(Button).onClick =function ( ... )
						-- body
						local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
						local request_params = {roleid = tostring(role_id),baseid = tostring(DataTwo.id)}
						local msgid = ActivityModel.getCode( DataTwo.id,DataTwo.type )
						Utils.SendMessage(msgid, request_params, function(response)
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:Callback(bytes)

							DataTwo.DaysSignRewardTag = DataTwo.DaysSignRewardTag + 1
							DataTwo.DaysSignTime = Utils.getSeverTime()

							Button:SetActive(false)
							Tag:SetActive(true)
							Mask:SetActive(false)
						end)

						-- --测试状态
						-- DataTwo.DaysSignRewardTag = DataTwo.DaysSignRewardTag + 1
						-- DataTwo.DaysSignTime = Utils.getSeverTime()
						-- Button:SetActive(false)
						-- Tag:SetActive(true)
						-- Mask:SetActive(false)
					end
				else
					Button:SetActive(false)
					Tag:SetActive(false)
					Mask:SetActive(true)
				end
			end
		end
	else

		for i=1,count do
			local child
			if i == count then
				child = tModules.SignPanel.Item3
			else
				child = tModules.SignPanel.Item2
			end

			local obj = NGUITools.AddChild(tModules.SignPanel.Grid.gameObject,child)
			obj:SetActive(true)

			local item = DataOne.activity_items[i]
			obj = obj.transform:Find('BG')

			obj:Find('Label'):GetComponent('UILabel').text = item.desc

			local Button = obj:Find('Button'):GetComponent('UISprite')
			local ButtonLabel = Button.transform:Find('Label'):GetComponent('UILabel')
			local Mask = obj:Find('Mask').gameObject
			--测试
			--item.status = Status.status_can_receive
			if item.status == Status.status_cannot_receive then
				--不可领取
				Button.spriteName = tModules.SignPanel.StrButtonNo
				Mask:SetActive(false)
				ButtonLabel.text = tModules.SignPanel.StrGet
			elseif item.status == Status.status_can_receive then
				--可领取
				Button.spriteName = tModules.SignPanel.StrButtonYes
				Mask:SetActive(false)
				ButtonLabel.text = tModules.SignPanel.StrGet
				UIEventListener.Get(Button.gameObject).onClick = function ( ... )
					-- body
					local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
					local request_params = {roleid = tostring(role_id),baseid = tostring(DataOne.id),serial = i}
					local msgid = ActivityModel.getCode( DataOne.id,DataOne.type )
					
					Mask:SetActive(true)
					Utils.SendMessage(msgid, request_params, function(response)
						if i ~= count then
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:Callback(bytes)

							item.status = Status.status_received
							Button.spriteName = tModules.SignPanel.StrButtonNo
							
							ButtonLabel.text = tModules.SignPanel.StrGeted

							if DataOne.activity_items[count].status == Status.status_received then
								UpdataSignPanel()
							end
						else
							ActivityModel.SendMessageFirst = false
							ActivityModel:RegisterCallback(function ( ... )
							-- body
							if this:isNil() then
								return
							end

							tModules.SignPanel.DataOne = UIActivitiesModel.GetServerDataAllByID(data.NextActivityID)
							if tModules.SignPanel.DataOne then
								tModules.SignPanel.DataTwo = UIActivitiesModel.GetServerDataAllByID(tModules.SignPanel.DataOne.activity_items[#tModules.SignPanel.DataOne.activity_items].argument7)
							end
							if tModules.SignPanel.Obj.activeSelf then
								UpdataSignPanel()
							end
							end)
							ActivityModel:getActivities(false)
						end

					end)
					
					-- --测试状态
					-- item.status = Status.status_received
					-- Button.spriteName = tModules.SignPanel.StrButtonNo
					-- Mask:SetActive(true)
					-- ButtonLabel.text = tModules.SignPanel.StrGeted
				end
			else
				--已领取
				Button.spriteName = tModules.SignPanel.StrButtonNo
				Mask:SetActive(true)
				ButtonLabel.text = tModules.SignPanel.StrGeted
			end

			local pos = 0
			for j=1,#item.rewards do
				local reward = item.rewards[j]
				local trs = AwardUtils.GetInstance():LoadAwardSprite(reward.id,reward.type,reward.num,obj.transform:Find('AwardPos'),reward.value,0.5)
				trs.localPosition = Vector3(pos,0,0)
				pos = pos + 100 
			end

			if i < count then
				if i >= tModules.SignPanel.SliderStep.transform.childCount then
					local stepScore = DataOne.activity_items[i].argument4
					local obj = NGUITools.AddChild(tModules.SignPanel.SliderStep.gameObject,tModules.SignPanel.SliderStepItem.gameObject)
					obj.transform.localPosition = Vector3(stepScore/maxScore * 468,0,0)
				end
			end
		end
	end
	tModules.SignPanel.Grid.enabled = true
	tModules.SignPanel.Scroll:ResetPosition()

	local curScore = 0
	for i=1,#DataOne.CampInfo do
		if DataOne.CampInfo[i].CampID == data.Camp then
			curScore = DataOne.CampInfo[i].CampScore
			break
		end
	end
	
	tModules.SignPanel.Slider.value = curScore > maxScore and maxScore or curScore / maxScore
	tModules.SignPanel.SliderLabel.text = curScore .. '/' .. maxScore
end

local function GoSign( ... )
	-- body
	tModules.SignPanel.Obj:SetActive(true)
	
	UpdataSignPanel()
end

local function GoRule( ... )
	-- body
	--print('规则！')
	local str = ManagerCsv.GetInstance():GetNameStatic('OperateConductRuleDetails')
	UIActivitiesRule:show(str)
end 

function this.init( ... )
	--一系列的按钮
	data = ...
	--跳转剧情
	UIEventListener.Get(this.page.transform:Find('Story').gameObject).onClick = function ( ... )
		-- body
		UIActivitiesButtons.close()
		--61200021001 
		UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.STORY_SCENE:ToInt(),UIDataBase.New(data.activity_items[1].argument24)), strCallBack)
	end

	local UtcTimestamp = tonumber(tostring(GUtilTime.toUtcTimestamp()))
	--跳转运营商店
	UIEventListener.Get(this.page.transform:Find('Shop').gameObject).onClick = function ( ... )
		-- body
		UIActivitiesButtons.close()
		local shopID = WaterBell.ProjX.View.Panel.ShopData.RunAcitivtyID
		if data.activity_items[1].argument25 ~= 0 then
			shopID = data.activity_items[1].argument25
		end
		UIActivitiesModel.GoOneShopPageByID( shopID,strCallBack )
	end
	this.page.transform:Find('Shop/Time'):GetComponent('UILabel').text = UIActivitiesModel.GetTimeSpanStr(data.closetime - UtcTimestamp)

	tModules = {}
	--跳转选择关卡
	tModules.Battle = {}
	tModules.Battle.Obj = this.page.transform:Find('Battle').gameObject
	tModules.Battle.Sprite = tModules.Battle.Obj.transform:GetComponent('UISprite')
	tModules.Battle.Collider = tModules.Battle.Obj.transform:GetComponent('BoxCollider')
	UIEventListener.Get(tModules.Battle.Obj).onClick = GoLevel

	tModules.Battle.Obj.transform:Find('Time'):GetComponent('UILabel').text = UIActivitiesModel.GetTimeSpanStr(data.endtime - UtcTimestamp)

	--打开规则界面
	tModules.Rule = {}
	tModules.Rule.Obj = this.page.transform:Find('Rule').gameObject
	tModules.Rule.Simple = tModules.Rule.Obj.transform:Find('Simple'):GetComponent('UILabel')
	tModules.Rule.Obj.transform:Find('Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateRuleIcon')
	UIEventListener.Get(tModules.Rule.Obj).onClick = GoRule

	tModules.Rule.Simple.text = ManagerCsv.GetInstance():GetNameStatic('OperateConductRule')

	--签到
	tModules.Sign = {}
	tModules.Sign.Obj = this.page.transform:Find('Sign').gameObject
	UIEventListener.Get(tModules.Sign.Obj).onClick = GoSign

	tModules.SignPanel = {}

	tModules.SignPanel.DataOne = UIActivitiesModel.GetServerDataAllByID(data.NextActivityID)
	if tModules.SignPanel.DataOne then
		tModules.SignPanel.DataTwo = UIActivitiesModel.GetServerDataAllByID(tModules.SignPanel.DataOne.activity_items[#tModules.SignPanel.DataOne.activity_items].argument7)
	end
	tModules.Sign.Obj:SetActive(tModules.SignPanel.DataOne)

	local Trs = this.page.transform:Find('SignPanel')
	tModules.SignPanel.Obj = Trs.gameObject
	tModules.SignPanel.Obj:SetActive(false)
	local Item 
	Item = Trs:Find('Item1').gameObject
	tModules.SignPanel.Item1 = Item
	Item:SetActive(false)
	Item = Trs:Find('Item2').gameObject
	tModules.SignPanel.Item2 = Item
	Item:SetActive(false)
	Item = Trs:Find('Item3').gameObject
	tModules.SignPanel.Item3 = Item
	Item:SetActive(false)
	local BG = Trs:Find('BG')
	tModules.SignPanel.Scroll = BG:Find('Scroll'):GetComponent('UIScrollView')
	tModules.SignPanel.Grid = tModules.SignPanel.Scroll.transform:Find('Grid'):GetComponent('UIGrid')
	BG:Find('Role/Rule/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateStageDescribe')
	BG:Find('Title'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateStageTitle')
	local Close = Trs:Find('Close').gameObject
	UIEventListener.Get(Close).onClick = function ( ... )
		-- body
		tModules.SignPanel.Obj:SetActive(false)
		
	end
	tModules.SignPanel.Slider = BG:Find('Slider'):GetComponent('UISlider')
	tModules.SignPanel.Slider.transform:Find('Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateStageProgress')
	tModules.SignPanel.SliderLabel = tModules.SignPanel.Slider.transform:Find('Value'):GetComponent('UILabel')
	tModules.SignPanel.SliderStep = tModules.SignPanel.Slider.transform:Find('Step')
	tModules.SignPanel.SliderStepItem = tModules.SignPanel.SliderStep:Find('Item')

	tModules.SignPanel.StrGet = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')
	tModules.SignPanel.StrGeted = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')

	tModules.SignPanel.StrButtonNo = 'Button_L_Normal'
	tModules.SignPanel.StrButtonYes = 'Button_S_Y_Normal'

	if data.endtime < UtcTimestamp then
		tModules.Battle.Sprite.spriteName = 'Button_ToChallenge_Locked'
		tModules.Battle.Collider.enabled = false
	else
		tModules.Battle.Sprite.spriteName = 'Button_ToChallenge_Normal'
		tModules.Battle.Collider.enabled = true
	end

	local textureRes = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/Bg/" .. data.background)
	if textureRes then
		this.page.transform:Find('BG'):GetComponent('UITexture').mainTexture = textureRes
	end

	this.hide2show( ... )
end

function this.back( ... )
	-- body
	UIActivitiesButtons:show()
end
