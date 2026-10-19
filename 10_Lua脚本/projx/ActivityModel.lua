--此处只写定义和一些基本处理，具体处理在UIActivitiesModel中
ActivityModel = {}
local ActivityModel = ActivityModel

ActivityModel.ActivityType = 
{
	--签到
	Sign = 
	{
		typeid = 1,
		msgid = 40002,
	},
	--充值
	Recharge = 
	{
		typeid = 2,
		msgid = 40001,
	},
	--跳转界面
	ToPage = 
	{
		typeid = 3,
		msgid = 0,
	},
	--升级活动
	LevelUP = 
	{
		typeid = 4,
		msgid = 40003,
	},
	--通关活动
	Complete = 
	{
		typeid = 5,
		msgid = 40004,
	},
	--跳转界面
	ToPage2 = 
	{
		typeid = 6,
		msgid = 0,
	},
	GetPower = {
		typeid = 7,
		msgid = 40005,
	},--领取体力
	--购买礼包
	Gift = 
	{
		typeid = 13,
		msgid = 0,
	},
	--累计登陆
	LandingSum =
	{
		typeid = 14,
		msgid = 40006,
	},
	--连续七日登陆（中断就重新开始）
	Landing7 =
	{
		typeid = 15,
		msgid = 40007,
	},
	--AD公告
	AD = 
	{
		typeid = 16,
		msgid = 0,
	},
	--挑战关卡
	ChallengeLevel = 
	{
		typeid = 17,
		msgid = 0,
	},
	--成长之路任务活动
	NurturanceTask = 
	{
		typeid = 18,
		msgid = 40011,
	},
	--复制装备
	CopyEquip = 
	{
		typeid = 19,
		msgid = 40013,
	},
	--分解装备
	DecomposeEquip = 
	{
		typeid = 20,
		msgid = 40014,
	},
	--看剧情选阵营
	SelectCamp2Story = 
	{
		typeid = 21,
		msgid = 40017,
	},
	--充值
	RechargeCAPH = 
	{
		typeid = 22,
		msgid = 40001,
	},
	--去抽卡的活动
	GoDraw = 
	{
		typeid = 23,
		msgid = 0,
	},
	--限时挑战活动
	ActivitiesChallenge = 
	{
		typeid = 24,
		msgid = 0,
	},
	--复合挑战活动
	ActivitiesChallengeMix = 
	{
		typeid = 25,
		msgid = 0,
	},
	--复合挑战活动下夹杂的按阶段领奖
	ActivitiesChallengeMixStageAward = 
	{
		typeid = 26,
		msgid = 40020,
	},
	--首次充值
	FirstRecharge = 
	{
		typeid = 28,
		msgid = 40022,
	},
	--解锁剧情的任务
	UnlockPlot = 
	{
		typeid = 29,
		msgid = 40023,
	},
	--每日任务累计活动
	DailyTaskTotal = 
	{
		typeid = 30,
		msgid = 40024,
	},
}

--ActivityModel.ActivityRelationData这下面的定义后续逐渐舍弃
--因为用id来区分活动不如用类型来区分的扩展性高
--后续类型都会添加到 ActivityModel.ActivityType
ActivityModel.ActivityRelationData = {
	Sign14 = {
		baseid = 1,
		msgid = 40002,
	},--14日签到
	LevelUP = {
		baseid = 2,
		msgid = 40003,
	},--冲级活动
	Campaign = {
		baseid = 3,
		msgid = 40004,
	},--通关活动
	Sign7 = {
		baseid = 5,--活动类型id
		msgid = 40002,--自定义消息id
	},--7日签到
	GoYunyingShop = {
		baseid = 6,
		msgid = 0,
	},
	GoTask = {
		baseid = 7,
		msgid = 0,
	},--去任务
	GoShop = {
		baseid = 8,
		msgid = 0,
	},--去商店
	Sign10 = {
		baseid = 9,
		msgid = 40002,
	},--10日签到
	RechargeTotal = {
		baseid = 10,
		msgid = 40001,
	},--累积充值
	RechargeWelfare = {
		baseid = 11,
		msgid = 40001,
	},--福利充值
	GoDraw = {
		baseid = 12,
		msgid = 0,
	},--去抽卡
	GetStamina = {
		baseid = 999,
		msgid = 40005,
	},--领取体力
	GoDraw1 = {
		baseid = 15,
		msgid = 0,
	},--去抽卡
}

