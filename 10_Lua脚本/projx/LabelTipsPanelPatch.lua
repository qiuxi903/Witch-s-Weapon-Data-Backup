--2019年2月23日 14:55:10
--用于隐藏未翻译文本---没有目标
--路径---BattleUIAddictive/UI Root (3D)/BattleUI/LabelTipsPanel(Clone)

local this = {}

function this:Start( obj )
	-- body
	obj:GetComponent('UIPanel').alpha = 0
end

return this