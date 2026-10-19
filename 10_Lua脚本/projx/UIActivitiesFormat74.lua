--多关卡挑战型2
UIActivitiesFormat74 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat74")

local this = UIActivitiesFormat74

local data
local LabelTimes

local RemainingTimeShop
local RemainingTimeLevel
local Lock

function this.clear( ... )
	-- body
	 data = nil
	 LabelTimes = nil
	 RemainingTimeShop = nil
	 RemainingTimeLevel = nil
	 Lock = nil
end

local function GoLevel( ... )
	UIActivitiesChallengeSelectLevel:show(data,1)
	UIActivitiesButtons.close()
end

function this.hide2show( ... )
	-- body
	data = ...
	local strFormat = ManagerCsv.GetInstance():GetNameStatic('Format62LeftTimes')
	if data.activity_items[1].argument5 == 0 then
		LabelTimes.text = ''
	else
		LabelTimes.text =  string.format(strFormat,(data.activity_items[1].argument5 - data.DayTimes) .. '/' .. data.activity_items[1].argument5)
	end
	local UtcTimestamp = tonumber(tostring(GUtilTime.toUtcTimestamp()))
	RemainingTimeShop.text = UIActivitiesModel.GetTimeSpanStr(data.closetime - UtcTimestamp)
	RemainingTimeLevel.text = UIActivitiesModel.GetTimeSpanStr(data.endtime - UtcTimestamp)
	Lock:SetActive(data.endtime - UtcTimestamp < 0)
end

function this.init( ... )
	local Button = this.page.transform:Find('Button')
	LabelTimes = this.page.transform:Find('LabelTimes'):GetComponent('UILabel')
	RemainingTimeLevel = Button:Find('Time'):GetComponent('UILabel')
	RemainingTimeShop = this.page.transform:Find('Shop/Time'):GetComponent('UILabel')
	Lock = this.page.transform:Find('Lock').gameObject
	UIEventListener.Get(Button.gameObject).onClick = GoLevel
	UIEventListener.Get(this.page.transform:Find('Shop').gameObject).onClick = function ( ... )
		-- body
		UIActivitiesButtons.close()
		--参数位25 用于指定 对应参数的商店
		local id 
		if data.activity_items[1].argument25 ~= '' then
			id = data.activity_items[1].argument25
		else
			id = WaterBell.ProjX.View.Panel.ShopData.RunAcitivtyID
		end
		UIActivitiesModel.GoOneShopPageByID( id,'UIActivitiesFormat74.back' )
	end

	this.hide2show( ... )
end

function this.back( ... )
	-- body
	UIActivitiesButtons:show()
end

function this.this( ... )
	-- body
	this = ...
end