ARData = ActivityModel.ActivityRelationData

--local allList = {}
local callback = nil

ActivityModel.Status = 
{
	status_cannot_receive = 1,--已领取
	status_can_receive = 2,--可领取
	status_received = 3,--不可领取
}

ActivityModel.ShowType = 
{
	No = 0,--不显示
	Yunying = 1,--运营
	NewHand= 2,--新手
}

local alllist = {}

local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
local Activity_CSV

ActivityModel.IsNeedUpdateData = false
local Timer = Timer

-- Get CSV table.
local function GetCSVTable(baseid)
	--[[
	local tt = ManagerCsv.GetInstance():GetActivitys(baseid)
	if tt.Count == 0 then
		print("can not find target activity: " .. baseid)
	    return {};
	end

	arr = {}
	tt:ForEach(function(v) 
			table.insert(arr, v)
		end
	)
	]]
	if Activity_CSV == nil then
		Activity_CSV = Utils.loadCsvFile("Config/ClientExel/Activity.csv") 
		local ExtraActivity_CSV = Utils.loadCsvFile("Config/ClientExel/ExtraActivity.csv") 
		for i,v in ipairs(ExtraActivity_CSV) do
			table.insert(Activity_CSV,v)
		end
	end
	local arr = {}
	local channel_group = ManagerCsv.GetInstance().channel_group
	for i,v in ipairs(Activity_CSV) do
		if v.channel_group == 0 or v.channel_group == channel_group then
			if v.base_id == baseid then
				table.insert(arr,v)
			end
		end
	end
	return arr
end

------------------ modual func define blow: ---------------------
local function bitCompare( tag,num )
	-- body
	local mybit = bit.rshift(tag,num - 1)
	return bit.band(mybit,1)
end

--- Get reward.
local function GetReward(CSVTable, canReceiveTag, tag)
	-- create list:
	local list = {}
	for index, value in ipairs(CSVTable) do
		local canReceive = -1
		if canReceiveTag ~= -1 then
		   canReceive = bitCompare(canReceiveTag, index)
		end
		-- print("tag :" .. tag .. "||" .. index)
		local received  = bitCompare(tag, index)

		local status = 0
		if received == 1 then
		    status = ActivityModel.Status.status_received
		else
			if canReceive == 1 or canReceive  == -1 then
			    status = ActivityModel.Status.status_can_receive
			else
				status = ActivityModel.Status.status_cannot_receive
			end
		end

		if status == 0 then
		    print("Error : activity reward status error." .. baseid .. " | " .. canReceiveTag .. " | " .. tag)
		    return list
		end
		local activity_item = {}
		activity_item.desc = ManagerCsv.GetInstance():GetName(value.reward_name)
	    activity_item.status = status
	    activity_item.rewards = {}
	    activity_item.argument1 = value.argument1
	    activity_item.argument2 = value.argument2
	    activity_item.argument3 = value.argument3
	    activity_item.argument4 = value.argument4
	    activity_item.argument5 = value.argument5
	    activity_item.argument6 = value.argument6
	    activity_item.argument7 = value.argument7
	    activity_item.argument8 = value.argument8
	    activity_item.argument9 = value.argument9
	    activity_item.argument10 = value.argument10
	    activity_item.argument11 = value.argument11
	    activity_item.argument12 = value.argument12
	    activity_item.argument13 = value.argument13
	    activity_item.argument14 = value.argument14
	    activity_item.argument15 = value.argument15
	    activity_item.argument16 = value.argument16
	    activity_item.argument17 = value.argument17
	    activity_item.argument18 = value.argument18
	    activity_item.argument19 = value.argument19
	    activity_item.argument20 = value.argument20
	    activity_item.argument21 = value.argument21
	    activity_item.argument22 = value.argument22
	    activity_item.argument23 = value.argument23
	    activity_item.argument24 = value.argument24
	    activity_item.argument25 = value.argument25
	    activity_item.argument26 = value.argument26
	    activity_item.argument27 = value.argument27
	    activity_item.argument28 = value.argument28
	    activity_item.argument29 = value.argument29
	    activity_item.argument30 = value.argument30

		-- create reward.
		if value.reward_type1 ~= 0  then
		    local reward = {}
		    reward.id = tostring(value.reward_id1)
		    reward.type = value.reward_type1
		    reward.value = value.reward_value1
		    reward.num = value.reward_num1
		    table.insert(activity_item.rewards, reward)
		end
	    
	    if value.reward_type2 ~= 0  then
	    	local reward = {}
		    reward.id = tostring(value.reward_id2)
		    reward.type = value.reward_type2
		    reward.value = value.reward_value2
		    reward.num = value.reward_num2
	    	table.insert(activity_item.rewards, reward)
	    end

	    if value.reward_type3 ~= 0  then
	    	local reward = {}
		    reward.id = tostring(value.reward_id3)
		    reward.type = value.reward_type3
		    reward.value = value.reward_value3
		    reward.num = value.reward_num3
	    	table.insert(activity_item.rewards, reward)
	    end
	    
	   

	    -- save activity item.
	    table.insert(list, activity_item)
	end
	return list
