--版式64
--分解装备

UIActivitiesFormat64 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat64")

local this = UIActivitiesFormat64

local data
local tPos
local LabelTime
local ScrollView
local Grid
local selectIndex
local UIResSpriteExAdd
local tSelect
local ButtonSprite
local LabelProbability
local Effect
local msgLock

local function test( ... )
	-- body
	--加成道具 1 2 3
	--加成道具系数 4 5 6	
	--单次兑换标准时间价值 7
	--单次兑换标准时间价值转化比率（1/10000）8
	--单次兑换加成时间价值 9
	--兑换结果上下浮动比率（1/10000）10
	--目标资源类型1	目标资源ID1	目标资源几率1	目标资源类型2	目标资源ID2	目标资源几率2	目标资源类型3	目标资源ID3	目标资源几率3	目标资源类型4	目标资源ID4	目标资源几率4
	--16 17 18 19 20 21 22 23 24 25 26 27
end 

function this.clear( ... )
	-- body
	 data = nil
	 tPos = nil
	 LabelTime = nil
	 ScrollView = nil
	 Grid = nil
	 selectIndex = nil
	 UIResSpriteExAdd = nil
	 tSelect = nil
	 ButtonSprite = nil
	 LabelProbability = nil
	 Effect = nil
	 msgLock = nil
end

local function canGet( ... )
	-- body
	--至少有 1 装备 + n 道具
	local needEquip = 0
	local needItem = 0
	for k,v in ipairs(tSelect) do
		if v.Type == GlobalEnum.ResType.Item then
			needItem = needItem + 1 
		elseif v.Type == GlobalEnum.ResType.Equip then
			needEquip = needEquip + 1 
		end
	end
	return (needEquip == 1) and needItem > 0
end 

local function updateCanGet( ... )
	-- body
	ButtonSprite.spriteName = canGet() and 'Button_Activty_Alchemy1_Start_Normal' or 'Button_Activty_Alchemy_Start_Disable'

	--预演可以得到的装备数量
	if canGet() then
		local itemPosCount = 0
		local equipTimeValue = 0
		for k,v in ipairs(tSelect) do
			if v.Type == GlobalEnum.ResType.Item then
				itemPosCount = itemPosCount + 1
			elseif v.Type == GlobalEnum.ResType.Equip then
				equipTimeValue = equipTimeValue + v.Num * v.time_value
			end
		end
		Utils.destoryChild( Grid )	

		local d = {}
		--目标资源类型1	目标资源ID1	目标资源几率1	目标资源类型2	目标资源ID2	目标资源几率2	目标资源类型3	目标资源ID3	目标资源几率3	目标资源类型4	目标资源ID4	目标资源几率4
		--16 17 18 19 20 21 22 23 24 25 26 27
		local activity_items1 = data.activity_items[1]
		local t = {}
		t.Type = GlobalEnum.ResType.IntToEnum(activity_items1.argument16)
		t.ID = activity_items1.argument17
		t.Probability = activity_items1.argument18
		table.insert(d,t)
		t = {}
		t.Type = GlobalEnum.ResType.IntToEnum(activity_items1.argument19)
		t.ID = activity_items1.argument20
		t.Probability = activity_items1.argument21
		table.insert(d,t)
		t = {}
		t.Type = GlobalEnum.ResType.IntToEnum(activity_items1.argument22)
		t.ID = activity_items1.argument23
		t.Probability = activity_items1.argument24
		table.insert(d,t)
		t = {}
		t.Type = GlobalEnum.ResType.IntToEnum(activity_items1.argument25)
		t.ID = activity_items1.argument26
		t.Probability = activity_items1.argument27
		table.insert(d,t)

		for i,v in ipairs(d) do
			local arg1 = activity_items1.argument7 * activity_items1.argument8 / 10000 + activity_items1.argument9 * itemPosCount
			local time_value
			--金币
			if v.Type == GlobalEnum.ResType.Gold then
				time_value = ManagerCsv.GetInstance():GetConstant('TIME_VALUE_GOLD').value4 / 10000
			--钻石
			elseif v.Type == GlobalEnum.ResType.Diamond then
				time_value = ManagerCsv.GetInstance():GetConstant('TIME_VALUE_DIAMOND').value4 / 10000
			else
				time_value = UIActivitiesModel.GetServantEquipOrItem( v.Type,v.ID ).time_value
			end
			local arg2 = 1 - activity_items1.argument10/10000
			v.Num = math.ceil(arg1 * arg2 / time_value)
			v.Value = v.Num
			local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(v.ID,v.Type,v.Num,Grid.transform,v.Value,0.6)
		end
		Grid.enabled = true
		ScrollView:ResetPosition()
		--LabelProbability.text = string.format('%s%%可能额外获得+1',math.floor(decimal * 100))
	else
		Utils.destoryChild( Grid )
	end
