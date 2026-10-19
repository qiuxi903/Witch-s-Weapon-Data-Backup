--日服 1197 hack 用于显示分享按钮
--路径 
--GetWeaponAndSvPanel(Clone)___Temp_GetWeaponAndSvPanel___UnloadOnClose
--GetServantAnimPanel
local this = {}

local lock
local Desc
local isTop
local timeCount
local funcShow

function this:OnEnable( obj )
	-- body
	lock = false
end

function this:OnDisable( obj )
	-- body
	lock = true
end

function this:Start( obj )
	-- body
	Desc = obj.transform:Find('Panel/Desc/Desc')

	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')
    local t = typeof('UIShare')
    --公有静态方法
    funcShow = tolua.getmethod(t, 'Show',typeof('System.Int32'))

	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
	lock = nil
	 Desc = nil
	 isTop = nil
	 timeCount = nil

    funcShow:Destroy()
    funcShow = nil
end

function this.UpdateBeat( ... )
	-- body
	if lock then
		return
	end
	--到达顶点的时机
	--print(Desc.localPosition.y)
	if Desc.localPosition.y == -110 then
		isTop = true
		timeCount = 0
	end
	if isTop then
		--下降到底
		if Desc.localPosition.y == -358 then
			lock = true
			funcShow:Call(1)
		end
	end
end

return this