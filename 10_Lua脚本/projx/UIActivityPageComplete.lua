UIActivityPageComplete = {}

local this
local curData

local objLevelRoot
local objLevelItem

local tabReward

local tabLevel

local index
local lastIndex

local good

local tabRolePic = {'Wuxi_Pic','Wuxi_Pic','Batlq_Pic'}
local tabTextureAsset

local function clear( ... )
	-- body
	this = nil

	curData  = nil

	objLevelItem  = nil
	objLevelRoot  = nil

	tabReward = nil
	index = nil
	lastIndex = nil
	good = nil
	tabTextureAsset = nil

	--购买商品中
	GUtilListener.removeListener("ShoppingListener", UIActivityPageComplete.Shopping)
	--购买成功回调，刷新数据
	GUtilListener.removeListener("ActivityBuyViewListener", UIActivityPageComplete.ActivityBuyViewListener)
	--购买失败
	GUtilListener.removeListener("ActivityBuyViewFailListener", UIActivityPageComplete.ActivityBuyViewFailListener)
end

local function initReward( ... )
	-- body
	local root = this.page.transform:Find('Grid').gameObject
	local child = root.transform:GetChild(0).gameObject
	local item
	local t
	tabReward = {}
	for i=1,3 do
		local item
		if i ==1 then
			item = child.transform
		else
			item = NGUITools.AddChild(root,child).transform
		end
		t = {}
		t.Obj = item.gameObject
		t.Title = item:Find('Title'):GetComponent('UILabel')
		t.Reward = item:Find('Reward')
		t.Button = item:Find('Button').gameObject
		t.Sprite = t.Button.transform:GetComponent('UIButton')
		t.ButtonLabel = t.Button.transform:Find('Label'):GetComponent('UILabel')
		t.ButtonTip = t.Button.transform:Find('Tip'):GetComponent('UILabel')
		t.Get = item:Find('Get').gameObject
		t.GetLabel = t.Get.transform:Find('Label'):GetComponent('UILabel')
		t.Get:SetActive(false)
		t.RewardHacked = item:Find('RewardHacked').gameObject
		t.RewardHackedItem = {}
		for i=1,3 do
			local _t = {}
			local item = t.RewardHacked.transform:GetChild(i - 1).gameObject
			item:SetActive(false)
			_t.Obj = item
			_t.Num = item.transform:Find('Num'):GetComponent('UILabel')
			_t.Back = item.transform:Find('Back'):GetComponent('UISprite')
			table.insert(t.RewardHackedItem,_t)
		end
		table.insert(tabReward,t)

		Utils.AddButtonEX( t.Button,UIBtnType.activity_nurturance_getrewards,i )
	end

	root.transform:GetComponent('UIGrid').enabled = true
end

local function updateShopNum( ... )
	-- body
	local t = tabReward[3]
	local num = good.Num
	if good.Num == -1 then
		num = "∞"
	end

	if good.Num == 0 then
		t.Button:SetActive(false)
		t.Get:SetActive(true)
		t.GetLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateSellOut')
	else
		t.Get:SetActive(false)
		t.Button:SetActive(true)
		t.ButtonTip.text = string.format('[fece7c]¥%s [8bab9d]'.. ManagerCsv.GetInstance():GetNameStatic('OperateGift3') ..'[ffffff]%s',good.Price/100,num)
	end
end

local function updateRed( ... )
	-- body
	for i,v in ipairs(tabLevel) do
		v.Red:SetActive((curData.activity_items[i].status == ActivityModel.Status.status_can_receive) or (WaterBell.ProjX.Common.Utils.AwardUtils.GetAchievementStatusByID(curData.activity_items[i].argument2) == 1))
	end
end