end

local function clearUI( ... )
	-- body
	tSelect = {}
	--LabelProbability.text = ''
	for i,v in ipairs(tPos) do	
		Utils.destoryChild( v.Goods )
	end
	Utils.destoryChild( Grid )	
	updateCanGet()
	Effect:SetActive(false)
end

function this.hide2show( ... )
	-- body
	data = ...
	LabelTime.text = UIActivitiesModel.GetTimeStampByTime( data.starttime,data.endtime )
	clearUI()
end

local function clickDelete( obj )
	-- body
	local index = tonumber(obj.transform.parent.name)
	Utils.destoryChild( tPos[index].Goods )
	for i=1,#tSelect do
		if tSelect[i].Index == index then
			table.remove(tSelect,i)
			break
		end
	end
	updateCanGet()
end

local function callFunc( ... )
	-- body
	local v = table.clone(...)

	--如果该位置本来就有东西，那就更新此位置的东西
	for i=1,#tSelect do
		if tSelect[i].Index == selectIndex then
			table.remove(tSelect,i)
			break
		end
	end
	v.Index = selectIndex
	--tSelect[v.ID] = v
	table.insert(tSelect,v)

	Utils.destoryChild( tPos[selectIndex].Goods )
	
	local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(v.ID,v.Type,v.Num,tPos[selectIndex].Goods,v.Value,0.8)
	trs:Find('Mid/IconFrame').gameObject:SetActive(false)
	trs:Find('Mid/Num').gameObject:SetActive(false)
	trs:Find('Mid/SuperScript').gameObject:SetActive(false)
	local ExAdd = NGUITools.AddChild(tPos[selectIndex].Goods.gameObject,UIResSpriteExAdd.gameObject)
	ExAdd.gameObject:SetActive(true)
	ExAdd.transform:Find('Label'):GetComponent('UILabel').text = 'x' .. v.Num
	UIEventListener.Get(ExAdd.transform:Find('Delete').gameObject).onClick = clickDelete
	ExAdd.name = selectIndex
	updateCanGet()
end

local function clickPos( obj )
	-- body
	local index = tonumber(obj.transform.parent.name)
	selectIndex = index
	if index == 4 then
		--打开装备
		--获取身上的装备列表
		local d = UIActivitiesModel.GetObservableEquips()
		if #d > 0 then
			local t = {}
			for i,v in ipairs(d) do
				--判断是否为合成装备
				local Qualit = UIActivitiesModel.GetEquipQualityByID(v.client_id)
				if v.compound and (Qualit > 0) and (Qualit < 4) then
					--判断所需要的数量是否满足
					local need = math.ceil(data.activity_items[1].argument7 / v.time_value)
					if v.Num >= need then
						--v.Num = need
						v.NeedNum = need
						table.insert(t,v)
					end
				end
			end
			if #t > 0 then
				UIPackagePicker:show(t,false,callFunc)
			else
				--提示没有满足数量的的装备
				--NetworkAlertUI.TryShowWarningTipBox('没有满足数量的的装备')
				NetworkAlertUI.TryShowWarningTipByTag('OperateNotEnough')
			end
		else
			--提示没有对应的的装备
			--NetworkAlertUI.TryShowWarningTipBox('没有对应的的装备')
			NetworkAlertUI.TryShowWarningTipByTag('OperateNoEquip')
		end
	else
		--如果该槽位已经选择了道具，那么打开就只能选择这个道具的数量
		local have
		for k,v in ipairs(tSelect) do
			if v.Index == index then
				have = v
				break
			end
		end
		if have then
			local d = {}
			local t = {}
			t.Type = GlobalEnum.ResType.Item
			t.Value = 0
			t.ID = have.ID
			t.Num = UIActivitiesModel.GetOrChangeItemOrEquipNum( t.Type,t.ID )
			local x = UIActivitiesModel.GetServantEquipOrItem( t.Type,t.ID )
			t.sequence = x.sequence
			t.time_value = x.time_value
			local need = math.ceil(data.activity_items[1].argument9 / t.time_value)
			--t.Num = need
			t.NeedNum = need
			table.insert(d,t)
			UIPackagePicker:show(d,false,callFunc)
			return
		end
		--打开道具选择
		local tID = {}
		if data.activity_items[1].argument1 then
			table.insert(tID,data.activity_items[1].argument1)
		end
		if data.activity_items[1].argument2 then
			table.insert(tID,data.activity_items[1].argument2)
		end
		if data.activity_items[1].argument3 then
			table.insert(tID,data.activity_items[1].argument3)
		end

		local d = {}
		for i,v in ipairs(tID) do
			local t = {}
			t.Type = GlobalEnum.ResType.Item
			t.Value = 0
			t.ID = v
			t.Num = UIActivitiesModel.GetOrChangeItemOrEquipNum( t.Type,t.ID )
			local x = UIActivitiesModel.GetServantEquipOrItem( t.Type,t.ID )
			t.sequence = x.sequence
			t.time_value = x.time_value
			local need = math.ceil(data.activity_items[1].argument9 / t.time_value)
			local have
			for i,v in ipairs(tSelect) do
				if v.ID == t.ID then
					have = true
					break
				end
			end
			if t.Num >= 1 and not have then
				--t.Num = need
				t.NeedNum = need
				table.insert(d,t)
			end
		end

		if #d > 0 then
			UIPackagePicker:show(d,false,callFunc)
		else
			--提示没有对应的的道具
			--NetworkAlertUI.TryShowWarningTipBox('没有对应的的道具')
			NetworkAlertUI.TryShowWarningTipByTag('OperateNoItem')
		end
	end
