UIActivityPageCompleteNew = BaseView:new("UI/Prefab/UIPrefab/UIActivity/","UIActivityPageCompleteNew")

local this

local curData
local GridParent
local ItemChild
local selectDay
local selectDayLast
local tDayItem
local ScrollViewItem
local cacheData
local tEffectGetReward
local msgLock
local BottomRightSlider

local function clear( ... )
	-- body
	 curData = nil
	 GridParent = nil
	 ItemChild = nil
	 tDayItem = nil
	 ScrollViewItem = nil
	 tEffectGetReward = nil
	 msgLock = nil
	 BottomRightSlider = nil
	 GUtilListener.removeListener("ActivityCloseAwardsPanelListener", UIActivityPageCompleteNew.ActivityCloseAwardsPanelListener)
end

local function clearOnReload( ... )
	-- body
	selectDay = nil
	 selectDayLast = nil
	 cacheData = nil
end

local function Close( ... )
	-- body
	this:destory()
	--UIActivityButton.updateRed()
	MainScenePanelAdd.UpdateRed()
	UIWindowsManager.GetInstance():RemoveAction()
end

function UIActivityPageCompleteNew.checkRed( d,index )
	-- body
	if index then
		if index > d.Day then
			return false
		end
		local data = d.activity_items[index]
		local t = {}
		if data.argument1 then
			table.insert(t,data.argument1)
		end
		if data.argument2 then
			table.insert(t,data.argument2)
		end
		if data.argument3 then
			table.insert(t,data.argument3)
		end
		if data.argument7 then
			table.insert(t,data.argument7)
		end
		if data.argument8 then
			table.insert(t,data.argument8)
		end
		if data.argument9 then
			table.insert(t,data.argument9)
		end
		if data.argument10 then
			table.insert(t,data.argument10)
		end
		for i,v in ipairs(t) do
			if UIActivitiesModel.GetTaskStatusByID( v ) == 1 then
				return true
			end--//0 没找到，1，可领取 ， 2 已领取，3未完成
		end
		return false
	else
		for i,v in ipairs(d.activity_items) do
			if i > d.Day then
				break
			end
			local data = v
			local t = {}
			if data.argument1 then
				table.insert(t,data.argument1)
			end
			if data.argument2 then
				table.insert(t,data.argument2)
			end
			if data.argument3 then
				table.insert(t,data.argument3)
			end
			if data.argument7 then
				table.insert(t,data.argument7)
			end
			if data.argument8 then
				table.insert(t,data.argument8)
			end
			if data.argument9 then
				table.insert(t,data.argument9)
			end
			if data.argument10 then
				table.insert(t,data.argument10)
			end
			for i,v in ipairs(t) do
				if UIActivitiesModel.GetTaskStatusByID( v ) == 1 then
					return true
				end--//0 没找到，1，可领取 ， 2 已领取，3未完成
			end
		end

		for i,v in ipairs(d.activity_items) do
			if v.argument4 then
				if v.status == ActivityModel.Status.status_can_receive then
					return true
				end
			end
		end

		return false
	end
end

