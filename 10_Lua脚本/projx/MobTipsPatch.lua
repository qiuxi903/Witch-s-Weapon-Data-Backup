--2019-04-24 13:56:27 
--日服1198sp1
--用于给大活动关卡详情敌人数据等级调整
--MobTips(Clone)

local this = {}

function this:Start( obj )
	-- body
	if not PatchModel.SelectLevelDetail_ActivityDataFloor then
		return
	end
	local Level = obj.transform:Find('Container/Label_Level'):GetComponent('UILabel')

	local CSVActivityGameData = CSVPool.ActivityGameData()
	for i=1,#CSVActivityGameData do
	 	if CSVActivityGameData[i].ID == PatchModel.SelectLevelDetail_ActivityDataFloor then
	 		Level.text = 'Lv.' .. CSVActivityGameData[i].mob_level
	 		return
	 	end
	 end 
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
end

return this