local function updateReward( v )
	-- body
	if #tabReward == 0 then
		print('#tabReward == 0')
		return
	end
	local animation = 0.7

	local t

	t = tabReward[1]
	t.Title.text = ManagerCsv.GetInstance():GetNameStatic('OperateReward1')
	SetFontStyle(t.Title,226,149,238)
	t.Button:SetActive(true)
	t.Get:SetActive(false)
	t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')--'领取'
	t.ButtonTip.text = ManagerCsv.GetInstance():GetNameStatic('OperateInstance' .. index)
	TweenAlpha.Begin(t.Obj,animation , 1,0)
	if #v.rewards > 0 then
		Utils.destoryChild( t.Reward )

		for i,v in ipairs(v.rewards) do
			local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(v["id"],v["type"],v["num"],t.Reward,v["value"],0.75)
			local Num = trs:Find('Mid/Num'):GetComponent('UILabel')

			if Num.gameObject.activeSelf then
				Num.gameObject:SetActive(false)
				t.RewardHackedItem[i].Obj:SetActive(true)
				t.RewardHackedItem[i].Num.text = Num.text
				t.RewardHackedItem[i].Back.spriteName = 'Prize_Box_' .. i
			else
				t.RewardHackedItem[i].Obj:SetActive(false)
			end
		end
		t.Reward.transform:GetComponent('UIGrid').enabled = true
	end

	if v.status == ActivityModel.Status.status_cannot_receive then
		--t.ButtonLabel.text = '未达成'
		t.Sprite.normalSprite = 'Button_Activity2_Disable'
		--t.Sprite.pressedSprite = ''
		SetFontStyle(t.ButtonLabel,0,0,0)
		UIEventListener.Get(t.Button).onClick = function ( ... )
			-- body
			NetworkAlertUI.TryShowWarningTipByTag('OperateRewardNote1')
		end
	elseif v.status == ActivityModel.Status.status_can_receive then
		--t.ButtonLabel.text = '领取'
		t.Sprite.normalSprite = 'Button_Activity2_Normal'
		--t.Sprite.pressedSprite = 'Button_Activity2_Pressed'
		SetFontStyle(t.ButtonLabel,255,255,255)
		UIEventListener.Get(t.Button).onClick = function ()
			local roleid = tostring(WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():RoleID())
			local baseid = tostring(curData["id"])
			local serial = index
			local msgParams = {roleid = roleid,baseid = baseid,serial = serial}
			Utils.SendMessage(ActivityModel.getCode(tonumber(curData["id"]),curData.type),msgParams, function(response)
				local bytes = response.bytes
				local LuaNetProxy = LuaNetProxy.New()
				LuaNetProxy:Callback(bytes)
				--领取完成后刷新按钮状态，刷新红点
				--tabReward[2].ButtonLabel.text = '已领取'
				tabReward[1].Button:SetActive(false)
				tabReward[1].Get:SetActive(true)
				tabReward[1].GetLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')
				curData.activity_items[index].status = ActivityModel.Status.status_received
				updateRed()
			end)                                    
		end
	elseif v.status == ActivityModel.Status.status_received then
		--t.ButtonLabel.text = '已领取'
		t.Button:SetActive(false)
		t.Get:SetActive(true)
		t.GetLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive');
	end

	t = tabReward[2]
	if v.argument2 == 0 then
		t.Obj:SetActive(false)
	else
		t.Obj:SetActive(true)
		t.Title.text = ManagerCsv.GetInstance():GetNameStatic('OperateAchievement1')--'成就'
		SetFontStyle(t.Title,138,230,190)
		t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateAchievement2')--'前往'
		t.ButtonTip.text = ManagerCsv.GetInstance():GetNameStatic('OperateAchievement3')--'切换至成就页面'

		t.Button:SetActive(true)
		t.Get:SetActive(false)
		SetFontStyle(t.ButtonTip,139,171,157)
		TweenAlpha.Begin(t.Obj,animation , 1,0)
		local achievement = ManagerCsv.GetInstance():GetAchievement(v.argument2)

		if achievement then
			local awardAll = {}
			local award = {}
			award.id = achievement.attachment_id1
			award.type = achievement.attachment_type1
			award.num = achievement.attachment_num1
			award.value = achievement.attachment_value1
			table.insert(awardAll,award)

			local award = {}
			award.id = achievement.attachment_id2
			award.type = achievement.attachment_type2
			award.num = achievement.attachment_num2
			award.value = achievement.attachment_value2
			table.insert(awardAll,award)

			local award = {}
			award.id = achievement.attachment_id3
			award.type = achievement.attachment_type3
			award.num = achievement.attachment_num3
			award.value = achievement.attachment_value3
			table.insert(awardAll,award)

			local award = {}
			award.id = achievement.attachment_id4
			award.type = achievement.attachment_type4
			award.num = achievement.attachment_num4
			award.value = achievement.attachment_value4
			table.insert(awardAll,award)

			local award = {}
			award.id = achievement.attachment_id5
			award.type = achievement.attachment_type5
			award.num = achievement.attachment_num5
			award.value = achievement.attachment_value5
			table.insert(awardAll,award)

			Utils.destoryChild( t.Reward )
			for i,v in ipairs(awardAll) do
				if v.type ~= 0 then
					local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(v.id,tostring(v.type),v.num,t.Reward,v.value,0.75)
					local Num = trs:Find('Mid/Num'):GetComponent('UILabel')
					if Num.gameObject.activeSelf then
						Num.gameObject:SetActive(false)
						t.RewardHackedItem[i].Obj:SetActive(true)
						t.RewardHackedItem[i].Num.text = Num.text
						t.RewardHackedItem[i].Back.spriteName = 'Prize_Box_' .. i
					else
						t.RewardHackedItem[i].Obj:SetActive(false)
					end
				end
			end
			--LoadAwardSprite(long resID, string eID, int num, Transform tran,long value,float scale)
			t.Reward.transform:GetComponent('UIGrid').enabled = true
		end

		if WaterBell.ProjX.Common.Utils.AwardUtils.GetLevelIsPassByID(v.argument1) and WaterBell.ProjX.Common.Utils.AwardUtils.GetAchievementStatusByID(v.argument2) ~= 0 then
			if WaterBell.ProjX.Common.Utils.AwardUtils.GetAchievementStatusByID(v.argument2) == 1 then
				SetFontStyle(t.ButtonLabel,255,255,255)
				t.Sprite.normalSprite = 'Button_Activity2_Normal'
				UIEventListener.Get(t.Button).onClick = function ()
					--UIFrame.UISceneManager.getInstance():Goto(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.ACHIEVEMENT_SCENE:ToInt()))
					UIFrame.UISceneManager.getInstance():GotoBackLua(UIFrame.UISceneState.New(UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt()),UIFrame.UISceneState.New(UIFrame.UISceneID.ACHIEVEMENT_SCENE:ToInt()), "UIActivityMenu.showBack")
					UIActivityMenu.close()
				end
			else
				t.Button:SetActive(false)
				t.Get:SetActive(true)
				t.GetLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive');
			end
		else
			SetFontStyle(t.ButtonLabel,0,0,0)
			t.Sprite.normalSprite = 'Button_Activity2_Disable'
			UIEventListener.Get(t.Button).onClick = function ()
				NetworkAlertUI.TryShowWarningTipByTag('OperateAchievementNote1')
			end
		end
	end

	t = tabReward[3]
	if v.argument7 == 0 then
		t.Obj:SetActive(false)
	else
		t.Obj:SetActive(true)
		t.Title.text = ManagerCsv.GetInstance():GetNameStatic('OperateGift1')--'礼包'
		SetFontStyle(t.Title,251,206,135)
		t.ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateGift2')--'购买'
		TweenAlpha.Begin(t.Obj,animation , 1,0)

		local shopSet = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetShopAllSets():GetShopSetByID(v.argument7)
		local shop = shopSet:GetShopByID(v.argument8)
		good = shop:GetGoodByID(v.argument9)
		local goods = ManagerCsv.GetInstance():GetGoods(good.ShopGoodID)
		--t.ButtonTip.text = string.format('¥%s 剩余次数%s',good.Price,good.Num)
		updateShopNum()

		Utils.destoryChild( t.Reward )
		local ShopGoods = WaterBell.ProjX.Common.Utils.AwardUtils.GetShopGoods(v.argument7,v.argument8,v.argument9)
		for i=1,ShopGoods.Count do
			local item = ShopGoods[i - 1]
			local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(item.rawID,item.rawType,item.rawNum,t.Reward,item.rawValue,0.7)
			local Num = trs:Find('Mid/Num'):GetComponent('UILabel')
			if Num.gameObject.activeSelf then
				Num.gameObject:SetActive(false)
				if t.RewardHackedItem[i] ~= nil then
					t.RewardHackedItem[i].Obj:SetActive(true)
					t.RewardHackedItem[i].Num.text = Num.text
					t.RewardHackedItem[i].Back.spriteName = 'Prize_Box_' .. i
				else
					t.RewardHackedItem[i].Obj:SetActive(false)
				end
			end
		end
		--WaterBell.ProjX.Common.Utils.AwardUtils.LoadShopGoodsAwardSprite(v.argument7,v.argument8,v.argument9,t.Reward,0.75)
		t.Reward.transform:GetComponent('UIGrid').enabled = true

		local item = ManagerCsv.GetInstance():GetItem(goods.goods_id)

		if WaterBell.ProjX.Common.Utils.AwardUtils.GetLevelIsPassByID(v.argument1) then
			t.Sprite.normalSprite = 'Button_Activity2_Normal'
			--t.Sprite.pressedSprite = 'Button_Activity2_Pressed'
			SetFontStyle(t.ButtonLabel,255,255,255)
			UIEventListener.Get(t.Button).onClick = function ()
				--购买礼包
				print(string.format('购买礼包：（%s）（%s）（%s）',v.argument7,v.argument8,v.argument9))

				if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
					WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyShop(this.page,v.argument7,v.argument8,v.argument9,WaterBell.ProjX.GlobalConstant.PAY_TYPE_ALI)
				else
					UIActivityPageSelectPay:show(function ( ... )
						-- body
						local payType
						if ... == 'Alipay' then
							payType = WaterBell.ProjX.GlobalConstant.PAY_TYPE_ALI
						else
							payType = WaterBell.ProjX.GlobalConstant.PAY_TYPE_WEIXIN
						end
							WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BuyShop(this.page,v.argument7,v.argument8,v.argument9,payType)

					end)
				end
			end
		else
			t.Sprite.normalSprite = 'Button_Activity2_Disable'
			--t.Sprite.pressedSprite = ''
			SetFontStyle(t.ButtonLabel,0,0,0)
			UIEventListener.Get(t.Button).onClick = function ( ... )
				-- body
				NetworkAlertUI.TryShowWarningTipByTag('OperateGiftNote1')
			end
		end
	end

	t.Obj.transform.parent:GetComponent('UIGrid').enabled = true
