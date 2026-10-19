UIActivitiesChallengeSelectLevel = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesChallengeSelectLevel",AssetsManager.AssetsType.LuaAssets2)

local this = UIActivitiesChallengeSelectLevel

local selectLevelLast
local selectLevel

local selectHardLevel

local tLevel
local data
local LabelTime
local LabelTimes
local Power
local ScrollViewAward
local GridAward
local tShowCount
local Desc
local Team
local lastActivityID

local tAwardObj
local LabelTimesEx
local showOriginType

local tSelector
local tHardLevel
local bNormal

local tBuffPanel
local cacheLastID

function this.clear( ... )
	-- body
	 tLevel = nil
	 LabelTime = nil
	 LabelTimes = nil
	 Power = nil
	 ScrollViewAward = nil
	 GridAward = nil
	 tShowCount = nil
	 Desc = nil
	 Team = nil
	 lastActivityID = nil
	 tAwardObj = nil
	 LabelTimesEx = nil
	 tSelector = nil
	 --tHardLevel = nil
	 tBuffPanel = nil
end

function this.clearOnReload( ... )
	-- body
	 selectLevelLast = nil
 	 selectLevel = nil
 	 selectHardLevel = nil
 	 bNormal = nil
end

local function ClickClose( ... )
	-- body
	this:destory()
	UIWindowsManager.GetInstance():RemoveAction()
end

local function getRealLevelID( ... )
	-- body
	--local temp = data.activity_items[data.Day]
	local realID
	-- if selectLevel == 1 then
	-- 	realID = temp.argument7
	-- elseif selectLevel == 2 then
	-- 	realID = temp.argument8
	-- elseif selectLevel == 3 then
	-- 	realID = temp.argument9
	-- elseif selectLevel == 4 then
	-- 	realID = temp.argument10
	-- end
	local temp = data.NormalInstances
	realID = temp[selectLevel].ID
	return realID
end

local function showAward( ... )
	-- body
	local id = data.activity_items[1].argument15
	
	id = string.split(id,'|')
	local trs
	local temp
	for i=1,#id do
		temp = tonumber(id[i])
		trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(temp,GlobalEnum.ResType.Item,0,tAwardObj.Root.transform,0,0.7)
		trs:Find('Mid/SuperScript').gameObject:SetActive(false)
		trs:Find('Mid/IconFrame').gameObject:SetActive(false)

		trs = NGUITools.AddChild(trs.gameObject,tAwardObj.Num.gameObject)
		trs.transform.localPosition = Vector3(50,-10,0)
		trs.transform:GetComponent('UILabel').text = 'x' .. UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,temp )		
	end
	tAwardObj.Root.enabled = true
end

local function clickLevelButton( obj )
	-- body
	local index
	if obj then
		tShowCount[data.id] = 1
		index = tonumber(obj.name)
	else
		if selectLevelLast then
			index = selectLevelLast
		else
			index = 1
		end
	end

	selectLevel = index
	if selectLevelLast then
		-- tLevel[selectLevelLast].Sprit.spriteName = 'Button_Activity_Difficulty_Normal'
		-- tLevel[selectLevelLast].Star.spriteName = 'Activity_Star_'.. selectLevelLast ..'_Normal'
		-- if obj then
		-- 	TweenPosition.Begin(tLevel[selectLevelLast].Obj, 0.3, tLevel[selectLevelLast].InitPos)
		-- else
		-- 	tLevel[selectLevelLast].Trs.localPosition = tLevel[selectLevelLast].InitPos
		-- end
		tLevel[selectLevelLast].Select:SetActive(false)
		tLevel[selectLevelLast].Trs.localScale = Vector3.one * 0.8
	end
	-- if tLevel[selectLevel].Trs.localPosition ~= tLevel[selectLevel].InitPos then
	-- 	tLevel[selectLevel].Trs.localPosition = tLevel[selectLevel].InitPos
	-- end
	-- tLevel[selectLevel].Sprit.spriteName = 'Button_Activity_Difficulty_Selection'
	-- tLevel[selectLevel].Star.spriteName = 'Activity_Star_'.. selectLevel ..'_Pressed'
	-- if obj then
	-- 	TweenPosition.Begin(tLevel[selectLevel].Obj, 0.3, tLevel[selectLevel].Trs.localPosition + Vector3(20, 0, 0))
	-- else
	-- 	tLevel[selectLevel].Trs.localPosition = tLevel[selectLevel].InitPos + Vector3(20, 0, 0)
	-- end
	tLevel[selectLevel].Select:SetActive(true)
	tLevel[selectLevel].Trs.localScale = Vector3.one
	selectLevelLast = selectLevel

