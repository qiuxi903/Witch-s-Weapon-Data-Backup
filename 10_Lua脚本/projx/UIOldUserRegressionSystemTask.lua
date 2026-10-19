UIOldUserRegressionSystemTask = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIOldUserRegressionSystemTask")
local this = UIOldUserRegressionSystemTask

function this.init( ... )
	-- body
	local Data = UIActivitiesModel.GetServerDataAllByID( 992 )
	local Item = this.page.transform:Find('Item')
	local Center = this.page.transform:Find('Center')
	local OffsetXY = Center:Find('OffsetXY')
	local OffsetX = OffsetXY.localPosition.x
	local OffsetY = OffsetXY.localPosition.y
	local Root = Center:Find('Root')

	local strReward = ManagerCsv.GetInstance():GetNameStatic('奖励') -- 奖励
	local strTaskText_GoTask = ManagerCsv.GetInstance():GetNameStatic('TaskText_GoTask') --去任务
	local strOperateReward2 = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')--领取
	local strOperateReceive = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')--已领取
	local strTaskText_Title = ManagerCsv.GetInstance():GetNameStatic('TaskText_Title')--完成日常任务

	local function GetStep( ... )
		-- body
		local index = 1
		for i=#Data.activity_items,1,-1 do
			--倒序 找最后一个领取过的， + 1就是当前的阶段
		    if Data.activity_items[i].status == ActivityModel.Status.status_received then
		    	index = i + 1
		    	break
			end
		end
		return index > #Data.activity_items and #Data.activity_items or index
	end

	--当前的阶段
	local Step = GetStep()

	--总的阶段
	local AllStep = #Data.activity_items
	--当前阶段完成日常任务的个数
	local CurNum = Data.Count
	--当前阶段完成日常任务的总个数
	local AllNum = Data.activity_items[Step].argument4

	--奖励只能三个
	for i=1,#Data.activity_items[Step].rewards do
		if Root.transform.childCount < i then
			temp = NGUITools.AddChild(Root.gameObject,Item.gameObject)
		else
			temp = Root:GetChild(i - 1)
		end
		temp = temp.transform

		if i < 3 then
			--第一行两个
			temp.localPosition = Vector3.New(OffsetX * (i - 1),0,0)
		elseif i == 3 then
			--第二行1个
			temp.localPosition = Vector3.New(OffsetX / 2, - OffsetY,0)
		end

		temp:Find('Title'):GetComponent('UILabel').text = strReward .. i

		local reward = Data.activity_items[Step].rewards[i]
		local tempRoot = temp:Find('Root')
		Utils.destoryChild( tempRoot )
		local trs = AwardUtils.GetInstance():LoadAwardSprite(reward.id,reward.type,reward.num,tempRoot,reward.value,1)
		local Mid = trs:Find('Mid')
		Mid:Find('SuperScript').gameObject:SetActive(false)
		Mid:Find('IconFrame').gameObject:SetActive(false)
		local Num = Mid:Find('Num'):GetComponent('UILabel')
		Num.gameObject:SetActive(false)
		temp:Find('Num'):GetComponent('UILabel').text = Num.text
	end

	local TopContent = this.page.transform:Find('TopContent')
	TopContent:Find('Step'):GetComponent('UILabel').text = Step
	TopContent:Find('AllStep'):GetComponent('UILabel').text = AllStep
	TopContent:Find('Progress'):GetComponent('UILabel').text = CurNum .. '/' .. AllNum
	TopContent:Find('Title'):GetComponent('UILabel').text = strTaskText_Title

	local Button = this.page.transform:Find('Button')
	tButton = {}
	tButton.Label = Button:Find('Label'):GetComponent('UILabel')
	tButton.Label.text = ''
	tButton.BG = Button:Find('BG'):GetComponent('UISprite')
	tButton.BG.spriteName = 'olduser_anniu01_02'
	local status = Data.activity_items[Step].status
	
	if status == ActivityModel.Status.status_received then
		--已领取
		tButton.Label.text = strOperateReceive
		tButton.BG.spriteName = 'olduser_anniu01_02'
	elseif status == ActivityModel.Status.status_can_receive then
		--可领取
		tButton.Label.text = strOperateReward2
		tButton.BG.spriteName = 'olduser_anniu01_01'

		UIEventListener.Get(Button.gameObject).onClick = function ( ... )
			--发送协议领取奖励
			local roleid = tostring(WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():RoleID())
			local baseid = Data.id
			local serial = Step
			local msgParams = {roleid = roleid,baseid = baseid,serial = serial}
			Utils.SendMessage(ActivityModel.getCode(baseid,Data.type),msgParams, function(response)
				local bytes = response.bytes
				local LuaNetProxy = LuaNetProxy.New()
				LuaNetProxy:Callback(bytes)
				--设置本地数据
				Data.activity_items[Step].status = ActivityModel.Status.status_received
				UIEventListener.Get(Button.gameObject).onClick = function ( ... )
				end
				-- tButton.Label.text = strOperateReceive
				-- tButton.BG.spriteName = 'olduser_anniu01_02'
				--重新刷新
				this.init()
				UIOldUserRegressionSystem.UpdateRed()
			end)
		end
	else
		--不可领取
		tButton.Label.text = strOperateReward2
		tButton.BG.spriteName = 'olduser_anniu01_02'

	end

	
end