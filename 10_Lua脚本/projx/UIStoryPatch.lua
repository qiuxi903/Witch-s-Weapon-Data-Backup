local this = {}



function this:Start( obj )
	-- body
	local BtnHelp = obj.transform:Find('BottomLeft/BtnHelp')
	UIEventListener.Get(BtnHelp.gameObject).onClick = function ( ... )
		-- body
		UIActivitiesRule:show(ManagerCsv.GetInstance():GetNameStatic('UISTORY_HELP'))
	end
end

return this