end

local function initLeveButton( ... )
	-- body
	local Level = this.page.transform:Find('Level')
	tSelector.LevelObj = Level
	local obj
	tLevel = {}
	local t = {}
	local tStr = {'普通','困难','高手','大师'}
	for i=1,Level.childCount do
		obj = Level:GetChild(i - 1)

		t = {}
		t.Obj = obj.gameObject
		t.Obj.name = i
		UIEventListener.Get(t.Obj).onClick = clickLevelButton
		t.Label = obj:Find('Label'):GetComponent('UILabel')
		UILabelLanguage.AddDictionaryStatic(t.Label,tStr[i])
		t.Sprit = obj:GetComponent('UISprite')
		t.Sprit.spriteName = 'Challenge_Hard' .. i
		t.LV = obj:Find('LV'):GetComponent('UILabel')
		t.LV.text = 'Lv.' .. (i + 2) * 10
		t.Star = obj:Find('Star'):GetComponent('UISprite')
		t.Star.spriteName = 'Activity_Star_'.. i ..'_Normal'
		t.InitPos = obj.transform.localPosition
		t.Trs = obj
		t.Trs.localScale = Vector3.one * 0.8
		t.Select = obj:Find('Select').gameObject
		t.Select:SetActive(false)
		table.insert(tLevel,t)
	end

end

local function GetInstancePower( id )
	-- body
	local instance = ManagerCsv.GetInstance():GetInstance(id)
	return instance.instance_stamina_victory + instance.instance_stamina_enter
end

local function SendPreMsg( _mode,_instanceid )
	-- body
	local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
	local request_params = {roleid = tostring(role_id),baseid = tostring(data.id),serial = '1',mode = tostring(_mode),instanceid = tostring(_instanceid)}

	Utils.SendMessageInBackGround(40019, request_params, function ( ... )
		-- body
	end)
end 

local function GoLevel( ... )
	-- body
	--没有选择阵营不能进入战斗
	-- local camp_combat_type = data.activity_items[1].argument6
	-- local UserGameCamp = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().UserGameCamp
	-- if UserGameCamp:ContainsKey(camp_combat_type) then
	-- else
	-- 	print('还未选择阵营！！！')
	-- 	NetworkAlertUI.TryShowWarningTipBox('还未选择阵营！！！')
	-- 	return
	-- end
	if not bNormal then
		if not selectHardLevel then
			--当前没有选中的副本！
			NetworkAlertUI.TryShowWarningTipBox(ManagerCsv.GetInstance():GetNameStatic('ChallengeNoChooseTips'))
			return
		end
		--SendPreMsg('2',tHardLevel[selectHardLevel].InstanceID)

		ClickClose()
		UIActivitiesModel.GoLevelSceneByID( tHardLevel[selectHardLevel].InstanceID,data.id,selectLevel,1,1 ,2,nil,'UIActivitiesChallengeSelectLevel.back')
		return
	end
	--体力不足，战斗次数不足提示
	if data.activity_items[1].argument5 ~= 0 then
		if data.activity_items[1].argument5 - data.DayTimes == 0 then
			NetworkAlertUI.TryShowWarningTipByTag('CE41106')--战斗次数
			return
		end
	end
	if WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().Stamina < data.activity_items[1].argument4 then
		NetworkAlertUI.TryShowWarningTipByTag('CE41108')--体力
		return
	end
	--SendPreMsg('1',getRealLevelID())
	ClickClose()
	UIActivitiesModel.GoLevelSceneByID( getRealLevelID(),data.id,selectLevel,data.activity_items[1].argument5 - data.DayTimes,data.activity_items[1].argument5,1,nil ,'UIActivitiesChallengeSelectLevel.back')