end



-- Register callback.
function ActivityModel:RegisterCallback(func)
	callback = func
end

local function SetCSVData( CSVTable )
	-- body
	local t = {}
	local row = CSVTable[1]

	t.mark = row["mark"]
	t.title = ManagerCsv.GetInstance():GetName(row["title"])
	t.name = ManagerCsv.GetInstance():GetName(row["name"])
	t.desc = ManagerCsv.GetInstance():GetName(row["desc"])
	t.desc_position = row["desc_location"]
	t.background = row["background"]
	t.total_count = row["page_footer_bar_number"]
	t.stick = row["stick"]
	t.foot = row["foot"]
	t.show_type = row.show_type

	t.panel_id = row["format"]
	t.format = t.panel_id
	t.row_num = row["row_num"]
	t.page_footer = row["page_footer"]
	t.page_footer_button1 = row["page_footer_button1"]
	t.page_footer_button_argument1 = row["page_footer_button_argument1"]
	t.page_footer_button2 = row["page_footer_button2"]
	t.page_footer_button_argument2 = row["page_footer_button_argument2"]
	t.page_footer_bar = row["page_footer_bar"]
	t.page_footer_bar_number = row["page_footer_bar_number"]

	return t
end

local tNextUpdateTimers

function ActivityModel.SetIsNeedUpdateData( ... )
	-- body
	ActivityModel.IsNeedUpdateData = true
end

function ActivityModel.Parse2CSharp( response )
	ActivityModel.Parse( response )
	AwardUtils.GetInstance().UpdateActivityData(response.bytes)
end

