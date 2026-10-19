UIActivities = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivities")
local this = UIActivities

local UISceneID = WaterBell.ProjX.View.UIFrame.UISceneID
local UISceneManager = WaterBell.ProjX.View.UIFrame.UISceneManager
local UISceneID = WaterBell.ProjX.View.UIFrame.UISceneID
local UISceneState = WaterBell.ProjX.View.UIFrame.UISceneState
local LotteryNewPanelData = WaterBell.ProjX.View.Panel.LotteryNewPanelData

--手账模板，order排序，type类型，index索引
local HandAccount ={} 

--AD模板
local ADTemplet = {}

local tItems
local tAD
local tADPoint
local tTimer

local curADIndex
local isReverse

local scrollView
local isAnimation
local UpdateTimeStep

local clickADArrowTimer
local clickADArrowTag

function this.clear( ... )
	for i,v in ipairs(tTimer) do
		if v.running then
			v:Stop()
		end
	end
	tTimer = nil

	tItems = nil
	tAD = nil
	tADPoint = nil

	curADIndex = nil
	isReverse = nil

	scrollView = nil
	isAnimation = nil
	UpdateTimeStep = nil

	clickADArrowTimer = nil
	clickADArrowTag = nil


	UpdateBeat:Remove(this.UpdateBeat,this)
end

local function close( obj )
	-- body
	--this:destory()
	--this:hide()
	--if obj then
	--	ActivityModel.getData2MainScene()
	--end
	UIActivitiesButtons.close(obj)
end

