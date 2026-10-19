UIOldUserRegressionSystem = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIOldUserRegressionSystem")
local this = UIOldUserRegressionSystem

local tempPage
local tButton
local index

function this.clear( ... )
	-- body
	tempPage = nil
end

local function ClickClose( ... )
	-- body
	if tempPage then
		tempPage:destory()
	end
	this:destory()
	UIWindowsManager.GetInstance():RemoveAction()
	MainScenePanelAdd.UpdateRed()
end

local function ClickButton( obj )
	-- body
	if tempPage then
		tempPage:destory()
	end

	if index then
		tButton[index].Normal.gameObject:SetActive(true)
		tButton[index].Select.gameObject:SetActive(false)
	end

	local name = obj.name
	if name == 'Sign' then
		tempPage = UIOldUserRegressionSystemSign
		index = 1
	elseif name == 'Task' then
		tempPage = UIOldUserRegressionSystemTask
		index = 2
	elseif name == 'Gift' then
		tempPage = UIOldUserRegressionSystemGift
		index = 3
	else
		print('不存在的对应界面！' .. name)
		return
	end
	tempPage:show()

	tButton[index].Normal.gameObject:SetActive(false)
	tButton[index].Select.gameObject:SetActive(true)
end

function this.UpdateRed( ... )
	-- body
	if this:isNil() then
		return
	end
	local data993 = UIActivitiesModel.GetServerDataAllByID( 993 )
	local data992 = UIActivitiesModel.GetServerDataAllByID( 992 )
	local data991 = UIActivitiesModel.GetServerDataAllByID( 991 )
	tButton[1].Red.gameObject:SetActive(UIActivitiesModel.GetIsRedByData( data993 ))
	tButton[2].Red.gameObject:SetActive(UIActivitiesModel.GetIsRedByData( data992 ))
	tButton[3].Red.gameObject:SetActive(UIActivitiesModel.GetIsRedByData( data991 ))
end

function this.init( ... )
	-- body
	UIEventListener.Get(this.page.transform:Find('TopRight/Close').gameObject).onClick = ClickClose
	local Buttons = this.page.transform:Find('Left/Buttons')
	tButton = {}
	for i=1,Buttons.childCount do
		local temp = Buttons:GetChild(i - 1)
		UIEventListener.Get(temp.gameObject).onClick = ClickButton

		temp = temp.transform

		local t = {}
		t.Normal = temp:Find('Normal')
		t.Normal_Label = t.Normal:Find('Label'):GetComponent('UILabel')
		t.Normal_Label.text =  ManagerCsv.GetInstance():GetNameStatic('UIOldUserRegressionSystem_Button' .. i)
		t.Select = temp:Find('Select')
		t.Select_Label = t.Select:Find('Label'):GetComponent('UILabel')
		t.Select_Label.text =  ManagerCsv.GetInstance():GetNameStatic('UIOldUserRegressionSystem_Button' .. i)
		t.Red = temp:Find('Red')
		t.Red.gameObject:SetActive(false)
		t.Obj = temp.gameObject
		table.insert(tButton,t)
	end

	local data993 = UIActivitiesModel.GetServerDataAllByID( 993 )
	local data992 = UIActivitiesModel.GetServerDataAllByID( 992 )
	local data991 = UIActivitiesModel.GetServerDataAllByID( 991 )
	tButton[1].Obj:SetActive(data993 ~= nil)
	tButton[2].Obj:SetActive(data992 ~= nil)
	tButton[3].Obj:SetActive(data991 ~= nil)
	local grid = Buttons:GetComponent('UIGrid')
	grid.hideInactive = true
	grid:Reposition()

	local obj = {}
	obj.name = "Sign"
	local Callback = function ( ... )
		-- body
		if this:isNil() then
			return
		end
		ClickButton( obj )
		this.UpdateRed()
	end
	UIActivitiesModel.RequestActivitiesData( Callback )

	UIWindowsManager.GetInstance():AddCloseAction(function ( ... )
		-- body
		ClickClose()
	end)
	LuaPanelHelper.SetLuaPanelCache('UIOldUserRegressionSystem','')
end

this.OpenPanel = function ( ... )
	-- body
	this:show()
end
this.ClosePanel = ClickClose