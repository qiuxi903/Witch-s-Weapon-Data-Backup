--2019-04-24 13:56:27 
--日服1198sp1
--用于给大活动关卡详情敌人数据等级调整
--SelectLevelDetail(Clone)___Temp_SelectLevelDetail___UnloadOnClose

--配合子物体 RoleIconItem(Clone)

local this = {}

function this:Start( obj )
	-- body
	local obj_SelectLevelDetail = obj.transform:GetComponent('SelectLevelDetail')
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')        
    local bitor = bit.bor(0,1,2,4,8,16,32,64,256,512,1024,2048,4096,8192,16384,32768)
    local field = tolua.getfield(typeof('WaterBell.ProjX.View.Panel.SelectLevelDetail'), 'modeType',bitor)
    local modeType = field:Get(obj_SelectLevelDetail)
    local field = tolua.getfield(typeof('WaterBell.ProjX.View.Panel.SelectLevelDetail'), 'instanceId',bitor)
    local instanceId = field:Get(obj_SelectLevelDetail)
    field:Destroy()
    PatchModel.SelectLevelDetail_ActivityDataFloor = nil
    if modeType:ToInt() == 8 then

    	-- var activityData = UserInfo.GetInstance().getActivityPlay().ActivityData;
     --    var activityPlayType= activityData.GetModeType();

     	local obj_ActivityPlay = UserInfo.GetInstance():getActivityPlay()
     	local property = tolua.getproperty(typeof('WaterBell.ProjX.Data.Entity.ActivityPlay'), 'ActivityData')
	    local obj_activityData = property:Get(obj_ActivityPlay, null)

	    local func = tolua.getmethod(typeof('WaterBell.ProjX.Data.Entity.ActivityPlayModeData'), 'GetModeType')
	    local modeType = func:Call(obj_activityData)
	    property:Destroy()

	    if modeType:ToInt() == 3 then

	    	local property = tolua.getproperty(typeof('WaterBell.ProjX.Data.Entity.ActivityPlayModeData'), 'Floor')
		    local Floor = property:Get(obj_activityData,null)
		    property:Destroy()
    		PatchModel.SelectLevelDetail_ActivityDataFloor = Floor
    	end
    end
    if UIMapPointPatchFristLevel then
        instanceId = tostring(instanceId)
        instanceId = tonumber(instanceId)
        if math.floor(instanceId / 100  ) == math.floor(UIMapPointPatchFristLevel / 100  ) then
            obj.transform:Find('Center/LevelDetailPanel/InfoBox/Container/LevelInfo/Label_Index').gameObject:SetActive(false)
        end
        UIMapPointPatchFristLevel = nil
    end 
end

return this