local function updateBottomModule( ... )
	-- body
	local BottomModule = this.page.transform:Find('BottomModule')

	local Award1 =BottomModule:Find('Award1')
	local Award2 = BottomModule:Find('Award2')
	--连续签到
	local data25 = UIActivitiesModel.GetServerDataByID( 25 )
	--七日连续签到
	local data26 = UIActivitiesModel.GetServerDataByID( 26 )
	if not data25 or not data26 then
		return
	end
	local data = data26
	Award1:Find('Num'):GetComponent('UILabel').text = data.DaysSignContinuityRewardTag .. '/' ..data.activity_items[1].argument4
	
	local str
	if data.activity_items[1].argument4 - data.DaysSignContinuityRewardTag == 0 then
		str = ManagerCsv.GetInstance():GetNameStatic('HomepageWikiSigninContinuity2')
		--'今日获得'
	else
		str = (data.activity_items[1].argument4 - data.DaysSignContinuityRewardTag) .. ManagerCsv.GetInstance():GetNameStatic('HomepageWikiSigninContinuity')
		--string.format('%s日后获得',data.activity_items[1].argument4 - data.DaysSignContinuityRewardTag)
	end

	Award1:Find('Title'):GetComponent('UILabel').text = str
	Award1:Find('Tips'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('HomepageWikiSigninContinuity3')

	local func25 = function ( ... )
		-- body
		local roleid = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
		local baseid = 25
		local msgParams = {roleid = tostring(roleid), baseid = tostring(baseid)}
		Utils.SendMessage(ActivityModel.ActivityType.LandingSum.msgid,msgParams, function(response)
			local LuaNetProxy = LuaNetProxy.New()
			LuaNetProxy:CallbackEX(response.bytes)
			UIActivitiesReward:show(2,data25,true)
		end)
		data25.DaysSignAutoCanTag = false
	end

	if data.DaySignContinuityCanTag then
		--发送消息领取
		local roleid = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
		local baseid = 26
		local msgParams = {roleid = tostring(roleid), baseid = tostring(baseid)}
		Utils.SendMessage(ActivityModel.ActivityType.Landing7.msgid,msgParams, function(response)
			WaterBell.ProjX.Common.Utils.AwardUtils.JPAdjustLoginReward()
			local LuaNetProxy = LuaNetProxy.New()
			LuaNetProxy:CallbackEX(response.bytes)
			if data25.DaysSignAutoCanTag then
				UIActivitiesReward:show(1,data26,true,func25)
			else
				UIActivitiesReward:show(1,data26,true)
			end
			data26.DaySignContinuityCanTag = false
		end)
	end

	--连续签到
	local data = data25
	Award2:Find('Num'):GetComponent('UILabel').text = data.DaysSignAutoDays--data.activity_items[1].argument4

	local str
	if data.DaysSignAutoDays % data.activity_items[1].argument4 == 0 then
		str = ManagerCsv.GetInstance():GetNameStatic('HomepageWikiSigninTotal2')
		--'今日获得'
	else
		str = (data.activity_items[1].argument4 - data.DaysSignAutoDays % data.activity_items[1].argument4) .. ManagerCsv.GetInstance():GetNameStatic('HomepageWikiSigninTotal')
		--string.format('%s日后获得',data.activity_items[1].argument4 - data.DaysSignAutoDays % data.activity_items[1].argument4)
	end

	Award2:Find('Title'):GetComponent('UILabel').text = str
	Award2:Find('Tips'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('HomepageWikiSigninTotal3')
	if data.DaysSignAutoCanTag then
		--发送消息领取
		--这个地方要处理下 连个消息同时发送时的先后顺序
		if not data26.DaySignContinuityCanTag then	
			func25()
		end
	end

	--新邮件提示
	BottomModule:Find('Mail/New').gameObject:SetActive(WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetMails().NewMailNum > 0)
	
	-- if (view.UserPlayerManager.Vip > 0)
 --        {
 --            int va = 0;
 --            for (int i = 0; i < ManagerCsv.GetInstance().GetConstant("CHARACTER_MAX_VIP_LEVEL").value3; i++)
 --            {
 --                if (i < view.UserPlayerManager.Vip)
 --                {
 --                    va += ManagerCsv.GetInstance().GetVip(i).exp;
 --                    //lim+= ManagerCsv.GetInstance().GetVip(i).exp;
 --                }
 --            }
 --            _exp = va + view.UserPlayerManager.VipExp;
 --            //lim+= ManagerCsv.GetInstance().GetVip(view.UserPlayerManager.Vip).exp;
 --        }
 --        else {
 --            _exp = view.UserPlayerManager.VipExp;
 --            //lim = ManagerCsv.GetInstance().GetVip(0).exp;
 --        }
 --        UIUtil.SetIsAcitonTran(mainView, developView, true);
 --        level.spriteName = "lv" + view.UserPlayerManager.Vip + "-light";
 --        nextLevel.text = view.UserPlayerManager.Vip == ManagerCsv.GetInstance().GetConstant("CHARACTER_MAX_VIP_LEVEL").value3 ? "MAX" : "Lv." + (view.UserPlayerManager.Vip+1).ToString();
 --        if (view.UserPlayerManager.Vip == ManagerCsv.GetInstance().GetConstant("CHARACTER_MAX_VIP_LEVEL").value3)
 --        {
 --            exp.text = _exp.ToString()+ "/" + GetLimit(view.UserPlayerManager.Vip).ToString();
 --            slider.fillAmount = 1;
 --        }
 --        else {
            
 --            exp.text=_exp.ToString()+"/"+ GetLimit(view.UserPlayerManager.Vip).ToString();
 --            slider.fillAmount = (float) _exp / (float)GetLimit(view.UserPlayerManager.Vip);
 --        }
	 local function GetLimit( lv )
		-- body
		-- private int GetLimit(int _level) {
	       
	 --            int limit = 0;
	 --            for (int i=0;i< _level; i++) {
	 --                limit += ManagerCsv.GetInstance().GetVip(i).exp;
	 --            }
	 --            limit += ManagerCsv.GetInstance().GetVip(_level).exp;
	 --            return limit;
	       
	 --    }
	 	local limit = 0
	 	for i=0,lv - 1 do
	 		limit = limit +  ManagerCsv.GetInstance():GetVip(i).exp;
	 	end
	 	limit = limit +  ManagerCsv.GetInstance():GetVip(lv).exp;
	 	return limit
	end
 
 	local vipLv = UIActivitiesModel.CAPHLevel()
	BottomModule:Find('CAPH/Level'):GetComponent('UISprite').spriteName = 'lv'.. vipLv ..'-light'
	local Slider = BottomModule:Find('CAPH/Slider'):GetComponent('UISlider')
	local labelSlider = Slider.transform:Find('Label'):GetComponent('UILabel')

	local vipExp = 0
	if vipLv > 0 then
		local va = 0
		for i=0,ManagerCsv.GetInstance():GetConstant("CHARACTER_MAX_VIP_LEVEL").value3 - 1 do
			if (i < vipLv) then
				va = va + ManagerCsv.GetInstance():GetVip(i).exp;
			end
		end
		vipExp = va + UserInfo.GetInstance():GetPlayer().VipExp
	else
		vipExp = UserInfo.GetInstance():GetPlayer().VipExp
	end
	
	if vipLv == ManagerCsv.GetInstance():GetConstant("CHARACTER_MAX_VIP_LEVEL").value3 then
		labelSlider.text = vipExp .. "/" .. GetLimit(vipLv)
		Slider.value = 1
	else
		labelSlider.text = vipExp .. "/" .. GetLimit(vipLv)
		Slider.value = vipExp / GetLimit(vipLv)
	end
end

local function getNextADIndex( curIndex )
	-- body
	local index
	if curIndex == #ADTemplet then
		index = 1
	else
		index = curIndex + 1
	end
	return index
end

local function getFrontADIndex( curIndex )
	-- body
	local index
	if curIndex == 1 then
		index = #ADTemplet
	else
		index = curIndex - 1
	end
	return index
end

local lastADIndex
local function updateADPoint( ... )
	-- body
	tADPoint[lastADIndex].Selected.gameObject:SetActive(false)
	tADPoint[curADIndex].Selected.gameObject:SetActive(true)

	lastADIndex = curADIndex
end

local function showADAutoAnimation( ... )
	-- body
	if clickADArrowTag or this:isNil() then
		return
	end
	local time = 5
	if isReverse then
		TweenAlpha.Begin(tAD.Self.gameObject,time,1, 0.5)
		isReverse = false
	else
		TweenAlpha.Begin(tAD.Self.gameObject,time,0.5, 1)
		isReverse = true
	end
	updateADPoint()
	tAD.Texture.mainTexture = ADTemplet[curADIndex].asset
	--tAD.TimeLabel.text = UIActivitiesModel.GetTimeStampByTime( ADTemplet[curADIndex].starttime,ADTemplet[curADIndex].endtime )
	local timer = Timer.New(function ( ... )
		-- body
		curADIndex = getNextADIndex( curADIndex )
		showADAutoAnimation()
	end, time, 1, true)
	table.insert(tTimer,timer)
	timer:Start()
end

local function clickADArrow( obj )
	-- body
	if not clickADArrowTag then
		--curADIndex = getFrontADIndex( curADIndex )
	end
	clickADArrowTag = true
	local name = obj.name
	local curIndex
	if name == 'LArrow' then
		--向左
		curIndex = getFrontADIndex(curADIndex)
	else
		--向右
		curIndex = getNextADIndex(curADIndex)
	end
	tAD.TweenAlpha.enabled = false
	tAD.Texture.alpha = 1
	tAD.Texture.mainTexture = ADTemplet[curIndex].asset
	curADIndex = curIndex
	updateADPoint()
	if clickADArrowTimer and clickADArrowTimer.running then
		clickADArrowTimer:Reset(function ( ... )
		-- body
		clickADArrowTag = false
		tAD.TweenAlpha:ResetToBeginning()
		showADAutoAnimation()
		end, 2, 1, true)

		return
	end
	clickADArrowTimer = Timer.New(function ( ... )
		-- body
		clickADArrowTag = false
		tAD.TweenAlpha:ResetToBeginning()
		showADAutoAnimation()
	end, 2, 1, true)
	table.insert(tTimer,clickADArrowTimer)
	clickADArrowTimer:Start()
end

local function clickAD( ... )
	-- body
	--[[
	类型	编号	参数1	参数2	参数3
	战服	1	战服ID
	商店	2	商店总集ID
	商品	3	商店集ID	商店ID	商品ID
	公告	4	公告ID
	]]
	local data = ADTemplet[curADIndex]
	local typeid = data.typeid
	if typeid == 1 then
		--战服
		close()
		UIActivitiesModel.GoClothesPageByID( data.parameter[1],'UIActivities.onBack' )
	elseif typeid == 2 then
		--商店
		close()
		UIActivitiesModel.GoOneShopPageByID( data.parameter[1],'UIActivities.onBack' )
	elseif typeid == 3 then
		--4个参数的商店
		close()
		UIActivitiesModel.GoOneShopPageByIDs( data.parameter[4],data.parameter[1],data.parameter[2],data.parameter[3],'UIActivities.onBack' )
	elseif typeid == 4 then
		--公告
		--close()
		WaterBell.ProjX.Common.Utils.AwardUtils.GoNoticeOnePage(data.parameter[1])
	elseif typeid == 5 then
		WaterBell.ProjX.Common.Utils.AwardUtils.OpenWebURLNotie(data.parameter[5],false,nil)
	else
		print('未知AD跳转类型：'..typeid)
	end
end

local function loadAD( ... )
	-- body
	local ADPanel = this.page.transform:Find('ADPoster/ADPanel')
	UIEventListener.Get(ADPanel:Find('RArrow').gameObject).onClick = clickADArrow
	UIEventListener.Get(ADPanel:Find('LArrow').gameObject).onClick = clickADArrow
	local ADPoint = ADPanel:Find('ADPoint')
	ADPoint.gameObject:SetActive(false)
	local ADPointRoot = ADPanel:Find('ADPointRoot')

	local data = ActivityModel.ServerData
	--local data = UIActivitiesModel.GetServerDatasByTypeID( ActivityModel.ActivityType.AD.typeid )

	ADTemplet = {}
	for i,v in ipairs(data) do
		local t = {}
		--{name = 'AD3',parameter = 3,asset = 1},
		t.name = v.background
		local asset = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/AD/" .. t.name)
		--如果有资源才显示
		if asset then
			t.asset = asset
			t.starttime = v.starttime
			t.endtime = v.endtime
			t.id = v.id
			t.typeid = 0
			t.parameter = {}
			if v.type == ActivityModel.ActivityType.AD.typeid then
				t.typeid = v.activity_items[1].argument4
				table.insert(t.parameter,v.activity_items[1].argument1)
				table.insert(t.parameter,v.activity_items[1].argument2)
				table.insert(t.parameter,v.activity_items[1].argument3)
				table.insert(t.parameter,v.activity_items[1].argument7)
				table.insert(t.parameter,v.activity_items[1].argument11)
			end
			table.insert(ADTemplet,t)
		end
	end

	table.sort(ADTemplet,function ( a,b )
		-- body
		return a.id < b.id
	end)

	tADPoint = {}

	--若当前没有任何AD内容，显示默认
	local isCanClickAD = true
	if #ADTemplet == 0 then
		local t = {}
		local asset = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/AD/default")
		t.asset = asset
		table.insert(ADTemplet,t)
		isCanClickAD = false
	end

	for i,v in ipairs(ADTemplet) do
		local item = NGUITools.AddChild(ADPointRoot.gameObject,ADPoint.gameObject)
		item.gameObject:SetActive(true)
		local t = {}
		t.Selected = item.transform:Find('Selected')
		table.insert(tADPoint,t)
	end
	ADPointRoot:GetComponent('UIGrid').enabled = true

	tAD = {}

	local t = {}
	t.Self = ADPanel:Find('AD')
	t.Texture = t.Self:GetComponent('UITexture')
	t.TweenAlpha = t.Self:GetComponent('TweenAlpha')
	t.TimeLabel = t.Self:Find('TimeLabel'):GetComponent('UILabel')
	if isCanClickAD then
		UIEventListener.Get(t.Self.gameObject).onClick = clickAD
	end
	tAD = t

	curADIndex = 1
	lastADIndex = 1
	isReverse = true
	clickADArrowTag = false
	tAD.Texture.mainTexture = ADTemplet[curADIndex].asset

	showADAutoAnimation()
	if #ADTemplet == 1 then
		ADPanel:Find('RArrow').gameObject:SetActive(false)
		ADPanel:Find('LArrow').gameObject:SetActive(false)
	end
end

local function loadGoPage( ... )
	-- body
	local URL_Announcement
	local URL_Wiki
	local URL_BAHAMUT_TW
	local URL_DISCORD_EN
	if 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_one or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_google or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_one_test or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_google_test or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr_test
		then

		URL_Announcement = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Announcement_KR')
		URL_Wiki = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Wiki_KR')

	elseif
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp_test
		then

		URL_Announcement = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Announcement_JP')
		URL_Wiki = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Wiki_JP')
		URL_Twitter = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Twitter_JP')
	elseif
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw
	then

		URL_Announcement = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Announcement_TW')
		URL_Wiki = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Wiki_TW')
		URL_BAHAMUT_TW = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_BAHAMUT_TW')
	elseif
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en
	then
		URL_Announcement = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Announcement_EN')
		URL_Wiki = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Wiki_EN')
		URL_DISCORD_EN = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_DISCORD_EN')
	elseif
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_pc_dmm_jp or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_pc_dmm_jp_test
	then
		URL_Announcement = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Announcement_JP_PC')
		URL_Wiki = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Wiki_JP_PC')	
	else
		URL_Announcement = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Announcement')
		URL_Wiki = ManagerCsv.GetInstance():GetClientPlatformConstant('URL_Wiki')
	end


	local BottomModule = this.page.transform:Find('BottomModule')
	UIEventListener.Get(BottomModule.transform:Find('Notice').gameObject).onClick = function ( ... )
		-- body
		--跳转公告
		--close()
		--WaterBell.ProjX.Common.Utils.AwardUtils.GoNoticeOnePage(-1)
		
		--WaterBell.ProjX.Common.Utils.AwardUtils.OpenWebURLNotie(URL_Announcement,false,nil)
		GUtilUISuper.show(typeof(UIAnnouncement),"UIAnnouncement", nil,true);
	end

	UIEventListener.Get(BottomModule.transform:Find('Mail').gameObject).onClick = function ( ... )
		-- body
		--跳转邮件
		--close(true)
		UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.MAIL_SCENE:ToInt()),'UIActivities.onBack')
	end

	UIEventListener.Get(BottomModule.transform:Find('Wiki').gameObject).onClick = function ( ... )
		-- body
		--跳转WiKi
		WaterBell.ProjX.Common.Utils.AwardUtils.OpenWebURLNotie(URL_Wiki,false,nil)
	end

	UIEventListener.Get(BottomModule.transform:Find('CAPH').gameObject).onClick = function ( ... )
		-- body
		--跳转CAPH
		close()
		UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.VIP_SCENE:ToInt()), 'UIActivities.onBack')
	end

	UIEventListener.Get(BottomModule.transform:Find('Award1').gameObject).onClick = function ( ... )
		-- body
		--test
		UIActivitiesReward:show(1,UIActivitiesModel.GetServerDataByID( 26 ))
	end

	UIEventListener.Get(BottomModule.transform:Find('Award2').gameObject).onClick = function ( ... )
		-- body
		--test
		UIActivitiesReward:show(2,UIActivitiesModel.GetServerDataByID( 25 ))
	end

	--bahamute
	if URL_BAHAMUT_TW then
		local obj = BottomModule.transform:Find('Bahamute').gameObject
		obj:SetActive(true)
		UIEventListener.Get(obj).onClick = function ( ... )
			-- body
			WaterBell.ProjX.Common.Utils.AwardUtils.OpenWebURLNotie(URL_BAHAMUT_TW,false,nil)
		end
	end
	if URL_Twitter then
		local obj = BottomModule.transform:Find('Twitter').gameObject
		obj:SetActive(true)
		UIEventListener.Get(obj).onClick = function ( ... )
			-- body
			WaterBell.ProjX.Common.Utils.AwardUtils.OpenWebURLNotie(URL_Twitter,false,nil)
		end
	end
	if URL_DISCORD_EN then
		local obj = BottomModule.transform:Find('Discord').gameObject
		obj:SetActive(true)
		UIEventListener.Get(obj).onClick = function ( ... )
			-- body
			WaterBell.ProjX.Common.Utils.AwardUtils.OpenWebURLNotie(URL_DISCORD_EN,false,nil)
		end
	end
