--2019-05-08 16:16:15 jp1198sp2
--用于显示UserSettingPanelPatch界面jpBind的hack显示

local this = {}

local UserType
local jpBindBtn
local Table

function this:Awake( obj )
	-- body
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')        
    local field = tolua.getfield(typeof('WaterBell.ProjX.Data.NetIO.ProtocolConstant'), 'UserType')
    UserType = field:Get(null)
    field:Destroy() 

    jpBindBtn = obj.transform:Find('jpBindBtn').gameObject
    Table = obj.transform:GetComponent('UITable')
end

function this:OnEnable( obj )
	-- body
    UserType = tonumber(UserType)
    --2 3 8 9 10 11
    local tag = UserType == 2 or UserType == 3 or UserType == 8 or UserType == 9 or UserType == 10 or UserType == 11
    jpBindBtn:SetActive(tag)
    Table:Reposition()
end

function this:OnDestroy()
	-- body

	 UserType = nil
	 jpBindBtn = nil
	 Table = nil
end

return this