--- 2018.08.15
--- add by gus
UIActivityPageSign = {}

--- 类似命名空间
local Color = UnityEngine.Color
local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
local GameObject = UnityEngine.GameObject

--- 本地化数据
local _view = nil
local _data = nil
local _viewRewardItem = nil


--- 视图信息本地化

local _viewBtnReward
local _viewItemList = {}
local _viewAnimStartKey = {}
--- 初始化视图
local function init()
	-- 数据集
	local activity_items = _data["activity_items"]
	-- 已经领取的天数
	local DaysSignRewardTag = _data["DaysSignRewardTag"]
	-- 上次签到的时间
	local DaysSignTime = _data["DaysSignTime"]
	-- 可不可以签到
	local isCanSign = Utils.getSeverTime() - DaysSignTime >= 60 * 60 * 24 or DaysSignRewardTag == 0
	
	--print("DaysSignTime"..DaysSignTime)
	--print("Utils.getSeverTime()"..Utils.getSeverTime())
	local RewardTagIndex
	local offsetY = 0
	local item = _view.page.transform:Find("BottomRight/scrollView/item").gameObject
	local btnReward = _view.page.transform:Find("BottomRight/scrollView/btnReward"):GetComponent("UIButton")
	--- 数据缓存清理
	_viewBtnReward = btnReward.gameObject
	_viewItemList = {}
	
	btnReward.isEnabled = isCanSign
	item:SetActive(false)
	--- 真个来个渐变就好了
	if nil ~= _view.page and nil ~= _view.page:GetComponent("UIPanel") then
		_view.page:GetComponent("UIPanel").alpha = 0
		TweenAlpha.Begin(_view.page.gameObject, 0.34, 1)
	end
	--- 清理动画
	for animTempIndex, animTempKey in pairs(_viewAnimStartKey) do
		GUtilListener.removeListener(animTempKey)
	end
	_viewAnimStartKey = {}
	local animKey = nil
	-----------------创建签 item【prefab】-----------------
	for index , value in pairs(activity_items) do
		RewardTagIndex = index - 1
		local tweenDeltaMul = Mathf.Max(index - 1 - DaysSignRewardTag, 0)
		itemClone = CloneGameObject(item, "item"..index)
		itemClone.transform.localPosition = item.transform.localPosition + UnityEngine.Vector3(0, offsetY, 0)
		--- 数据装在起来
		table.insert(_viewItemList, index, itemClone)
		
		--- 奖励延迟创建一下
		animKey = GUtilListener.calledTime(
			function(sEventData)
				-----------------创建签到中的奖励【prefab】-----------------
				if nil == sEventData or nil == sEventData.eventTarget then
					return
				end
				local rewardArr = sEventData.eventArgs
				--value["rewards"]
				local rewardOffsetX = 0
				for key, reward in pairs(rewardArr) do
					local reward_id = reward["id"]
					local reward_num = reward["num"]
					local reward_type = reward["type"]
					local reward_value = reward["value"]
					AwardUtils.GetInstance():LoadAwardSprite(reward_id, tostring(reward_type), reward_num, sEventData.eventTarget.transform:Find("reward"), reward_value, 0.8)
					local rewardIcon = sEventData.eventTarget.transform:Find("reward/UIRuneSpriteExObj(Clone)")
					if nil ~= rewardIcon then
						rewardIcon.localPosition = UnityEngine.Vector3(rewardOffsetX, 0, 0)
						
						rewardIcon.name = "reward_"..key
						if key > 1 then
							local rewardBack = CloneGameObject(sEventData.eventTarget.transform:Find("reward/back").gameObject, "back"..key)
							rewardBack.transform.localPosition = UnityEngine.Vector3(rewardOffsetX, 0, 0)
							rewardBack.transform:GetComponent("UISprite").spriteName = "Prize_Box_"..key
							--- 只有有数字的菜进行复制
							if rewardIcon.transform:Find("Mid/Num").gameObject.activeSelf then
								local rewardBackNum = CloneGameObject(sEventData.eventTarget.transform:Find("reward/backNum").gameObject, "backNum"..key)
								rewardBackNum.transform.localPosition = UnityEngine.Vector3(rewardOffsetX, -26, 0)
								local rewardLabelNum = CloneGameObject(sEventData.eventTarget.transform:Find("reward/labelNum").gameObject, "labelNum"..key)
								rewardLabelNum.transform.localPosition = UnityEngine.Vector3(rewardOffsetX, -28, 0)
								rewardLabelNum:GetComponent("UILabel").text = rewardIcon.transform:Find("Mid/Num"):GetComponent("UILabel").text
							end
						else
							sEventData.eventTarget.transform:Find("reward/labelNum"):GetComponent("UILabel").text = rewardIcon.transform:Find("Mid/Num"):GetComponent("UILabel").text
							sEventData.eventTarget.transform:Find("reward/labelNum").gameObject:SetActive(rewardIcon.transform:Find("Mid/Num").gameObject.activeSelf)
							sEventData.eventTarget.transform:Find("reward/backNum").gameObject:SetActive(rewardIcon.transform:Find("Mid/Num").gameObject.activeSelf)
						end
						
						rewardIcon.transform:Find("Mid/Num").gameObject:SetActive(false)
						rewardOffsetX = rewardOffsetX - 130
					end
				end
			--- 奖励延迟创建一下
			end, Mathf.Abs(index - 1 - DaysSignRewardTag) * 0.03, itemClone, value["rewards"])
		----------------- 绘制时间 -----------------
		itemClone.transform:Find("date/labelDay"):GetComponent("UILabel").text = ""..index
		----------------- 绘制是否领取过 -----------------
		--- 当前要签到的
		if RewardTagIndex == DaysSignRewardTag and isCanSign then
			itemClone.transform:Find("date/iconReward").gameObject:SetActive(false)
			itemClone.transform:Find("date/iconUnReward").gameObject:SetActive(false)
		end
		--- 以后要签到的
		if RewardTagIndex > DaysSignRewardTag or (not isCanSign and RewardTagIndex == DaysSignRewardTag) then
			itemClone.transform:Find("date/iconReward").gameObject:SetActive(false)
			itemClone.transform:Find("date/iconUnReward").gameObject:SetActive(true)
		end
		--- 已经签到过的
		if RewardTagIndex < DaysSignRewardTag then
			itemClone.transform:Find("date/iconReward").gameObject:SetActive(true)
			itemClone.transform:Find("date/iconUnReward").gameObject:SetActive(false)
		end
		--- 过度动画
		itemClone.transform.localPosition = itemClone.transform.localPosition + Vector3(150, 0, 0)
		itemClone.gameObject:GetComponent("UIWidget").alpha = 0
		TweenPosition.Begin(itemClone.gameObject, 0.3 + tweenDeltaMul * 0.1, itemClone.transform.localPosition - Vector3(150, 0, 0))
		TweenAlpha.Begin(itemClone.gameObject, 0.3 + tweenDeltaMul * 0.11, 1)
		
		----------------- 绘制 领取 按钮 -----------------
		if (RewardTagIndex == DaysSignRewardTag and isCanSign) or (index == DaysSignRewardTag and not isCanSign) then
			local tempP = btnReward.transform.localPosition
			tempP.y = itemClone.transform.localPosition.y
			btnReward.transform.localPosition = tempP
			
			--- 过度动画
			btnReward.transform.localPosition = btnReward.transform.localPosition + Vector3(150, 0, 0)
			TweenPosition.Begin(btnReward.gameObject, 0.3 + tweenDeltaMul * 0.1, btnReward.transform.localPosition - Vector3(150, 0, 0))
			if isCanSign then
				--- 点击领取
				_viewRewardItem = itemClone
				UIEventListener.Get(btnReward.gameObject).onClick = function ()
					btnReward.isEnabled = false
					--向服务器发送签到验证请求，并接受服务器的响应
					local roleid = AwardUtils.GetInstance():RoleID()
					local baseid = tostring(_data["id"])
					local msgParams = {roleid = tostring(roleid), baseid = tostring(baseid)}
					Utils.SendMessage(ActivityModel.getCode(_data["id"], _data["type"]),msgParams, 
						function(response)
							--- 本地写数据
							-- if _data["DaysSignRewardTag"] == 0 then
							-- 	_data["DaysSignTime"] = tonumber(os.time())
							-- else
							-- 	_data["DaysSignTime"] = Utils.getSeverTime()
							-- end
							_data["DaysSignTime"] = Utils.getSeverTime()
							_data["DaysSignRewardTag"] = _data["DaysSignRewardTag"] + 1
							--- 
							local bytes = response.bytes
							local LuaNetProxy = LuaNetProxy.New()
							LuaNetProxy:Callback(bytes)
							--- 标注已经领取
							if nil ~= _viewRewardItem then
								_viewRewardItem.transform:Find("date/iconReward").gameObject:SetActive(true)
							end
						end
					)
				end
			end
		end
		----------------- 坐标 下移 -----------------
		offsetY = offsetY - 146
		table.insert(_viewAnimStartKey, index, animKey)
	end
	--签到天数大于7的时候，显示出来后面的
	local scrollView = _view.page.transform:Find("BottomRight/scrollView"):GetComponent("UIScrollView")
	local delta = Mathf.Min(Mathf.Max((DaysSignRewardTag - 2) / (#activity_items - 4), 0.0), 1.0)
	scrollView:SetDragAmount(0, delta, false)
end

--- 动画关闭
local function animClose()
	if nil == _view then
		return
	end
	
	--- 清理动画
	for animTempIndex, animTempKey in pairs(_viewAnimStartKey) do
		GUtilListener.removeListener(animTempKey)
	end
	_viewAnimStartKey = {}
	
	
	for index , value in pairs(_viewItemList) do
		if nil ~= value and nil ~= value.gameObject then
			TweenPosition.Begin(value.gameObject, 0.3 + (index - 1) * 0.05, value.transform.localPosition + Vector3(100, 0, 0))
			TweenAlpha.Begin(value.gameObject, 0.3 + (index - 1) * 0.05, 0)
		end
	end
	
	if nil ~= _viewBtnReward then
		--- 去掉点击事件
		if nil ~= _viewBtnReward:GetComponent("UIEventListener") and  not _viewBtnReward:GetComponent("UIEventListener"):Equals(nil) then
			GameObject.Destroy(_viewBtnReward:GetComponent("UIEventListener"))
		end
		--- 放心播放动画
		TweenPosition.Begin(_viewBtnReward.gameObject, 0.3, _viewBtnReward.transform.localPosition + Vector3(150, 0, 0))
		--TweenAlpha.Begin(_viewBtnReward.gameObject, 0.3, 0)
	end
	
	if nil ~= _view.page then
		TweenAlpha.Begin(_view.page.gameObject, 0.64, 0)
	end
	
	local tempView = _view
	GUtilListener.calledTime(
		function()
			tempView:destory()
		end
		, 0.641)
	
	_viewItemList = {}
	_viewBtnReward = nil
	_view = nil
	_data = nil
end
--- 显示 活动 每日签到页面
function UIActivityPageSign.show(sView, sData)
	_view = sView
	_data = sData
	--- 显示活动界面
	_view.init = init
	_view.animClose = animClose
	_view:show()
end

