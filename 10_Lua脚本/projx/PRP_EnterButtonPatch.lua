--功能：查看活动剧情的按钮关闭点击，变灰色
--时间：2019年2月27日 13:02:32
--路径：UI Root (3D)/PlotReviewPanel(Clone)___Temp_PlotReview___UnloadOnClose/Scroll View/Grid/PRP_EnterButton(Clone)

local this = {}
function this:Start( obj )
	-- body
	local name = obj.transform:Find('Image'):GetComponent('UISprite').spriteName
	-- if name == 'Entrance-activity' then
	-- 	obj.transform:Find('LockIcon').gameObject:SetActive(true)
	-- 	local collider = obj:GetComponent('BoxCollider')
	-- 	collider.enabled = false
	-- end

	if name == 'Entrance-feeder' then
		--支线剧情开放，跳转到支线，临时德皇的支线
		local ButtonEx = obj.transform:GetComponent('ButtonEx')
		ButtonEx.onClick = nil

		require 'tolua.reflection'          
	    tolua.loadassembly('Assembly-CSharp-firstpass')
	    tolua.loadassembly('Assembly-CSharp')

	    local SubLineLoader = obj.transform.parent.parent.parent:Find('SubLineLoader'):GetComponent('LoadUIPanelSingle')

	    local t = typeof('WaterBell.ProjX.View.Panel.LoadUIPanelSingle')
	    local GetUIPanelSingle = tolua.getmethod(t, 'GetUIPanelSingle',typeof('AssetsManager+AssetsType'))

	    local t = typeof('WaterBell.ProjX.View.Panel.PRP_DetailListPanel')
	    local OpenPanel = tolua.getmethod(t, 'OpenPanel',typeof('System.Int32'))

		UIEventListener.Get(obj).onClick = function ( ... )
			-- body
			OpenPanel:Call(GetUIPanelSingle:Call(SubLineLoader,AssetsManager.AssetsType.UIPrefab),2)
		end
	end
end
return this