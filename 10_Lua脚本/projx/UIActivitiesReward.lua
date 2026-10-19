UIActivitiesReward =  BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesReward")
local this = UIActivitiesReward
local func
local tTimer

local tPos = 
{
	{-6,76},{166,76},{334,76},{502,76},
	{84,-150},{252,-150},{418,-150},
}

function this.clear( ... )
	-- body
	for i,v in ipairs(tTimer) do
		if v.running then
			v:Stop()
		end
	end
	tTimer = nil
end

local function close( ... )
	-- body
	this:destory()

	if func then
		func()
	end
	UIWindowsManager.GetInstance():RemoveAction()
end


function this.init( ... )
	-- body
	local rewardType,data,animation,funcc = ...
	func = funcc
	local Title = this.page.transform:Find('Title'):GetComponent('UILabel')
	local RewardPatchRoot = this.page.transform:Find('RewardPatchRoot')
	local RewardPatchItem = this.page.transform:Find('RewardPatchItem')
	RewardPatchItem.gameObject:SetActive(false)
	local RewardRoot = this.page.transform:Find('RewardRoot')
	local RewardTitle = this.page.transform:Find('RewardTitle'):GetComponent('UILabel')
	local RewardTips1 = this.page.transform:Find('RewardTips1'):GetComponent('UILabel')
	local RewardTips2 = RewardTips1.transform:Find('RewardTips2'):GetComponent('UILabel')

	UIEventListener.Get(this.page.transform:Find('Box').gameObject).onClick = close

	tTimer = {}

	local curDay
	if rewardType == 1 then
		--七日登陆
		RewardTitle.gameObject:SetActive(false)
		RewardTips1.gameObject:SetActive(false)

		Title.text = ManagerCsv.GetInstance():GetNameStatic('OperateContinuousSignIn')--'连续签到'
		curDay = data.DaysSignContinuityRewardTag
	else
		--连续登陆
		Title.text = ManagerCsv.GetInstance():GetNameStatic('OperateLogin')--'累计登陆'
		RewardTitle.text = string.format(ManagerCsv.GetInstance():GetNameStatic('OperateLoginDays'),data.DaysSignAutoDays)
		RewardTips1.text = string.format(ManagerCsv.GetInstance():GetNameStatic('OperateRewardDays'),data.activity_items[1].argument4 - data.DaysSignAutoDays % data.activity_items[1].argument4)
		RewardTips2.text = string.format( ManagerCsv.GetInstance():GetNameStatic('OperateMeetDays'),data.activity_items[1].argument4)
		curDay = data.DaysSignAutoDays
	end
	local tTrs = {}
	for i,v in ipairs(data.activity_items) do
		--这里只支持显示一个物品
		local v1 = v.rewards[1]
		local trs = WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSprite(v1["id"],v1["type"],v1["num"],RewardRoot,v1["value"],0.95)
		table.insert(tTrs,trs)
		local item = NGUITools.AddChild(trs.gameObject,RewardPatchItem.gameObject)
		item.gameObject:SetActive(true)
		item.transform.localScale = Vector3.New(1.05,1.05,1)
		item.transform:Find('Label'):GetComponent('UILabel').text = v.desc
		trs.transform.localPosition = Vector3.New(tPos[i][1],tPos[i][2],0)
		--item.transform.localPosition = Vector3.New(tPos[i][1],tPos[i][2],0)
		local Selected = item.transform:Find('Selected')
		if animation then
			TweenAlpha.Begin(trs.gameObject,0,0)
		end
		local show = false
		if rewardType == 1 then 
			Selected.gameObject:SetActive(curDay >= i)
			if animation and curDay == i then
				show = true
			end
		else
			Selected.gameObject:SetActive(data.DaysSignAutoDays % v.argument4 == 0)

			if animation and data.DaysSignAutoDays % v.argument4 == 0 then
				show = true
			end
		end
		if show then
			trs.transform.localPosition = Vector3.New(0,0,0)
			trs.transform.localScale = Vector3.New(1.5,1.5,1)
			TweenAlpha.Begin(trs.gameObject,0.1,1,0)
			TweenScale.Begin(trs.gameObject,0.3,Vector3.New(0.95,0.95,1))
			Selected.gameObject:SetActive(false)

			local timer = Timer.New(function ( ... )
				-- body
				TweenPosition.Begin(trs.gameObject,0.3,Vector3.New(tPos[i][1], tPos[i][2], 0))
				local timer = Timer.New(function ( ... )
					-- body
					for index,value in ipairs(tTrs) do
						if index ~= i then
							TweenAlpha.Begin(value.gameObject,1,1,0)
						end
					end
					Selected.gameObject:SetActive(true)
					Selected.localScale = Vector3.New(1.5,1.5,1)
					TweenScale.Begin(Selected.gameObject,0.1,Vector3.New(1.05,1.05,1))
					end, 0.3, 1, true)
				table.insert(tTimer,timer)
				timer:Start()
			end, 0.5, 1, true)
			table.insert(tTimer,timer)
			timer:Start()			
		end
	end
	UIWindowsManager.GetInstance():AddCloseAction(this.close)
end

function this.close( ... )
	-- body
	close()
end