end

local function endAnimation( ... )
	-- body
	this.updateView()
	isAnimation = false
end

local function showAnimation( curIndex )
	-- body
	local cellHeight = grid.cellHeight
	local time = 0.3
	for i,v in ipairs(tItems) do
		if i == curIndex then
			local eventDelegate = function ( ... )
				-- body
				for i,v in ipairs(tItems) do
					if i == #tItems then
						local timer = Timer.New(endAnimation, time, 1, true)
						table.insert(tTimer,timer)
						timer:Start()
					end

					if i > curIndex then
						TweenPosition.Begin(tItems[i].Self.gameObject, time,Vector3.New(0, tItems[i].Self.localPosition.y + cellHeight, 0))
					end
				end
			end
			local timer = Timer.New(eventDelegate, time, 1, true)
			table.insert(tTimer,timer)
			timer:Start()
			TweenPosition.Begin(tItems[i].Self.gameObject,time,Vector3.New(300, tItems[i].Self.localPosition.y, 0))

			isAnimation = true
		end
	end
end

local function clickMask( obj )
	-- body
	--print(obj.name)
	--showAnimation(tonumber(obj.name))

	if obj.transform:Find('Mask').gameObject.activeSelf then
		local index = tonumber(obj.name)
		local t = tItems[index]
		if t.Name == 'Shop2' then
			NetworkAlertUI.TryShowWarningTipByTag('Homepage7#5')
		elseif t.Name == 'Shop3' then
			NetworkAlertUI.TryShowWarningTipByTag('HomepageWeekend5')
		elseif t.Name == 'CAPH1' or t.Name == 'CAPH2' then
			NetworkAlertUI.TryShowWarningTipByTag('HomepageLock')
		else
			NetworkAlertUI.TryShowWarningTipByTag('HomepageClear')
		end
	end
