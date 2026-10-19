UIHelpPanel = BaseView:new("UI/Prefab/Help/","HelpPanel")

local this = UIHelpPanel

function this.clear( ... )
	-- body
end

local function clickClose( ... )
	-- body
	this:destory()
end

function this.init( ... )
	-- body
	local str = ...
	local closeButton = this.page.transform:Find('closeButton')
	UIEventListener.Get(closeButton.gameObject).onClick = clickClose

	local Daily = this.page.transform:Find('Scroll View/Daily'):GetComponent('UILabel')
	Daily.text = str
end