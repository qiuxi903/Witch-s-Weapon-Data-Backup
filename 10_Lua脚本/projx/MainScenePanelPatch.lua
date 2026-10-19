local this = {}

local UIFrame = WaterBell.ProjX.View.UIFrame
local t = 	{
			UIFrame.UISceneID.MAIN_SCENE_NEW:ToInt(),
			}
local check
local cur

function this:OnEnable( obj )
	-- body
	check = true
end

function this:Start( obj )
	-- body
	cur = obj
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDisable( obj )
	-- body
	check = false
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
	check = nil
	cur = nil
end

function this.UpdateBeat( ... )
	-- body
	if not check then
		return
	end
	--检测是否存在不应该存在的界面，如果存在关闭一下
	for i,v in ipairs(t) do
		if UIFrame.UISceneManager.getInstance():CheckSceneIsShow(v) then
			--UIFrame.UISceneManager.getInstance():Hide(v)
			if cur.activeSelf then
				cur:SetActive(false)
			end
		end
	end
end

return this