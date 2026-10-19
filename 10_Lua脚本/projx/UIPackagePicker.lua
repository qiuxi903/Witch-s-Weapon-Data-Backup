--背包挑选器

UIPackagePicker = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIPackagePicker")
local this = UIPackagePicker

local callFunc
local tSelect
local selectIndex
local selectIndexLast
local tExAdd
local tNumPicker
local longPressLeft
local longPressRight
local pressTime
local isNumPicker

function this.clear( ... )
	-- body
	 callFunc = nil
	 tSelect = nil
	 selectIndex = nil
	 selectIndexLast = nil
 	 tExAdd = nil
	 tNumPicker = nil
	 longPressLeft = nil
	 longPressRight = nil
	 pressTime = nil
	 isNumPicker = nil
end

local function clickClose( ... )
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)

	this:destory()
	UIWindowsManager.GetInstance():RemoveAction()
end

local function clickButton( ... )
	-- body
	if not isNumPicker then
		if tSelect.Max < tSelect.Num then
			NetworkAlertUI.TryShowWarningTipByTag('UIPackagePicker_NotEnoughItems')
			return
		end
	end

	if callFunc then
		callFunc(tSelect)
	end

	clickClose()
end

local function updateNumPicker( ... )
	-- body
	tNumPicker.Num.text = tSelect.Num
	tNumPicker.Left.gameObject:SetActive(isNumPicker)
	tNumPicker.Right.gameObject:SetActive(isNumPicker)
	tNumPicker.Left.spriteName = (tSelect.Num == 1 or not isNumPicker) and 'Icon_EndNum_Normal' or 'Icon_NextNum_Normal'
	tNumPicker.Right.spriteName = (tSelect.Num == tSelect.Max or not isNumPicker) and 'Icon_EndNum_Normal' or 'Icon_NextNum_Normal'
	tNumPicker.Tips.gameObject:SetActive(not isNumPicker)
	tNumPicker.Num.gameObject:SetActive(isNumPicker)
	if not isNumPicker then
		tNumPicker.Tips.text = string.format(tNumPicker.TipsStr,tSelect.Num)
	end
end

local function clickSelect( index,v,Num )
	-- body
	selectIndex = index
	if selectIndexLast then
		if selectIndexLast == selectIndex then
			return
		end
		tExAdd[selectIndexLast].Select:SetActive(false)
	end
	tExAdd[selectIndex].Select:SetActive(true)

	selectIndexLast = selectIndex
	tSelect = table.clone(v)
	tSelect.Max = v.Num
	tSelect.Num = Num

	updateNumPicker()
end

local function clickLeft( ... )
	-- body
	if tSelect.Num == 1 or not isNumPicker then
		return
	end
	tSelect.Num = tSelect.Num - 1
	updateNumPicker()
end

local function clickRight( ... )
	-- body
	if tSelect.Num == tSelect.Max or not isNumPicker then
		return
	end
	tSelect.Num = tSelect.Num + 1
	updateNumPicker()
end

local function clickLeftLong( obj,tag )
	-- body
	if tag then
		pressTime = os.time()
		longPressLeft = true
	else
		longPressLeft = false
	end
end

local function clickRightLong( obj,tag )
	-- body
	if tag then
		pressTime = os.time()
		longPressRight = true
	else
		longPressRight = false
	end
end

function this.init( ... )
	-- body
	local data,_isNumPicker,_callFunc = ...
	isNumPicker = _isNumPicker
	callFunc = _callFunc
	tSelect = {}
	local Button = this.page.transform:Find('Button')
	local ScrollView = this.page.transform:Find('ScrollView'):GetComponent('UIScrollView')
	local Grid = ScrollView.transform:Find('Grid'):GetComponent('UIGrid')
	local UIResSpriteExAdd = this.page.transform:Find('UIResSpriteExAdd')
	UIResSpriteExAdd.gameObject:SetActive(false)

	local Close = this.page.transform:Find('BG/Close')
	UIEventListener.Get(Close.gameObject).onClick = clickClose
	local Mask = this.page.transform:Find('Mask')
	UIEventListener.Get(Mask.gameObject).onClick = clickClose
	UIEventListener.Get(Button.gameObject).onClick = clickButton
	local NumPicker = this.page.transform:Find('NumPicker')

	tNumPicker = {}
	tNumPicker.Left = NumPicker:Find('Left'):GetComponent('UISprite')
	tNumPicker.Right = NumPicker:Find('Right'):GetComponent('UISprite')
	tNumPicker.Num = NumPicker:Find('Num'):GetComponent('UILabel')
	tNumPicker.Tips = NumPicker:Find('Tips'):GetComponent('UILabel')
	tNumPicker.TipsStr = ManagerCsv.GetInstance():GetNameStatic('UIPackagePicker_EachQuantity')--'每次必须放入%s个'
	UIEventListener.Get(tNumPicker.Left.gameObject).onClick = clickLeft
	UIEventListener.Get(tNumPicker.Right.gameObject).onClick = clickRight

	UIEventListener.Get(tNumPicker.Left.gameObject).onPress = clickLeftLong
	UIEventListener.Get(tNumPicker.Right.gameObject).onPress = clickRightLong

	Utils.destoryChild( Grid )
	tExAdd = {}
	table.sort(data,function ( a,b )
		-- body
		return a.sequence < b.sequence
	end)
	for i,v in ipairs(data) do
		local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(v.ID,v.Type,v.Num,Grid.transform,v.Value,1)

		UIEventListener.Get(trs:Find('Bot/BtnEx').gameObject).onPress = function ( obj,tag )
			-- body
			if not tag then
				clickSelect(i,v,isNumPicker and 1 or v.NeedNum)
			end
		end

		local t = {}
		local ExAdd = NGUITools.AddChild(trs.gameObject,UIResSpriteExAdd.gameObject)
		ExAdd:SetActive(true)
		t.Obj = ExAdd
		t.Select = ExAdd.transform:Find('Select').gameObject
		t.Select:SetActive(false)
		table.insert(tExAdd,t)
		if i == 1 then
			clickSelect(i,v,isNumPicker and 1 or v.NeedNum)
		end
	end

	UpdateBeat:Add(this.UpdateBeat,this)
	UIWindowsManager.GetInstance():AddCloseAction(this.clickButton)
end

function this.clickButton( ... )
	-- body
	clickButton()
end

function this.UpdateBeat( ... )
	-- body

	if longPressLeft then
		if  os.time() - pressTime > 0.5 then
			clickLeft()
		end
	end

	if longPressRight then
		if os.time() - pressTime > 0.5 then
			clickRight()
		end
	end
end