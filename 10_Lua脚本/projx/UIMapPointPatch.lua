local this = {}

local lastIndex

function OpenBuffPanel( index )
	-- body
	this.BuffPanel.gameObject:SetActive(true)
	if lastIndex and lastIndex == index then
		return
	end
	Utils.destoryChild( this.BuffPanelGrid )
	local temp
	if index == 1 then
		--打开buff
		for i=1,#this.BuffData do
			temp = NGUITools.AddChild(this.BuffPanelGrid.gameObject,this.BuffPanelBuffItem)
			temp.transform:Find('Icon'):GetComponent('UISprite').spriteName = this.BuffData[i].icon
			temp.transform:Find('Name'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetName(this.BuffData[i].name)
			temp.transform:Find('Desc'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetName(this.BuffData[i].desc)
			temp.gameObject:SetActive(true)
		end
		this.BuffPanelTitle.text = ManagerCsv.GetInstance():GetNameStatic('UIMapPoint_BuffPanelTitle')--'Buffer详情'
	else
		--打开奖励
		this.BuffPanelTitle.text = ManagerCsv.GetInstance():GetNameStatic('UIMapPoint_AwardPanelTitle')--'奖励总览'
		local InstanceStructure = CSVPool.InstanceStructure()
		local function GetInstanceTable( frist )
			-- body
			local t = {}
			--去table.insert(t,frist)
			frist = math.floor(frist / 100  )

			for i,v in ipairs(InstanceStructure) do
				if math.floor(v.ID / 100  ) == frist then
					table.insert(t,v.ID)
				end
			end
			return t
		end

		local t = GetInstanceTable(this.data.activity_items[1].argument1)

		if #t == 0 then
			print('InstanceStructure 没有对应字段：' .. this.data.activity_items[1].argument1)
			return
		end

		local tGoodsNum = {}
		temp = string.split(this.data.activity_items[1].argument12,'|') 
		for i=1,#temp do
			tGoodsNum[i] = tonumber(temp[i])
		end

		local goods
		local instance
		local tempGrid
		for i=1,#t do
			temp = NGUITools.AddChild(this.BuffPanelGrid.gameObject,this.BuffPanelAwardItem)
			temp.gameObject:SetActive(true)

			instance = ManagerCsv.GetInstance():GetInstance(t[i])
			if not instance then
				print('Instance表没有对应id ：' .. t[i])
				break
			end
			temp.transform:Find('Name'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetName(instance.instance_name)
			tempGrid = temp.transform:Find('Grid'):GetComponent('UIGrid')

			goods = UIActivitiesModel.GetLevelGoodsByID( t[i] )
			for ii=0,goods.Count - 1 do
				--chang by gus 2019.09.30
				--轻微修改坐标以及尺寸
				--WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(goods[i].rawID,goods[i].rawType,goods[i].rawNum,temp.transform,goods[i].rawValue,0.7)
				WaterBell.ProjX.Common.Utils.AwardUtils.GetInstance():LoadAwardSpriteEx(goods[ii].rawID,goods[ii].rawType,tGoodsNum[i],tempGrid.transform,goods[ii].rawValue,0.8)--.localPosition = Vector3((ii + #this.BuffData) * 75,40,0)
			end
			for ii=1,#this.BuffData do
				if tonumber(this.BuffData[ii].level) == t[i] then
					temp = NGUITools.AddChild(tempGrid.gameObject,this.IconBuffer.gameObject)
					temp:SetActive(true)
					temp:GetComponent('UISprite').spriteName = this.BuffData[ii].icon
					temp.transform.localScale = Vector3(3.8,3.8,1)
					break
				end
			end

			tempGrid.enabled = true
		end
	end
	this.BuffPanelGrid.enabled = true
	this.BuffPanelScroll:ResetPosition()
end

function this:OnEnable( obj )
	-- body
	local BuffPanel = obj.transform:Find('BuffPanel')
	this.BuffPanel = BuffPanel

	UIEventListener.Get(BuffPanel:Find('Close').gameObject).onClick = function ( ... )
		-- body
		BuffPanel.gameObject:SetActive(false)
	end

	this.BuffPanelScroll = BuffPanel:Find('ScrollView'):GetComponent('UIScrollView')
	this.BuffPanelGrid = this.BuffPanelScroll.transform:Find('Grid'):GetComponent('UIGrid')
	this.BuffPanelBuffItem = BuffPanel:Find('BuffItem').gameObject
	this.BuffPanelBuffItem:SetActive(false)
	this.BuffPanelAwardItem = BuffPanel:Find('AwardItem').gameObject
	this.BuffPanelAwardItem:SetActive(false)
	this.BuffPanelTitle = BuffPanel:Find('BG/Title'):GetComponent('UILabel')

	local BottomRight = obj.transform:Find('BottomRight')

	UIEventListener.Get(BottomRight:Find('Help').gameObject).onClick = function ( ... )
		-- body
		UIActivitiesRule:show(ManagerCsv.GetInstance():GetNameStatic('UIMapPoint_Rule'))
	end

	local Times = BottomRight:Find('Times'):GetComponent('UILabel')

	local Bottom = obj.transform:Find('Bottom')
	local Buffer = Bottom:Find('Buffer').gameObject
	UIEventListener.Get(Buffer).onClick = function ( ... )
		-- body
		OpenBuffPanel(1)
	end

	local BottomLeft = obj.transform:Find('BottomLeft')
	local Award = BottomLeft:Find('Award')
	Award:Find('Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('UIMapPoint_AwardButton')
	UIEventListener.Get(Award.gameObject).onClick = function ( ... )
		-- body
		OpenBuffPanel(2)
	end

	--请求运营活动数据，显示buff 数据，当前次数数据

	local function CallBack( ... )
		-- body
		local data = UIActivitiesModel.GetServerDataAllByID( UIActivitiesChallenge.ChallengeID )
		UIMapPointPatchFristLevel = data.activity_items[1].argument1
		this.data = data
		--data.ChallengeTimes = 3
		local temp
		--若当前是限制关卡次数的，需要限制次数，并且显示当前剩余的次数
		local maxTimes = data.activity_items[1].argument4
		if maxTimes == 0 then
			Times.text = ''
		else
			--'今日可通关次数：%s/%s'
			Times.text = string.format(ManagerCsv.GetInstance():GetNameStatic('UIMapPoint_TimesLabel'),math.max(maxTimes - data.ChallengeTimes,0),maxTimes)
			local point = BottomLeft:Find('offset/scrollView/point')
			for i=1,point.transform.childCount do
				temp = point:GetChild(i - 1)
				temp = temp:GetComponent('UISprite')
				if temp.spriteName ~= "Checkpoint_Icon_2" then
					if not string.find(temp.spriteName, 'Black') then
						if data.ChallengeTimes >= maxTimes then
							Destroy(temp.transform:GetComponent('SuperUIButton'))
							UIEventListener.Get(temp.gameObject).onClick = function ( ... )
								-- body
								--print('当前关卡已通过！')
								NetworkAlertUI.TryShowWarningTipByTag('UIMapPoint_NoTimes')
							end
						end
					end
				end
			end
			--[[
			--需要做特殊判断
			for i=1,point.transform.childCount do
				temp = point:GetChild(i - 1)
				temp = temp:GetComponent('UISprite')

				local id = string.split(temp.name,'_')
				local instance
				if id[2] then
					instance = ManagerCsv.GetInstance():GetInstance(tonumber(id[2]))
				end
				if instance then
					temp.transform:Find('Label'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetName(instance.instance_name)
				end
				if temp.spriteName == 'Checkpoint_Icon_1' then
					if data.ChallengeTimes >= maxTimes then
						Destroy(temp.transform:GetComponent('SuperUIButton'))
						UIEventListener.Get(temp.gameObject).onClick = function ( ... )
							-- body
							--print('今日可通关次数不足！')
							NetworkAlertUI.TryShowWarningTipByTag('UIMapPoint_NoTimes')
						end
					end
					--根据副本表刷新下图片名称
					if instance then
						temp.spriteName = instance.instance_icon
					end
				elseif temp.spriteName == 'Checkpoint_Icon_2' then
					--if data.ChallengeTimes >= maxTimes then
						Destroy(temp.transform:GetComponent('SuperUIButton'))
						UIEventListener.Get(temp.gameObject).onClick = function ( ... )
							-- body
							--print('当前关卡已通过！')
							NetworkAlertUI.TryShowWarningTipByTag('UIMapPoint_PassTips')
						end
					--end
				elseif temp.spriteName == 'Checkpoint_Icon_3' then
					if instance then
						temp.spriteName = instance.instance_icon .. '_Black'
					end
				end
			end
			]]--
		end

		--显示buff
		local tBuff = {}
		local argument = data.activity_items[1].argument11
		argument = string.split(argument,'|')
		
		local tBuffLevel = {}
		for i=1,#argument do
			temp = string.split(argument[i],':')
			tBuff[i] = temp[2]
			tBuffLevel[i] = temp[1]
		end

		if #tBuff == 0 then
			print('参数11填写的 id：buff | id：buff 有错！' .. data.activity_items[1].argument11)
			return
		end

		local iconBuffer = Bottom:Find('Item').gameObject
		this.IconBuffer = iconBuffer
		iconBuffer:SetActive(false)
		local temp
		local Buff = CSVPool.Buff()
		local t = {}
		for i,v in ipairs(tBuff) do
			for ii,vv in ipairs(Buff) do
				if vv.ID == tonumber(v) then
					temp = {}
					temp.id = v
					temp.name = vv.buff_name
					temp.icon = vv.buff_icon
					temp.desc = vv.buff_description
					temp.level = tBuffLevel[i]
					table.insert(t,temp)
					break
				end
			end
		end
		if #t == 0 then
			print('Buff 表找不到对应Buff!')
			table.print(tBuff)
			return
		end
		Utils.destoryChild(Buffer)
		for i=1,#t do
			temp = NGUITools.AddChild(Buffer,iconBuffer)
			temp.gameObject:SetActive(true)
			temp = temp:GetComponent('UISprite')
			temp.spriteName = t[i].icon
			t.state = false
			if data.Buffs then
				for j=1,#data.Buffs do
					if data.Buffs[j] == t[i].id then
						t.state = true
						break
					end
				end
			end

			temp.color = t.state and Color.white or Color.gray
		end
		this.BuffData = t

		Buffer:GetComponent('UIGrid').enabled = true

		obj.transform:Find('Mask').gameObject:SetActive(false)
	end 
	ActivityModel:RegisterCallback(CallBack)
	ActivityModel:getActivities(false)
end

function this:Start( obj )
	-- body
end

return this