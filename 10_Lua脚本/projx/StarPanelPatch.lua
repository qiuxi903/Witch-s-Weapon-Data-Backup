local this = {}

local obj_CurrentServantStarInfo
local property_StarLevel

local goRecoveryBtn
local maxLv

local check

function this:OnEnable( obj )
	-- body
	check = true
end

function this:Start( obj )
	-- body
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')        

    local obj_CurrentServantStarInfoView = obj.transform:GetComponent('CurrentServantStarInfoView')

    local type_CurrentServantStarInfoViewBase = typeof('CurrentServantStarInfoViewBase')

    local property_CurrentServantStarInfo = tolua.getproperty(type_CurrentServantStarInfoViewBase, 'CurrentServantStarInfo')
    obj_CurrentServantStarInfo = property_CurrentServantStarInfo:Get(obj_CurrentServantStarInfoView, null)

    local type_CurrentServantStarInfoViewModel = typeof('CurrentServantStarInfoViewModel')
    property_StarLevel = tolua.getproperty(type_CurrentServantStarInfoViewModel, 'StarLevel')

    goRecoveryBtn = obj.transform:Find('right/goRecoveryBtn').gameObject

    maxLv = ManagerCsv.GetInstance():GetConstant("CHARACTER_MAX_STAR").value3

	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDisable( obj )
	-- body
	check = false
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)

	 obj_CurrentServantStarInfo:Destroy()
	 obj_CurrentServantStarInfo = nil
	 property_StarLevel:Destroy()
	 property_StarLevel = nil
	 goRecoveryBtn = nil
	 maxLv = nil
	 check = nil
end

function this.UpdateBeat( ... )
	-- body
	if not check then
		return
	end

	if property_StarLevel:Get(obj_CurrentServantStarInfo, null) == maxLv then
		if not goRecoveryBtn.activeSelf then
			goRecoveryBtn:SetActive(true)
		end
	end
end

return this