end

local function updateItems( ... )
	-- body
	for i,v in ipairs(HandAccount) do
		local t = tItems[i]
		t.Num.gameObject:SetActive(false)
		t.Button.gameObject:SetActive(false)
		t.ButtonMask.gameObject:SetActive(false)
		t.ButtonEX.gameObject:SetActive(false)
		t.Mask.gameObject:SetActive(false)
		t.Statue.gameObject:SetActive(false)
		t.Tips.gameObject:SetActive(false)
		t.TimeEX.gameObject:SetActive(false)
		t.Time.gameObject:SetActive(false)
		t.StatueTips.gameObject:SetActive(false)
		t.Name = v.type..v.index
		if v.type == 'CAPH' then
			t.SelfSprite.spriteName = 'Account_List_Resources'
			t.ButtonSprite.spriteName = 'Button_Account_Get_Normal'
			t.Icon.spriteName = 'Icon_Gift_' .. v.index
			t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('HomepageClickReceive')--'点击领取'

			if v.index == 1 then
				t.Title.text = ManagerCsv.GetInstance():GetNameStatic('HomepageCAPHBag1')--'CAPH基础礼包'
			elseif v.index == 2 then
				t.Title.text = ManagerCsv.GetInstance():GetNameStatic('HomepageCAPHBag2')--'CAPH进阶礼包'
			end
			local tGetLevel = {2,5}
			if UIActivitiesModel.CAPHLevel() >= tGetLevel[v.index] then
				t.Num.gameObject:SetActive(true)
				if UIActivitiesModel.CAPHCanGet( v.index ) then
					t.Button.gameObject:SetActive(true)
					t.ButtonListener.onClick = function ( ... )
						-- body
						--发送消息领取CAPH礼包
						UIActivitiesModel.CAPHGetReward( v.index )
					end

					t.Num.text = '0/1'
				else
					t.Mask.gameObject:SetActive(true)
					v.Mask = true
					t.Num.text = '1/1'
					t.Tips.gameObject:SetActive(true)
					t.Tips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageCAPHBag2')--'今日礼包已领取'
				end
			else
				t.Mask.gameObject:SetActive(true)
				v.Mask = true
				t.Tips.gameObject:SetActive(true)
				t.Tips.text = v.index == 1 and ManagerCsv.GetInstance():GetNameStatic('HomepageCAPHBag4') or ManagerCsv.GetInstance():GetNameStatic('HomepageCAPHBag5') --'需CAPH Lv'..tGetLevel[v.index]
			end
		elseif v.type == 'Task' then
			t.SelfSprite.spriteName = 'Account_List_Task'
			t.ButtonSprite.spriteName = 'Button_Account_Check_Normal'
			t.Icon.spriteName = 'Icon_Daily_Task'
			t.Title.text = ManagerCsv.GetInstance():GetNameStatic('HomepageDaily')--'日常任务'
			t.ButtonEX.gameObject:SetActive(true)
			t.ButtonEXListener.onClick = function ( ... )
				-- body
				--跳转日常任务
				close()
				UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.TASK_SCENE:ToInt()),'UIActivities.onBack')
			end

			local left,right = UIActivitiesModel.GetTaskSomeCount()
			t.Num.gameObject:SetActive(true)
			t.Num.text = left .. '/' .. right

			t.Tips.gameObject:SetActive(true)
			if left == right then
				t.Tips.text =  ManagerCsv.GetInstance():GetNameStatic('HomepageDailyDesc2')--'今日日常任务已完成'
				t.Mask.gameObject:SetActive(true)
				v.Mask = true
			else
				t.Tips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageDailyDesc')--'可获得CAPH点数x605'
			end
		elseif v.type == 'Power' then
			t.SelfSprite.spriteName = 'Account_List_Resources'
			t.ButtonSprite.spriteName = 'Button_Account_Get_Normal'
			t.Icon.spriteName = 'Icon_AP_' .. v.index
			t.Title.text = ManagerCsv.GetInstance():GetNameStatic('HomepageStamina')--'行动力补给' .. v.index
			
			local Data = UIActivitiesModel.GetPowerInfo()
			local StartTime,EndTime,CanReceive = Data.StartTime,Data.EndTime,Data.CanReceive
			local curTime = Utils.getSeverTime()
			t.Time.gameObject:SetActive(true)
			t.TimeLabel.text = os.date("%H:%M",StartTime) .. '-' .. os.date("%H:%M",EndTime)

			--判断当前时间所处的时间段，
			if curTime >= StartTime then
				--1 正在其中 
				if CanReceive then
					t.Button.gameObject:SetActive(true)
					local curIndex = i
					t.ButtonListener.onClick = function ( ... )
						-- body
						--发送消息领取体力
						local roleid = tostring(WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID)
						local msgParams = {roleid = roleid}
						Utils.SendMessage(ActivityModel.ActivityType.GetPower.msgid,msgParams, function(response)
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:ShowStamina()
							--刷新本地数据
							Data.CanReceive = false
							--this.hide2show()
							showAnimation(curIndex)
						end
						)
					end
					t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('HomepageClickReceive')--'点击领取'
				else

					t.Mask.gameObject:SetActive(true)
					v.Mask = true
					t.StatueTips.gameObject:SetActive(true)
					t.StatueTips.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--'已领取'
				end
			else
				--2 将要进入
				t.Button.gameObject:SetActive(true)
				t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('HomepageClickCD')--'未到时间'
				t.ButtonMask.gameObject:SetActive(true)
				Data.CanReceive = true
			end

		elseif v.type == 'Draw' then
			t.SelfSprite.spriteName = 'Account_List_Inform'
			t.ButtonSprite.spriteName = 'Button_Account_Go_Normal'
			t.Icon.spriteName = v.index == 1 and 'Icon_Gold' or 'Icon_Card'
			t.Title.text = v.index == 1 and ManagerCsv.GetInstance():GetNameStatic('HomepageDrawGold1') or ManagerCsv.GetInstance():GetNameStatic('HomepageDrawDiamonds1')--'每日免费金币祈愿' or '每日免费抽卡祈愿'

			local canFree,freeTime,freeCount,freeCountMax
			local drawType
			if v.index == 1 then
				--金币
				drawType = WaterBell.ProjX.View.Panel.LuckDrawTypes.Gold
				t.Tips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageDrawGold3')--'今日【免费金币祈愿】已完成'
			elseif v.index == 2 then
				drawType = WaterBell.ProjX.View.Panel.LuckDrawTypes.Diamond
				t.Tips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageDrawGold3')--'今日【免费抽卡祈愿】已完成'
			end
			canFree,isFree,freeTime,freeCount,freeCountMax = UIActivitiesModel.GetDrawSomeInfoByType( drawType )

			t.Num.text = freeCount .. '/' .. freeCountMax
			--判断当前金币抽卡是否有免费次数
			if freeCount == freeCountMax then
				t.Mask.gameObject:SetActive(true)
				v.Mask = true
				t.Tips.gameObject:SetActive(true)
			else
				t.Button.gameObject:SetActive(true)
				t.ButtonListener.onClick = function ( ... )
					-- body
					--跳转抽卡
					close()
					UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.LOTTERY_SCENE:ToInt(),LotteryNewPanelData.New(drawType,-1)),'UIActivities.onBack')
				end
				--判断当前金币抽卡率刷新时间是多少
				if canFree then
					if isFree then
						--可以抽
						t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('HomepageClickView')--'前往'
					else
						--等待时间
						t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('HomepageClickCD')--'未到时间'
						t.ButtonMask.gameObject:SetActive(true)
						t.TimeEX.gameObject:SetActive(true)
						t.TimeEXTips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageDrawGold2')--'下次领取时间:'
						t.TimeEXLabel.text = UIActivitiesModel.GetTimeSpanStr( freeTime -  GUtilTime.serverTimeFormat)
					end
				end
			end
		elseif v.type == 'Shop' then
			t.SelfSprite.spriteName = 'Account_List_Inform'
			t.ButtonSprite.spriteName = 'Button_Account_Go_Normal'
			t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('HomepageClickView')--'前往'
			local shopsID
			--[[
			44000001 杂货商店
			44000014 7#
			44000012 周末
			]]

			local bigShopsID
			--[[
			47000004 杂货商店
			47000011 7#
			47000012 周末
			]]

			if v.index == 1 then
				t.Icon.spriteName = 'Icon_Shop_Normal'
				t.Title.text = ManagerCsv.GetInstance():GetNameStatic('HomepageShop1')--'杂货商店'
				shopsID = 44000001
				bigShopsID = 47000004
				t.TimeEXTips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageShop3')--'新品到货时间:'
				t.TimeEXLabel.text = UIActivitiesModel.GetTimeSpanStr(UIActivitiesModel.GetOneShopUpdateTimeByID( shopsID ))
			elseif v.index == 2 then
				t.Icon.spriteName = 'Icon_Shop_7#'
				t.Title.text = ManagerCsv.GetInstance():GetNameStatic('Homepage7#1')--'7#商店'
				shopsID = 44000014
				bigShopsID = 47000011
				t.TimeEXTips.text = ManagerCsv.GetInstance():GetNameStatic('Homepage7#2')--'商店关闭时间:'
				t.Tips.text = ManagerCsv.GetInstance():GetNameStatic('Homepage7#4')--'7#商店已离开都市'
				t.TimeEXLabel.text = UIActivitiesModel.GetTimeSpanStr(UIActivitiesModel.GetShopSetStopTimeByID( shopsID ) - GUtilTime.toUtcTimestamp())
			elseif v.index == 3 then
				t.Icon.spriteName = 'Icon_Shop_Weekend'
				t.Title.text = ManagerCsv.GetInstance():GetNameStatic('HomepageWeekend1')--'周末商店'
				shopsID = 44000012
				bigShopsID = 47000012
				t.TimeEXTips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageWeekend2')--'商店关闭时间:'
				t.Tips.text = ManagerCsv.GetInstance():GetNameStatic('HomepageWeekend5')--'周末商店未营业'
				t.TimeEXLabel.text = UIActivitiesModel.GetTimeSpanStr(UIActivitiesModel.GetShopSetStopTimeByID( shopsID )- GUtilTime.toUtcTimestamp())
			end
			local CanShow = UIActivitiesModel.CanShowShopSetByID(shopsID)
			if CanShow then
				t.TimeEX.gameObject:SetActive(true)
				t.Button.gameObject:SetActive(true)
				t.ButtonListener.onClick = function ( ... )
					-- body
					--跳转商店
					close()
					UIActivitiesModel.GoOneShopPageByID( bigShopsID,'UIActivities.onBack' )
				end
				if v.index ~= 1 then
					t.Statue.gameObject:SetActive(true)
				end
			else
				t.Mask.gameObject:SetActive(true)
				v.Mask = true
				t.Tips.gameObject:SetActive(true)
			end
		end
	end
	grid.enabled = true
