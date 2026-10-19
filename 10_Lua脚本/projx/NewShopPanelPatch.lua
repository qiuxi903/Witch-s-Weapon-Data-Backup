local this = {}

local NewShopPanelControl
local currentBigSetID
local Helper

local Check
local tempID

function this:OnEnable( obj )
	-- body
	Check = true

    local function Cal( ... )
    	-- body
    	--判断当前时间是否满足开放 menuSub_47000027 menuSub_47000029
	    if Utils.getSeverTime() < 1570032000 then
	    	local BottomLeft = obj.transform:Find('btnList/BottomLeft')
	    	local child
	    	for i=1,BottomLeft.childCount do
	    		child = BottomLeft:GetChild(i - 1)
	    		if child.name == 'menuSub_47000027' or child.name == 'menuSub_47000029' then
	    			child.gameObject:SetActive(false)
	    		end
	    	end
	    end
    end
    local timer =  Timer.New(Cal, 0.1, 1, true)
	timer:Start()
end

function this:Start( obj )
	-- body
	Helper = obj.transform:Find('Helper').gameObject
	Helper:SetActive(false)
	local channel_group = ManagerCsv.channel_group
	if channel_group ~= 60 then
		return
	end

	NewShopPanelControl = obj:GetComponent('NewShopPanelControl')

	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp')

    --公有字段
    currentBigSetID = tolua.getfield(typeof('NewShopPanelControl'), 'currentBigSetID')

    

    local str0 = ManagerCsv.GetInstance():GetNameStatic('starshop_0')
    local str1 = ManagerCsv.GetInstance():GetNameStatic('starshop_1')
    local str2 = ManagerCsv.GetInstance():GetNameStatic('starshop_2')

    local str = str0 .. '\n' .. str1 .. '\n' .. str2

    UIEventListener.Get(Helper).onClick = function ( ... )
    	-- body
    	UIHelpPanel:show(str)
    end

	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDisable( obj )
	-- body
	Check = false
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
	NewShopPanelControl = nil
	currentBigSetID:Destroy()
	currentBigSetID = nil
	Helper = nil
end

function this.UpdateBeat( ... )
	-- body
	if not Check then
		return
	end
	tempID = tostring(currentBigSetID:Get(NewShopPanelControl))
	if tempID == '47000019' or tempID == '47000020' then
		if not Helper.activeSelf then
			Helper:SetActive(true)
		end
	else
		if Helper.activeSelf then
			Helper:SetActive(false)
		end
	end
end

return this