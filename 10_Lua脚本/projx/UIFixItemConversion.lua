UIFixItemConversion = BaseView:new("UI/Prefab/UIPrefab/UIFix/","UIFixItemConversion")

local this = UIFixItemConversion
local msgLock
local RightButtons
local Item1
local IsUnLock
local IsExist
local Star
local showRestart

function this.clear( ... )
	-- body
	msgLock = nil
	 RightButtons = nil
	 Item1 = nil
	 IsUnLock = nil
	 IsExist = nil
	 Star = nil
	 showRestart = nil
	 GUtilListener.removeListener("ActivityCloseAwardsPanelListener", UIFixItemConversion.ActivityCloseAwardsPanelListener)
end

local function CheckItemNum1( ... )
	-- body
	--判断玩家身上道具是否足够
	--100个吉他魔导器 40130006，20个吉他核心 40330049，ssr吉他，
	local num1 = UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40130006)
	local num2 = UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40330049)

	return num1 >= 100 and num2 >=20
end

local function CheckItemNum2( ... )
	-- body
	--当前玩家100个吉他魔导器 40130006，当前玩家大盾星级到零一共所需魔导器 + 身上的 >= 100 可用规则2
    --20个吉他核心 40330049，ssr吉他 不够 规则2用不了
    --大盾星级到零一共所需魔导器 + 身上的 - 100 / 没星所需数量 = 星 + 被包中数量（余数）

    --吉他星级表 ID 1301050100 1301050101 1301050102 1301050103 1301050104 1301050105
    local CSVServantStarInfo = CSVPool.ServantStarInfo()
    local StarNeedItems = {}
    local IDIndex = 0
    local t
    for i,v in ipairs(CSVServantStarInfo) do
    	if v.ID == 1301050100 + IDIndex then
    		t = {}
    		t.levelup_item_num = v.levelup_item_num
    		t.cost = v.cost
    		table.insert(StarNeedItems,t)
    		IDIndex = IDIndex + 1
    		if IDIndex == 6 then
    			break
    		end
    	end
    end
    if #StarNeedItems < 5 then
    	print('#StarNeedItems < 5')
    	return
    end
    --背包中的数量
    local num1 = UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40130006)
    local num2 = UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40330049)

    local costItemNum = 0
    print('当前星级：' .. Star)
    for i=0,Star do
    	if StarNeedItems[i] then
    		costItemNum = costItemNum + StarNeedItems[i].levelup_item_num
    	end
    end
    if (costItemNum + num1 < 100) or num2 < 20 then
    	print('costItemNum:' .. costItemNum)
    	print('num1:' .. num1)
    	print('num2:' .. num2)
    	print('不满足规则2:'.. costItemNum + num1)
    	return
    end
    return true
end

