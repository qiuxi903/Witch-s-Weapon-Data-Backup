--特殊Panel，用于主界面扩展
local this = {}

local satinRoseBtn
local welfareBtn
local supplyBtn
local Table
local firstRechargeBtn
local plotAndCheckpointBtn
local oldUserRegressionSystemBtn
local satinRoseBtn_redPoint
local welfareBtn_redPoint
local firstRechargeBtn_redPoint
local plotAndCheckpointBtn_redPoint
local oldUserRegressionSystemBtn_redPoint
local satinRoseBtn_time
local welfareBtn_time
local firstRechargeBtn_time
local plotAndCheckpointBtn_time
local oldUserRegressionSystemBtn_time

function this:Awake( obj )
	-- body
	--print("Awake:"..obj.name)

	local LeftTop = obj.transform:Find('ElementUI/LeftTop')
	Table = LeftTop:Find('Table'):GetComponent('UITable')

	satinRoseBtn = Table.transform:Find('satinRoseBtn').gameObject
	welfareBtn = Table.transform:Find('welfareBtn').gameObject
	firstRechargeBtn = Table.transform:Find('firstRechargeBtn').gameObject
	plotAndCheckpointBtn = Table.transform:Find('plotAndCheckpointBtn').gameObject
	oldUserRegressionSystemBtn = Table.transform:Find('oldUserRegressionSystemBtn').gameObject

	local RightTop = obj.transform:Find('ElementUI/RightTop')
	supplyBtn = RightTop.transform:Find('supplyBtn').gameObject

	satinRoseBtn_redPoint = satinRoseBtn.transform:Find('redPoint').gameObject
	welfareBtn_redPoint = welfareBtn.transform:Find('redPoint').gameObject
	firstRechargeBtn_redPoint = firstRechargeBtn.transform:Find('redPoint').gameObject
	plotAndCheckpointBtn_redPoint = plotAndCheckpointBtn.transform:Find('redPoint').gameObject
	oldUserRegressionSystemBtn_redPoint = oldUserRegressionSystemBtn.transform:Find('redPoint').gameObject

	satinRoseBtn_time = satinRoseBtn.transform:Find('time'):GetComponent('UILabel')
	welfareBtn_time = welfareBtn.transform:Find('time'):GetComponent('UILabel')
	firstRechargeBtn_time = firstRechargeBtn.transform:Find('time'):GetComponent('UILabel')
	plotAndCheckpointBtn_time = plotAndCheckpointBtn.transform:Find('time'):GetComponent('UILabel')
	oldUserRegressionSystemBtn_time = oldUserRegressionSystemBtn.transform:Find('time'):GetComponent('UILabel')

	--MainScenePanelAdd.UpdateUI()
end

function this:OnEnable( obj )
	-- body
	--print("OnEnable:"..obj.name)
	MainScenePanelAdd.UpdateRed()
	--临时 蔽掉 进入主界面屏 任何的打开回调
	LuaPanelHelper.Clear()
end

-- function this:Start( obj )
-- 	-- body
-- 	print("Start:"..obj.name)

-- 	--local library = RightTop.transform:Find('library')
-- 	--UpdateBeat:Add(this.UpdateBeat,this)
-- end

-- function this:OnDisable( obj )
-- 	-- body
-- 	print("OnDisable:"..obj.name)
-- end

function this:OnDestroy()
	-- body
	--print("OnDestroy")
	--UpdateBeat:Remove(this.UpdateBeat,this)

	satinRoseBtn = nil
	welfareBtn = nil
	supplyBtn = nil
	Table = nil
	firstRechargeBtn = nil
	satinRoseBtn_redPoint = nil
	welfareBtn_redPoint = nil
	firstRechargeBtn_redPoint = nil
	satinRoseBtn_time = nil
	welfareBtn_time = nil
	firstRechargeBtn_time = nil
end

-- function this.UpdateBeat( ... )
-- 	-- body
-- end

local function GetTimeStr( data )
	-- body
	local v = data
	local day = (v.closetime - tonumber(tostring(GUtilTime.toUtcTimestamp()))) / (60 * 60 * 24)
	day = math.floor(day)
	if day >= 1000 then
		return ManagerCsv.GetInstance():GetNameStatic('HomepageForever')--"永久开放"
	else
		return UIActivitiesModel.GetTimeSpanStr((v.closetime - tonumber(tostring(GUtilTime.toUtcTimestamp()))))--day.."天"
	end
end

