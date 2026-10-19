local this = {}
function this:Awake( obj )
	-- body
	print("Awake:"..obj.name)
end

function this:OnEnable( obj )
	-- body
	print("OnEnable:"..obj.name)
end

function this:Start( obj )
	-- body
	print("Start:"..obj.name)
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDisable( obj )
	-- body
	print("OnDisable:"..obj.name)
end

function this:OnDestroy()
	-- body
	print("OnDestroy")
	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
end

return this