function ActivityModel.Parse( response )
	-- body
	Remove(alllist)
	local arr = {"achievemod", "backpack_info", "extra_info", "loot_info",'level', "activity"}
	local result = Utils.ParseProtobufEx(response, arr, "activitymod.ActivityListLua")
	local isError = result[1]
	if isError == false then
		local content = result[2]
		local dic = content["ActivityInstanceProtos"]
		print('当前运营活动数据 	︻$▅▆▇◤')
		print('baseid 	typeid 	format 	show_type 	')
		for index, value in ipairs(dic) do
			value = setmetatable(value, {
				__index = {
					ActivityType = 0,
					BaseID = 0,
					StartTime = 0,
					EndTime = 0,
					CloseTime = 0,
					Finished = false,
					}
				})
			local baseid = value.BaseID
			--print("当前运营活动baseid："..baseid .. '  typeid:' .. value.ActivityType)
			local CSVTable = GetCSVTable(baseid)
			if #CSVTable > 0 then
				local activity = SetCSVData(CSVTable)
				--print("baseid: "..baseid .. '  typeid: ' .. value.ActivityType .. ' format: ' .. activity.format .. ' show_type: '..activity.show_type)
				--if activity.show_type ~= ActivityModel.ShowType.No then
				activity.type = value.ActivityType;
			    activity.id = baseid;
			    activity.starttime = value.StartTime;
			    activity.endtime = value.EndTime;
				activity.closetime = value.CloseTime
				activity.isFinished = value.Finished
				print(string.format('%s 	%s 	%s 	%s 	',activity.id,activity.type,activity.format,activity.show_type))
				if activity.type == ActivityModel.ActivityType.Sign.typeid then
					value.DaysSign = setmetatable(value.DaysSign, {
							__index = {
								DaysSignRewardTag = 0,
								DaysSignTime = 0
								}
							})
					activity.activity_items = GetReward(CSVTable, -1, value["DaysSign"]["DaysSignRewardTag"])
					activity.DaysSignTime = value["DaysSign"]["DaysSignTime"]
					activity.DaysSignRewardTag = value["DaysSign"]["DaysSignRewardTag"]
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.LevelUP.typeid then
					value.RoleLevelReward = setmetatable(value.RoleLevelReward, {
							__index = {
								RoleLevelCanReceiveTag = 0,
								RoleLevelRewardTag = 0
								}
							})
					activity.activity_items = GetReward(CSVTable,  value["RoleLevelReward"]["RoleLevelCanReceiveTag"], value["RoleLevelReward"]["RoleLevelRewardTag"])
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.Complete.typeid then
					value.InstanceReward = setmetatable(value.InstanceReward, {
							__index = {
								InstanceCanReceiveTag = 0,
								InstanceRewardTag = 0
								}
							})
					activity.activity_items = GetReward(CSVTable, value["InstanceReward"]["InstanceCanReceiveTag"], value["InstanceReward"]["InstanceRewardTag"])
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.Recharge.typeid or activity.type == ActivityModel.ActivityType.RechargeCAPH.typeid then
					value.RechargeReward = setmetatable(value.RechargeReward, {
							__index = {
								Recharge = 0,
								RechargeCanReceiveTag = 0,
								RechargeRewardTag = 0,
								}
							})
					activity.activity_items = GetReward(CSVTable, value["RechargeReward"]["RechargeCanReceiveTag"], value["RechargeReward"]["RechargeRewardTag"])
					local Recharge = tonumber(value["RechargeReward"]["Recharge"])
					activity.Recharge = Recharge
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.GetPower.typeid then
					value.BonusStamina = setmetatable(value.BonusStamina, {
							__index = {
								StartTime = 0,
								EndTime = 0,
								CanReceive = false,
								}
							})
					activity.StartTime = value.BonusStamina.StartTime
					activity.EndTime = value.BonusStamina.EndTime
					activity.CanReceive = value.BonusStamina.CanReceive
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.ToPage.typeid or activity.type == ActivityModel.ActivityType.ToPage2.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.Gift.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					if value.BuyBox then
						value.BuyBox = setmetatable(value.BuyBox, {
								__index = {
									BuyBoxTag = 0,
									}
								})
						activity.BuyBoxTag = value.BuyBox.BuyBoxTag
					else
						activity.BuyBoxTag = 0
					end
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.LandingSum.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					value.DaysSignAuto = setmetatable(value.DaysSignAuto, {
							__index = {
								DaysSignAutoDays = 0,--总的登陆天数
								DaysSignAutoRewardTag = 0,--不关注
								DaysSignAutoCanTag = false,--能否领取
								}
							})
					activity.DaysSignAutoDays = value.DaysSignAuto.DaysSignAutoDays
					activity.DaysSignAutoRewardTag = value.DaysSignAuto.DaysSignAutoRewardTag
					activity.DaysSignAutoCanTag = value.DaysSignAuto.DaysSignAutoCanTag
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.Landing7.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					value.DaysSignContinuity = setmetatable(value.DaysSignContinuity, {
							__index = {
								DaysSignContinuityRewardTag = 0,--连续登陆的天数
								DaysSignContinuityTime = 0,--不关注
								DaySignContinuityCanTag = false,--能否领取
								}
							})
					activity.DaysSignContinuityRewardTag = value.DaysSignContinuity.DaysSignContinuityRewardTag
					activity.DaysSignContinuityTime = value.DaysSignContinuity.DaysSignContinuityTime
					activity.DaySignContinuityCanTag = value.DaysSignContinuity.DaySignContinuityCanTag
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.AD.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.ChallengeLevel.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					value.RoleStory = setmetatable(value.RoleStory,{
							__index = {
							DayTimes = 0;--//已经打了多少次
							Day = 0;-- //第几天
							Storys = 0;--//今天的关卡信息
							HighTimes = 0;--//高倍奖励打了多少次
							}
						})
					activity.DayTimes = value.RoleStory.DayTimes
					activity.Day = value.RoleStory.Day
					activity.Storys = value.RoleStory.Storys
					activity.HighTimes = value.RoleStory.HighTimes

					if value.RoleStory.NormalInstances then
						for i=1,#value.RoleStory.NormalInstances do
							value.RoleStory.NormalInstances[i] = setmetatable(value.RoleStory.NormalInstances[i],{
								__index = {
										ID = 0;			--//关卡ID
										Pass = false;		--//是否打过
										Stars = false;		--//是否有星级
										Status = false;		--//是否可以打这关
										Sweep =false; 		--//是否可以扫荡
										ResetCount = 0;	--//重置次数
										BattleCount = 0;	--//单日挑战次数
									}
								})
						end
						activity.NormalInstances = value.RoleStory.NormalInstances
					end

					if value.RoleStory.ChallengeInstances then
						for i=1,#value.RoleStory.ChallengeInstances do
							value.RoleStory.ChallengeInstances[i] = setmetatable(value.RoleStory.ChallengeInstances[i],{
								__index = {
										ID = 0;			--//关卡ID
										Pass = false;		--//是否打过
										Stars = false;		--//是否有星级
										Status = false;		--//是否可以打这关
										Sweep =false; 		--//是否可以扫荡
										ResetCount = 0;	--//重置次数
										BattleCount = 0;	--//单日挑战次数
									}
								})
						end

						activity.ChallengeInstances = value.RoleStory.ChallengeInstances
						
						
						-- int64 SetID = 1;
					 	-- int64 StartTime = 2;              //开始时间
					 	-- int64 EndTIme = 3;                //结束时间
						activity.ChallengeInstanceSet = value.RoleStory.ChallengeInstanceSet
					end

					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.NurturanceTask.typeid then
					value.RoleMission = setmetatable(value.RoleMission,{
							__index = {
								Day = 0;--//第几天
								CurScore = 0;-- //当前分数
								CanRewardTag = 0;-- //可以领哪些
								RewardTag = 0;--//已经领了哪些
								
							}
						})
					activity.Day = value.RoleMission.Day
					activity.CurScore = value.RoleMission.CurScore
					activity.CanRewardTag = value.RoleMission.CanRewardTag
					activity.RewardTag = value.RoleMission.RewardTag
					activity.activity_items = GetReward(CSVTable, value.RoleMission.CanRewardTag, value.RoleMission.RewardTag)
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.CopyEquip.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.DecomposeEquip.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.SelectCamp2Story.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					activity.Camp = value.Camp or 0 
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.ActivitiesChallenge.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					value.ChallengeInfo = setmetatable(value.ChallengeInfo,{
						__index = {
							ChallengeTimes = 0;--//挑战次数
							Buffs = {};--当前激活的buff
						}})
					activity.ChallengeTimes = value.ChallengeInfo.ChallengeTimes
					activity.Buffs = value.ChallengeInfo.Buffs
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.GoDraw.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					table.insert(alllist, activity)
				elseif  activity.type == ActivityModel.ActivityType.ActivitiesChallengeMix.typeid then
					activity.activity_items = GetReward(CSVTable, 0, 0)
					value.SubActivity = setmetatable(value.SubActivity,{
							__index = {
								--[[
								message SubActivity {
								    int64 SubStep = 1;                //当前到第几阶段了
								    bool  Status = 2;                 //本阶段是否开启过
								    int64 StartTime = 3;              //本阶段开始时间
									int64 EndTIme = 4;                //本阶段结束时间
								}
								]]
								SubStep = 0;
								Status = false;
								StartTime = 0;
								EndTIme = 0;
							}
						})
					activity.SubStep = value.SubActivity.SubStep
					activity.Status = value.SubActivity.Status
					activity.starttime = value.SubActivity.StartTime
					activity.endtime = value.SubActivity.EndTIme
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.ActivitiesChallengeMixStageAward.typeid then
					value.ActivityCamp = setmetatable(value.ActivityCamp,{
						__index = {
							--[[
							 int32 CurStam = 1;              //当前体力
							    int32 TopStam = 2;              //累计体力
							    int32 CurRmb = 3;               //当前消耗RMB
							    int32 TopRmb = 4;               //累计消耗RMB
							    int32 CanRewardTag = 5;         //可以领哪些
							    int32 RewardTag = 6;            //已经领了哪些
							    repeated ActivityCampInfo CampInfo = 7; //本活动的阵营积分
							]]

							CurStam = 0;
							TopStam = 0;
							CurRmb = 0;
							TopRmb = 0;
							CanRewardTag = 0;
							RewardTag = 0;
							CampInfo = {};
						}
					})
					activity.activity_items = GetReward(CSVTable, value.ActivityCamp.CanRewardTag, value.ActivityCamp.RewardTag)
					activity.CampInfo = value.ActivityCamp.CampInfo
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.FirstRecharge.typeid then
					value.ChargeGift = setmetatable(value.ChargeGift,{
						__index = {
							-- bool CanReceive = 1;                //满足条件,可以领取
   							--bool IsReceive = 2;                 //已经领取
   							CanReceive = false;
   							IsReceive = false;
						}
					})
					activity.CanReceive = value.ChargeGift.CanReceive
					activity.IsReceive = value.ChargeGift.IsReceive
					activity.activity_items = GetReward(CSVTable, 0, 0)
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.UnlockPlot.typeid then
					if value.StoryGift == nil then
						value.StoryGift = {}
					end
					value.StoryGift = setmetatable(value.StoryGift,{
						__index = {
							-- int32 CanRewardTag = 1;         //可以领哪些
    						-- int32 RewardTag = 2;            //已经领了哪些
   							CanRewardTag = 0;
   							RewardTag = 0;
						}
					})
					activity.activity_items = GetReward(CSVTable, value.StoryGift.CanRewardTag, value.StoryGift.RewardTag)
					table.insert(alllist, activity)
				elseif activity.type == ActivityModel.ActivityType.DailyTaskTotal.typeid then
					if value.CountDailyTast == nil then
						value.CountDailyTast = {}
					end
					value.CountDailyTast = setmetatable(value.CountDailyTast,{
						__index = {
							-- int32 CanRewardTag = 1;         //可以领哪些
    						-- int32 RewardTag = 2;            //已经领了哪些
   							CanRewardTag = 0;
   							RewardTag = 0;
   							Count = 0;						--//一共完成了多少个
						}
					})
					activity.Count = value.CountDailyTast.Count
					activity.activity_items = GetReward(CSVTable, value.CountDailyTast.CanRewardTag, value.CountDailyTast.RewardTag)
					table.insert(alllist, activity)
				else
					print('未知类型：'..activity.type)
				end
				--end
			end
		end
	end
	--所有的数据
	ActivityModel.ServerDataAll = alllist
	local MinimunTime
	--过滤用于显示的数据
	local curTime = Utils.getSeverTime()
	local temp = {}
	for i,v in ipairs(alllist) do
		if v.show_type ~= ActivityModel.ShowType.No then
			if v.closetime == v.starttime or curTime <= v.closetime and curTime >= v.starttime then
				table.insert(temp,v)
			end
		end

		local Difference = 0
		if v.type == ActivityModel.ActivityType.GetPower.typeid then
			if v.EndTime > curTime then
				Difference = v.EndTime - curTime
			elseif v.StartTime > curTime then
				Difference = v.StartTime - curTime
			end
		else
			if v.closetime > curTime then
				--要关闭
				Difference = v.closetime - curTime
			elseif v.starttime > curTime then
				--要开始
				Difference = v.starttime - curTime
			else
				Difference = curTime
			end
		end

		if MinimunTime then
			if Difference < MinimunTime then
				MinimunTime = Difference
			end
		else
			MinimunTime = Difference
		end
	end

	--做定时 刷新数据
	if MinimunTime and MinimunTime ~= 0 then
		if tNextUpdateTimers then
			for i=1,#tNextUpdateTimers do
				tNextUpdateTimers[i]:Stop()
			end
			tNextUpdateTimers = {}
		else
			tNextUpdateTimers = {}
		end
		--寻找最短刷新时间点，设置标记
		MinimunTime = MinimunTime + 5
		print('运营活动主体数据下次刷新秒数：' .. MinimunTime)
		local timer = Timer.New(function ( ... )
			-- body
			ActivityModel.IsNeedUpdateData = true
			--直接拉数据用于各种刷新
			ActivityModel.getData2MainScene()
		end, MinimunTime, 1, 1)
		table.insert(tNextUpdateTimers,timer)
		timer:Start()
	end

	ActivityModel.ServerData = temp
	if callback then
		callback(ActivityModel.ServerData)
		callback = nil
	end
	
	ActivityModel.IsNeedUpdateData = false
	GUtilListener.dispatch("ActivityDataHaveUpdate");