MainScenePanelAdd = {}
--外部消息调用刷新
function MainScenePanelAdd.UpdateUI( ... )
	if not satinRoseBtn then
		return
	end
	print('刷新主界面Lua部分信息！')
	-- body
	--获取当前最新运营活动数据，刷新UI显示

	--刷新探员福利的显示
	local data19 = UIActivitiesModel.GetServerDataAllByID( 19 )
	if not data19 then
		data19 = UIActivitiesModel.GetServerDataAllByID( 996 )
	end
	welfareBtn:SetActive(data19 ~= nil)
	if data19 then
		UIEventListener.Get(welfareBtn).onClick = function ( ... )
			-- body	
			UIActivityPageGift.addShow(data19)
		end
		satinRoseBtn_time.text = GetTimeStr(data19)
	end
	--刷新玫瑰之约的显示
	local data54 = UIActivitiesModel.GetServerDataAllByID( 54 )
	if not data54 then
		data54 = UIActivitiesModel.GetServerDataAllByID( 997 )
	end
	satinRoseBtn:SetActive(data54 ~= nil)
	if data54 then
		UIEventListener.Get(satinRoseBtn).onClick = function ( ... )
			-- body
			UIActivityPageCompleteNew.addShow(data54)
		end
		welfareBtn_time.text = GetTimeStr(data54)
	end

	--首冲活动
	local data998 = UIActivitiesModel.GetServerDataAllByID( 998 )
	if data998 and not data998.IsReceive then
		firstRechargeBtn:SetActive(true)
	else
		firstRechargeBtn:SetActive(false)
	end
	if data998 then
		UIEventListener.Get(firstRechargeBtn).onClick = function ( ... )
			UIActivitiesFirstRecharge:show()
		end
		--firstRechargeBtn_time.text = GetTimeStr(data998)
	end
	firstRechargeBtn_time.gameObject:SetActive(false)

	--刷新体力补给的显示
	local data999 = UIActivitiesModel.GetServerDataAllByID( 999 )
	supplyBtn:SetActive(data999.CanReceive)
	if data999.CanReceive then
		local roleid = tostring(WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID)
		local msgParams = {roleid = roleid}
		UIEventListener.Get(supplyBtn).onClick = function ( ... )
			-- body
			Utils.SendMessage(ActivityModel.ActivityType.GetPower.msgid,msgParams, function(response)
				local LuaNetProxy = LuaNetProxy.New()
				LuaNetProxy:ShowStamina()
				--刷新本地数据
				data999.CanReceive = false
				supplyBtn:SetActive(false)

				ActivityModel.getData2MainScene()
			end)
		end
	end
	--刷新看剧情和通关活动的活动
	local data995 = UIActivitiesModel.GetServerDataAllByID( 995 )
	plotAndCheckpointBtn:SetActive(data995 ~= nil)
	if data995 then
		UIEventListener.Get(plotAndCheckpointBtn).onClick = function ( ... )
			UIPlotAndCheckpoint:show()
		end
		plotAndCheckpointBtn_time.text = GetTimeStr(data995)
	end
	--老用户回归活动
	local data991 = UIActivitiesModel.GetServerDataAllByID( 991 )
	if not data991 then
		data991 = UIActivitiesModel.GetServerDataAllByID( 992 )
	end
	if not data991 then
		data991 = UIActivitiesModel.GetServerDataAllByID( 993 )
	end
	oldUserRegressionSystemBtn:SetActive(data991 ~= nil)
	if data991 then
		UIEventListener.Get(oldUserRegressionSystemBtn).onClick = function ( ... )
			UIOldUserRegressionSystem:show()
		end
		oldUserRegressionSystemBtn_time.text = GetTimeStr(data991)
	end

	Table:Reposition()

	MainScenePanelAdd.showOnNewDay()
end

