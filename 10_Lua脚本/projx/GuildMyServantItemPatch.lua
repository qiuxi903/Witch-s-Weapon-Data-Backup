local this = {}

function this:OnEnable( obj )
	-- body
	local function Check( ... )
		-- body
	
    	require 'tolua.reflection'          
        tolua.loadassembly('Assembly-CSharp')  

        local obj_GuildMyServantInfo = obj:GetComponent('GuildMyServantInfo')
        local t_GuildMyServantInfo = typeof('GuildMyServantInfo')

        local field_wpWidgets = tolua.getfield(t_GuildMyServantInfo,'wpWidgets')
        local wpWidgets = field_wpWidgets:Get(obj_GuildMyServantInfo)
        
        local t_SvWeaponItemInfo = typeof('SvWeaponItemInfo')
        local field_wID = tolua.getfield(t_SvWeaponItemInfo,'wID')

        local field_derbisNumLabel = tolua.getfield(t_SvWeaponItemInfo,'derbisNumLabel')

        for i=0,wpWidgets.Length -1 do
            local obj_SvWeaponItemInfo = wpWidgets[i]:GetComponent('SvWeaponItemInfo')
            local wID = field_wID:Get(obj_SvWeaponItemInfo)
            local derbisNumLabel = field_derbisNumLabel:Get(obj_SvWeaponItemInfo)

            if tonumber(tostring(wID)) ~= 0 then
                local str = derbisNumLabel.text
                local str2
                local csvData = ManagerCsv.GetInstance():GetServantWeapon(wID)
                derbisNumLabel.text = string.split(str,'/')[1] .. '/' .. csvData.promote1_item_num3
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