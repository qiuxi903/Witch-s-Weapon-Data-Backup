local this = {}

local week
local isHide
local Container
local Label
local Label_Name
local subName

function this:OnEnable( obj )
	-- body
	--[619AC7FF]魔能泄露 难度1[-][D1D5D8FF](剩余[-]1/2[D1D5D8FF]次)[-]
	Container = obj.transform:Find('Container')
	Label = Container:Find('Label_Name'):GetComponent('UILabel')

	local week = os.date("%w",Utils.getSeverTime())
	week = tonumber(week)

	isHide = false
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDisable()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
	week = nil
	isHide = nil
	Container = nil
	Label = nil
	Label_Name = nil
	subName = nil
end

function this.UpdateBeat( ... )
	-- body
	--[[
	if isHide then
		return
	end
	]]
	isHide = false
	Label_Name = Label.text
	subName = string.sub(Label_Name,10,22)
	if string.find(subName, '首领降临') then
		if week == 3 or week == 6 or week == 0 then
		else
			isHide = true
		end
	elseif string.find(subName, '乱战无双') then
		
	elseif string.find(subName, '钢铁之躯') then
		if week == 1 or week == 4 or week == 0 then
		else
			isHide = true
		end
	elseif string.find(subName, '魔能泄露') then
		if week == 2 or week == 5 or week == 0 then
		else
			isHide = true
		end
	end

	if isHide then
		Container:Find('MultSweepButton').gameObject:SetActive(false)
		Container:Find('SweepButton').gameObject:SetActive(false)
		Label_Name = string.gsub (Label_Name, '%(.*%)', '暂未开启')
		Label.text = Label_Name
	end
end

return this