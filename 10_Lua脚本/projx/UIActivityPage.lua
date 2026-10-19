--- 2018.08.15
--- add by gus
--- 活动 页面
UIActivityPage = {}
UIActivityPageView = nil

--- 显示 活动 页面
function UIActivityPage.show(...)
	local data = ...
	--- 关闭上一个
	UIActivityPage.close(false)
	--- 签到
	if data.id == 17 or data.id == 1 then
		UIActivityPageView = BaseView:new("UI/Prefab/UIPrefab/UIActivity/","UIActivityPageSign")
		UIActivityPageSign.show(UIActivityPageView, data)
	end
	--- 通关
	if data.id == 18 then
		UIActivityPageView = BaseView:new("UI/Prefab/UIPrefab/UIActivity/","UIActivityPageComplete")
		UIActivityPageComplete.show(UIActivityPageView, data)
	end
	--- 礼包
	if data.id == 19 then
		UIActivityPageView = BaseView:new("UI/Prefab/UIPrefab/UIActivity/","UIActivityPageGift")
		UIActivityPageGift.show(UIActivityPageView, data)
	end
	
	-- if data.id == 54 then
	-- 	UIActivityPageView = BaseView:new("UI/Prefab/UIPrefab/UIActivity/","UIActivityPageCompleteNew")
	-- 	UIActivityPageCompleteNew.show(UIActivityPageView, data)
	-- end
end


--- 显示 活动 页面
function UIActivityPage.close(isAnim)
	if nil ~= UIActivityPageView then
		if nil ~= UIActivityPageView.animClose and isAnim then
			UIActivityPageView.animClose()
		else
			UIActivityPageView:destory()
		end
		UIActivityPageView = nil

		--UIActivityButton.updateRed()
		MainScenePanelAdd.UpdateRed()
	end
end

--- 添加消息侦听
--- GUtilListener.addEventListener("ServerDataChatMngrListener", UIChatSYSHD)