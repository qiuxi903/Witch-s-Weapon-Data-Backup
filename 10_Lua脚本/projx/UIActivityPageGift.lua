UIActivityPageGift = BaseView:new("UI/Prefab/UIPrefab/UIActivity/","UIActivityPageGift",AssetsManager.AssetsType.LuaAssets1)

local this

local curData

local objLevelItem
local objLevelRoot

local objRewardRoot

local index
local lastIndex

local tLevel
local tButton
local tRewardHacked
local tabTextureAsset

local curLevel
local tSign
local Ttitle

local curPrice

local function clear( ... )
	-- body
	this = nil

	curData  = nil

	objLevelItem  = nil
	objLevelRoot  = nil

	objRewardRoot  = nil

	index = nil
	lastIndex = nil

	tLevel = nil
	tButton = nil
	tRewardHacked = nil
	tabTextureAsset = nil

	curLevel = nil
	tSign = nil
	Ttitle = nil
	curPrice = nil

	GUtilListener.removeListener("ShoppingListener", UIActivityPageGift.Shopping)
	--购买成功回调，刷新数据
	GUtilListener.removeListener("ActivityBuyViewListener", UIActivityPageGift.ActivityBuyViewListener)
	--购买失败
	GUtilListener.removeListener("ActivityBuyViewFailListener", UIActivityPageGift.ActivityBuyViewFailListener)
end

local function Close( ... )
	-- body
	this:destory()

	--UIActivityButton.updateRed()
	MainScenePanelAdd.UpdateRed()

	UIWindowsManager.GetInstance():RemoveAction()
	LuaPanelHelper.GoBackMainScene()
end