local function initItem( ... )
	-- body
	--任务ID argument1 argument2 argument3 argument7 argument8 argument9 argument10
	--阶段分数 argument3
	local data = curData.activity_items[selectDay]
	local t = {}
	if data.argument1 then
		table.insert(t,data.argument1)
	end
	if data.argument2 then
		table.insert(t,data.argument2)
	end
	if data.argument3 then
		table.insert(t,data.argument3)
	end
	if data.argument7 then
		table.insert(t,data.argument7)
	end
	if data.argument8 then
		table.insert(t,data.argument8)
	end
	if data.argument9 then
		table.insert(t,data.argument9)
	end
	if data.argument10 then
		table.insert(t,data.argument10)
	end
	table.sort(t,function ( A,B )
		-- body
		local statusA = UIActivitiesModel.GetTaskStatusByID( A )
		local statusB = UIActivitiesModel.GetTaskStatusByID( B )
		local sortA
		local sortB
		--/0 没找到，1，可领取 ， 2 已领取，3未完成
		if statusA == 1 then
			sortA = 1
		elseif statusA == 2 then
			sortA = 3
		else 
			sortA = 2
		end
		if statusB == 1 then
			sortB = 1
		elseif statusB == 2 then
			sortB = 3
		else 
			sortB = 2
		end

		return sortA < sortB
	end)
	--Utils.destoryChild( GridParent )
	local tTemp = {}
	for i,v in ipairs(t) do
		local obj
		if GridParent:GetChild(i - 1) then
			obj = GridParent:GetChild(i - 1)
		else
			obj = NGUITools.AddChild(GridParent.gameObject,ItemChild.gameObject)
		end
		TweenAlpha.Begin(obj.gameObject,0.7,1,0)
		--local obj = NGUITools.AddChild(GridParent.gameObject,ItemChild.gameObject)
		obj.gameObject:SetActive(true)
		local Button = obj.transform:Find('Button').gameObject
		--Button.name = v
		local _t = {}
		_t.Button = Button
		local ButtonSprite = Button.transform:GetComponent('UISprite')
		_t.ButtonSprite = ButtonSprite
		local ButtonLabel = Button.transform:Find('Label'):GetComponent('UILabel')
		_t.ButtonLabel = ButtonLabel
		table.insert(tTemp,_t)

		local task = UIActivitiesModel.GetTaskDescByID( v )
		local LabelButton = Button.transform:Find('Label'):GetComponent('UILabel')
		local Desc = obj.transform:Find('Desc'):GetComponent('UILabel')
		Desc.text = task.desc
		local ProgressLabel = obj.transform:Find('ProgressLabel'):GetComponent('UILabel')
		ProgressLabel.text = UIActivitiesModel.GetTaskProgressByID(v) .. '/' .. task.argu1
		local Goods = obj.transform:Find('Goods')
		local Award = Goods:Find('Award')
		Utils.destoryChild( Award )
		local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(task.attachment_id1,GlobalEnum.ResType.IntToEnum(task.attachment_type1),task.attachment_num1,Award,task.attachment_value1,0.7)
		local Num = trs:Find('Mid/Num'):GetComponent('UILabel')
		local BG = Goods:Find('BG').gameObject
		if Num.gameObject.activeSelf then
			Num.gameObject:SetActive(false)
			BG:SetActive(true)
			Goods:Find('BG/Num'):GetComponent('UILabel').text = Num.text
			--Goods:GetComponent('UISprite').spriteName = 'Prize_Box_' .. (i%3 + 1)
		else
			BG:SetActive(false)
		end
		local Progress = obj.transform:Find('Progress'):GetComponent('UISprite')
		Progress.fillAmount = UIActivitiesModel.GetTaskProgressByID(v) / task.argu1
		local Disable = obj.transform:Find('Disable').gameObject
		Disable:SetActive(false)
		local status = UIActivitiesModel.GetTaskStatusByID( v ) --//0 没找到，1，可领取 ， 2 已领取，3未完成
		if status == 0 or status == 3 then
			--ButtonSprite.spriteName = 'Button_Activity2_Receive_Disable'
			ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateNotCanGet')--'未完成'
			UIEventListener.Get(Button).onClick = function ( ... )
				-- body
			end
		elseif status == 1 then
			--ButtonSprite.spriteName = 'Button_Activity2_Go_Normal'
			ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')--'领取'
			UIEventListener.Get(Button).onClick = function ( ... )
				-- body
				if msgLock then
					return
				end
				msgLock = true
				UIActivitiesModel.GetTaskRewardByID( v ,function ( tag )
					-- body
					if tag then
						--tTemp[i].ButtonSprite.spriteName = 'Button_Activity2_Receive_Disable'
						tTemp[i].ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--'已领取'
						UIEventListener.Get(tTemp[i].Button).onClick = function ( ... )
							-- body
						end
						tDayItem[selectDay].Red:SetActive(UIActivityPageCompleteNew.checkRed( curData,selectDay ))
						Progress.fillAmount = 1
						Disable:SetActive(true)
						--tEffectGetReward.index = i
						msgLock = nil
						--重新请求运营活动数据
						UIActivitiesModel.RequestActivitiesData( UIActivityPageCompleteNew.updateUI2Msg )
					end
				end)
			end
		elseif status == 2 then
			UIEventListener.Get(Button).onClick = function ( ... )
				-- body
			end
			--ButtonSprite.spriteName = 'Button_Activity2_Receive_Disable'
			ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--'已领取'
			Progress.fillAmount = 1
			Disable:SetActive(true)
		end
	end
	for i=#t,GridParent.transform.childCount - 1 do
		GridParent:GetChild(i).gameObject:SetActive(false)
	end

	ScrollViewItem:ResetPosition()
	GridParent.enabled = true