end


ActivityModel.SendMessageFirst = false
--- get activities.
function ActivityModel:getActivities(refresh)
	print('请求运营活动主体数据！')
	local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
	local request_params = {roleid = tostring(role_id)}
	local mode = ActivityModel.SendMessageFirst and 2 or 1
	ActivityModel.SendMessageFirst = true
	Utils.SendMessageEx(mode,40000, request_params, function(response)
		--ActivityModel.Parse( response )
		ActivityModel.Parse2CSharp( response )
	end
	)
end

----弃用接口，请用UIActivitiesModel.GetIsRedByData
--从传入的data中查找某类型活动是否显示红点
function ActivityModel.isRed( ... )
	-- body
	local data,id,typeid = ...
	for k,v in pairs(data) do
		if v.show_type == ActivityModel.ShowType.Yunying then
		if tonumber(v.id) == id then
			if v.type == ActivityModel.ActivityType.Sign.typeid then
				if v.DaysSignRewardTag < #v.activity_items and ((Utils.getSeverTime() - v.DaysSignTime) >= 60*60*24 or v.DaysSignRewardTag == 0) then
					return true
				end
			elseif v.type == ActivityModel.ActivityType.Recharge.typeid or v.type == ActivityModel.ActivityType.RechargeCAPH.typeid 
				or v.type == ActivityModel.ActivityType.LevelUP.typeid or v.type == ActivityModel.ActivityType.Complete.typeid
				then
				--充值相关类型
				for k1,v1 in pairs(v.activity_items) do
					if v1.status == ActivityModel.Status.status_can_receive then
						return true
					end
				end
			elseif id == ARData.LevelUP.baseid or id == ARData.Campaign.baseid 
				or id == ARData.RechargeTotal.baseid or id == ARData.RechargeWelfare.baseid then
				--冲级活动 --通关活动 --累积充值 --福利充值
				for k1,v1 in pairs(v.activity_items) do
					if v1.status == ActivityModel.Status.status_can_receive then
						return true
					end
				end
			elseif id == ARData.GetStamina.baseid then
				--领取体力
				if v.CanReceive then
					return true
				end
			end
		end

		if v.type == typeid then
			if v.type == ActivityModel.ActivityType.Sign.typeid then
				if v.DaysSignRewardTag < #v.activity_items and ((Utils.getSeverTime() - v.DaysSignTime) >= 60*60*24 or v.DaysSignRewardTag == 0) then
					return true
				end
			elseif v.type == ActivityModel.ActivityType.Recharge.typeid or v.type == ActivityModel.ActivityType.RechargeCAPH.typeid 
				or v.type == ActivityModel.ActivityType.LevelUP.typeid or v.type == ActivityModel.ActivityType.Complete.typeid
				then
				for k1,v1 in pairs(v.activity_items) do
					if v1.status == ActivityModel.Status.status_can_receive then
						return true
					end
				end
			end
		end
		end
	end
	return false
