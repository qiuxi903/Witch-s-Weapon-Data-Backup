--运营活动数据处理，用于分担ActivityModel 数据处理的业务
UIActivitiesModel = {}

local UserInfoHelper = WaterBell.ProjX.Data.Entity.UserInfoHelper
local UserInfo = WaterBell.ProjX.Data.Entity.UserInfo
local ShopInfoHelper = WaterBell.ProjX.Data.Entity.ShopInfoHelper
local UISceneManager = WaterBell.ProjX.View.UIFrame.UISceneManager
local UISceneState = WaterBell.ProjX.View.UIFrame.UISceneState
local ClothUIData = WaterBell.ProjX.View.Panel.ClothUIData
local UISceneID = WaterBell.ProjX.View.UIFrame.UISceneID
local ShopData = WaterBell.ProjX.View.Panel.ShopData
local ReminderInfoHelper = WaterBell.ProjX.Data.Entity.ReminderInfoHelper
local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
local UITool = WaterBell.ProjX.View.Panel.UITool
local Package = WaterBell.ProjX.Data.Entity.Package

local ActivityModel = ActivityModel

--CAPH
function UIActivitiesModel.CAPHLevel( ... )
	-- body
	return UserInfo.GetInstance():GetPlayer().Vip
end

function UIActivitiesModel.CAPHCanGet( index )
	-- body
	if index == 1 then
		return UserInfoHelper.CanReceiveVip2Gift() == "0" --可以领2级礼包
	else
		return UserInfoHelper.CanReceiveVip5Gift() == "0" --可以领5级礼包
	end
end

function UIActivitiesModel.CAPHGetReward( index,Callback )
	-- body
	local msgID
	if index == 1 then
		msgID = 20009
	else
		msgID = 20010
	end
	local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
	local request_params = {roleid = tostring(role_id)}
	Utils.SendMessage(msgID, request_params, function(response)
			local bytes = response.bytes
			local LuaNetProxy = LuaNetProxy.New()
			LuaNetProxy:Callback(bytes)

			if index == 1 then
				UserInfo.GetInstance():GetPlayer().Vip2GiftState = true;
			else
				UserInfo.GetInstance():GetPlayer().Vip5GiftState = true;
			end

			if Callback then
				Callback()
			end
		end)

end

--公告板
--商店
function UIActivitiesModel.GetOneShopUpdateTimeByID( shopsID )
	-- body
	--商店集id
	--[[
	44000001 杂货商店
	44000014 7#
	44000012 周末
	]]
	return UserInfoHelper.GetShopSetTimeLeft(shopsID)
end

function UIActivitiesModel.GoOneShopPageByID( bigShopsID,Callback )
	-- body
	--跳商店： 
	--[[
	UISceneManager.getInstance().Goto(UISceneManager.getInstance().GetCurrentUISceneState(),
                       new UISceneState((int)UISceneID.SHOP_SCENE, new ShopData(ShopData.SHOP_SCENE_ARG_DEFRAULT))
                   );
	]]
	--[[
	47000004 杂货商店
	47000011 7#
	47000012 周末
	]]
	UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.SHOP_SCENE:ToInt(),ShopData.New(false,bigShopsID,nil)), Callback)

end

function UIActivitiesModel.GoOneShopPageByIDs( bigShopsID,shopsID,shopID,goodsID,Callback )
	-- body
	--跳商店： 
	--[[
	UISceneManager.getInstance().Goto(UISceneManager.getInstance().GetCurrentUISceneState(),
                       new UISceneState((int)UISceneID.SHOP_SCENE, new ShopData(ShopData.SHOP_SCENE_ARG_DEFRAULT))
                   );
	]]
	--[[
	47000004 杂货商店
	47000011 7#
	47000012 周末
	]]
	UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.SHOP_SCENE:ToInt(),ShopData.New(false,bigShopsID,ShopArug.New(shopsID,shopID,goodsID))), Callback)
end

