--版式68
--周年运营领取奖励图，上面滚动轮播图片，下面一个领取按钮
UIActivitiesFormat68 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat68")
local this = UIActivitiesFormat68
local Button
local UIFrame = WaterBell.ProjX.View.UIFrame
local TimeLabel
local curData
local HaveGet

function this.clear( ... )
	-- body
	Button = nil
	TimeLabel = nil
	curData = nil
	HaveGet = nil
end

local function loadScrollPanel( ... )
	-- body
	local ScrollPanel = this.page.transform:Find('ScrollPanel')
	local tScroll = {}

	local tPos = {Vector3.New(-500,0,0),Vector3.New(0,0,0),Vector3.New(500,0,0),Vector3.New(1000,0,0)}
	local tTex = {}
	for i=1,11 do
		table.insert(tTex,'Anniversary_Sequence_' .. ((i < 10) and ('0'..i) or i))
	end

	for i=1,ScrollPanel.childCount do
		local obj = ScrollPanel:GetChild(i - 1)
		local t = {}
		t.TP = obj:GetComponent('TweenPosition')
		t.Tex = obj:GetComponent('UITexture')
		t.Tex.mainTexture = AssetsManager.LoadTextureForLua("UI/UIImage/Activities/" .. tTex[i])
		table.insert(tScroll,t)
	end

	local function nextPosIndex( index )
		-- body
		if index == 2 then
			index = 4
		else
			index = index - 1
		end
		return index
	end
	local texIndex = 1
	local function nextTexIndex( index )
		-- body
		if index == #tTex then
			index = 1
		else
			index = index + 1
		end
		return index
	end
	local function auto( TP,Tex,startPosIndex )
		-- body
		if startPosIndex == 4 then
			Tex.mainTexture = AssetsManager.LoadTextureForLua("UI/UIImage/Activities/" .. tTex[texIndex])
			texIndex = nextTexIndex(texIndex)
		end
		TP.duration = 20
		TP.from = tPos[startPosIndex]
		TP.to = tPos[startPosIndex - 1]
		TP.onEnd = function ( ... )
			-- body
			auto(TP,Tex,nextPosIndex(startPosIndex))
		end
		TP:ResetToBeginning()
		TP:PlayForward()
	end

	for i,v in ipairs(tScroll) do
		auto(v.TP,v.Tex,i + 1)
	end
end

local function clickButton( obj )
	-- body
	local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
	local request_params = {roleid = tostring(role_id),baseid = tostring(curData.id)}
	local msgid = ActivityModel.getCode( curData.id,curData.type )
	--检测是否可以领取
	if ActivityModel.isRed( ActivityModel.ServerData,curData.id) then
		if msgid then
			Utils.SendMessage(msgid, request_params, function(response)
				local bytes = response.bytes
				local LuaNetProxy = LuaNetProxy.New()
				LuaNetProxy:Callback(bytes)
				curData.DaysSignRewardTag = curData.DaysSignRewardTag + 1
				curData.DaysSignTime = Utils.getSeverTime()
				--刷新红点
				UIActivitiesButtons.updateRed(curData.id)
				Button.gameObject:SetActive(false)
				HaveGet.gameObject:SetActive(true)
			end)
		end
	else
		--提示已经领取
		NetworkAlertUI.TryShowWarningTipByTag('OperateReceive')
	end
end

function this.onBack( ... )
	-- body
	UIActivitiesButtons:show()
end

function this.hide2show( data )
	-- body
	local str = ''
	if data.type == ActivityModel.ActivityType.ToPage2.typeid then
		str = UIActivitiesModel.GetTimeStampByTime( data.starttime,data.endtime )
	end
	TimeLabel.text = str

	curData = data

	local b = ActivityModel.isRed( ActivityModel.ServerData,curData.id)
	Button.gameObject:SetActive(b)
	HaveGet.gameObject:SetActive(not b)
end

function this.init( ... )
 	-- body
 	local data = ...
 	local Texture = this.page.transform:Find('Texture')
 	Button = Texture.transform:Find('Button')
 	HaveGet = Texture.transform:Find('HaveGet')
 	TimeLabel = Texture.transform:Find('TimeLabel'):GetComponent('UILabel')

 	UIEventListener.Get(Button.gameObject).onClick = clickButton

 	this.hide2show(data)

 	loadScrollPanel()
end