local function InitSign( ... )
	-- body
	tSign = {}

	local SignItem = this.page.transform:Find('SignItem')

	local SignShow = this.page.transform:Find('SignShow'):GetComponent('UISprite')
	local SignPanel = this.page.transform:Find('SignPanel')

	local SingGrid = SignPanel:Find('ScrollView/Grid'):GetComponent('UIGrid')

	SignShow.spriteName = 'Icon_Storage_1'
	SignPanel.gameObject:SetActive(false)

	UIEventListener.Get(SignShow.gameObject).onClick = function ( ... )
		-- body
		SignShow.spriteName = 'Icon_Storage_2'
		SignPanel.gameObject:SetActive(true)
	end

	UIEventListener.Get(SignPanel:Find('Close').gameObject).onClick = function ( ... )
		-- body
		SignShow.spriteName = 'Icon_Storage_1'
		SignPanel.gameObject:SetActive(false)
	end

	UIEventListener.Get(this.page.transform:Find('TopLeft/Close').gameObject).onClick = function ( ... )
		-- body
		Close()
	end

	local SignData = UIActivitiesModel.GetServerDataAllByID( 17 )

	local reward
	local obj
	local trs
	local canSign = Utils.getSeverTime() - SignData.DaysSignTime >= 60 * 60 * 24 or SignData.DaysSignRewardTag == 0
	local t
	local isLast
	local signDay = SignData.DaysSignRewardTag + 1
	if signDay > #SignData.activity_items then
		canSign = false
		signDay = SignData.DaysSignRewardTag
		isLast = true
	end
	local obj
	for i,v in ipairs(SignData.activity_items) do
		
		if SingGrid:GetChild(i - 1) then
			obj = SingGrid:GetChild(i - 1)
		else
			obj = NGUITools.AddChild(SingGrid.gameObject,SignItem.gameObject)
		end
		obj.transform:Find('date/labelDay'):GetComponent('UILabel').text = i
		local rewardRoot = obj.transform:Find('rewardRoot')
		for ii,vv in ipairs(v.rewards) do
			local child = rewardRoot:GetChild(ii - 1)
			local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(vv.id,vv.type,vv.num,child.transform,vv.value,1)	
			
			child.gameObject:SetActive(true)

			local Num = trs:Find('Mid/Num'):GetComponent('UILabel')
			local labelNum = child.transform:Find('labelNum'):GetComponent('UILabel')
			if Num.gameObject.activeSelf then
				labelNum.gameObject:SetActive(true)
				labelNum.text = Num.text
				Num.gameObject:SetActive(false)
			else
				labelNum.gameObject:SetActive(false)
			end
			
			child.transform:Find('back'):GetComponent('UISprite').spriteName = 'Prize_Box_' .. ii
		end

		for ii=#v.rewards + 1,rewardRoot.childCount do
			rewardRoot:GetChild(ii - 1).gameObject:SetActive(false)
		end
		if i < signDay then
			--已经签到的
			obj.transform:Find('iconUnReward').gameObject:SetActive(true)
		elseif i > signDay then
			--还没有签到的
			obj.transform:Find('iconUnReward').gameObject:SetActive(false)
		else
			--当前的天数
			SignItem.transform:Find('date/labelDay'):GetComponent('UILabel').text = i
			--obj.transform:Find('iconReward').gameObject:SetActive(not canSign)
			if isLast then
				obj.transform:Find('iconUnReward').gameObject:SetActive(true)
			end
		end

	end

	local rewardRoot = SignItem.transform:Find('rewardRoot')
	for ii,vv in ipairs(SignData.activity_items[signDay].rewards) do
		local child = rewardRoot:GetChild(ii - 1)
		local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(vv.id,vv.type,vv.num,child.transform,vv.value,1)	
	
		child.gameObject:SetActive(true)

		local Num = trs:Find('Mid/Num'):GetComponent('UILabel')
		local labelNum = child.transform:Find('labelNum'):GetComponent('UILabel')
		if Num.gameObject.activeSelf then
			labelNum.text = Num.text
			Num.gameObject:SetActive(false)
			labelNum.gameObject:SetActive(true)
		else
			labelNum.gameObject:SetActive(false)
		end
		
		child.transform:Find('back'):GetComponent('UISprite').spriteName = 'Prize_Box_' .. ii

	end
	for ii=#SignData.activity_items[signDay].rewards + 1,rewardRoot.childCount do
		rewardRoot:GetChild(ii - 1).gameObject:SetActive(false)
	end
	
	--SignItem.transform:Find('iconReward').gameObject:SetActive(not canSign)

	local Get = SignItem.transform:Find('Get').gameObject
	Get:SetActive(canSign)
	
	UIEventListener.Get(Get).onClick = function ( ... )
		-- body
		--发送协议
		local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
		local request_params = {roleid = tostring(role_id),baseid = tostring(SignData.id)}
		local msgid = ActivityModel.getCode( SignData.id,SignData.type )
		Utils.SendMessage(msgid, request_params, function(response)
			local bytes = response.bytes
			local LuaNetProxy = LuaNetProxy.New()
			LuaNetProxy:Callback(bytes)
			SignData.DaysSignRewardTag = SignData.DaysSignRewardTag + 1
			SignData.DaysSignTime = Utils.getSeverTime()
			Get:SetActive(false)
			SignItem.transform:Find('iconReward').gameObject:SetActive(true)
			UIEventListener.Get(Get).onClick = function ( ... )
				-- body
			end
		end)
	end

	if isLast then
		SignItem.transform:Find('iconReward').gameObject:SetActive(true)
	end
end

