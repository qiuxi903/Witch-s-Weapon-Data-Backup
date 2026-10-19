--看剧情选阵营
UIActivitiesFormat65 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat65")

local this = UIActivitiesFormat65

local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
local tPlayPosition = {Vector3(0,0,0),Vector3(0,-180,0)}
local tMaskRotation = {Vector3(0,0,0),Vector3(0,180,0)}

local curData
local Lock
local Play
local tSelect
local Mask

local function checkUnlock( ... )
	-- body
	local isGroup = ...
	local item = curData.activity_items[1]
	if isGroup then
		require 'tolua.reflection'          
    	tolua.loadassembly('Assembly-CSharp')   
		local obj_Story = UserInfo.GetInstance():GetStory()
		local func = tolua.getmethod(typeof('WaterBell.ProjX.Data.Entity.Story'), 'GetStoryGroupById',typeof('System.Int64'))
	    local obj_GetStoryGroupById = func:Call(obj_Story,item.argument7)

	    local property = tolua.getproperty(typeof("WaterBell.ProjX.Data.Entity.StoryGroup"), 'Unlock')
	    local Unlock = property:Get(obj_GetStoryGroupById, null)
	    property:Destroy()

	    func:Destroy()
	    func = nil

	    return Unlock
	else
		return AwardUtils.CheckStoryUnlock(item.argument7,item.argument1)
	end
end 

local function clickPlay( ... )
	-- body
	--1.剧情ID	2.信物物品ID1	3.信物物品ID2	4.阵营序号1	5.阵营序号2	6.阵营对抗类型	7.剧情组ID
	--判断当前剧情是否解锁，1.若没解锁，则解锁看剧情，2.若已解锁，直接看剧情
	local item = curData.activity_items[1]

	if checkUnlock(false) then
		AwardUtils.OpenStory(item.argument1)
	else
		if checkUnlock(true) then
			AwardUtils.UnlockStory(item.argument7,item.argument1,curData.id,function ( ... )
				-- body
				this.hide2show( curData )
			end)
		else
			local role_id = UserInfo.GetInstance():GetPlayer().RoleID
			local request_params = {roleid = tostring(role_id),groupid = tostring(item.argument7)}
			Utils.SendMessage(21005, request_params, function(response)
				AwardUtils.UnlockStory(item.argument7,item.argument1,curData.id,function ( ... )
					-- body
					this.hide2show( curData )
				end)
			end)
		end
	end
end

local function RequestMsg( ... )
	-- body
	ActivityModel.SendMessageFirst = false
	UIActivitiesModel.RequestActivitiesData( UIActivitiesButtons.updateInfo )
end

local function ActivityCloseAwardsPanelListener( arg )
	-- body
	if arg.eventArgs then
		RequestMsg()
	else
		local timer =  Timer.New(RequestMsg, 0.7, 1, true)
		timer:Start()
	end
	GUtilListener.removeListener("ActivityCloseAwardsPanelListener", ActivityCloseAwardsPanelListener)
end

local function clickSelect( obj )
	-- body
	--若当前已经选择了阵营，return
	
	if curData.Camp ~= 0 then
		return
	end

	--选择阵营，弹出选择提示框，确认后，发送选择协议，领取信物
	local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
	--HomepageWikiTitle 确认
	--OperateSelect 确认加入阵营？
	Alert:setData(ManagerCsv.GetInstance():GetNameStatic('HomepageWikiTitle'),ManagerCsv.GetInstance():GetNameStatic('OperateSelect'))
	Alert:setListener(function ( ... )
		-- body
		--发送选择协议
		local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
		local request_params = {roleid = tostring(role_id),baseid = tostring(curData.id),serial = tostring(tonumber(obj.name))}
		Utils.SendMessage(ActivityModel.ActivityType.SelectCamp2Story.msgid, request_params, function(response)
			--如果参数2有值就处理掉落
			if curData.activity_items[1].argument2 ~= 0 then
				--等待领取奖励关闭,重新拉取运营活动数据，做一次刷新显示
				GUtilListener.addEventListener("ActivityCloseAwardsPanelListener", ActivityCloseAwardsPanelListener)

				local bytes = response.bytes
				local LuaNetProxy = LuaNetProxy.New()
				LuaNetProxy:Callback(bytes)
			else
				RequestMsg()
			end
			
			curData.Camp = tonumber(obj.name)
			this.hide2show( curData )

			--设置本地用户数据阵营选择
			local UserGameCamp = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().UserGameCamp
			if not UserGameCamp:ContainsKey(curData.activity_items[1].argument6) then
				UserGameCamp:Add(curData.activity_items[1].argument6,curData.Camp)
			end
		end)	
	end,nil)
