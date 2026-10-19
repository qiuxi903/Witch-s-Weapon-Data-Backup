local this = {}

function this:OnEnable( obj )
	-- body
	local function Check( ... )
		-- body
	
    	require 'tolua.reflection'          
        tolua.loadassembly('Assembly-CSharp')  

        local obj_CTLD_WeaponButton = obj:GetComponent('CTLD_WeaponButton')
        local t_CTLD_WeaponButton = typeof('WaterBell.ProjX.View.Panel.CTLD_WeaponButton')

        local field_derbisNumLabel = tolua.getfield(t_CTLD_WeaponButton,'derbisNumLabel')
        local derbisNumLabel = field_derbisNumLabel:Get(obj_CTLD_WeaponButton)

        local t_UIDataBase = typeof('WaterBell.ProjX.View.Panel.UIDataBase')
    	local field_id = tolua.getfield(t_UIDataBase, 'id')  

    	local t_WeaponButtonItem = typeof('WaterBell.ProjX.View.Panel.WeaponButtonItem')
    	local field_weaponData = tolua.getfield(t_WeaponButtonItem,'weaponData')

    	local weaponData = field_weaponData:Get(obj_CTLD_WeaponButton)
    	local id = field_id:Get(weaponData)
    	if tonumber(tostring(id)) ~= 0 then
	    	local csvData = ManagerCsv.GetInstance():GetServantWeapon(id)
	        local str = derbisNumLabel.text
	        derbisNumLabel.text = string.split(str,'/')[1] .. '/' .. csvData.promote1_item_num3
	    end
    end 

    Timer.New(function ()
		if not obj:Equals(nil) then
			Check()
		end
			-- body
	end, 0.1, 1, true):Start()
end

return this