function UIActivitiesModel.CanShowShopSetByID( shopsID )
	-- body
	--商店集ID
	--[[
	44000001 杂货商店
	44000014 7#
	44000012 周末

	]]
	return ShopInfoHelper.CanShowShopSet(shopsID)
end

function UIActivitiesModel.GetShopSetStopTimeByID( shopsID )
	-- body
	return UserInfo.GetInstance():GetShopAllSets():GetShopSetByID(shopsID).StopTime
end

--去战斗服
function UIActivitiesModel.GoClothesPageByID( clothesID,Callback )
	-- body
	UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.SELECT_FASHION_SCENE:ToInt(),ClothUIData.New(clothesID)), Callback)
end

--任务
function UIActivitiesModel.GetTaskSomeCount( ... )
	-- body

	local items = ReminderInfoHelper.GetDailyQuestCompleteness()
	--返回类型Tuple的Item1是完成数量 Item2 是总数量
	return items.Item1,items.Item2
end

--抽卡
function UIActivitiesModel.GetDrawSomeInfoByType( type )
	-- body
	--WaterBell.ProjX.View.Panel.LuckDrawTypes.Gold --金币
	--WaterBell.ProjX.View.Panel.LuckDrawTypes.Diamond --钻石
	local data = AwardUtils.GetDrawInfo()
	if data then
		for i=0,data.Count do
			if type == data[i].luckDrawType then
				--下一次免费抽时间,免费抽了几次,最大免费抽次数
				return data[i].canFree,data[i].isFree,data[i].freeTime,tonumber(data[i].freeCount),tonumber(data[i].freeCountMax)
			end
		end
	else
		print('抽卡信息数据报错！！！')
	end
end

--体力
function UIActivitiesModel.GetPowerInfo( ... )
	-- body
	for i,v in ipairs(ActivityModel.ServerData) do
		if v.type == ActivityModel.ActivityType.GetPower.typeid then
			--获取领取体力的开始时间，结束时间，可不可以领
			return v
		end
	end
end

--获取所有运营活动某id数据
function UIActivitiesModel.GetServerDataAllByID( id )
	-- body
	for i,v in ipairs(ActivityModel.ServerDataAll) do
		if v.id == id then
			return v
		end
	end
end

--获取运营活动某id数据
function UIActivitiesModel.GetServerDataByID( id )
	-- body
	for i,v in ipairs(ActivityModel.ServerData) do
		if v.id == id then
			return v
		end
	end
end

--获取运营活动某类型数据
function UIActivitiesModel.GetServerDatasByTypeID( typeid )
	-- body
	local t = {}
	for i,v in ipairs(ActivityModel.ServerData) do
		if v.type == typeid then
			table.insert(t,v)
		end
	end
	return t
end

--获取新版式的运营活动
function UIActivitiesModel.GetNewFormatActivitiesDatas( ... )
	-- body
	local t = {}
	for i,v in ipairs(ActivityModel.ServerData) do
		if v.panel_id >= 60 then
			table.insert(t,v)
		end
	end
	return t
end

--消息请求运营数据
function UIActivitiesModel.RequestActivitiesData( Callback )
	-- body
	ActivityModel:RegisterCallback(Callback)
	ActivityModel:getActivities(false)
end

--返回倒计时字符串
--timeSpan: long/TimeSpan
function UIActivitiesModel.GetTimeSpanStr( timeSpan )
	-- body
	return UITool.GetTimeSpanStr(timeSpan)
end

--当前是否存在养成之路活动 17/18/19
function UIActivitiesModel.IsHaveNurturanceRoad( ... )
	-- body
	for key, value in ipairs(ActivityModel.ServerData) do
		--18 领取雾夕
		if value.id == 18 then
			return true
		end
	end
	return false
end

