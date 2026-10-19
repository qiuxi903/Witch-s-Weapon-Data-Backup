--新签到3
UIActivitiesFormat69 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat69")

local this = UIActivitiesFormat69

local UIResSpriteExAdd
local tUIResSpriteExAdd 
local Texture
local TimeLabel 
local ScrollView 
local Grid
local curData
local tButton
local lastActivityID

function this.clear( ... )
	-- body
	 UIResSpriteExAdd = nil
	 tUIResSpriteExAdd  = nil
	 Texture = nil
	 TimeLabel  = nil
	 ScrollView  = nil
	 Grid = nil
	 curData = nil
	 tButton = nil
	 lastActivityID = nil
end

function this.init( ... )
	-- body
	local data = ...
	UIResSpriteExAdd = this.page.transform:Find('UIResSpriteExAdd').gameObject
	UIResSpriteExAdd:SetActive(false)

	Texture = this.page.transform:Find('Texture'):GetComponent('UITexture')
	TimeLabel = this.page.transform:Find('TimeLabel'):GetComponent('UILabel')
	ScrollView = this.page.transform:Find('ScrollView'):GetComponent('UIScrollView')
	Grid = ScrollView.transform:Find('Grid'):GetComponent('UIGrid')
	tButton = {}
	tButton.Obj = this.page.transform:Find('Button').gameObject
	tButton.Sprite = tButton.Obj.transform:GetComponent('UISprite')
	tButton.Label = tButton.Obj.transform:Find('Label'):GetComponent('UILabel')
	lastActivityID = nil
	this.hide2show(data)
end

local function LoadItems( ... )
	-- body
	local reward
	local obj
	local trs
	Utils.destoryChild( Grid )	
	tUIResSpriteExAdd = {}
	local canSign = Utils.getSeverTime() - curData.DaysSignTime >= 60 * 60 * 24 or curData.DaysSignRewardTag == 0
	local t
	local strFormat = ManagerCsv.GetInstance():GetNameStatic('OperateFormatDay')
	local signDay = curData.DaysSignRewardTag + 1
	if signDay > #curData.activity_items then
		canSign = false
	end
	for i,v in ipairs(curData.activity_items) do
		reward = v.rewards[1]
		trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(reward.id,reward.type,reward.num,Grid.transform,reward.value,1)
		TweenAlpha.Begin(trs.gameObject,0.7,1,0)
		obj = NGUITools.AddChild(trs.gameObject,UIResSpriteExAdd.gameObject)
		obj:SetActive(true)
		t = {}
		t.Obj = obj
		t.Trs = t.Obj.transform
		t.Label = t.Trs:Find('Label'):GetComponent('UILabel')
		t.Label.text = string.format(strFormat,i)
		t.Selected = t.Trs:Find('Selected').gameObject
		t.Selected:SetActive(false)
		t.Can = t.Trs:Find('Can').gameObject
		t.Can:SetActive(false)
		table.insert(tUIResSpriteExAdd,t)
		
		if i < signDay then
			--已经签到的
			t.Selected:SetActive(true)
		elseif i > signDay then
			--还没有签到的

		else
			--当前的天数
		end
	end

	if canSign then
		tUIResSpriteExAdd[signDay].Can:SetActive(true)
		tButton.Sprite.spriteName = 'Button_Y_Normal'
		tButton.Label.text = ManagerCsv.GetInstance():GetNameStatic('OperateMark')
		UIEventListener.Get(tButton.Obj).onClick = function ( ... )
			local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
			local request_params = {roleid = tostring(role_id),baseid = tostring(curData.id)}
			local msgid = ActivityModel.getCode( curData.id,curData.type )
			Utils.SendMessage(msgid, request_params, function(response)
				local bytes = response.bytes
				local LuaNetProxy = LuaNetProxy.New()
				LuaNetProxy:Callback(bytes)
				curData.DaysSignRewardTag = curData.DaysSignRewardTag + 1
				curData.DaysSignTime = Utils.getSeverTime()
				--刷新红点
				UIActivitiesButtons.updateRed(curData.id)
				tUIResSpriteExAdd[signDay].Can:SetActive(false)
				tUIResSpriteExAdd[signDay].Selected:SetActive(true)
				tButton.Sprite.spriteName = 'Button_L_Normal'
				tButton.Label.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')
				UIEventListener.Get(tButton.Obj).onClick = function ( ... )
					-- body
				end
			end)
		end
	else
		tButton.Sprite.spriteName = 'Button_L_Normal'
		tButton.Label.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')
		UIEventListener.Get(tButton.Obj).onClick = function ( ... )
			-- body
		end
	end
	Grid.enabled = true

	local delta = #curData.activity_items > 3 and Mathf.Min(((curData.DaysSignRewardTag >= 2 and curData.DaysSignRewardTag < #curData.activity_items) and curData.DaysSignRewardTag/(#curData.activity_items - 1) or 0),1) or 0
	if #curData.activity_items == curData.DaysSignRewardTag then
		delta = 1
	end
	local timer = Timer.New(function ( ... )
		-- body
		ScrollView:ResetPosition()
		ScrollView:SetDragAmount(delta,0,false)
	end, 0.01 * #curData.activity_items, 1, true)
	timer:Start()
end

function this.hide2show( ... )
	-- body
	curData = ...
	if lastActivityID and lastActivityID == curData.id then
		return
	end
	TimeLabel.text = UIActivitiesModel.GetTimeStampByTime( curData.starttime,curData.endtime )
	Texture.mainTexture = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/Bg/" .. curData.background)
	LoadItems()
	lastActivityID = curData.id
end