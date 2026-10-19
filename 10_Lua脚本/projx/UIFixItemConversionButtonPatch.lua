local this = {}

function this:Start( obj )
	-- body
	--2019-03-23 11:12:30
	--国服不要转化按钮
	obj:SetActive(false)

	-- require 'tolua.reflection'          
	-- tolua.loadassembly('Assembly-CSharp') 
	-- --测试是否能拿到接口
	-- --10010501,1701050102
	-- local ServantInfo = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetServantInfo()
	-- local t = typeof('WaterBell.ProjX.Data.Entity.ObservableServantWeapon')
 --    local property = tolua.getproperty(t, 'IsUnLock')
 --    local t = typeof('WaterBell.ProjX.Data.Entity.ServantCore')

 --    local func = tolua.getmethod(t, 'GetObservableServantWeaponByID',typeof('System.Int64'),typeof('System.Int64'))
 --    local ObservableServantWeapon = func:Call(ServantInfo,10010501,1701050102)
 --    local IsUnLock = property:Get(ObservableServantWeapon, null)
 --    if not IsUnLock then
 --    	obj:SetActive(false)
 --    	return
 --    end
	-- UIEventListener.Get(obj).onClick = function ( ... )
	-- 	-- body
	-- 	UIFixItemConversion:show()
	-- end
end

return this