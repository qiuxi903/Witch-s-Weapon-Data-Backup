local ActivityGameModeFourTipsPatch = {}
local this = ActivityGameModeFourTipsPatch

function this:Start( obj )
	UIEventListener.Get(obj.transform:Find('Button_Help').gameObject).onClick = 
	function()
		obj.transform:Find('HelpPanel').gameObject:SetActive(true)
	end

	UIEventListener.Get(obj.transform:Find('HelpPanel/closeButton').gameObject).onClick = 
	function()
		obj.transform:Find('HelpPanel').gameObject:SetActive(false)
	end
end

return this