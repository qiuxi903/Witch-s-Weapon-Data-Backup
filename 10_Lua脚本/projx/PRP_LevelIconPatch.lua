--补丁用于修复剧情连载中报错
--路径：MainScenePanel(Clone)/LeftTop/Hero/StoryContainer/StoryMiniPanel/Detail/GameObject/Scroll View/Grid/PRP_LevelIcon(Clone)
local this = {}
local mBoxCollider
local Tips

function this:Start( obj )
	-- body
	mBoxCollider = obj:GetComponent('BoxCollider')
	Tips = obj.transform:Find('Tips').gameObject
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	mBoxCollider = nil
	Tips = nil
	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
	mBoxCollider.enabled = not Tips.activeSelf
end

return this