end

local function clickDayItem( obj )
	-- body
	if obj then
		selectDay = tonumber(obj.name)
	else
		if not selectDay then
			selectDay = curData.Day
		end
	end
	if selectDayLast then
		--tDayItem[selectDayLast].Sprite.spriteName = 'Button_Activity2_Days_Normal'
		tDayItem[selectDayLast].Select:SetActive(false)
	end
	--tDayItem[selectDay].Sprite.spriteName = 'Button_Activity2_Days_Selection'
	tDayItem[selectDay].Select:SetActive(true)
	selectDayLast = selectDay

	initItem()
end 

local function initDayItem( ... )
	-- body
	local Bottom = this.page.transform:Find('Bottom')
	local t
	local obj
	tDayItem = {}
	for i=1,Bottom.childCount do
		obj = Bottom:GetChild(i - 1)
		t = {}
		t.Obj = obj.gameObject
		t.Obj.name = i
		t.Trs = obj
		t.Label = obj:Find('Label'):GetComponent('UILabel')
		t.Label.text = string.format(ManagerCsv.GetInstance():GetNameStatic('OperateFormatDay'),i)
		t.Sprite = obj:GetComponent('UISprite')
		t.Select = obj.transform:Find('Select').gameObject
		t.Select:SetActive(false)
		--黑色 Button_Activity2_Days_Disable
		--绿色 Button_Activity2_Days_Normal
		--黄色 Button_Activity2_Days_Selection
		if i <= curData.Day  then
			UIEventListener.Get(t.Obj).onClick = clickDayItem
			t.Sprite.spriteName = 'Button_Activity2_Days_Normal'
		else
			t.Sprite.spriteName = 'Button_Activity2_Days_Disable'
		end

		t.Red = obj:Find('Red').gameObject
		--t.Red:SetActive(false)
		t.Red:SetActive(UIActivityPageCompleteNew.checkRed( curData,i ))
		
		table.insert(tDayItem,t)
	end
end

local function GetSpecialProgress( value )
	-- body
	--积分共49，长度共690 
	-->15 （49 - 15）
	--<=15 15 瓜分 
	local Progress
	--<=15 所占比重
	local ratio = 0.5
	if value > 15 then
		Progress = ratio + (1 - ratio) / 34 * (value - 15)
	else
		Progress = ratio / 15 * value
	end
	return Progress
end

local function GetBottomSpriteName( index )
	-- body
	if index == 2 then
		if ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw or 
			ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_tw_test or
			ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw or
			ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_tw_test or
			ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en or
			ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.android_en_test or 
			ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en or
			ManagerCsv.sdkPlatform == ManagerCsv.SDKPlatform.ios_en_test
		then
			index = 6
		end
	end
	 
	return 'Frame_Activty2_Reward' .. index
end

