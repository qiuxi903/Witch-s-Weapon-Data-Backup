local this = {}

function this:OnDestroy()
	-- body
	--print("OnDestroy")
	--WaterBell.ProjX.View.UIFrame.UISceneManager.getInstance():Dispose()
	local a = WaterBell.ProjX.View.UIFrame.UISceneManager.getInstance():GetUIScene(16)
	System.Type.GetType("WaterBell.ProjX.View.UIFrame.UIScene"):InvokeMember("Reset", 256,System.Type.DefaultBinder, a, nil);
end

return this