end

function this.hide2show( ... )
	-- body
	data,showOriginType = ...
	if tShowCount and tShowCount[data.id] then
		tShowCount[data.id] = tShowCount[data.id] + 1
	else
		tShowCount = {}
		tShowCount[data.id] = 1
	end
	--Desc.text = ManagerCsv.GetInstance():GetNameStatic('OperateDesc')
	LabelTime.text = UIActivitiesModel.GetTimeStampByTime( data.starttime,data.endtime )
	--Power.text = 'x' .. data.activity_items[1].argument4
	local strFormat = ManagerCsv.GetInstance():GetNameStatic('Format62LeftTimes')
	if data.activity_items[1].argument5 == 0 then
		LabelTimes.text = ''
	else
		LabelTimes.text =  string.format(strFormat,(data.activity_items[1].argument5 - data.DayTimes) .. '/' .. data.activity_items[1].argument5)
	end
	--新增配置等级
	local tLV = {}
	tLV[1] = data.activity_items[1].argument16
	tLV[2] = data.activity_items[1].argument17
	tLV[3] = data.activity_items[1].argument18
	tLV[4] = data.activity_items[1].argument19

	for i=1,#tLV do
		if tLV[i] ~= 0 then
			tLevel[i].LV.text = 'Lv.' .. tLV[i]
		end
	end
	clickLevelButton()

	local strFormat = ManagerCsv.GetInstance():GetNameStatic('MultipleTimesStrEx')
	--通关奖励增加%s%%，剩余%s/%s次
	--每天前%s次,通关奖励增加%s%%
	if data.activity_items[1].argument2 == 0 then
		LabelTimesEx.text = ''
	else
		LabelTimesEx.text = string.format(strFormat,data.activity_items[1].argument3/100,math.max(data.activity_items[1].argument2 - data.HighTimes,0),data.activity_items[1].argument2)
		--LabelTimesEx.text = string.format(strFormat,math.max(data.activity_items[data.Day].argument2 - data.HighTimes,0))
	end

	UIWindowsManager.GetInstance():AddCloseAction(function ( ... )
		-- body
		ClickClose()
		if showOriginType == 2 then
			UIActivitiesChallenge.AddShow()
		else
			UIActivitiesButtons:show()
		end
	end)
end