local function updateReward( v )
	-- body
	Utils.destoryChild( objRewardRoot )
	local ShopGoods = WaterBell.ProjX.Common.Utils.AwardUtils.GetShopGoods(v.argument1,v.argument2,v.argument3)
	for i=1,ShopGoods.Count do
		local item = ShopGoods[i - 1]
		local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(item.rawID,item.rawType,item.rawNum,objRewardRoot.transform,item.rawValue,0.75)
		
		TweenAlpha.Begin(trs.gameObject,0.7 , 1,0)
		local Num = trs:Find('Mid/Num'):GetComponent('UILabel')
		if Num.gameObject.activeSelf then
			Num.gameObject:SetActive(false)
			if tRewardHacked[i] ~= nil then
				tRewardHacked[i].Obj:SetActive(true)
				tRewardHacked[i].Num.text = Num.text
			end
		else
			tRewardHacked[i].Obj:SetActive(false)
		end
	end
	objRewardRoot.transform:GetComponent('UIGrid').enabled = true

	local shopSet = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetShopAllSets():GetShopSetByID(v.argument1)
	local shop = shopSet:GetShopByID(v.argument2)
	local goods = shop:GetGoodByID(v.argument3)
	--CurrencySymbol
	local Price
	local CurrencySymbol
	local goodsCsv = ManagerCsv.GetInstance():GetGoods(goods.ShopGoodID)
	if ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr or ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr_test then
		CurrencySymbol = '$'
		Price = goodsCsv.kr_ios_value
	elseif 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp_test or 

		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en
		then
		CurrencySymbol = ManagerCsv.GetInstance():GetNameStatic('DiamondTipsRealRmb')
		--后面会除以100 日服是钻石价格 先乘以100把
		Price = goods.Price * 100
	else
		Price = goods.Price
		CurrencySymbol = ManagerCsv.GetInstance():GetNameStatic('CurrencySymbol')
	end
	curPrice = Price/100
	tButton.Tip.text = string.format('%s%s',CurrencySymbol,Price/100)
	tButton.Sprite.spriteName = ((curLevel + 1) == index) and 'Button_Buy_Normal' or 'Button_Buy_Disable'

	local Original
	if 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_one or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_google or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_one_test or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_google_test
	then

		Original = goodsCsv.original_price_kr

	elseif
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr_test
	then

		Original = goodsCsv.original_price_krios

	elseif
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp_test or

		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en
	then

		Original = goodsCsv.original_price_jp * 100

	else
		Original = goodsCsv.original_price_rmb
	end


	tButton.Original.text = string.format('[s]%s%s[/s]',CurrencySymbol,Original/100)
end

local function selectOneLevel( obj )
	-- body
	local max
	if obj then
		local curIndex = tonumber(obj.transform.parent.name)
		if curIndex <= curLevel then
			return
		end
		index = curIndex
	else
		if curLevel >= #curData.activity_items then
			index = #curData.activity_items
			max = true
		else
			index = curLevel + 1
		end
	end

	if lastIndex == index then
		return
	end 
	updateReward(curData.activity_items[index])

	if lastIndex then
		tLevel[lastIndex].uiSprite.spriteName = 'Cube_Normal'
		tLevel[lastIndex].uiSprite:MakePixelPerfect()
		tLevel[lastIndex].numSprite.transform.localScale = Vector3.New(0.8,0.8,0.8)
		tLevel[lastIndex].numSprite.transform.localPosition = Vector3.New(-10,44,0)
	end
	if not max then
		tLevel[index].uiSprite.spriteName = 'Cube_Pressed'
		tLevel[index].uiSprite:MakePixelPerfect()
		tLevel[index].numSprite.transform.localScale = Vector3.New(1,1,1)
		tLevel[index].numSprite.transform.localPosition = Vector3.New(-15,61,0)
	end

	this.page.transform:Find('Role'):GetComponent('UITexture').mainTexture = tabTextureAsset[index]
	this.page.transform:Find('Role'):GetComponent('UITexture'):MakePixelPerfect()
	Ttitle.text = tLevel[index].desc
	lastIndex = index
end

local function loadLevel()
	-- body
	tLevel = {}
	for i,v in ipairs(curData.activity_items) do

		local obj
		if objLevelRoot.transform.childCount >= i then
			obj = objLevelRoot.transform:GetChild(i - 1)
		else
			obj = NGUITools.AddChild(objLevelRoot,objLevelItem)
		end
		obj.gameObject:SetActive(true)
		obj.name = i
		obj.transform:Find('Value'):GetComponent('UILabel').text = v.desc

		local uiSprite = obj.transform:Find('Box'):GetComponent('UISprite')
		uiSprite.spriteName = 'Cube_Normal'
		uiSprite:MakePixelPerfect()
		local numSprite = uiSprite.transform:Find('Sprite'):GetComponent('UISprite')

		numSprite.spriteName = 'Activity3_Progress_Number_' .. i
		numSprite.transform.localScale = Vector3.New(0.8,0.8,1)
		numSprite.transform.localPosition = Vector3.New(-10,44,0)
		if i > curLevel then
			uiSprite.color = Color.New(0.5,0.5,0.5)
		else
			uiSprite.color = Color.New(1,1,1)
		end

		UIEventListener.Get(uiSprite.gameObject).onClick = selectOneLevel

		local t = {}
		t.numSprite = numSprite
		t.uiSprite = uiSprite
		t.desc = v.desc
		table.insert(tLevel,t)
	end
	local Slider = this.page.transform:Find('Slider')

	Slider:GetComponent('UISlider').value = curLevel * 0.25
	tButton.Sprite.spriteName = ((curLevel + 1) == index) and 'Button_Buy_Normal' or 'Button_Buy_Disable'
	
	selectOneLevel()
