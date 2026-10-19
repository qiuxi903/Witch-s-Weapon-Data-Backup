UIActivitiesRule = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesRule",AssetsManager.AssetsType.LuaAssets3)

local this = UIActivitiesRule

function this.init( ... )
	-- body
	local str = ...

	UIEventListener.Get(this.page.transform:Find('Close').gameObject).onClick = function ( ... )
		-- body
		this:destory()
	end

	this.page.transform:Find('ScrollView/Grid/Label'):GetComponent('UILabel').text = str
end