function UIActivitiesModel.GetTimeStampByTime( starttime,endtime )
	-- body
	local str = ''
	if not starttime or not endtime then
		return str
	end
	local format1 = '%m.%d'
	local format = '%m.%d %H:%M'
	--如果时间大于三年显示永久开放
	local curEndTime = endtime - 1
	local showForever = endtime - starttime >= 3 * 365 * 24 * 60 * 60 or endtime == starttime
	if showForever then
		str = ManagerCsv.GetInstance():GetNameStatic('HomepageForever')--"永久开放"
	else
		str = os.date(format1,starttime).. "-" .. os.date(format,curEndTime)
	end
	return str
end

--新增通关运营活动
--1.根据关卡id跳转关卡详情界面
function UIActivitiesModel.GoLevelSceneByID( levelID,baseID,Serial,BattleCount,BattleMaxCount,mode,extraargu,Callback)
	-- body
	if not extraargu then
		extraargu = ''
	end
	AwardUtils.ChangePlayMode(levelID,baseID,Serial,BattleCount,BattleMaxCount,mode,extraargu)
	UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.LEVEL_DETAIL_SCENE:ToInt()), Callback)
end
--2.根据关卡id查找可获得物品
function UIActivitiesModel.GetLevelGoodsByID( ID )
	-- body
	--[[
	local instance = ManagerCsv.GetInstance():GetInstance(ID);
	local t = {}
	t.equip1 = instance.instance_loot_equip1
	t.equip2 = instance.instance_loot_equip2
	t.equip3 = instance.instance_loot_equip3
	t.item1 = instance.instance_loot_item1
	t.item2 = instance.instance_loot_item2
	t.item3 = instance.instance_loot_item3
	t.item4 = instance.instance_loot_item4
	t.item5 = instance.instance_loot_item5
	t.item6 = instance.instance_loot_item6
	return t
	]]

	local instance = AwardUtils.GetLevelAward(ID)
	return instance
end

--新增任务运营活动
--1.根据任务id获取任务的描述，进度
function UIActivitiesModel.GetTaskDescByID( ID )
	-- body
	local achievementTableData = ManagerCsv.GetInstance():GetAchievement(ID);

    --//object[] achieveDetail = GetAchievementTable(ID);
    local t = {}

    t.id = ID;
    --//result[1] = GetName(achieveDetail[2].ToString()); //名字
    t.name = ManagerCsv.GetInstance():GetName(achievementTableData.achievement_name); --//名字
    t.desc = ManagerCsv.GetInstance():GetName(achievementTableData.achievement_desc); --//描述
    t.icon = achievementTableData.achievement_icon; --//头像
    t.tips = ManagerCsv.GetInstance():GetName(achievementTableData.achievement_tips);--//tipsS

    --//描述的图片背景
    t.descIcon = achievementTableData.achievement_desc_icon;
    --//参数1 任务进度最大值
    t.argu1 = achievementTableData.achievement_argu1;
    --//参数2
    t.argu2 = achievementTableData.achievement_argu2;
    --//参数3
    t.argu3 = achievementTableData.achievement_argu3;

    t.attachment_type1 = achievementTableData.attachment_type1
    t.attachment_id1 = achievementTableData.attachment_id1
    t.attachment_value1 = achievementTableData.attachment_value1
    t.attachment_num1 = achievementTableData.attachment_num1
    return t;
end

--获取任务进度
function UIActivitiesModel.GetTaskProgressByID( ID )
	-- body
	return AwardUtils.GetTaskProgressByID(ID)
end

--领取任务奖励
function UIActivitiesModel.GetTaskRewardByID( ID ,luaFunc)
	-- body
	AwardUtils.GetInstance():GetTaskRewardByID(ID,luaFunc)
end

--获取任务状态  //0 没找到，1，可领取 ， 2 已领取，3未完成
function UIActivitiesModel.GetTaskStatusByID( ID )
	-- body
	return AwardUtils.GetTaskStatusByID(ID)
end

