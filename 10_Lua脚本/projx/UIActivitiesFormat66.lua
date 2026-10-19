--多关卡挑战型2
UIActivitiesFormat66 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat66")

local this = UIActivitiesFormat66

local selectLevelLast
local selectLevel
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

function this.clear( ... )
	-- body
	 tLevel = nil
	 data = nil
	 LabelTime = nil
	 LabelTimes = nil
	 Power = nil
	 ScrollViewAward = nil
	 GridAward = nil
	 tShowCount = nil
	 Desc = nil
	 Team = nil
	 lastActivityID = nil
end

function this.clearOnReload( ... )
	-- body
	 selectLevelLast = nil
 	 selectLevel = nil
end

local function getRealLevelID( ... )
	-- body
	local temp = data.activity_items[data.Day]
	local realID
	if selectLevel == 1 then
		realID = temp.argument7
	elseif selectLevel == 2 then
		realID = temp.argument8
	elseif selectLevel == 3 then
		realID = temp.argument9
	elseif selectLevel == 4 then
		realID = temp.argument10
	end
	return realID
end

local function showAward( ... )
	-- body
	local instance = UIActivitiesModel.GetLevelGoodsByID( getRealLevelID() )
	local item
	local trs
	Utils.destoryChild( GridAward )
	for i=1,instance.Count do
		item = instance[i - 1]
		trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(item.rawID,item.rawType,item.rawNum,GridAward.transform,item.rawValue,0.6)
		TweenAlpha.Begin(trs.gameObject,0.7,1,0)
	end
	GridAward.enabled = true
	ScrollViewAward:ResetPosition()
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

	if tShowCount[data.id] == 1 then
		showAward()
	end
end

local function initLeveButton( ... )
	-- body
	local Level = this.page.transform:Find('Level')
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
		t.Sprit.spriteName = 'Anniversary_Challenge_Difficulty' .. i
		t.LV = obj:Find('LV'):GetComponent('UILabel')
		t.LV.text = 'Lv.' .. (i + 2) * 10
		t.Star = obj:Find('Star'):GetComponent('UISprite')
		t.Star.spriteName = 'Activity_Star_'.. i ..'_Normal'
		t.InitPos = obj.transform.localPosition
		t.Trs = obj
		t.Select = obj:Find('Select').gameObject
		t.Select:SetActive(false)
		table.insert(tLevel,t)
	end

end

local function GoLevel( ... )
	-- body
	--没有选择阵营不能进入战斗
	-- local camp_combat_type = data.activity_items[data.Day].argument6
	-- local UserGameCamp = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().UserGameCamp
	-- if UserGameCamp:ContainsKey(camp_combat_type) then
	-- else
	-- 	print('还未选择阵营！！！')
	-- 	NetworkAlertUI.TryShowWarningTipBox('还未选择阵营！！！')
	-- 	return
	-- end
	--体力不足，战斗次数不足提示
	if data.activity_items[data.Day].argument5 ~= 0 then
		if data.activity_items[data.Day].argument5 - data.DayTimes == 0 then
			NetworkAlertUI.TryShowWarningTipByTag('CE41106')--战斗次数
			return
		end
	end
	if WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().Stamina < data.activity_items[data.Day].argument4 then
		NetworkAlertUI.TryShowWarningTipByTag('CE41108')--体力
		return
	end
	UIActivitiesModel.GoLevelSceneByID( getRealLevelID(),data.id,selectLevel,data.activity_items[data.Day].argument5 - data.DayTimes,data.activity_items[data.Day].argument5,nil,nil ,'UIActivitiesFormat62.back')
	UIActivitiesButtons.close(true)
end

function this.hide2show( ... )
	-- body
	data = ...

	if tShowCount and tShowCount[data.id] then
		tShowCount[data.id] = tShowCount[data.id] + 1
	else
		tShowCount = {}
		tShowCount[data.id] = 1
	end
	--Desc.text = ManagerCsv.GetInstance():GetNameStatic('OperateDesc')
	LabelTime.text = UIActivitiesModel.GetTimeStampByTime( data.starttime,data.endtime )
	Power.text = 'x' .. data.activity_items[data.Day].argument4
	local strFormat = ManagerCsv.GetInstance():GetNameStatic('Format62LeftTimes')
	if data.activity_items[data.Day].argument5 == 0 then
		LabelTimes.text = ''
	else
		LabelTimes.text =  string.format(strFormat,(data.activity_items[data.Day].argument5 - data.DayTimes) .. '/' .. data.activity_items[data.Day].argument5)
	end
	--新增配置等级
	local tLV = {}
	tLV[1] = data.activity_items[data.Day].argument16
	tLV[2] = data.activity_items[data.Day].argument17
	tLV[3] = data.activity_items[data.Day].argument18
	tLV[4] = data.activity_items[data.Day].argument19

	for i=1,#tLV do
		if tLV[i] ~= 0 then
			tLevel[i].LV.text = 'Lv.' .. tLV[i]
		end
	end
	clickLevelButton()
	--查看当前的team，应该是服务器给的

	local teamid = {}
	local CampCombatData = ManagerCsv.GetInstance():GetCampCombatAll()
	local temp
	local camp_combat_type = data.activity_items[data.Day].argument6
	local camp_serial
	local UserGameCamp = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().UserGameCamp
	if UserGameCamp:ContainsKey(camp_combat_type) then
		camp_serial = UserGameCamp[camp_combat_type]
		print('当前选择的阵营：'..camp_serial)
	else
		print('还未选择阵营！！！')
		return
	end

	if lastActivityID and lastActivityID == data.id then
		return
	end
	lastActivityID = data.id

	Utils.destoryChild(Team)
	for i=1,CampCombatData.Count do
		temp = CampCombatData[i-1]
		if tostring(temp.camp_combat_type) == tostring(camp_combat_type) and temp.camp_serial == camp_serial then
			table.insert(teamid,temp.servant_id1)
			table.insert(teamid,temp.servant_id2)
			table.insert(teamid,temp.servant_id3)
			table.insert(teamid,temp.servant_id4)
			table.insert(teamid,temp.servant_id5)
			break
		end
	end
	local trs
	for i,v in ipairs(teamid) do
		trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(v,GlobalEnum.ResType.Servant,0,Team.transform,0,0.6)
		trs:Find('Mid/IconFrame'):GetComponent('UISprite').spriteName = 'Weapon_Awaken_Unfinishedl'
	end
	Team.enabled = true
end

function this.init( ... )
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
	UIEventListener.Get(Button.gameObject).onClick = GoLevel
	UIEventListener.Get(this.page.transform:Find('Shop').gameObject).onClick = function ( ... )
		-- body
		UIActivitiesButtons.close()
		UIActivitiesModel.GoOneShopPageByID( WaterBell.ProjX.View.Panel.ShopData.RunAcitivtyID,'UIActivitiesFormat66.back' )
	end

	initLeveButton()

	this.hide2show( ... )
end

function this.back( ... )
	-- body
	UIActivitiesButtons:show()
end