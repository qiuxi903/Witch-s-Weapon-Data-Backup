UIOldUserRegressionSystemGift = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIOldUserRegressionSystemGift")
local this = UIOldUserRegressionSystemGift

local tSelector
local Item
local tButton
local index
local Data
local Condition
local Root

local strOperateReceive
local strRechargeText_AlreadyRecharge
local strRechargeText_GoRecharge
local strOperateReward2
local strReward

function this.clear( ... )
	-- body
	 tSelector = nil
	 Item = nil
	 tButton = nil
	 index = nil
	 Data = nil
	 Condition = nil
	 Root = nil
end

local function UpdateRed( ... )
	-- body
	for i,v in ipairs(tSelector) do
		v.Red.gameObject:SetActive(Data.activity_items[i].status == ActivityModel.Status.status_can_receive)
	end
end

local function UpdateGift( ... )
	-- body
	for i=1,#Data.activity_items[index].rewards do
		local temp
		if Root.transform.childCount < i then
			temp = NGUITools.AddChild(Root.gameObject,Item.gameObject)
		else
			temp = Root:GetChild(i - 1)
		end
		temp = temp.transform

		if i < 3 then
			--第一行两个
			temp.localPosition = Vector3.New(OffsetX * (i - 1),0,0)
		elseif i == 3 then
			--第二行1个
			temp.localPosition = Vector3.New(OffsetX / 2, - OffsetY,0)
		end

		temp:Find('Title'):GetComponent('UILabel').text = strReward .. i

		local reward = Data.activity_items[index].rewards[i]

		local tempRoot = temp:Find('Root')
		Utils.destoryChild( tempRoot )
		local trs = AwardUtils.GetInstance():LoadAwardSprite(reward.id,reward.type,reward.num,tempRoot,reward.value,1)
		local Mid = trs:Find('Mid')
		Mid:Find('SuperScript').gameObject:SetActive(false)
		Mid:Find('IconFrame').gameObject:SetActive(false)
		local Num = Mid:Find('Num'):GetComponent('UILabel')
		Num.gameObject:SetActive(false)
		temp:Find('Num'):GetComponent('UILabel').text = Num.text

		Condition.text = Data.activity_items[index]["desc"]
	end

	local status = Data.activity_items[index].status
	
	if status == ActivityModel.Status.status_received then
		--已领取
		tButton.Label.text = strOperateReceive
		tButton.BG.spriteName = 'olduser_anniu01_02'
	elseif status == ActivityModel.Status.status_can_receive then
		--可领取
		tButton.Label.text = strOperateReward2
		tButton.BG.spriteName = 'olduser_anniu01_01'
	else
		--不可领取
		tButton.Label.text = strOperateReward2
		tButton.BG.spriteName = 'olduser_anniu01_02'
	end
end

local function ClickSelector( obj )
	-- body
	if not obj then
		index = 1
	else
		tSelector[index].Select.gameObject:SetActive(false)
		tSelector[index].Label.color = Color.white
		index = tonumber(obj.name)
	end

	tSelector[index].Select.gameObject:SetActive(true)
	tSelector[index].Label.color = Color.black
	UpdateGift()
end

function this.init( ... )
	-- body
	Data = UIActivitiesModel.GetServerDataAllByID( 991 )

	strOperateReceive = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--已领取
	strRechargeText_AlreadyRecharge = ManagerCsv.GetInstance():GetNameStatic('RechargeText_AlreadyRecharge') --已充%s
	strRechargeText_GoRecharge = ManagerCsv.GetInstance():GetNameStatic('RechargeText_GoRecharge')--去充值
	strOperateReward2 = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')--领取
	strReward = ManagerCsv.GetInstance():GetNameStatic('奖励') -- 奖励

	Condition = this.page.transform:Find('TopContent/Condition'):GetComponent('UILabel')
	local Recharge = this.page.transform:Find('TopContent/Recharge'):GetComponent('UILabel')
	Recharge.text = string.format(strRechargeText_AlreadyRecharge,Data.Recharge)

	local Button = this.page.transform:Find('Button')
	tButton = {}
	tButton.Label = Button:Find('Label'):GetComponent('UILabel')
	tButton.Label.text = ''
	tButton.BG = Button:Find('BG'):GetComponent('UISprite')
	tButton.BG.spriteName = 'olduser_anniu01_02'

	UIEventListener.Get(Button.gameObject).onClick = function ( ... )
		-- body
		local status = Data.activity_items[index].status
		if status == ActivityModel.Status.status_can_receive then
			--发送协议领取奖励
			local roleid = tostring(WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():RoleID())
			local baseid = Data.id
			local serial = index
			local msgParams = {roleid = roleid,baseid = baseid,serial = serial}
			Utils.SendMessage(ActivityModel.getCode(baseid,Data.type),msgParams, function(response)
				local bytes = response.bytes
				local LuaNetProxy = LuaNetProxy.New()
				LuaNetProxy:Callback(bytes)

				Data.activity_items[index].status = ActivityModel.Status.status_received
				tButton.Label.text = strOperateReceive
				tButton.BG.spriteName = 'olduser_anniu01_02'
				UIOldUserRegressionSystem.UpdateRed()
				UpdateRed()
				Utils.GetRoleInfoByMsg()
			end)
		end
		
	end

	Item = this.page.transform:Find('Item')
	local Center = this.page.transform:Find('Center')
	Root = Center:Find('Root')

	local Center = this.page.transform:Find('Center')
	local OffsetXY = Center:Find('OffsetXY')
	OffsetX = OffsetXY.localPosition.x
	OffsetY = OffsetXY.localPosition.y

	local SelectorItem = this.page.transform:Find('SelectorItem')
	local Selector = this.page.transform:Find('Selector')
	local Selector_Grid = Selector:Find('Grid'):GetComponent('UIGrid')
	tSelector = {}
	local lastSelectorItem
	for i=1,#Data.activity_items do
		local temp = NGUITools.AddChild(Selector_Grid.gameObject,SelectorItem.gameObject)
		temp = temp.transform
		temp.name = i
		local t = {}
		t.Select = temp:Find('Select')
		t.Select.gameObject:SetActive(false)
		t.Label = temp:Find('Label'):GetComponent('UILabel')

		t.Label.text = i
		t.Label.color = Color.white
		t.Red = temp:Find('Red')
		table.insert(tSelector,t)
		UIEventListener.Get(temp.gameObject).onClick = ClickSelector
	end
	ClickSelector()
	UpdateRed()
end