end 

local function selectOneLevel( obj )
	-- body
	if obj then	
		index = tonumber(obj.name)
	else
		index = 1
	end
	if lastIndex == index then
		return
	end

	updateReward(curData.activity_items[index])

	local GoodsPic = this.page.transform:Find('GoodsPic'):GetComponent('UISprite')
	local RolePic = this.page.transform:Find('RolePic'):GetComponent('UITexture')

	if index % 2 == 0 then
		GoodsPic.spriteName = 'Icon_Big_Treasure_Box_Activity2'
		RolePic.mainTexture = nil
	else
		local id = math.ceil(index / 2 )
		GoodsPic.spriteName = 'Weapon_'.. id .. '_Activity2'
		RolePic.mainTexture = tabTextureAsset[id]
	end

	if lastIndex then
		tabLevel[lastIndex].icon.normalSprite = 'Process_'.. lastIndex ..'_Activity2_Normal'
	end

	tabLevel[index].icon.normalSprite = index and 'Process_'.. index ..'_Activity2_Pressed'

	lastIndex = index
end 

local function loadLevel()
	-- body
	tabLevel = {}
	local curLevel = 1
	objLevelItem:SetActive(false)
	for i,v in ipairs(curData.activity_items) do
		local obj = NGUITools.AddChild(objLevelRoot,objLevelItem)
		obj.gameObject:SetActive(true)
		obj.name = i
		obj.transform:Find('Value'):GetComponent('UILabel').text = v.desc
		UIEventListener.Get(obj).onClick = selectOneLevel

		local icon = obj.transform:GetComponent('UIButton')
		icon.normalSprite = 'Process_'.. i ..'_Activity2_Normal'
		--icon.pressedSprite = 'Process_'.. i ..'_Activity2_Pressed'
		obj.transform:Find('Label').gameObject:SetActive(i % 2 > 0)

		if v.status > 1 then
			curLevel = i
		end

		if i == #curData.activity_items then
			obj.transform:Find('Arrow').gameObject:SetActive(false)
		end

		local t = {}
		t.Red = obj.transform:Find('Red').gameObject
		t.icon = icon
		table.insert(tabLevel,t)

		Utils.AddButtonEX( obj,UIBtnType.activity_nurturance_bottombtns,i )
	end

	this.page.Find('Slider'):GetComponent('UISlider').value = curLevel / #curData.activity_items
	local obj = {}
	obj.name = curLevel
	selectOneLevel(obj)
