UIActivitiesButtons = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesButtons")
local this = UIActivitiesButtons

local tPages
local lastPage
local tButtons
local index
local lastIndex
local format
function this.clear( ... )
	-- body
	tButtons = nil
	tPages = {}
end

function this.clearOnReload( ... )
	-- body
	lastPage = nil
	index = nil
	lastIndex = nil
	format = nil
end

function this.close( ... )
	-- body
	--关闭所有的运营活动界面
	if ... then
		for i,v in ipairs(tPages) do
			v:destory()
		end
		--ActivityModel.getData2MainScene()
		UIActivitiesModel.OpenCafe()

		this:destory()
		--卸载资源
		--WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():ActivityUnloadResource()
		UIWindowsManager.GetInstance():RemoveAction()
		MainScenePanelAdd.PlayCV()
	else
		this:hide()
		for i,v in ipairs(tPages) do
			v:hide()
		end
	end
end

local function openOne( id,panel_id )
	-- body
	index = id
	--界面活动关闭了，打开主界面
	if (lastIndex and not tButtons[lastIndex]) or (not tButtons[index]) then
		panel_id = 0
		index = 0
	end

	if lastPage then
		lastPage:hide()
	end
	local first = false
	local t
	local data

	if panel_id == 0 then
		t = UIActivities
		t:show()
		if not table.containValue(tPages,t) then
			table.insert(tPages,t)
		end
	else
		t = _G['UIActivitiesFormat' .. panel_id]
		data = UIActivitiesModel.GetServerDataByID( id )
		t:show(data)
		if not table.containValue(t) then
			table.insert(tPages,t)
		end
	end
	lastPage = t

	if lastIndex and tButtons[lastIndex] then
		tButtons[lastIndex].Selected.gameObject:SetActive(false)
		--if lastIndex ~= 0 then
			tButtons[lastIndex].Label.color = Color.New(123/255,185/255,224/255)
		--end
	end
	lastIndex = id
	format = panel_id
	tButtons[index].Selected.gameObject:SetActive(true)
	--if index ~= 0 then
		tButtons[index].Label.color = Color.New(33/255,49/255,72/255)
	--end

	LuaPanelHelper.SetLuaPanelCache('UIActivitiesButtons',index .. '|' .. format)
end

local function clickButton( obj )
	-- body
	local splitStr = string.split(obj.name, '_');
	local id = splitStr[1]
	local panel_id = splitStr[2]

	openOne(tonumber(id),tonumber(panel_id))
end

local function loadButtonItems( keep )
	-- body
	local datas = UIActivitiesModel.GetNewFormatActivitiesDatas()
	local ScrollView = this.page.transform:Find('LeftButtons/Scroll View'):GetComponent('UIScrollView')
	local root = ScrollView.transform:Find('Grid'):GetComponent('UIGrid')
	local child = this.page.transform:Find('ButtonItem')
	table.sort(datas,function ( a,b )
		-- body
		if a.stick == b.stick then
			if a.foot == b.foot then
				return a.id < b.id
			else
				return a.foot < b.foot
			end	
		else
			return a.stick > b.stick
		end
	end)
	local childCount = root.transform.childCount
	for i,v in ipairs(datas) do
		local item
		if i <= childCount then
			item = root.transform:GetChild(i - 1).gameObject
		else
			item = NGUITools.AddChild(root.gameObject,child.gameObject)
		end
		item:SetActive(true)
		item.name = v.id..'_'..v.panel_id
		UIEventListener.Get(item.gameObject).onClick = clickButton
		local t = {}
		t.Label = item.transform:Find('Label'):GetComponent('UILabel')
		t.Selected = item.transform:Find('Selected')
		t.Selected.gameObject:SetActive(false)
		t.Red = item.transform:Find('Red')
		t.TimeLabel = item.transform:Find('TimeLabel'):GetComponent('UILabel')
		tButtons[v.id] = t

		t.Label.text = v.name
		local day = (v.closetime - tonumber(tostring(GUtilTime.toUtcTimestamp()))) / (60 * 60 * 24)
		day = math.floor(day)

		local tag = day >= 1000 or v.closetime == v.starttime
		if tag then
			t.TimeLabel.text = ManagerCsv.GetInstance():GetNameStatic('HomepageForever')--"永久开放"
		else
			t.TimeLabel.text = UIActivitiesModel.GetTimeSpanStr((v.closetime - tonumber(tostring(GUtilTime.toUtcTimestamp()))))--day.."天"
		end
	end
	for i=#datas,root.transform.childCount - 1 do
		root.transform:GetChild(i).gameObject:SetActive(false)
	end

	child.gameObject:SetActive(false)
	root.enabled = true
	if not keep then
		ScrollView:ResetPosition()
	end

	this.updateRed()