end

--根据活动baseid获取msgid
function ActivityModel.getCode( ... )
	-- body
	local id,typeid = ...

	for k,v in pairs(ActivityModel.ActivityType) do
		if v.typeid == typeid then
			return v.msgid
		end
	end

	for k,v in pairs(ARData) do
		if v.baseid == id then
			return v.msgid
		end
	end

	return 0
end

ActivityModel.MsgUpdateUIFunc = nil
function ActivityModel.checkAllRed2CSharp( alldata )
	-- body
	local tag = false
	for k,v in pairs(ActivityModel.ActivityType) do
		tag = ActivityModel.isRed( alldata,0,v.typeid)
		if tag then
			break
		end
	end

	if not tag then
		for k,v in pairs(ARData) do
			tag = ActivityModel.isRed( alldata,v.baseid )
			if tag then
				break
			end
		end
	end
	AwardUtils.GetInstance():ActivityRemind(tag);
	--检测下是否在主界面
	-- if WaterBell.ProjX.View.UIFrame.UISceneManager.getInstance():CheckSceneIsShow(WaterBell.ProjX.View.UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()) then
	-- 	--- 显示活动界面按钮
	-- 	UIActivityButton.show(alldata)
	-- end

	--ActivityModel.ServerData = alldata

	--如果运营活动界面存在，强制重新刷新一次界面
	if UIActivitiesButtons.active then
		UIActivitiesButtons:show()
	end

	if ActivityModel.MsgUpdateUIFunc then
		ActivityModel.MsgUpdateUIFunc()
		ActivityModel.MsgUpdateUIFunc = nil
	end
	--主界面额外刷新显示
	MainScenePanelAdd.UpdateUI()
end

function ActivityModel.getData2MainScene( ... )
	-- body
	ActivityModel:RegisterCallback(ActivityModel.checkAllRed2CSharp)
	ActivityModel:getActivities(false)
end