end

local function BuyShop( ... )
	-- body
	local v = curData.activity_items[curLevel + 1]
	if v == nil then
		--本活动礼包已全部售罄
		NetworkAlertUI.TryShowWarningTipByTag('OperateGiftBag3')
		return
	end
	if index ~= (curLevel + 1) then
		--需先完成前序阶段购买
		NetworkAlertUI.TryShowWarningTipByTag('OperateGiftBag2')
		return
	end
	print(string.format('购买礼包：（%s）（%s）（%s）',v.argument1,v.argument2,v.argument3))

	-- if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
	-- 	WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyShop(this.page,v.argument1,v.argument2,v.argument3,WaterBell.ProjX.GlobalConstant.PAY_TYPE_ALI)
	-- else
	-- 	--[[
	-- 	local request_params = {roleid = 10,baseid = 19,serial = curLevel + 1,paytype = 1,
	-- 					cid = 99,userid = 105947,zid = 13}

	-- 				Utils.SendMessage(40006, request_params, function ( ... )
	-- 					-- body
	-- 					UIActivityPageGift.ActivityBuyViewListener()
	-- 				end)
	-- 	]]
	-- 	UIActivityPageSelectPay:show(function ( ... )
	-- 		-- body
	-- 		local payType
	-- 		if ... == 'Alipay' then
	-- 			payType = WaterBell.ProjX.GlobalConstant.PAY_TYPE_ALI
	-- 		else
	-- 			payType = WaterBell.ProjX.GlobalConstant.PAY_TYPE_WEIXIN
	-- 		end
	-- 			WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyShop(this.page,v.argument1,v.argument2,v.argument3,payType)

	-- 	end)
		
	-- end
	if 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_taptap
	then
		UIActivityPageSelectPay:show(function ( ... )
			-- body
			local payType
			if ... == 'Alipay' then
				payType = WaterBell.ProjX.GlobalConstant.PAY_TYPE_ALI
			else
				payType = WaterBell.ProjX.GlobalConstant.PAY_TYPE_WEIXIN
			end
				WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyShop(this.page,v.argument1,v.argument2,v.argument3,payType)

		end)
	elseif 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_one or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_google or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_one_test or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_kr_google_test or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_kr_test
	then
		WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyShop(this.page,v.argument1,v.argument2,v.argument3,WaterBell.ProjX.GlobalConstant.PAY_TYPE_EFUN)
	elseif 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en_test or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw or 
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en or

		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp_test or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_jp_test or  
		ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_jp
	then
		--UIActivityPageGift.ActivityBuyViewListener( ... )
		--判断身上的钻石是否满足
		if curPrice > tonumber(tostring(UserInfo.GetInstance():GetPlayer().RealRmb)) then

			local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
			--有償鑽晶數量不足，請前往商店進行儲值
            Alert:setData(ManagerCsv.GetInstance():GetNameStatic('OperateGiftBag4'),ManagerCsv.GetInstance():GetNameStatic('NoEnoughDiamondsTips'))
            Alert:setButton(true,ManagerCsv.GetInstance():GetNameStatic('OperateAchievement2'),ManagerCsv.GetInstance():GetNameStatic('AssetsBundleCannel'))
            Alert:setListener(function ( ... )
            	-- body
            	--前往充值界面
            	this:hide()
            	UIActivitiesModel.GoOneShopPageByID( 47000001,'UIActivityPageGift.Back' )
            end,nil)

			return
		end

		WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyGood(v.argument1,v.argument2,v.argument3,1)
	else
		WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyShop(this.page,v.argument1,v.argument2,v.argument3,WaterBell.ProjX.GlobalConstant.PAY_TYPE_ALI)
	end