function ButtonsClick( obj )
	-- body
	local name = obj.name
	if name == 'Close' then
		this:destory()
	elseif name == 'Conversion' then
		if msgLock then
			return
		end
		if not IsUnLock then
			NetworkAlertUI.TryShowWarningTipByTag('FixDrawConversionNoHaveWeapon')
			return
    	end
		if RightButtons.ClickRightIndex == 1 then
			if not CheckItemNum1() then	
				NetworkAlertUI.TryShowWarningTipByTag('E21101')
				return
			end
			local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
			--提示 OperateGiftBag4
			local strTS = ManagerCsv.GetInstance():GetNameStatic('OperateGiftBag4')
			local strSelect = ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionSelect')
			Alert:setData(strTS,strSelect)
			Alert:setListener(
				function ( ... )
					-- body
					--发送转换协议

					msgLock = true
					local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
					local request_params = {roleid = tostring(role_id)}
					Utils.SendMessage(40018, request_params, 
						function(response)
							UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40130006,-100)
							UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40330049,-20)
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:Callback(bytes)
							msgLock = false
							-- local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
							-- local strResetContent = ManagerCsv.GetInstance():GetNameStatic('CE10007')
							-- local strReset = ManagerCsv.GetInstance():GetNameStatic('重启')
							-- Alert:setButton(true,strReset,nil)
							-- Alert:setData(strTS,strResetContent)
							-- Alert:setListener(
							-- 	function ( ... )
							-- 	this.clear()
							-- 	NetworkAlertUI.RestartGame()
							-- 	end
							-- ,nil)
						end
					)
				end
			,nil)
		elseif RightButtons.ClickRightIndex == 2 then
			if CheckItemNum1() then		
				NetworkAlertUI.TryShowWarningTipByTag('FixDrawConversionPleaseSelect1')
				return
			end
			if not CheckItemNum2() then
				NetworkAlertUI.TryShowWarningTipByTag('E21101')
				return
			end
			local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
			--提示 OperateGiftBag4
			local strTS = ManagerCsv.GetInstance():GetNameStatic('OperateGiftBag4')
			local strSelect = ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionSelect')
			Alert:setData(strTS,strSelect)
			Alert:setListener(
				function ( ... )
					-- body
					--发送转换协议

					msgLock = true
					local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
					local request_params = {roleid = tostring(role_id)}
					Utils.SendMessage(40018, request_params, 
						function(response)
							-- UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40130006,-100)
							-- UIActivitiesModel.GetOrChangeItemOrEquipNum( GlobalEnum.ResType.Item,40330049,-20)
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:Callback(bytes)
							msgLock = false
							showRestart = true
						end
					)
				end
			,nil)
		end
	end
end

function ClickRightButton( obj )
	-- body
	if obj then
		RightButtons.ClickRightIndex = tonumber(obj.name)
	else
		RightButtons.ClickRightIndex = 1
	end

	if RightButtons.ClickRightLastIndex == RightButtons.ClickRightIndex  then
		return
	end
	
	Item1.gameObject:SetActive(RightButtons.ClickRightIndex == 1)
	Item2.gameObject:SetActive(RightButtons.ClickRightIndex == 2)

	if RightButtons.ClickRightIndex == 1 then
	    this.page.transform:Find('Scroll View/Rule'):GetComponent('UILabel').text = 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule1_word1') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule1_word2') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_a') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_b') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_c') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_extra')
	else
		this.page.transform:Find('Scroll View/Rule'):GetComponent('UILabel').text = 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule2_word1') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule2_word2') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_a') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_b') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_c') .. '\n' .. 
	    ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRule_extra')
	end
	this.page.transform:Find('Scroll View'):GetComponent('UIScrollView'):ResetPosition()

	if RightButtons.ClickRightLastIndex then
		RightButtons.Buttons[RightButtons.ClickRightLastIndex].Label.color = RightButtons.LabelColor[2]
		RightButtons.Buttons[RightButtons.ClickRightLastIndex].Sprite.spriteName = RightButtons.SpriteName[2]
	end
	RightButtons.Buttons[RightButtons.ClickRightIndex].Label.color = RightButtons.LabelColor[1]
	RightButtons.Buttons[RightButtons.ClickRightIndex].Sprite.spriteName = RightButtons.SpriteName[1]

	RightButtons.ClickRightLastIndex = RightButtons.ClickRightIndex
end

function initRightButtons( ... )
	-- body
	RightButtons = {}
	RightButtons.Buttons = {}
	--[2]选中
	RightButtons.LabelColor = {Color.New(97/255,97/255,97/255,1),Color.New(115/255,115/255,115/255,1)}
	RightButtons.SpriteName = {'Button_Tab_Sellected_Normal','Button_Tab_Normal_Normal'}
	local trs = this.page.transform:Find('Right/Buttons')
	local child
	local t
	for i=1,trs.childCount do
		child = trs:GetChild(i-1)
		t = {}
		t.Sprite = child:GetComponent('UISprite')
		t.Label = child.transform:Find('Label'):GetComponent('UILabel')
		t.Label.color = RightButtons.LabelColor[2]
		t.Label.text = ManagerCsv.GetInstance():GetNameStatic('转化规则') .. i
		t.Sprite.spriteName = RightButtons.SpriteName[2]
		table.insert(RightButtons.Buttons,t)
		UIEventListener.Get(child.gameObject).onClick = ClickRightButton
	end
	ClickRightButton()