local function GetFrameIcon( typeID,id )
	-- body
	if GlobalEnum.ResType.IntToEnum(typeID) == GlobalEnum.ResType.Weapon then
		local CsvServantWeapon = ManagerCsv.GetInstance():GetServantWeapon(id)
		if CsvServantWeapon.weapon_rare <= 3 then --SR
			return 'rose_bottmo_02'
		elseif CsvServantWeapon.weapon_rare >= 4 then --SSR
			return 'rose_bottmo_03'
		end
	end
	return 'rose_bottmo_01'
end

local function initBottomRight( ... )
	-- body	
	local tStage = {}
	for i,v in ipairs(curData.activity_items) do
		if v.argument4 ~= 0 then
			local t = {}
			t.status = v.status
			t.score = v.argument4
			table.insert(tStage,t)
		end
	end
	--curData.MaxScore = 49--tStage[#tStage].score
	local BottomRight = this.page.transform:Find('BottomRight')
	BottomRightSlider = BottomRight:GetComponent('UISlider')
	Utils.destoryChild(BottomRight)
	BottomRightSlider.value = GetSpecialProgress(curData.CurScore)
	local BottomItem = this.page.transform:Find('BottomItem')
	local tBottomRight = {}
	local t
	local obj
	local tempReward
	for i=1,#tStage do
		obj = NGUITools.AddChild(BottomRight.gameObject,BottomItem.gameObject) --BottomRight:GetChild(i - 1)
		obj = obj.transform
		obj.name = i
		t = {}
		t.Obj = obj.gameObject
		tempReward = curData.activity_items[i].rewards[1]
		--obj.transform:GetComponent('UISprite').spriteName = GetBottomSpriteName(i)
		local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(tempReward.id,GlobalEnum.ResType.IntToEnum(tempReward.type),tempReward.num,obj:Find('Root'),tempReward.value,0.7)
		trs:Find('Mid/IconFrame').gameObject:SetActive(false)
		trs:Find('Mid/SuperScript').gameObject:SetActive(false)
		local trsNum = trs:Find('Mid/Num'):GetComponent('UILabel')
		local Num = obj:Find('Num'):GetComponent('UILabel')
		if trsNum.gameObject.activeSelf then
			Num.gameObject:SetActive(true)
			trsNum.gameObject:SetActive(false)
			Num.text = trsNum.text
		else
			Num.gameObject:SetActive(false)
		end
		obj.transform.localPosition = Vector3(GetSpecialProgress(tStage[i].score) * 690,0,0)
		t.Label = obj:Find('Label'):GetComponent('UILabel')
		local Frame = obj.transform:Find('Frame'):GetComponent('UISprite')
		Frame.spriteName = GetFrameIcon(tempReward.type,tempReward.id)
		
		if tStage[i].status == ActivityModel.Status.status_received then
			t.Label.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--'已领取'
			UIEventListener.Get(obj.gameObject).onClick = function ( ... )
				-- body
				
			end
		elseif tStage[i].status == ActivityModel.Status.status_can_receive then
			t.Label.text = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')--'领取'--tStage[i].score

			UIEventListener.Get(t.Label.gameObject).onClick = function ( ... )
				-- body
				--发送领取协议，--刷新本地状态
				UIActivitiesModel.GetNurturanceTaskAward( curData.id,i,function ( ... )
					-- body
					curData.activity_items[i].status = ActivityModel.Status.status_received
					tBottomRight[i].Label.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--'已领取'
					UIEventListener.Get(tBottomRight[i].Obj).onClick = function ( ... )
						-- body
					end
					--更新左边标签红点

				end )
			end
		elseif tStage[i].status == ActivityModel.Status.status_cannot_receive then
			t.Label.text = tStage[i].score --.. ManagerCsv.GetInstance():GetNameStatic('OperateScore')--'积分'
			UIEventListener.Get(obj.gameObject).onClick = function ( ... )
				-- body
				
			end
		end
		table.insert(tBottomRight,t)
	end
end

local function showEffectGetReward( ... )
	-- body
	if not tEffectGetReward or not tEffectGetReward.index then
		return
	end
	local click = NGUITools.AddChild(tEffectGetReward.self.gameObject,tEffectGetReward.click.gameObject)
	click = click.transform
	click.gameObject:SetActive(true)
	click.position = GridParent.transform:GetChild(tEffectGetReward.index - 1):Find('Button').position
	local from = click.localPosition
	local to = tEffectGetReward.hit.localPosition
	tEffectGetReward.trail.gameObject:SetActive(true)
	local randomY = math.random(-100,100)
	local randomX = math.random(-100,100)
	local offset = Vector3(randomX,random,0)
	tEffectGetReward.hit.gameObject:SetActive(false)
	WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():BezierMovie(tEffectGetReward.trail.gameObject,from,to,offset,0.7,function ( ... )
		-- body
		click.gameObject:SetActive(false)
		tEffectGetReward.trail.gameObject:SetActive(false)
		tEffectGetReward.hit.gameObject:SetActive(true)

		--重新请求运营活动数据
		UIActivitiesModel.RequestActivitiesData( UIActivityPageCompleteNew.updateUI2Msg )
	end)
	tEffectGetReward.index = nil
end

local function initEffectGetReward( ... )
	-- body
	local EffectWidget = this.page.transform:Find('EffectPanel/EffectWidget')
	tEffectGetReward = {}
	tEffectGetReward.self = EffectWidget
	tEffectGetReward.click = EffectWidget:Find('UIActivityPageCompleteNew_click')
	tEffectGetReward.click.gameObject:SetActive(false)
	tEffectGetReward.hit = EffectWidget:Find('UIActivityPageCompleteNew_hit')
	tEffectGetReward.hit.gameObject:SetActive(false)
	tEffectGetReward.trail = EffectWidget:Find('UIActivityPageCompleteNew_trail')
	tEffectGetReward.trail.gameObject:SetActive(false)
end

local function init( ... )
	-- body
	ItemChild = this.page.transform:Find('Item')
	ItemChild.gameObject:SetActive(false)
	ScrollViewItem = this.page.transform:Find('ItemBG/ScrollViewItem'):GetComponent('UIScrollView')
	GridParent = ScrollViewItem.transform:Find('Grid'):GetComponent('UIGrid')

	UIEventListener.Get(this.page.transform:Find('Close').gameObject).onClick = function ( ... )
		-- body
		Close()
	end
	this.page.transform:Find('RolePic/Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('OperateCompleteDes')

	initEffectGetReward()
	initDayItem()
	clickDayItem()
	initItem()
	initBottomRight()

	GUtilListener.addEventListener("ActivityCloseAwardsPanelListener", UIActivityPageCompleteNew.ActivityCloseAwardsPanelListener)

	UIWindowsManager.GetInstance():AddCloseAction(Close)
end

function UIActivityPageCompleteNew.ActivityCloseAwardsPanelListener( arg )
	-- body
	if arg.eventArgs then
		showEffectGetReward()
	else
		local timer =  Timer.New(showEffectGetReward, 0.7, 1, true)
		timer:Start()
	end
end

--- 显示 活动 页面
function UIActivityPageCompleteNew.addShow(...)
	this = UIActivityPageCompleteNew
	curData = ...
	if cacheData then
		curData = cacheData
	end
	this.init = init
	this.clear = clear
	this.clearOnReload = clearOnReload
	this:show(...)
end

function UIActivityPageCompleteNew.updateUI2Msg( ... )
	-- body
	if this:isNil() then
		return
	end
	curData = UIActivitiesModel.GetServerDataAllByID( curData.id )
	initBottomRight()
	cacheData = curData

	BottomRightSlider.value = GetSpecialProgress(curData.CurScore)
end