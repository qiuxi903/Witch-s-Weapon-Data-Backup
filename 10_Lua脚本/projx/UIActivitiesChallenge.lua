UIActivitiesChallenge = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesChallenge",AssetsManager.AssetsType.LuaAssets1)

local this = UIActivitiesChallenge

local curData

function this.clear( ... )
	-- body
	curData = nil
end

local function Close( ... )
	-- body
	this:destory()
	UIWindowsManager.GetInstance():RemoveAction()

	AssetsManager.UnloadType(this.assetsType,false)

	if ... then
		LuaPanelHelper.GoBackMainScene()
	end
end

local function Go( obj )
	-- body
	--判断是不是ui关卡的
	local ids = string.split(obj.name,'_')
	local data = UIActivitiesModel.GetServerDataByID( tonumber(ids[1]) )
	if data and data.type == ActivityModel.ActivityType.ChallengeLevel.typeid then
		UIActivitiesChallengeSelectLevel:show(data,2)
	else
		--UISceneManager.getInstance().Goto(UISceneState((int)UISceneID.MAIN_SCENE_NEW, null), new UISceneState((int)UISceneID.TRAINING_SCENE, null));
		AwardUtils.SetTrainingSceneID(tonumber(ids[2]))
		UISceneManager.getInstance():GotoBackLua(UISceneState.New(UISceneID.MAIN_SCENE_NEW:ToInt()),UISceneState.New(UISceneID.TRAINING_SCENE:ToInt()),'UIActivitiesChallenge.AddShow')	
	end

	this.ChallengeID = tonumber(ids[1])

	Close()
end

function this.init( ... )
	-- body
	local ScrollView = this.page.transform:Find('ScrollView'):GetComponent('UIScrollView')
	local Grid = ScrollView.transform:Find('Grid'):GetComponent('UIGrid')
	local Item = this.page.transform:Find('Item').gameObject
	Item.transform.parent = Grid.transform

	local TopLift = this.page.transform:Find('TopLift')
	UIEventListener.Get(TopLift:Find('Button').gameObject).onClick = Close

	local obj

	local title
	local tempId
	local tempObj
	local tempTextureName
	for i=1,#curData do
		if Grid:GetChild(i - 1) then
			obj = Grid:GetChild(i - 1).gameObject
		else
			obj = NGUITools.AddChild(Grid.gameObject,Item)
		end
		
		tempObj = obj.transform:Find('Button').gameObject
		if curData[i].type == ActivityModel.ActivityType.ChallengeLevel.typeid then
			title = curData[i].activity_items[1].argument21
			tempObj.name = curData[i].id
		else
			tempId = curData[i].activity_items[1].argument1
			title = ManagerCsv.GetInstance():GetInstance(tempId).instance_set_attached
			tempObj.name = curData[i].id .. '_' .. tempId
		end
		UIEventListener.Get(tempObj).onClick = Go
		tempTextureName = ManagerCsv.GetInstance():GetInstanceSet(title).instance_set_image
		title = ManagerCsv.GetInstance():GetInstanceSet(title).instance_set_chinesename
		title = ManagerCsv.GetInstance():GetName(title)
		obj.transform:Find('Label'):GetComponent('UILabel').text = title
		obj.transform:Find('LabelContent'):GetComponent('UILabel').text = ManagerCsv.GetInstance():GetNameStatic('UIActivitiesChallenge_ItemDes')
		obj.transform:Find('TimeLabel'):GetComponent('UILabel').text = os.date("%Y.%m.%d",curData[i].starttime) .. '~' .. os.date("%Y.%m.%d",curData[i].endtime - 1)
		tempObj.transform:GetComponent('UITexture').mainTexture = AssetsManager.LoadTextureForLua('UI/UIImage/InstanceSet/' .. tempTextureName,this.assetsType)
	end	
	UIWindowsManager.GetInstance():AddCloseAction(this.BackClose)


end

function this.BackClose( ... )
	-- body
	Close()
end

--用于C#传递过来打开界面
function this.AddShow( ... )
	-- body
	--查询是否有可以开启的限时挑战活动
	curData = UIActivitiesModel.GetServerDatasByTypeID( ActivityModel.ActivityType.ActivitiesChallenge.typeid )
	--查询是否有可以开启的挑战关卡活动
	local tempData = UIActivitiesModel.GetServerDatasByTypeID( ActivityModel.ActivityType.ChallengeLevel.typeid )
	
	local temp = {}
	local curSevTime = Utils.getSeverTime()

	for i,v in ipairs(curData) do
		if v.endtime >= curSevTime then
			table.insert(temp,v)
		end
	end

	for i,v in ipairs(tempData) do
		if v.endtime >= curSevTime then
			table.insert(temp,v)
		end
	end

	curData = temp

	if #curData == 0 then
		NetworkAlertUI.TryShowWarningTipByTag('UIActivitiesChallenge_NullWarningTip')
		return
	end
	this:show()
end