local function GoBuffer( obj )
	-- body
	local index = tonumber(obj.transform:GetChild(0).gameObject.name)

	tBuffPanel.Obj:SetActive(true)
	local obj
	for i,v in ipairs(tBuffPanel.Data[index]) do
		if v.icon ~= '' then
			if tBuffPanel.Grid:GetChild(i - 1) then
				obj = tBuffPanel.Grid:GetChild(i - 1)
			else
				obj = NGUITools.AddChild(tBuffPanel.Grid.gameObject,tBuffPanel.Item.gameObject)
			end

			obj.transform:Find('Icon'):GetComponent('UISprite').spriteName = v.icon
			obj.transform:Find('Name'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetName(v.name)
			obj.transform:Find('Desc'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetName(v.desc)
			obj.gameObject:SetActive(true)
		end
	end

	for i=#tBuffPanel.Data[index] + 1,tBuffPanel.Grid.transform.childCount do
		tBuffPanel.Grid:GetChild(i - 1).gameObject:SetActive(false)
	end

	tBuffPanel.Grid.enabled = true
	tBuffPanel.ScrollView:ResetPosition()
end

local function GoSelectHardLevel( obj )
	-- body
	local index
	if obj then
		index = tonumber(obj.name)
	else
		index = selectHardLevel
	end
	if selectHardLevel then
		tHardLevel[selectHardLevel].Selected:SetActive(false)
	end
	selectHardLevel = index

	tHardLevel[selectHardLevel].Selected:SetActive(true)

	Power.text = 'x' .. GetInstancePower(tHardLevel[selectHardLevel].InstanceID)
end

local function InitHardLevel( ... )
	-- body
	local HardLevel = this.page.transform:Find('HardLevel')
	tSelector.HardLevelObj = HardLevel
	--一共要加载的剧情组
	local tInstanceSet = {}
	for i=1,# data.activity_items do
		if data.activity_items[i].argument22 ~= 0 then
			table.insert(tInstanceSet,data.activity_items[i].argument22)
		end
	end
	if #tInstanceSet == 0 then
		print('没有任何的挑战关卡数据！')
		return
	end
	tBuffPanel = {}
	local BuffPanel = this.page.transform:Find('BuffPanel')
	tBuffPanel.Obj = BuffPanel.gameObject

	UIEventListener.Get(BuffPanel:Find('Close').gameObject).onClick = function ( ... )
		-- body
		BuffPanel.gameObject:SetActive(false)
	end
	BuffPanel:Find('BG/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateChallengeBuffDetails')
	tBuffPanel.ScrollView = BuffPanel:Find('ScrollView'):GetComponent('UIScrollView')
	tBuffPanel.Grid = tBuffPanel.ScrollView.transform:Find('Grid'):GetComponent('UIGrid')
	tBuffPanel.Item = tBuffPanel.Grid:GetChild(0)
	tBuffPanel.Data = {}
	tSelector.Obj:SetActive(true)

	tHardLevel = {}
	local HardLeveGrid = HardLevel:Find('Grid'):GetComponent('UIGrid')
	local HardLeveItem = HardLeveGrid.transform:Find('HardLeveItem')

	local InstanceStructure = CSVPool.InstanceStructure()
	local function GetInstanceTable( id )
		-- body
		local t = {}
		table.insert(t,id)
		for i,v in ipairs(InstanceStructure) do
			if v.ID == id and v.next_instance1 ~= 0 then
				id = v.next_instance1
				table.insert(t,v.next_instance1)
			end
		end
		return t
	end
	
	local InstanceMobList = CSVPool.InstanceMobList()
	local BattleEnvironment = CSVPool.BattleEnvironment()
	local Buff = CSVPool.Buff()

	local function GetBuffer( id )
		-- body
		local tempID
		--根据副本ID，在 InstanceMobList 查询 globalbuff
		for i,v in ipairs(InstanceMobList) do
			if v.ID == id then
				tempID = v.globalbuff
				break
			end
		end
		if not tempID then
			return
		end

		local tempBuff
		--根据 globalbuff 在 BattleEnvironment 查询 mob_buff1 至 mob_buff5
		for i,v in ipairs(BattleEnvironment) do
			if v.ID == tempID then
				tempBuff = {}
				if v.mob_buff1 ~= 0 then
					table.insert(tempBuff,v.mob_buff1)
				end
				if v.mob_buff2 ~= 0 then
					table.insert(tempBuff,v.mob_buff2)
				end
				if v.mob_buff3 ~= 0 then
					table.insert(tempBuff,v.mob_buff3)
				end
				if v.mob_buff4 ~= 0 then
					table.insert(tempBuff,v.mob_buff4)
				end
				if v.mob_buff5 ~= 0 then
					table.insert(tempBuff,v.mob_buff5)
				end
				break
			end
		end
		if not tempBuff then
			return
		end

		local t = {}
		local temp
		--根据 mob_buff1 - 5 在 Buff 查询 名称、图标

		for i,v in ipairs(tempBuff) do
			for ii,vv in ipairs(Buff) do
				if vv.ID == v then
					temp = {}
					temp.name = vv.buff_name
					temp.icon = vv.buff_icon
					temp.desc = vv.buff_description
					table.insert(t,temp)
					break
				end
			end
		end
		return t
	end

	local function GetShowInstance( t )
		-- body
		--从某个副本级中 根据当前服务器数据 查询能打的副本是哪个
		for i,v in ipairs(data.ChallengeInstances) do
			for ii,vv in ipairs(t) do
				if v.ID == vv then
					if v.Status and v.BattleCount == 0 then
						return v.ID,ii,true
					end
				end
			end
		end
		return t[1],1,false
	end
	local SeverTime = Utils.getSeverTime()
	local function GetTimeSeconds( id )
		-- body
		for i,v in ipairs(data.ChallengeInstanceSet) do
			if v.SetID == id then
				return v.StartTime - SeverTime
			end
		end
		return -1
	end

	local bufferStr = ManagerCsv.GetInstance():GetNameStatic('OperateChallengeBuffDetails')
	local noSelect
	if not selectHardLevel then
		selectHardLevel = 1
	end
	local tempObj
	for i=1,#tInstanceSet do
		if HardLeveGrid:GetChild(i - 1) then
			tempObj = HardLeveGrid:GetChild(i - 1).gameObject
		else
			tempObj = NGUITools.AddChild(HardLeveGrid.gameObject,HardLeveItem.gameObject)
		end

		local first_instance = ManagerCsv.GetInstance():GetInstanceSet(tInstanceSet[i]).first_instance

		local tInstance = GetInstanceTable(tonumber(tostring(first_instance)))
		local id,index,tag = GetShowInstance(tInstance)

		tempObj.name = i

		--查询当前副本是否为可打副本

		local instance = ManagerCsv.GetInstance():GetInstance(id)
		local instance_power = instance.instance_power

		local instance_name = instance.instance_name
		local instance_name = ManagerCsv.GetInstance():GetName(instance_name)

		local Detail = tempObj.transform:Find('Detail')

		tempObj.transform:Find('LevelIcon'):GetComponent('UISprite').spriteName = 'Challenge_2_Hard_' .. index
		Detail.transform:Find('Name'):GetComponent('UILabel').text = instance_name
		--'战力：%s'
		Detail.transform:Find('Power'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('战力:') .. instance_power
		--'推荐级别：%s'
		Detail.transform:Find('Level'):GetComponent('UILabel').text = string.format(ManagerCsv.GetInstance():GetNameStatic('ChallengeRecommendLevel'),data.activity_items[index].argument12)

		local BuffButton = Detail.transform:Find('Button')
		BuffButton:GetChild(0).gameObject.name = i
		BuffButton:GetChild(0).transform:GetComponent('UILabel').text = bufferStr
		UIEventListener.Get(BuffButton.gameObject).onClick = GoBuffer

		UIEventListener.Get(tempObj).onClick = GoSelectHardLevel

		local t = {}
		t.Selected = tempObj.transform:Find('Selected').gameObject
		t.InstanceID = id
		table.insert(tHardLevel,t)

		--buffer
		local Buffer = Detail.transform:Find('Buffer'):GetComponent('UIGrid')
		local BufferItem = Buffer.transform:Find('BufferItem')

		local BufferData = GetBuffer(id)
		local tempBuffObj
		local childCount = Buffer.transform.childCount
		for ii,vv in ipairs(BufferData) do
			if ii <= childCount then
				tempBuffObj = Buffer.transform:GetChild(ii - 1)
			else
				tempBuffObj = NGUITools.AddChild(Buffer.gameObject,BufferItem.gameObject)
			end
			tempBuffObj.gameObject:SetActive(true)
			tempBuffObj.transform:GetComponent('UISprite').spriteName = vv.icon
		end
		for i=#BufferData,Buffer.transform.childCount - 1 do
			Buffer.transform:GetChild(i).gameObject:SetActive(false)
		end

		Buffer.enabled = true

		table.insert(tBuffPanel.Data,BufferData)

		--如果当前关卡开启中，并且没有能打的状态，显示通关
		local timeSceonds = GetTimeSeconds(tInstanceSet[i]) -- 开始时间 - 当前服务器时间
		local timeTag = timeSceonds < 0 --已开启
		--1.判断时间是否到达
		if timeTag then
			--时间已到
			--2.判断当前有没有可以打得关卡，
			if tag then
				--有可以打的
				tempObj.transform:Find('Disabled').gameObject:SetActive(false)
				Detail.gameObject:SetActive(true)
				tempObj.transform:Find('End').gameObject:SetActive(false)
			else
				--没有可以打得，已通关
				Detail.gameObject:SetActive(false)
				tempObj.transform:Find('End').gameObject:SetActive(true)
				tempObj.transform:Find('Disabled').gameObject:SetActive(false)
				tempObj.transform:Find('LevelIcon'):GetComponent('UISprite').spriteName = 'Challenge_2_Hard_' .. #tInstance
				if selectHardLevel == i then
					noSelect = true
					selectHardLevel = nil
					-- selectLevel = selectLevel + 1
					-- if selectLevel > #tInstanceSet then
					-- 	noSelect = true
					-- 	selectHardLevel = nil
					-- end
				end
			end
		else
			--时间未到，未开启
			Detail.gameObject:SetActive(true)
			tempObj.transform:Find('End').gameObject:SetActive(false)
			tempObj.transform:Find('Disabled').gameObject:SetActive(true)
			tempObj.transform:Find('Disabled/Label'):GetComponent('UILabel').text = UIActivitiesModel.GetTimeSpanStr(timeSceonds)
		end
	end

	--要是上一次选中的关已经通关了，就不提供默认选择

	if noSelect then
	else
		GoSelectHardLevel()
	end
end

local function SelectorChoose( obj )
	-- body
	if obj then
		bNormal = obj.name == 'Normal'
	end
	
	if bNormal then
		--普通模式
		Power.text = 'x' .. GetInstancePower(getRealLevelID())
	else
		--挑战模式
		if selectHardLevel then
			Power.text = 'x' .. GetInstancePower(tHardLevel[selectHardLevel].InstanceID)
		else
			Power.text = 'x0'
		end
	end
	--showAward()
	LabelTimesEx.gameObject:SetActive(bNormal)

	tSelector.Labels[2].color = bNormal and Color.gray or Color.white
	tSelector.Labels[1].color = not bNormal and Color.gray or Color.white
	tSelector.Sprits[2].spriteName = bNormal and 'Button_Tab_Model_Normal' or 'Button_Tab_Model_Sellected'
	tSelector.Sprits[1].spriteName = not bNormal and 'Button_Tab_Model_Normal' or 'Button_Tab_Model_Sellected'
	tSelector.LevelObj.gameObject:SetActive(bNormal)
	tSelector.HardLevelObj.gameObject:SetActive(not bNormal)
end

function this.init( ... )
	data = ...
	--多个活动同时开启，前后进入不一致时，清空缓存数据
	if cacheLastID and cacheLastID ~= data.id then
		this.clearOnReload()
	end
	cacheLastID = data.id

	local Button = this.page.transform:Find('Button')
	Desc = this.page.transform:Find('Desc'):GetComponent('UILabel')
	Power = this.page.transform:Find('Power'):GetComponent('UILabel')
	LabelTime = this.page.transform:Find('LabelTime'):GetComponent('UILabel')
	LabelTimes = this.page.transform:Find('LabelTimes'):GetComponent('UILabel')
	ScrollViewAward = this.page.transform:Find('ScrollViewAward'):GetComponent('UIScrollView')
	GridAward  = ScrollViewAward.transform:Find('Grid'):GetComponent('UIGrid')
	Team = this.page.transform:Find('Team'):GetComponent('UIGrid')
	--data = UIActivitiesModel.GetServerDataByID( 53 )
	tShowCount = nil
	tAwardObj = {}
	local Award = this.page.transform:Find('Award')
	tAwardObj.Root = Award:Find('Root'):GetComponent('UIGrid')
	tAwardObj.Num = Award:Find('Num'):GetComponent('UILabel')
	--tAwardObj.Num.gameObject:SetActive(false)
	LabelTimesEx = this.page.transform:Find('LabelTimesEx'):GetComponent('UILabel')

	UIEventListener.Get(Button.gameObject).onClick = GoLevel

	--如果是炼金活动，跳转炼金
	local relationID = data.activity_items[1].argument14
	relationID = string.split(relationID,'|')

	local dataEquip
	if relationID[1] then
		relationID[1] = tonumber(relationID[1])
		if relationID[2] then
			relationID[2] = tonumber(relationID[2])
		end

		local temp = UIActivitiesModel.GetServerDataAllByID( relationID[1])
		if not temp then
			temp = UIActivitiesModel.GetServerDataAllByID( relationID[2] )
		end
		dataEquip = temp
	end
	local Shop = this.page.transform:Find('Shop')
	local TimesLevel = this.page.transform:Find('TimesLevel'):GetComponent('UILabel')
	if dataEquip then
		Shop:Find('Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('UIActivitiesChallengeSelectLevel_GoCopyEquip') --'前往炼金'
		UIEventListener.Get(Shop.gameObject).onClick = function ( ... )
			ClickClose()
			UIActivitiesButtons.ShowOnePage(dataEquip.id,dataEquip.format)
		end
		-- 累计通关次数：%s
		local task = data.activity_items[1].argument13
		task = string.split(task,'|')

		if task[1] then
			local id = tonumber(task[#task]) 
			local taskData = UIActivitiesModel.GetTaskDescByID(id )
			local progress = taskData.argu1
			for i=1,#task do
				local id = tonumber(task[i]) 
				local state = UIActivitiesModel.GetTaskStatusByID( id )
				if state == 3 then
					progress = UIActivitiesModel.GetTaskProgressByID( id )
					break
				end
			end
			TimesLevel.text = string.format(ManagerCsv.GetInstance():GetNameStatic('UIActivitiesChallengeSelectLevel_TimesLevel'),progress)
		else
			TimesLevel.text = ''
		end
	else
		TimesLevel.text = ''
		UIEventListener.Get(Shop.gameObject).onClick = function ( ... )
			-- body
			ClickClose()
			--参数位25 用于指定 对应参数的商店
			local id 
			if data.activity_items[1].argument25 ~= '' then
				id = data.activity_items[1].argument25
			else
				id = WaterBell.ProjX.View.Panel.ShopData.RunAcitivtyID
			end
			UIActivitiesModel.GoOneShopPageByID( id,'UIActivitiesChallengeSelectLevel.back' )
		end
	end

	if data.activity_items[1].argument26 ~= '' then
		this.page.transform:Find('BG/Role'):GetComponent('UITexture').mainTexture = AssetsManager.LoadTextureForLua('UI/UIImage/Servant00_Image/Servant00_Image_' .. data.activity_items[1].argument26,this.assetsType)
	end

	UIEventListener.Get(this.page.transform:Find('Close').gameObject).onClick = function ( ... )
		-- body
		ClickClose()
		if showOriginType == 2 then
			UIActivitiesChallenge.AddShow()
		else
			UIActivitiesButtons:show()
		end

		if UIActivitiesButtons.page then
			UIActivitiesButtons:show()
		end
	end

	local Selector = this.page.transform:Find('Selector')
	tSelector = {}
	tSelector.Obj = Selector.gameObject
	tSelector.Obj:SetActive(false)
	tSelector.Sprits = {}
	tSelector.Labels = {}
	local tempTrs
	for i=1,2 do
		tempTrs = Selector:GetChild(i - 1)
		UIEventListener.Get(tempTrs.gameObject).onClick = SelectorChoose
		tSelector.Sprits[i] = tempTrs:GetComponent('UISprite')
		tSelector.Labels[i] = tempTrs:Find('Label'):GetComponent('UILabel')
		tSelector.Labels[i].text = i == 1 and ManagerCsv.GetInstance():GetNameStatic('OperateChallengeNormalMode') or ManagerCsv.GetInstance():GetNameStatic('OperateChallengeChallengeMode')
	end

	initLeveButton()

	InitHardLevel()
	if bNormal == nil then
		bNormal = true
	end

	showAward()

	this.hide2show( ... )

	SelectorChoose()
end

local function showBack( ... )
	-- body
	data = UIActivitiesModel.GetServerDataAllByID(data.id)

	this:show(data,showOriginType)
end

function this.back( ... )
	-- body
	ActivityModel.MsgUpdateUIFunc = showBack
	ActivityModel.getData2MainScene()
end
