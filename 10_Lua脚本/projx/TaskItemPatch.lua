--2019-06-10 14:32:45
--jp1198sp6
--用于修复任务面板进度数字显示的正确
--TaskItem

local this = {}
local conditionCount
local objSelf
function this:Start( obj )
	-- body
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')   
    objSelf = obj.transform:GetComponent('QuestInfoView')
	conditionCount = obj.transform:Find('btn/conditionCount'):GetComponent('UILabel')

    UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
	conditionCount = nil

	objSelf = nil
end

function this.UpdateBeat( ... )
	-- body
	if not conditionCount.gameObject.activeSelf then
		return
	end
	if conditionCount.text ~= '' then
		return
	end

    local property = tolua.getproperty(typeof('QuestInfoViewBase'), 'QuestInfo')
    local QuestInfo = property:Get(objSelf, null)

    local t = typeof('QuestInfoViewModel')
    property = tolua.getproperty(t, 'Info')
    local Info = property:Get(QuestInfo, null)

    property = tolua.getproperty(t, 'Status')
    local Status = property:Get(QuestInfo, null)

    property = tolua.getproperty(t, 'Meta')
    local Meta = property:Get(QuestInfo, null)

	local t = typeof('QuestData')
    property = tolua.getproperty(t, 'Type')
    local Type =  property:Get(Info, null)

    property = tolua.getproperty(t, 'Argu1')
    local Argu1 =  property:Get(Info, null)

    local CSVData = CSVPool.AchievementConfig()
    local arg1
    local temp
    for i=1,#CSVData do
    	temp = CSVData[i]
    	if temp.ID == Type then
    		arg1 = temp.arg1
    		break
    	end
    end

    if arg1 == '' then
    	return
    end
    local text
    if Status == -1 then
    	text = "[FF0000]" .. Meta .. "[-]" .. "[AFAFAF]" .. "/" .. Argu1 .. "[-]"
    else
    	text = "[FFFFFF]" .. Argu1 .. "[-]" .. "[AFAFAF]" .. "/" .. Argu1 .. "[-]";
    end

    conditionCount:GetComponent('UILabel').text = text

    property:Destroy()
    property = nil
end

return this