end

function this.init( ... )
	-- body
	Item1 = this.page.transform:Find('Item1')
	Item2 = this.page.transform:Find('Item2')

	UIEventListener.Get(this.page.transform:Find('TopLine/Close').gameObject).onClick = ButtonsClick
	UIEventListener.Get(this.page.transform:Find('Conversion').gameObject).onClick = ButtonsClick
	
	this.page.transform:Find('TopLine/Label'):GetComponent('UILabel').text = 
	ManagerCsv.GetInstance():GetNameStatic('特殊转化目标魔女') .. ' : ' ..
	ManagerCsv.GetInstance():GetName(11101110101)

    --掉落展示
	--     {Type: global.RESOURCE_ITEM, Id: 40130012, Num: 100},--1. 都有  
	-- 		{Type: global.RESOURCE_ITEM, Id: 40330059, Num: 20},
	-- {Type: global.RESOURCE_WEAPON, Id: 1701110102, Num: 1},--2.都没有 
	-- 		{Type: global.RESOURCE_SERVANT, Id: 10011101, Num: 1},
	-- 	{Type: global.RESOURCE_WEAPON, Id: 1701110102, Num: 1},--3.有英灵 没武器
	-- 		{Type: global.RESOURCE_ITEM, Id: 40130012, Num: 100},

    --展示物品
    local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
    local scale = 0.7
    --扣除的物品 100个吉他魔导器 40130006，20个吉他核心 40330049，ssr吉他
    local item = Item1
    local GoodsRoot = item:Find('GoodsRoot')
    AwardUtils.GetInstance():LoadAwardSpriteEx(40130006,GlobalEnum.ResType.Item,100,GoodsRoot,0,scale)
	AwardUtils.GetInstance():LoadAwardSpriteEx(40330049,GlobalEnum.ResType.Item,20,GoodsRoot,0,scale)
	GoodsRoot:GetComponent('UIGrid').enabled = true
	--什么都没有
    local GoodsRoot1 = item:Find('GoodsRoot1')
    AwardUtils.GetInstance():LoadAwardSpriteEx(10011101,GlobalEnum.ResType.Servant,1,GoodsRoot1,0,scale)
	AwardUtils.GetInstance():LoadAwardSpriteEx(1701110102,GlobalEnum.ResType.Weapon,1,GoodsRoot1,0,scale)
	GoodsRoot1:GetComponent('UIGrid').enabled = true	
    --有魔女没武器
    local GoodsRoot2 = item:Find('GoodsRoot2') 
	AwardUtils.GetInstance():LoadAwardSpriteEx(40130012,GlobalEnum.ResType.Item,100,GoodsRoot2,0,scale)
	AwardUtils.GetInstance():LoadAwardSpriteEx(1701110102,GlobalEnum.ResType.Weapon,1,GoodsRoot2,0,scale)
	GoodsRoot2:GetComponent('UIGrid').enabled = true	
    --有魔女有武器
    local GoodsRoot3 = item:Find('GoodsRoot3')
    AwardUtils.GetInstance():LoadAwardSpriteEx(40130012,GlobalEnum.ResType.Item,100,GoodsRoot3,0,scale)
    AwardUtils.GetInstance():LoadAwardSpriteEx(40330059,GlobalEnum.ResType.Item,20,GoodsRoot3,0,scale)
    GoodsRoot3:GetComponent('UIGrid').enabled = true	

    --为了ui显示方便，先临时这么写，后面有机会在优化
    local item = Item2
    local GoodsRoot = item:Find('GoodsRoot')
    AwardUtils.GetInstance():LoadAwardSpriteEx(40130006,GlobalEnum.ResType.Item,100,GoodsRoot,0,scale)
	AwardUtils.GetInstance():LoadAwardSpriteEx(40330049,GlobalEnum.ResType.Item,20,GoodsRoot,0,scale)
	GoodsRoot:GetComponent('UIGrid').enabled = true
	--什么都没有
    local GoodsRoot1 = item:Find('GoodsRoot1')
    AwardUtils.GetInstance():LoadAwardSpriteEx(10011101,GlobalEnum.ResType.Servant,1,GoodsRoot1,0,scale)
	AwardUtils.GetInstance():LoadAwardSpriteEx(1701110102,GlobalEnum.ResType.Weapon,1,GoodsRoot1,0,scale)
	GoodsRoot1:GetComponent('UIGrid').enabled = true	
    --有魔女没武器
    local GoodsRoot2 = item:Find('GoodsRoot2') 
	AwardUtils.GetInstance():LoadAwardSpriteEx(40130012,GlobalEnum.ResType.Item,100,GoodsRoot2,0,scale)
	AwardUtils.GetInstance():LoadAwardSpriteEx(1701110102,GlobalEnum.ResType.Weapon,1,GoodsRoot2,0,scale)
	GoodsRoot2:GetComponent('UIGrid').enabled = true	
    --有魔女有武器
    local GoodsRoot3 = item:Find('GoodsRoot3')
    AwardUtils.GetInstance():LoadAwardSpriteEx(40130012,GlobalEnum.ResType.Item,100,GoodsRoot3,0,scale)
    AwardUtils.GetInstance():LoadAwardSpriteEx(40330059,GlobalEnum.ResType.Item,20,GoodsRoot3,0,scale)
    GoodsRoot3:GetComponent('UIGrid').enabled = true	

    initRightButtons()
    --反射模块

	require 'tolua.reflection'          
	tolua.loadassembly('Assembly-CSharp') 
	--测试是否能拿到接口
	--10010501,1701050102
	local ServantInfo = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetServantInfo()
    --查看魔女星级
    local t = typeof('WaterBell.ProjX.Data.Entity.ServantCore')
    local func = tolua.getmethod(t, 'GetObservableServantsByID',typeof('System.Int64'))
    local ObservableServants = func:Call(ServantInfo,10010501)

    local t = typeof('WaterBell.ProjX.Data.Entity.ObservableSingleServant')
    local property = tolua.getproperty(t, 'Star')

    Star = property:Get(ObservableServants, null)

    local property = tolua.getproperty(t, 'IsExist')

    IsExist = property:Get(ObservableServants, null)

    local t = typeof('WaterBell.ProjX.Data.Entity.ServantCore')

    local func = tolua.getmethod(t, 'GetObservableServantWeaponByID',typeof('System.Int64'),typeof('System.Int64'))
    local ObservableServantWeapon = func:Call(ServantInfo,10010501,1701050102)

    func:Destroy()

    local t = typeof('WaterBell.ProjX.Data.Entity.ObservableServantWeapon')
    local property = tolua.getproperty(t, 'IsUnLock')

    IsUnLock = property:Get(ObservableServantWeapon, null)
    property:Destroy()

    GUtilListener.addEventListener("ActivityCloseAwardsPanelListener", UIFixItemConversion.ActivityCloseAwardsPanelListener)
end

local function ActivityCloseAwardsPanelListener( ... )
	-- body
	local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
	local strResetContent = ManagerCsv.GetInstance():GetNameStatic('FixDrawConversionRestartContent')
	local strReset = ManagerCsv.GetInstance():GetNameStatic('重启')
	Alert:setButton(true,strReset,nil)
	Alert:setData(strTS,strResetContent)
	Alert:setListener(
		function ( ... )
		this.clear()
		NetworkAlertUI.RestartGame()
		end
	,nil)
end

function UIFixItemConversion.ActivityCloseAwardsPanelListener( arg )
	-- body
	if not showRestart then
		return
	end
	if arg.eventArgs then
		ActivityCloseAwardsPanelListener()
	else
		local timer =  Timer.New(ActivityCloseAwardsPanelListener, 0.7, 1, true)
		timer:Start()
	end
	showRestart = false
end