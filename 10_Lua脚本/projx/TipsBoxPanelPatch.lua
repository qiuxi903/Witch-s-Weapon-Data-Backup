local this = {}

local check

local Label
local CatchStr

function this:OnEnable( obj )
	-- body
	check = true
end

function this:OnDisable( obj )
	-- body
	check = false
end

function this:Start( obj )
	-- body
	Label = obj.transform:Find('Container/Label'):GetComponent('UILabel')
	CatchStr = ""
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	Label = nil
	CatchStr = nil

	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
	if not check then
		return
	end

	if CatchStr ~= Label.text then
		Label.text = ManagerCsv.GetInstance():GetNameStatic(Label.text)
		CatchStr = Label.text
	end
end

return this