end

function this.updateInfo( ... )
	-- body
	if not this.page then
		return
	end
	loadButtonItems(true)
	openOne(index,format)
end

function this.updateRed(id)
	-- body
	if id then
		--判断是不是集合型活动。集合行要替换id
		local data  = UIActivitiesModel.GetServerDataByID( index )
		if data.type == ActivityModel.ActivityType.ActivitiesChallengeMix.typeid then
			tButtons[data.id].Red.gameObject:SetActive(ActivityModel.isRed( ActivityModel.ServerDataAll,id ))
			return
		end
		tButtons[id].Red.gameObject:SetActive(ActivityModel.isRed( ActivityModel.ServerDataAll,id ))
	else	
		for k,v in pairs(tButtons) do
			if k ~= 0 then
				v.Red.gameObject:SetActive(ActivityModel.isRed( ActivityModel.ServerData,k ))
			end
		end
	end
end

local function ClickClose( ... )
	-- body
	this.close(true)

	LuaPanelHelper.GoBackMainScene()
end 

function this.init( ... )
	-- body
	tPages = {}
	tButtons = {}
	local first = ...
	this.page.transform:Find('TopLine/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('HomepageTitle')
	this.page.transform:Find('LeftTopButton/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('HomepageName')

	local t = {}
	local item = this.page.transform:Find('LeftTopButton')
	t.Label = item.transform:Find('Label'):GetComponent('UILabel')
	t.Selected = item.transform:Find('Selected')
	t.Selected.gameObject:SetActive(false)
	tButtons[0] = t

	UIEventListener.Get(this.page.transform:Find('LeftTopButton').gameObject).onClick = function ( ... )
		-- body
		openOne(0,0)
	end
	UIEventListener.Get(this.page.transform:Find('TopLine/ButtonBack').gameObject).onClick = ClickClose
	--[[
	UIEventListener.Get(this.page.transform:Find('LeftTopButton').gameObject).onClick = function ( ... )
		-- body
		local roleid = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
		local msgParams = {roleid = tostring(roleid)}
		Utils.SendMessage(40008,msgParams, function(response)
			print('第二天登陆')
		end)
	end
	]]

	loadButtonItems()
	if first then
		--openOne(0,0)
		--return
		index = nil
		format = nil
	end
	--[[
	if index and format then
		openOne(index,format)
	else
		openOne(0,0)
	end
	]]
	this.hide2show( ... )
	
	UIWindowsManager.GetInstance():AddCloseAction(function ( ... )
		-- body
		ClickClose()
	end)
end

function this.hide2show( ... )
	-- body
	if index and format then
		openOne(index,format)
	else
		openOne(0,0)
	end
end

function this.realBack( ... )
	-- body
	this.close(true)
end

function this.addShow( ... )
	-- body
	this:show()
	--Utils.ShowPageC2L(1)
end

function this.ShowOnePage( _index,_format )
	-- body
	index = tonumber(_index)
	format = tonumber(_format)
	if index == 999 then
		index = 0
		format = 0
	end
	--openOne(index,format)
	if this:isNil() or this.hide then
		this:show()
	end
end

this.OpenPanel = this.ShowOnePage
this.ClosePanel = this.realBack