--领取成长之路奖励
function UIActivitiesModel.GetNurturanceTaskAward( baseid,serial,Callback )
	-- body
	local role_id = UserInfo.GetInstance():GetPlayer().RoleID
	local request_params = {roleid = tostring(role_id),baseid = tostring(baseid),serial = tostring(serial)}
	Utils.SendMessage(ActivityModel.ActivityType.NurturanceTask.msgid, request_params, function(response)
		local bytes = response.bytes
		local LuaNetProxy = LuaNetProxy.New()
		LuaNetProxy:Callback(bytes)

		if Callback then
			Callback()
		end
	end)
end

--发送装备合成协议
function UIActivitiesModel.SendMsg2CopyEquip( baseid,msgID,t,Callback )
	-- body
	local role_id = UserInfo.GetInstance():GetPlayer().RoleID
	--roleid"`baseid"`serial"`baseitem"`basenum"`food1"`food1num"`food2"`food2num"`food3"`food3num"`
	local request_params = {}
	request_params['roleid'] = tostring(role_id)
	request_params['baseid'] = tostring(baseid)
	local index = 1
	for k,v in pairs(t) do
		local strID = tostring(v.ID)
		local strNum = tostring(v.Num)
		if v.Type == GlobalEnum.ResType.Item then
			if index == 1 then
				request_params['food1'] = strID
				request_params['food1num'] = strNum
			elseif index == 2 then
				request_params['food2'] = strID
				request_params['food2num'] = strNum
			elseif index == 3 then
				request_params['food3'] = strID
				request_params['food3num'] = strNum
			end
			index = index + 1
		elseif v.Type == GlobalEnum.ResType.Equip then
			request_params['baseitem'] = strID
			request_params['basenum'] = strNum
		end
	end
	--local request_params = {roleid = tostring(role_id),baseid = tostring(baseid)}
	--ActivityModel.ActivityType.CopyEquip.msgid
	Utils.SendMessage(msgID, request_params, 
		function(response)
			local bytes = response.bytes
			local LuaNetProxy = LuaNetProxy.New()
			LuaNetProxy:Callback(bytes)

			if Callback then
				Callback()
			end
		end
	)
end

--兑换活动
--1.获取某装备的价值
--2.获取某物品的价值
--3.获取某物品的数量
--4.增加减少背包中物品的的数量
--[[
UserInfo.GetInstance().GetPackage().GetItemOrEquipNum 获取道具或者装备的数量 
UserInfo.GetInstance().GetPlayer().Gold 玩家的金币数量 修改这个就可以增加或者减少金币数量
UserInfo.GetInstance().GetPlayer().Diamond 玩家的钻石数量 修改这个就可以增加或者减少钻石数量
UserInfo.GetInstance().GetPackage().ChangeItemCount 这个是修改道具的数量 可以增加或者减少
UserInfo.GetInstance().GetPackage().ChangeEquipCount 这个是修改装备的数量
UserInfo.GetInstance().GetPlayer().Stamina 修改体力值
]]
--玩家的钻石数量
function UIActivitiesModel.GetOrChangeDiamondOrGoldCount( Type,num )
	-- body
	--金币
	if Type == GlobalEnum.ResType.Gold then
		if num then
			UserInfo.GetInstance():GetPlayer().Gold = UserInfo.GetInstance():GetPlayer().Gold + num
		else
			return UserInfo.GetInstance():GetPlayer().Gold
		end
	--钻石
	elseif Type == GlobalEnum.ResType.Diamond then
		if num then
			UserInfo.GetInstance():GetPlayer().Diamond = UserInfo.GetInstance():GetPlayer().Diamond + num
		else
			return UserInfo.GetInstance():GetPlayer().Diamond
		end
	end
end

--获取或修改道具或者装备的数量 
function UIActivitiesModel.GetOrChangeItemOrEquipNum( Type,ID,num )
	-- body
	--装备
	if Type == GlobalEnum.ResType.Equip then
		if num then
			UserInfo.GetInstance():GetPackage():ChangeEquipCount(ID,num)
			return
		end
	--道具
	elseif Type == GlobalEnum.ResType.Item then
		if num then
			UserInfo.GetInstance():GetPackage():ChangeItemCount(ID,num)
			return
		end
	end
	return UserInfo.GetInstance():GetPackage():GetItemOrEquipNum(ID)
end

--获取背包中的所有装备列表
function UIActivitiesModel.GetObservableEquips( ... )
	-- body
	local t = {}
	local _t
	local ObservableEquips = UserInfo.GetInstance():GetPackage().ObservableEquips
	for i=1,ObservableEquips.Count do
		local item = ObservableEquips[i - 1]
		_t = {}
		_t.ID = item.ID
		_t.Num = item.Num
		_t.Max = item.Max
		_t.Type = GlobalEnum.ResType.Equip
		_t.Value = 0
		local x = UIActivitiesModel.GetServantEquipOrItem( _t.Type,_t.ID )
		_t.time_value = x.time_value
		_t.sequence = x.sequence
		_t.compound = x.compound
		_t.client_id = x.client_id
		table.insert(t,_t)
	end
	return t
end

--获取装备表或物品表 属性
function UIActivitiesModel.GetServantEquipOrItem( Type,ID )
	-- body
	local t = {}
	local data
	if Type == GlobalEnum.ResType.Equip then
		data = ManagerCsv.GetInstance():GetServantEquip(ID)
		--时间价值
		t.time_value = data.time_value
		--排序编号
		t.sequence = data.equip_sequence
		--是否为合成装备
		t.compound = tostring(data.compound_equip1) == '0'
		t.client_id = data.client_id
	elseif Type == GlobalEnum.ResType.Item then
		data = ManagerCsv.GetInstance():GetItem(ID)
		--时间价值
		t.time_value = data.time_value / 10000
		--排序编号
		t.sequence = data.item_sequence
	end
	return t
end

UIActivitiesModel.IsOpenCafe = false
function UIActivitiesModel.OpenCafe( ... )
	-- body
	if UIActivitiesModel.IsOpenCafe then
		return
	end
	local role_id = UserInfo.GetInstance():GetPlayer().RoleID
	UIActivitiesModel.IsOpenCafe = true
	AwardUtils.OpenCafe(tostring(role_id))
end

function UIActivitiesModel.GetEquipQualityByID( ClientID )
	-- body
	local Qualit = 0
	ClientID = tonumber(tostring(ClientID))
	local data = CSVPool.ServantEquipClient()
	for i,v in ipairs(data) do
		if v.ID == ClientID then
			Qualit = v.quality
			break
		end
	end
	return Qualit
end

function UIActivitiesModel.ProtoBufExtraContent( ExtraContent )
	-- body
	print("运营活动战斗返回额外信息：" .. ExtraContent)
end

function UIActivitiesModel.GetIsRedByData( sData )
	-- body
	if not sData then
		return false
	end
	local v = sData
	if v.type == ActivityModel.ActivityType.Sign.typeid then
		if v.DaysSignRewardTag < #v.activity_items and ((Utils.getSeverTime() - v.DaysSignTime) >= 60*60*24 or v.DaysSignRewardTag == 0) then
			return true
		end
	elseif v.type == ActivityModel.ActivityType.Recharge.typeid or v.type == ActivityModel.ActivityType.RechargeCAPH.typeid 
		or v.type == ActivityModel.ActivityType.LevelUP.typeid or v.type == ActivityModel.ActivityType.Complete.typeid
		or v.type == ActivityModel.ActivityType.UnlockPlot.typeid or v.type == ActivityModel.ActivityType.DailyTaskTotal.typeid
		then
		--充值相关类型
		for k1,v1 in pairs(v.activity_items) do
			if v1.status == ActivityModel.Status.status_can_receive then
				return true
			end
		end
	elseif v.type == ActivityModel.ActivityType.FirstRecharge.typeid then
		return v.CanReceive
	elseif v.type == ActivityModel.ActivityType.NurturanceTask.typeid then
		return UIActivityPageCompleteNew.checkRed( v )
	end
	return false
end