end

local function init( ... )
	-- body
	objLevelItem = this.page.transform:Find("Sprite/Slider/LevelItem").gameObject
	objLevelRoot = this.page.transform:Find("Sprite/Slider/Level").gameObject

	tabTextureAsset = {}
	for i,v in ipairs(tabRolePic) do
		local asset = AssetsManager.LoadTextureForLua("UI/UIImage/Activity/" .. v)
		table.insert(tabTextureAsset,asset)
	end
	
	initReward()
	loadLevel()

	updateRed()

	--购买商品中
	GUtilListener.addEventListener("ShoppingListener", UIActivityPageComplete.Shopping)
	--购买成功回调，刷新数据
	GUtilListener.addEventListener("ActivityBuyViewListener", UIActivityPageComplete.ActivityBuyViewListener)
	--购买失败
	GUtilListener.addEventListener("ActivityBuyViewFailListener", UIActivityPageComplete.ActivityBuyViewFailListener)
end

function UIActivityPageComplete.ActivityBuyViewFailListener( ... )
	-- body
	if this == nil then
		return
	end
	this.page.transform:Find('Mask').gameObject:SetActive(false)
end

function UIActivityPageComplete.ActivityBuyViewListener( ... )
	-- body
	if this == nil then
		return
	end
	print('update 商品')
	updateShopNum()
	this.page.transform:Find('Mask').gameObject:SetActive(false)
end

function UIActivityPageComplete.Shopping( ... )
	-- body
	if this == nil then
		return
	end
	this.page.transform:Find('Mask').gameObject:SetActive(true)
end

--- 显示 活动 页面
function UIActivityPageComplete.show(...)
	this,curData = ...
	this.init = init
	this.clear = clear
	this:show(...)
end