function MainScenePanelAdd.UpdateRed( ... )
	-- body
	if not satinRoseBtn then
		return
	end
	print('刷新主界面Lua部分红点！')
	local data17 = UIActivitiesModel.GetServerDataAllByID( 17 )
	local data19 = UIActivitiesModel.GetServerDataAllByID( 19 )
	local data54 = UIActivitiesModel.GetServerDataAllByID( 54 )
	if not data54 then
		data54 = UIActivitiesModel.GetServerDataAllByID( 997 )
	end
	local data998 = UIActivitiesModel.GetServerDataAllByID( 998 )
	local data994 = UIActivitiesModel.GetServerDataAllByID( 994 )
	local data995 = UIActivitiesModel.GetServerDataAllByID( 995 )
	local data993 = UIActivitiesModel.GetServerDataAllByID( 993 )
	local data992 = UIActivitiesModel.GetServerDataAllByID( 992 )
	local data991 = UIActivitiesModel.GetServerDataAllByID( 991 )
	welfareBtn_redPoint:SetActive(UIActivitiesModel.GetIsRedByData( data17 ) or UIActivitiesModel.GetIsRedByData( data19 ))
	satinRoseBtn_redPoint:SetActive(UIActivitiesModel.GetIsRedByData( data54 ))
	firstRechargeBtn_redPoint:SetActive(UIActivitiesModel.GetIsRedByData( data998 ))
	plotAndCheckpointBtn_redPoint:SetActive(UIActivitiesModel.GetIsRedByData( data994 ) or UIActivitiesModel.GetIsRedByData( data995 ))
	oldUserRegressionSystemBtn_redPoint:SetActive(UIActivitiesModel.GetIsRedByData( data993 ) or UIActivitiesModel.GetIsRedByData( data992 ) or UIActivitiesModel.GetIsRedByData( data991 ))
end

function MainScenePanelAdd.CheckIsOneRed( ... )
	-- body
	local data17 = UIActivitiesModel.GetServerDataAllByID( 17 )
	if UIActivitiesModel.GetIsRedByData( data17 ) then
		return true
	end
	local data19 = UIActivitiesModel.GetServerDataAllByID( 19 )
	if UIActivitiesModel.GetIsRedByData( data19 ) then
		return true
	end
	local data54 = UIActivitiesModel.GetServerDataAllByID( 54 )
	if not data54 then
		data54 = UIActivitiesModel.GetServerDataAllByID( 997 )
	end
	if UIActivitiesModel.GetIsRedByData( data54 ) then
		return true
	end
	local data998 = UIActivitiesModel.GetServerDataAllByID( 998 )
	if UIActivitiesModel.GetIsRedByData( data998 ) then
		return true
	end
	local data994 = UIActivitiesModel.GetServerDataAllByID( 994 )
	if UIActivitiesModel.GetIsRedByData( data994 ) then
		return true
	end
	local data995 = UIActivitiesModel.GetServerDataAllByID( 995 )
	if UIActivitiesModel.GetIsRedByData( data995 ) then
		return true
	end
	local data993 = UIActivitiesModel.GetServerDataAllByID( 993 )
	if UIActivitiesModel.GetIsRedByData( data993 ) then
		return true
	end
	local data992 = UIActivitiesModel.GetServerDataAllByID( 992 )
	if UIActivitiesModel.GetIsRedByData( data992 ) then
		return true
	end
	local data991 = UIActivitiesModel.GetServerDataAllByID( 991 )
	if UIActivitiesModel.GetIsRedByData( data991 ) then
		return true
	end
	return false
end

MainScenePanelAdd.isPlayCV = false
function MainScenePanelAdd.PlayCV( ... )
	-- body
	if MainScenePanelAdd.isPlayCV then
		MainScenePanelAdd.isPlayCV = false
		AwardUtils.PlaySound(99300000003)
	end
end

function MainScenePanelAdd.showOnNewDayCallback( ... )
	-- body
	--UIActivities:show()
	MainScenePanelAdd.isPlayCV = true
	UIActivitiesButtons:show(true)
end

--每天登陆检查是否打开运营活动首页
function MainScenePanelAdd.showOnNewDay( ... )
	-- body
	--有引导不弹出
	if AwardUtils.IsGuideRuning() then
		return
	end
	--不在主界面不弹出
	if UISceneManager.getInstance():GetCurrentUISceneState().SceneID ~= UISceneID.MAIN_SCENE_NEW:ToInt() then
		return
	end
	--已经打开了不弹出
	if UIActivitiesButtons.page ~= nil then
		return
	end
	--延迟几秒
	local timer = Timer.New(function ( ... )
		-- body
		local curTime = math.floor(Utils.getSeverTime() / 86400)
		local key = 'UIActivities_showOnNewDay' .. tostring(WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID)
		local lastTime
		if UnityEngine.PlayerPrefs.HasKey(key) then
			lastTime = UnityEngine.PlayerPrefs.GetInt(key)
		end
		local show = false
		if lastTime then
			if curTime ~= lastTime then
				show = true
			end
		else
			show = true
		end
		if show then
			--AwardUtils.DoMove2AD(1,0.7,-15,'MainScenePanelAdd.showOnNewDayCallback')
			MainScenePanelAdd.showOnNewDayCallback()
			UnityEngine.PlayerPrefs.SetInt(key,curTime)
		else
			UIActivitiesModel.OpenCafe()
		end
	end, 0.07, 1, true)
	timer:Start()
end

return this