end

local function sortItems( ... )
	-- body
	--[[
	排序规则：
	1.Mask
	2.color 1 > 2 > 3
	3.index 
	]]

	table.sort(HandAccount,function ( a,b )
		-- body
		if a.Mask ~= b.Mask then
			return not a.Mask
		end
		if a.color ~= b.color then
			return a.color < b.color
		end
		--if a.index ~= b.index then
		--	return a.index < b.index
		--end
		return a.order < b.order
	end)

	updateItems()
end

function this.updateView( ... )
	-- body
	if this.page == nil then
		return
	end
	for i,v in ipairs(HandAccount) do
		local t = tItems[i]
		v.Mask = false
		if v.type == 'CAPH' then
			local tGetLevel = {2,5}
			if UIActivitiesModel.CAPHLevel() >= tGetLevel[v.index] then
				if UIActivitiesModel.CAPHCanGet( v.index ) then
				else
					v.Mask = true
				end
			else
				v.Mask = true
			end
		elseif v.type == 'Task' then
			local left,right = UIActivitiesModel.GetTaskSomeCount()
			if left == right then
				v.Mask = true
			end
		elseif v.type == 'Power' then
			
			local Data = UIActivitiesModel.GetPowerInfo()
			if not Data then
				return
			end
			local StartTime,EndTime,CanReceive = Data.StartTime,Data.EndTime,Data.CanReceive
			local curTime = Utils.getSeverTime()

			--判断当前时间所处的时间段，
			if curTime >= StartTime then
				--1 正在其中 
				if CanReceive then
				else
					v.Mask = true
				end
			end

		elseif v.type == 'Draw' then

			local canFree,freeTime,freeCount,freeCountMax
			if v.index == 1 then
				--金币
				canFree,isFree,freeTime,freeCount,freeCountMax = UIActivitiesModel.GetDrawSomeInfoByType( WaterBell.ProjX.View.Panel.LuckDrawTypes.Gold )

			elseif v.index == 2 then
				canFree,isFree,freeTime,freeCount,freeCountMax = UIActivitiesModel.GetDrawSomeInfoByType( WaterBell.ProjX.View.Panel.LuckDrawTypes.Diamond )

			end
			--判断当前金币抽卡是否有免费次数
			if freeCount == freeCountMax then
				v.Mask = true
			end
		elseif v.type == 'Shop' then
			local shopsID
			--[[
			44000001 杂货商店
			44000014 7#
			44000012 周末
			]]

			if v.index == 1 then
				shopsID = 44000001
			elseif v.index == 2 then
				shopsID = 44000014
			elseif v.index == 3 then
				shopsID = 44000012
			end
			local CanShow = UIActivitiesModel.CanShowShopSetByID(shopsID)
			if CanShow then
			else
				v.Mask = true
			end
		end
	end
	sortItems()
