local this = {}

local obj_ActivityGameModeOne
local method_OnSliderChange
local field_multModeSlider

function this:Start( obj )
	-- body
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')        
    local bitor = bit.bor(0,1,2,4,8,16,32,64,256,512,1024,2048,4096,8192,16384,32768)

    --WaterBell.ProjX.View.Panel.ActivityGameModeOne.OnSliderChange
    obj_ActivityGameModeOne = obj:GetComponent('ActivityGameModeOne')

    local type_ActivityGameModeOne = typeof('WaterBell.ProjX.View.Panel.ActivityGameModeOne')
    method_OnSliderChange = tolua.gettypemethod(type_ActivityGameModeOne, 'OnSliderChange',bitor,System.Type.DefaultBinder,{typeof('WaterBell.ProjX.View.Panel.ActivityMultModeSlider')},nil)

    field_multModeSlider = tolua.getfield(type_ActivityGameModeOne, 'multModeSlider')
    
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body

	 obj_ActivityGameModeOne = nil
	 method_OnSliderChange:Destroy()
	 method_OnSliderChange = nil
	 field_multModeSlider:Destroy()
	 field_multModeSlider = nil

	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
    method_OnSliderChange:Call(obj_ActivityGameModeOne,field_multModeSlider:Get(obj_ActivityGameModeOne))
end

return this