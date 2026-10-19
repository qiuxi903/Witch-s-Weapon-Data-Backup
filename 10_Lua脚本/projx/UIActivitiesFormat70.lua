--阶段结合活动，包含多个阶段的集合活动
UIActivitiesFormat70 = {}

local this = UIActivitiesFormat70

local curFormat
function this:show( ... )
	-- body
	local data = ...

	local willData = UIActivitiesModel.GetServerDataAllByID( data.activity_items[data.SubStep].argument7 )
	willData.NextActivityID = data.activity_items[data.SubStep].argument8
	willData.Camp = UIActivitiesModel.GetServerDataAllByID( data.activity_items[1].argument7 ).Camp
	if not willData then
		print('阶段结合活动,当前子活动不存在！！！')
	end
	curFormat = _G['UIActivitiesFormat' .. willData.panel_id]
	curFormat:show(willData)
end

function this:destory( ... )
	-- body
	curFormat:destory()
end

function this:hide( ... )
	-- body
	curFormat:hide()
end