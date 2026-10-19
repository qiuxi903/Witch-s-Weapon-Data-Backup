local this = {}
local UIFrame = WaterBell.ProjX.View.UIFrame
local t = 	{
			UIFrame.UISceneID.ACTIVITY_PLAY_ROOT_SCENE:ToInt(),
			UIFrame.UISceneID.ACTIVITY_PLAY_RULE_5_LEVEL_SCENE:ToInt(),
			}

local GoMainBtn
local curObj
local PRP_ActivityDetail

local ActivityStory

function this:Start( obj )
	-- body
	curObj = obj
	if curObj.name ~= 'activityCurrency2' then
		return
	end

	GoMainBtn = obj.transform.parent.parent.parent.parent:Find('TopLeft/comeback/GoMainBtn').gameObject

	UpdateBeat:Add(this.UpdateBeat,this)
end


function this:OnDestroy()
	-- body
	 GoMainBtn = nil
	 curObj = nil
	 ActivityStory = nil
	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
	if UIFrame.UISceneManager.getInstance():CheckSceneIsShow(t[1]) then
		if not curObj.activeSelf then
			ActivityStory = curObj.transform.parent:Find('ActivityStory')

			if not ActivityStory then
				curObj:SetActive(true)
			end
		end
		if GoMainBtn.activeSelf then
			GoMainBtn:SetActive(false)
		end
	elseif UIFrame.UISceneManager.getInstance():CheckSceneIsShow(t[2]) then
		if GoMainBtn.activeSelf then
			GoMainBtn:SetActive(false)
		end
	end
end

return this