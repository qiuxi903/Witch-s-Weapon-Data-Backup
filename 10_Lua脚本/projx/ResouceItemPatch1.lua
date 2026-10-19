local this = {}

local curObj
local value
local drawItemID
local drawItemIDReal
function this:Start( obj )
	-- body
	curObj = obj
	drawItemIDReal = ManagerCsv.GetInstance():GetConstant("RMB_DRAW_ITEM_REAL").value2
	drawItemID = ManagerCsv.GetInstance():GetConstant("RMB_DRAW_ITEM").value2;
	value = obj.transform:Find('value'):GetComponent('UILabel')

	UpdateBeat:Add(this.UpdateBeat,this)
end


function this:OnDestroy()
	-- body
	 curObj = nil
	 value = nil
	 drawItemID = nil
 	drawItemIDReal = nil
	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
	if curObj.name ~= 'drawItem' then
		return
	end
	if value.gameObject.activeSelf then
		local num = UIActivitiesModel.GetOrChangeItemOrEquipNum(GlobalEnum.ResType.Item,drawItemID)
		num = num + UIActivitiesModel.GetOrChangeItemOrEquipNum(GlobalEnum.ResType.Item,drawItemIDReal)
		if value.text ~= tostring(num) then
			value.text = num
		end
	end
end

return this