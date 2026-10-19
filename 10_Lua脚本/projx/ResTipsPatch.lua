local this = {}

function this:Start( obj )
	-- body
	--只检测抽卡结果界面
	if UISceneManager.getInstance():GetCurrentUISceneState().SceneID ~= UISceneID.LOTTERY_UNIVERSE_SCENE:ToInt() then
		return
	end
	
	this.AcquiringWay = obj.transform:Find('Container/AcquiringWay').gameObject
	this.AcquiringWay:SetActive(false)

	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')   
	local field = tolua.getfield(typeof('WaterBell.ProjX.View.Panel.ResTips'), 'isAutoClose')
	field:Set(obj:GetComponent('ResTips'), true)
    field:Destroy() 
	--UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	--UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
	
end

return this