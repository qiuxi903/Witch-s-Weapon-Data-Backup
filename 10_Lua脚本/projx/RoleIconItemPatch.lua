--2019-04-24 13:56:27 
--日服1198sp1
--用于大活动三关卡详情界面敌人等级修正
--RoleIconItem(Clone)

--需通过 SelectLevelDetailPatch 的检测才能生效

local this = {}

function this:Start( obj )
	-- body
	if not PatchModel.SelectLevelDetail_ActivityDataFloor then
		return
	end
	local Level = obj.transform:Find('Bg/Level'):GetComponent('UILabel')

	local CSVActivityGameData = CSVPool.ActivityGameData()
	for i=1,#CSVActivityGameData do
	 	if CSVActivityGameData[i].ID == PatchModel.SelectLevelDetail_ActivityDataFloor then
	 		Level.text = 'Lv.' .. CSVActivityGameData[i].mob_level
	 		return
	 	end
	end
end

return this