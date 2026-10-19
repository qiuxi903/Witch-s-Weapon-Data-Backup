--多关卡挑战型2
UIActivitiesFormat75 = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFormat75")

local this = UIActivitiesFormat75

local function IsExistServant( id )
	-- body
	-- UserInfo.GetInstance().GetServantInfo().GetObservableServantsByID(SingleServant.ServantCardID)
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp') 

    local ServantInfo = UserInfo.GetInstance():GetServantInfo()

    local t_ServantCore = typeof('WaterBell.ProjX.Data.Entity.ServantCore')
	local func = tolua.getmethod(t_ServantCore, 'GetObservableServantsByID',typeof('System.Int64'))
    local ObservableSingleServant = func:Call(ServantInfo,id)

    local t_ObservableSingleServant = typeof('WaterBell.ProjX.Data.Entity.ObservableSingleServant')

    local property = tolua.getproperty(t_ObservableSingleServant, 'IsExist')
    local IsExist = property:Get(ObservableSingleServant, null)
    property:Destroy()
    property = nil
    func:Destroy()
    func = nil

    return IsExist
end

function this.init( ... )
	-- body
	local data = ...
	local GoCopyEquip = this.page.transform:Find('GoCopyEquip')
	local GoLevel = this.page.transform:Find('GoLevel')

	local UtcTimestamp = tonumber(tostring(GUtilTime.toUtcTimestamp()))

	--剩余时间：%s
	local timeLabel = ManagerCsv.GetInstance():GetNameStatic('剩余时间:')
	
	GoLevel:Find('Time'):GetComponent('UILabel').text = timeLabel .. UIActivitiesModel.GetTimeSpanStr(data.endtime - UtcTimestamp)
	
	UIEventListener.Get(GoLevel.gameObject).onClick = function ( ... )
		-- body
		UIActivitiesChallengeSelectLevel:show(data,1)
		UIActivitiesButtons.close()
	end

	local relationID = data.activity_items[1].argument14
	relationID = string.split(relationID,'|')

	local dataEquip
	if relationID[1] then
		relationID[1] = tonumber(relationID[1])
		if relationID[2] then
			relationID[2] = tonumber(relationID[2])
		end

		local temp = UIActivitiesModel.GetServerDataAllByID( relationID[1])
		if not temp then
			temp = UIActivitiesModel.GetServerDataAllByID( relationID[2] )
		end
		dataEquip = temp
		data.dataEquip = dataEquip
		GoCopyEquip:Find('Time'):GetComponent('UILabel').text = timeLabel ..UIActivitiesModel.GetTimeSpanStr(temp.endtime - UtcTimestamp)

	end

	UIEventListener.Get(GoCopyEquip.gameObject).onClick = function ( ... )
		-- body
		--前往其他炼金
		if dataEquip then
			UIActivitiesButtons.ShowOnePage(dataEquip.id,dataEquip.format)
		end
	end

	local BG = this.page.transform:Find('Layer/BG'):GetComponent('UITexture')
	local texture = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityImg/Bg/" .. data.background)
	if texture then
		BG.mainTexture = texture
	end

	--显示任务
	local task = data.activity_items[1].argument13
	task = string.split(task,'|')

	if task[1] then

		local Slider = this.page.transform:Find('Slider')
		local width = Slider:GetComponent('UISprite').width

		local SliderValue = Slider:GetComponent('UISlider')

		local parent = Slider:Find('Root').gameObject
		local child = Slider:Find('Item').gameObject

		local Receiving = Slider:Find('Receiving').gameObject
		local Received = Slider:Find('Received').gameObject
		local temp
		local pos = 0

		local id = tonumber(task[#task]) 
		local taskData = UIActivitiesModel.GetTaskDescByID(id )
		local max = taskData.argu1
		local haveProgress
		for i=1,#task do
			temp = NGUITools.AddChild(parent,child)

			--展示任务奖励
			local id = tonumber(task[i]) 
			local taskData = UIActivitiesModel.GetTaskDescByID(id )

			pos = taskData.argu1 / max * width
			temp.transform.localPosition = Vector3(pos,0,0)
			
			temp.transform:Find('Times'):GetComponent('UILabel').text = taskData.argu1 .. ManagerCsv.GetInstance():GetNameStatic('次')

			local itemRoot = temp.transform:Find('Root')
			AwardUtils.GetInstance():LoadAwardSprite(taskData.attachment_id1,tostring(taskData.attachment_type1),taskData.attachment_num1,itemRoot,taskData.attachment_value1,0.7)

			--//0 没找到，1，可领取 ， 2 已领取，3未完成
			local state = UIActivitiesModel.GetTaskStatusByID( id )
			if state == 1 then
				local buttonReceiving = NGUITools.AddChild(itemRoot.gameObject,Receiving)
				UIEventListener.Get(buttonReceiving.gameObject).onClick = function ( ... )
					-- body
					--检测 特定任务id 509022005  10011201
					--CE40622
					if id == 509022005 and not IsExistServant(10011201) then
						NetworkAlertUI.TryShowWarningTipByTag('CE40622')
						return
					end

					UIActivitiesModel.GetTaskRewardByID( id ,function ( ... )
						-- body
						NGUITools.AddChild(itemRoot.gameObject.gameObject,Received)
						Destroy(buttonReceiving.gameObject)
					end)
				end
			elseif state == 2 then
				NGUITools.AddChild(itemRoot.gameObject,Received)
			elseif state == 3 then
				if not haveProgress then
					local progress = UIActivitiesModel.GetTaskProgressByID( id )
					data.progress = progress
					SliderValue.value = progress / max
					haveProgress = true
				end
			elseif state == 0 then
				print('未找到任务：' .. id)
			end
		end

		if not haveProgress then
			SliderValue.value = 1
			data.progress = max
		end
	end
end