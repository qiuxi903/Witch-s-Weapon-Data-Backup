local this = {}

function this:Start( obj )
	-- body

	local Button_Yes = obj.transform:Find('Center/DialogBox/Button_Yes')

	local function Click( ... )
		-- body
     	require 'tolua.reflection'          
    	tolua.loadassembly('Assembly-CSharp')  

    	-- ///需要清理佣兵
	    --    if (UserInfo.GetInstance().GetGuild().GetHiredMercenaryListByMode(GlobalConstant.HIRE_MODE_AP) != null)
	    --    {
	    --        UserInfo.GetInstance().GetGuild().HiredMercenaryList[GlobalConstant.HIRE_MODE_AP].Clear();
	    --    }
    	local obj_GetGuild = UserInfo.GetInstance():GetGuild()

    	local func = tolua.getmethod(typeof('WaterBell.ProjX.Data.Entity.ObservablePlayerGuild'), 'GetHiredMercenaryListByMode',typeof('System.Int32'))
	    local obj_ListByMode = func:Call(obj_GetGuild,1)
	    if obj_ListByMode then
	    	obj_ListByMode:Clear()
	    end

		--    if (PlayModeMngr.GetInstance().GetCurrPlayMode() != null)
	    --    {
	    --        ((BasicActivityPlayMode)PlayModeMngr.GetInstance().GetCurrPlayMode()).ClearCache();
	    --    }

	    local func = tolua.getmethod(typeof('WaterBell.ProjX.Playmode.PlayModeMngr'),'GetInstance')
	    local obj_PlayModeMngr = func:Call()

	    local func = tolua.getmethod(typeof('WaterBell.ProjX.Playmode.PlayModeMngr'),'GetCurrPlayMode')
	    local obj_GetCurrPlayMode = func:Call(obj_PlayModeMngr)

	    if obj_GetCurrPlayMode then
	    	local func = tolua.getmethod(typeof('WaterBell.ProjX.Playmode.BasicActivityPlayMode'),'ClearCache')
	    	func:Call(obj_GetCurrPlayMode)
	    end

	    func:Destroy()
	    func = nil

	end

	UIEventListener.Get(Button_Yes.gameObject).onClick = Click
end

return this