end

local function checkNum( ... )
	-- body
	local argument1,argument2,argument3 = ...
	local shopSet = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetShopAllSets():GetShopSetByID(argument1)
	local shop = shopSet:GetShopByID(argument2)
	local goods = shop:GetGoodByID(argument3)
	return goods.Num == 0
end

local function init( ... )
	-- body
	objLevelItem = this.page.transform:Find("Slider/LevelItem").gameObject
	objLevelItem:SetActive(false)
	objLevelRoot = this.page.transform:Find("Slider/Level").gameObject
	objRewardRoot = this.page.transform:Find('Reward').gameObject
	Ttitle = this.page.transform:Find('Ttitle'):GetComponent('UILabel')

	tButton = {}
	tButton.obj = this.page.transform:Find('Button').gameObject
	tButton.Label = tButton.obj.transform:Find('Label'):GetComponent('UILabel')
	tButton.Label.text = ManagerCsv.GetInstance():GetNameStatic('OperateGiftBag1')
	tButton.Tip = tButton.obj.transform:Find('Tip'):GetComponent('UILabel')
	tButton.Sprite = tButton.obj.transform:GetComponent('UISprite')
	tButton.Original = tButton.obj.transform:Find('Original'):GetComponent('UILabel')

	UIEventListener.Get(tButton.obj).onClick = BuyShop

	tRewardHacked = {}
	local RewardHacked = this.page.transform:Find('RewardHacked')
	for i=1,3 do
		local t = {}
		t.Obj = RewardHacked:GetChild(i - 1).gameObject
		t.Num = t.Obj.transform:Find('Num'):GetComponent('UILabel')
		table.insert(tRewardHacked,t)
	end

	tabTextureAsset = {}

	for i=1,5 do
		local asset = AssetsManager.LoadTextureForLua("UI/UIImage/Activity/Activity3_Bg_Pic_" .. i)
		table.insert(tabTextureAsset,asset)
	end

	this.page.transform:Find('Title/Label1'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateGiftBagNote1')
	this.page.transform:Find('Title/Label2'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateGiftBagNote2')
	this.page.transform:Find('Title/Label3'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateGiftBagNote4')
	this.page.transform:Find('Tips'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateGiftBagNote3')

	curLevel = curData.BuyBoxTag
	--[[
	for i,v in ipairs(curData.activity_items) do
		if not checkNum(v.argument1,v.argument2,v.argument3) then
			curLevel = i - 1
			break
		end
	end
	]]

	--购买商品中
	GUtilListener.addEventListener("ShoppingListener", UIActivityPageGift.Shopping)
	--购买成功回调，刷新数据
	GUtilListener.addEventListener("ActivityBuyViewListener", UIActivityPageGift.ActivityBuyViewListener)
	--购买失败
	GUtilListener.addEventListener("ActivityBuyViewFailListener", UIActivityPageGift.ActivityBuyViewFailListener)

	loadLevel()
	InitSign()

	UIWindowsManager.GetInstance():AddCloseAction(Close)
end

function UIActivityPageGift.ActivityBuyViewFailListener( ... )
	-- body
	if this == nil then
		return
	end
	print('购买回调UIActivityPageGift')
	this.page.transform:Find('Mask').gameObject:SetActive(false)
end

function UIActivityPageGift.ActivityBuyViewListener( ... )
	-- body
	if this == nil then
		return
	end
	print('购买回调UIActivityPageGift')
	this.page.transform:Find('Mask').gameObject:SetActive(false)

	curLevel = curLevel + 1
	if curLevel > #curData.activity_items then
		curLevel = #curData.activity_items
	end
	curData.BuyBoxTag = curLevel
	loadLevel()
end

function UIActivityPageGift.Shopping( ... )
	-- body
	if this == nil then
		return
	end
	this.page.transform:Find('Mask').gameObject:SetActive(true)
end

--- 显示 活动 页面
function UIActivityPageGift.addShow(...)
	this = UIActivityPageGift
	curData = ...
	this.init = init
	this.clear = clear
	this:show(...)
end

function UIActivityPageGift.Back( ... )
	-- body
	this:show()
end