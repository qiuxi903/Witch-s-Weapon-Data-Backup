--版式60
--中间一个大图，有一个跳转的按钮
UIActivitiesFormat60 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat60")
local this = UIActivitiesFormat60
local Texture
local Button
local page_footer_button_argument1
local UIFrame = WaterBell.ProjX.View.UIFrame
local argument14
local argument7
local argument5
local argument15
local TimeLabel
local curData

function this.clear( ... )
	-- body
	Texture = nil
	Button = nil
	page_footer_button_argument1 = nil
	argument14 = nil
	argument7 = nil
	argument5 = nil
	argument15 = nil
	TimeLabel = nil
	curData = nil
end

local function clickButton( obj )
	-- body
	-- 1 去商店，2去抽卡 3 去任务 4跳转外部网页 5前往选关卡界面 6领取对应活动类型的奖励（签到类型）7跳转限时挑战
	if page_footer_button_argument1 == 1 then
		UIActivitiesModel.GoOneShopPageByID( 47000014,'UIActivitiesFormat60.onBack' )
	elseif page_footer_button_argument1 == 2 then
		--2是金币，3是钻石
		if argument5 == 2 or argument5 == 3 then
			UIFrame.UISceneManager.getInstance():GotoBackLua(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.LOTTERY_SCENE:ToInt(),WaterBell.ProjX.View.Panel.LotteryNewPanelData.New(WaterBell.ProjX.View.Panel.LuckDrawTypes.IntToEnum(argument5),argument7)),'UIActivitiesFormat60.onBack')
		else
			UIFrame.UISceneManager.getInstance():GotoBackLua(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.LOTTERY_SCENE:ToInt(),WaterBell.ProjX.View.Panel.LotteryNewPanelData.New(curData.id)),'UIActivitiesFormat60.onBack')
		end
	elseif page_footer_button_argument1 == 3 then	
		UIFrame.UISceneManager.getInstance():GotoBackLua(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.TASK_SCENE:ToInt()),'UIActivitiesFormat60.onBack')
	elseif page_footer_button_argument1 == 4 then
		UnityEngine.Application.OpenURL(argument14)
		return
	elseif page_footer_button_argument1 == 5 then
		UIFrame.UISceneManager.getInstance():GotoBackLua(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.LEVEL_SCENE:ToInt()),'UIActivitiesFormat60.onBack')
	elseif page_footer_button_argument1 == 6 then
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
				end)
			end
		else
			--提示已经领取
			NetworkAlertUI.TryShowWarningTipByTag('OperateReceive')
		end
		return
	elseif page_footer_button_argument1 == 7 then
		UIActivitiesButtons.close(true)
		UIActivitiesChallenge.AddShow()
		return
	end
	UIActivitiesButtons.close()
end

function this.onBack( ... )
	-- body
	UIActivitiesButtons:show()
end

function this.hide2show( data )
	-- body
	page_footer_button_argument1 = data.page_footer_button_argument1
	argument14 = data.activity_items[1].argument14
	argument7 = data.activity_items[1].argument7
	argument5 = data.activity_items[1].argument5
	argument15 = data.activity_items[1].argument15
	Texture.mainTexture = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/Bg/" .. data.background)
	local ButtonSprite = Button.transform:GetComponent('UISprite')
	if argument15 ~= '' then
		--X_Y_W_H
		local argument15_strs = string.split(argument15, "_");
		if #argument15_strs ~= 4 then
			print('运营活动版式60 argument15参数格式错误，参照格式：X_Y_W_H')
			return
		end
		Button.transform.localPosition = Vector3(tonumber(argument15_strs[1]),tonumber(argument15_strs[2]),0)	
		ButtonSprite.width = tonumber(argument15_strs[3])
		ButtonSprite.height = tonumber(argument15_strs[4])
	else
		--默认
		Button.transform.localPosition = Vector3(470,60,0)
		ButtonSprite.width = 328
		ButtonSprite.height = 90
	end

	local str = ''
	if data.type == ActivityModel.ActivityType.ToPage2.typeid then
		str = UIActivitiesModel.GetTimeStampByTime( data.starttime,data.endtime )
	end
	TimeLabel.text = str

	curData = data
end

function this.init( ... )
 	-- body
 	local data = ...

 	Texture = this.page.transform:Find('Texture'):GetComponent('UITexture')
 	Button = Texture.transform:Find('Button')
 	TimeLabel = Texture.transform:Find('TimeLabel'):GetComponent('UILabel')

 	UIEventListener.Get(Button.gameObject).onClick = clickButton

 	this.hide2show(data)
end