end

local function loadItems( ... )
	-- body
	tItems = {}
	local root = grid.gameObject
	local child = this.page.transform:Find('RightBG/Item').gameObject
	child:SetActive(false)
	for i,v in ipairs(HandAccount) do
		local item = NGUITools.AddChild(root,child).transform
		item.gameObject:SetActive(true)
		local t = {}
		t.Self = item
		t.Name = item.name
		t.SelfSprite = item:GetComponent('UISprite')
		t.Icon = item:Find('Icon'):GetComponent('UISprite')
		t.Title = item:Find('Title'):GetComponent('UILabel')
		t.Num = item:Find('Num'):GetComponent('UILabel')
		t.Button = item:Find('Button')
		t.ButtonListener = UIEventListener.Get(t.Button.gameObject)
		t.ButtonSprite = t.Button:GetComponent('UISprite')
		t.ButtonLabel = t.Button:Find('Label'):GetComponent('UILabel')
		t.ButtonMask = t.Button:Find('Mask')
		t.ButtonEX = item:Find('ButtonEX')
		t.ButtonEXListener = UIEventListener.Get(t.ButtonEX.gameObject)
		t.Mask = item:Find('Mask')
		t.Statue = item:Find('Statue')
		t.Tips = item:Find('Tips'):GetComponent('UILabel')
		t.TimeEX = item:Find('TimeEX')
		t.TimeEXTips = t.TimeEX:Find('Tips'):GetComponent('UILabel')
		t.TimeEXLabel = t.TimeEX:Find('Label'):GetComponent('UILabel')
		t.Time = item:Find('Time')
		t.TimeLabel = t.Time:Find('Label'):GetComponent('UILabel')
		t.StatueTips = item:Find('StatueTips'):GetComponent('UILabel')
		t.TweenPosition = item:GetComponent('TweenPosition')
		table.insert(tItems,t)
		item.name = i
		UIEventListener.Get(t.Self.gameObject).onClick = clickMask
	end

	--grid.enabled = true