end 

function this.init( ... )
	-- body
	local data = ...
	local Texture = this.page.transform:Find('Texture')
	Lock = this.page.transform:Find('Lock').gameObject
	local textureRes = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/Bg/" .. data.activity_items[1].argument11)
	if textureRes then
		Lock.transform:GetComponent('UITexture').mainTexture = textureRes
	end
	local textureRes = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/Bg/" .. data.background)
	if textureRes then
		Texture:GetComponent('UITexture').mainTexture = textureRes
	end

	local Rule = this.page.transform:Find('Rule')
	Rule:Find('Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateReadyRule')
	local RuleButton = Rule:Find('Button')
	RuleButton:Find('Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateRuleIcon')
	UIEventListener.Get(RuleButton.gameObject).onClick = function ( ... )
		-- body
		local str = ManagerCsv.GetInstance():GetNameStatic('OperateReadyRuleDetails')
		--print('打开详情\n' .. str)
		UIActivitiesRule:show(str)
	end

	Play = Texture.transform:Find('Play')
	Mask = this.page.transform:Find('Mask')

	tSelect = {}
	local obj = Texture.transform:Find('Left')
	local t = {}
	t.SelectLabel = obj:Find('SelectLabel'):GetComponent('UILabel')
	t.Reward = obj:Find('Reward').gameObject
	t.SelectButton = obj:Find('SelectButton').gameObject
	UIEventListener.Get(t.SelectButton).onClick = clickSelect
	t.SelectButton.name = '1'
	t.Reward = obj:Find('Reward')
	t.Mask = obj:Find('Mask')
	table.insert(tSelect,t)
	local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(data.activity_items[1].argument2,GlobalEnum.ResType.Item,0,t.Reward,0,0.4)
	trs:Find('Mid/SuperScript').gameObject:SetActive(false)
	trs:Find('Mid/IconFrame').gameObject:SetActive(false)

	local obj = Texture.transform:Find('Right')
	local t = {}
	t.SelectLabel = obj:Find('SelectLabel'):GetComponent('UILabel')
	t.Reward = obj:Find('Reward').gameObject
	t.SelectButton = obj:Find('SelectButton').gameObject
	UIEventListener.Get(t.SelectButton).onClick = clickSelect
	t.SelectButton.name = '2'
	t.Reward = obj:Find('Reward')
	t.Mask = obj:Find('Mask')
	table.insert(tSelect,t)

	local Mask
	Mask = tSelect[2].Mask
	tSelect[2].Mask = tSelect[1].Mask
	tSelect[1].Mask = Mask

	local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(data.activity_items[1].argument3,GlobalEnum.ResType.Item,0,t.Reward,0,0.4)
	trs:Find('Mid/SuperScript').gameObject:SetActive(false)
	trs:Find('Mid/IconFrame').gameObject:SetActive(false)

	UIEventListener.Get(Play.gameObject).onClick = clickPlay

	this.hide2show( data )
end

function this.hide2show( ... )
	-- body
	curData = ...

	Lock:SetActive(not checkUnlock())
	--Play.localPosition = checkUnlock() and tPlayPosition[2] or tPlayPosition[1]

	--当前选择的team
	local team = curData.Camp
	if team ~= 0 then
		--Selected 
		tSelect[team].SelectLabel.text = ManagerCsv.GetInstance():GetNameStatic('Selected')--'已选择'
		--Mask.localRotation = tMaskRotation[team]
		
		tSelect[team].Mask.gameObject:SetActive(true)
	end
	--Mask.gameObject:SetActive(team ~= 0)
end