end

local function clickButton( obj )
	-- body
	if msgLock then
		print('防止多次点击')
		return
	end
	if canGet() then
		msgLock = true
		local send = function ( ... )
			-- body
			--判断下当前界面是否在激活状态
			if not this.active then
				return
			end

			--减少身上的物品和道具
			for k,v in ipairs(tSelect) do
				UIActivitiesModel.GetOrChangeItemOrEquipNum( v.Type,v.ID, - v.Num )
			end
			--发送协议，清空界面
			UIActivitiesModel.SendMsg2CopyEquip( data.id,ActivityModel.ActivityType.DecomposeEquip.msgid,tSelect,function ( ... )
				-- body
				clearUI()
				msgLock = false
			end )
		end
		--展示特效0.5s后发送协议
		local timer =  Timer.New(send, 0.5, 1, true)
		timer:Start()
		Effect:SetActive(true)
	else
		--提示请放入材料和装备
		--NetworkAlertUI.TryShowWarningTipBox('请放入材料和装备')
		NetworkAlertUI.TryShowWarningTipByTag('OperatePlace')
	end
end

local function clickHelp( ... )
	-- body
	--ManagerCsv.GetInstance():GetNameStatic('OperateAlchemyHelp2')
	UIHelpPanel:show(ManagerCsv.GetInstance():GetNameStatic('OperateAlchemyHelp2'))
end

function this.init( ... )
	-- body
	--test()
	tSelect = {}
	tPos = {}
	local pos = this.page.transform:Find('Pos')
	for i=1,pos.childCount do
		local obj = pos:GetChild(i - 1)
		
		local t = {}
		t.Add = obj:Find('Add').gameObject
		UIEventListener.Get(t.Add).onClick = clickPos
		t.Goods = obj:Find('Goods')
		table.insert(tPos,t)
	end

	ScrollView = this.page.transform:Find('ScrollView'):GetComponent('UIScrollView')
	Grid = ScrollView.transform:Find('Grid'):GetComponent('UIGrid')

	LabelTime = this.page.transform:Find('LabelTime'):GetComponent('UILabel')
	local Button = this.page.transform:Find('Button')
	ButtonSprite = Button:GetComponent('UISprite')
	UIEventListener.Get(Button.gameObject).onClick = clickButton
	local Help = this.page.transform:Find('Help')
	UIEventListener.Get(Help.gameObject).onClick = clickHelp

	UIResSpriteExAdd = this.page.transform:Find('UIResSpriteExAdd')
	UIResSpriteExAdd.gameObject:SetActive(false)

	LabelProbability = this.page.transform:Find('LabelProbability'):GetComponent('UILabel')
	Effect = this.page.transform:Find('Effect').gameObject
	Effect:SetActive(false)
	this.hide2show( ... )
end