end

function this.init( ... )
	tTimer = {}

	scrollView = this.page.transform:Find('RightBG/Items'):GetComponent('UIScrollView')
	grid = scrollView.transform:Find('Grid'):GetComponent('UIGrid')
	--this.page.transform:Find('TopLine/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('HomepageTitle')
	--this.page.transform:Find('LeftTopButton/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('HomepageName')
	--this.page.transform:Find('RightBG/CAPH/Button/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('HomepageClickView')

	--UIEventListener.Get(this.page.transform:Find('TopLine/ButtonBack').gameObject).onClick = close

	HandAccount =
	{
		{order = 1,color = 1,type = 'CAPH',index = 1,Mask = false},--CAPH基础礼包
		{order = 2,color = 1,type = 'CAPH',index = 2,Mask = false},--CAPH进阶礼包
		{order = 3,color = 1,type = 'Power',index = 1,Mask = false},--体力一阶段
		--{order = 4,color = 1,type = 'Power',index = 2,Mask = false},--体力二阶段
		--{order = 5,color = 1,type = 'Power',index = 3,Mask = false},--体力三阶段
		{order = 6,color = 2,type = 'Draw',index = 1,Mask = false},--金币抽卡
		{order = 7,color = 2,type = 'Draw',index = 2,Mask = false},--钻石抽卡
		{order = 8,color = 2,type = 'Shop',index = 1,Mask = false},--杂货商点
		{order = 9,color = 2,type = 'Shop',index = 2,Mask = false},--7#商店
		{order = 10,color = 2,type = 'Shop',index = 3,Mask = false},--周末商店
		{order = 11,color = 3,type = 'Task',index = 1,Mask = false},--日常任务
	} 

	--增加条件检测
	local delIndex
	local level =  WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer():GetCurrentLevel();
	local lockLevel = ManagerCsv.GetInstance():GetConstant('ACTIVITY_MAINPAGE_MISSION_LEVEL').value3
	for i,v in ipairs(HandAccount) do
		if v.type == 'Task' and level < lockLevel then
			delIndex = i
		end
	end
	if delIndex then
		table.remove(HandAccount,delIndex)
	end

	loadGoPage()
	loadItems()
	--this.hide2show()
	this.updateView()

	loadAD()
	updateBottomModule()

	isAnimation = false
	UpdateTimeStep = 1
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this.onBack( ... )
	-- body
	-- local timer = Timer.New(function ( ... )
	-- 	-- body
	-- 	--UIActivities:show()
	-- 	UIActivitiesButtons:show()
	-- end, 0.1, 1, true)
	-- timer:Start()
	UIActivitiesButtons:show()
	
	UIWindowsManager.GetInstance():AddCloseAction(UIActivitiesButtons.realBack)
end

function this.hide2show( ... )
	-- body
end

function this.UpdateBeat( ... )
	-- body
	if this:isNil() then
		UpdateBeat:Remove(this.UpdateBeat,this)
		return
	end
	UpdateTimeStep = UpdateTimeStep - Time.deltaTime
	if UpdateTimeStep < 0 then
		UpdateTimeStep = 1
	else
		return
	end
	if isAnimation then
		return
	end
	this.updateView()
end