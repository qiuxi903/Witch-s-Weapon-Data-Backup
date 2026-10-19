local this = {}
function this:Awake( obj )
	-- body

	-- var DailyInstance = UserInfo.GetInstance().GetProgress().GetLevelByID(Convert.ToInt64(extra.LevelEvent[eventCount].Value[i]));

 --    //UtilLog.LogError("当前日常关卡状态  ： " + DailyInstance.UnLocok);
 --    if (!DailyInstance.UnLocok)
 --    {
 --        //UtilLog.LogError("日常关卡内存解锁! ");
 --        //解锁日常
 --        DailyInstance.UnLocok = true;

 --    }
 	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')
--     7-1  3110007001
-- 7-10  3110007010
-- 8-1  3110008001
-- 8-10  3110008010
-- 9-1  3110009001
-- 9-10  3110009010  
    local tLevel = 
    {
    	{3110006010,3110007001,33},
    	{3110007010,3110008001,36},
    	{3110008010,3110009001,40},
	}

 	local obj_Progress = UserInfo.GetInstance():GetProgress()
 	local func = tolua.getmethod(typeof('WaterBell.ProjX.Data.Entity.Progress'), 'GetLevelByID',typeof('System.Int64'))
    local property
 	for i=1,#tLevel do
 		if AwardUtils.GetLevelIsPassByID(tLevel[i][1]) and (UserInfo.GetInstance():GetPlayer().Level >= tLevel[i][3]) and not AwardUtils.GetLevelIsPassByID(tLevel[i][2]) then
	 		local obj_ObservableSingleLevel = func:Call(obj_Progress,tLevel[i][2])
		    if obj_ObservableSingleLevel then
			    property = tolua.getproperty(typeof('WaterBell.ProjX.Data.Entity.ObservableSingleLevel'), 'UnLocok')
			    property:Set(obj_ObservableSingleLevel, false, null)
			    local UnLocok = property:Get(obj_ObservableSingleLevel, null)
			    
			    if not UnLocok then
			    	property:Set(obj_ObservableSingleLevel, true, null)
			    end
			end
	 	end
    end
    if func then
    	func:Destroy()
		func = nil
    end
    if property then
	    property:Destroy()
	    property = nil
    end
end

return this