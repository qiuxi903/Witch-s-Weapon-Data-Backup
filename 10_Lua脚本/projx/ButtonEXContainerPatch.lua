local this = {}
local MailBtn
function this:Awake( obj )
	-- body
	MailBtn = obj.transform:Find('MailBtn').gameObject
end

function this:Start( obj )
	-- body
	UpdateBeat:Add(this.UpdateBeat,this)
end
function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
	MailBtn = nil
end

function this.UpdateBeat( ... )
	-- body
	if MailBtn == nil or MailBtn:Equals(nil) then
		UpdateBeat:Remove(this.UpdateBeat,this)
		return
	end
	MailBtn:SetActive(WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetMails().NewMailNum > 0)
end

return this