local this = {}

function this:OnEnable( obj )
	-- body
	local function Check( ... )
		-- body
	
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')  

    local obj_CTLD_WeaponIcon = obj:GetComponent('CTLD_WeaponIcon')

    local t_CTLD_WeaponIcon = typeof('WaterBell.ProjX.View.Panel.CTLD_WeaponIcon')

    local t_CTLD_WeaponButton = typeof('WaterBell.ProjX.View.Panel.CTLD_WeaponButton')

    local t_WeaponButtonItem = typeof('WaterBell.ProjX.View.Panel.WeaponButtonItem')
    local field_weaponData = tolua.getfield(t_WeaponButtonItem,'weaponData')

    local field_weapon = tolua.getfield(t_CTLD_WeaponIcon, 'weapon')
    local field_weapon2 = tolua.getfield(t_CTLD_WeaponIcon, 'weapon2')
    local field_weapon3 = tolua.getfield(t_CTLD_WeaponIcon, 'weapon3')
    local field_weapon4 = tolua.getfield(t_CTLD_WeaponIcon, 'weapon4')

    local t_obj_weapon = {}
    table.insert(t_obj_weapon,field_weapon:Get(obj_CTLD_WeaponIcon))
    table.insert(t_obj_weapon,field_weapon2:Get(obj_CTLD_WeaponIcon))
    table.insert(t_obj_weapon,field_weapon3:Get(obj_CTLD_WeaponIcon))
    table.insert(t_obj_weapon,field_weapon4:Get(obj_CTLD_WeaponIcon))

    local t_CTLD_WeaponButtonData = typeof('WaterBell.ProjX.View.Panel.CTLD_WeaponButtonData')

    local t_WeaponButtonItemData = typeof('WaterBell.ProjX.View.Panel.WeaponButtonItemData')
    local field_isUnlock = tolua.getfield(t_WeaponButtonItemData, 'isUnlock')

    local t_UIPanelBase = typeof('WaterBell.ProjX.View.Panel.UIPanelBase')
    local property_Data = tolua.getproperty(t_UIPanelBase, 'Data')

    local t_UIDataBase = typeof('WaterBell.ProjX.View.Panel.UIDataBase')
    local field_id = tolua.getfield(t_UIDataBase, 'id')  

    local field_derbisNumLabel = tolua.getfield(t_CTLD_WeaponButton, 'derbisNumLabel')
    local field_debrisNum = tolua.getfield(t_CTLD_WeaponButtonData,'debrisNum')
    local field_limtNum = tolua.getfield(t_CTLD_WeaponButtonData,'limtNum')

	for i,v in ipairs(t_obj_weapon) do
    	local obj_CTLD_WeaponButton = v
    	local Data = property_Data:Get(obj_CTLD_WeaponButton,null)

    	if Data then
    		local weaponData = field_weaponData:Get(obj_CTLD_WeaponButton)
	    	local id = field_id:Get(weaponData)
	    	local isUnlock = field_isUnlock:Get(weaponData)
	    	local derbisNumLabel = field_derbisNumLabel:Get(obj_CTLD_WeaponButton)
	    	local debrisNum = field_debrisNum:Get(Data)
	    	local limtNum = field_limtNum:Get(Data)
	    	local str = derbisNumLabel.text
	    	local str2
	    	local csvData = ManagerCsv.GetInstance():GetServantWeapon(id)
	    	if isUnlock then
	    		derbisNumLabel.text = string.split(str,'/')[1] .. '/' .. csvData.promote1_item_num3
	    	end
	    	
	    end
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