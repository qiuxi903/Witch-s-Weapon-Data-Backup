--2019-04-24 17:07:36 jp 1197sp1
--在商店钻石标签页显示的时候 刷新一个钻石数量
--NewShopPanel(Clone)___Temp_NewShopPanel___UnloadOnClose
-- Center
-- View
-- DiamondScrollView

local this = {}

local price1
local lock
function this:Awake( obj )
	-- body
	local parent = obj.transform.parent.parent:Find('price1')
	price1 = {}
	price1.obj = parent.gameObject
	price1.Label = parent:Find('Label'):GetComponent('UILabel')
	price1.img = parent:Find('img').gameObject
	price1.Label1 = parent:Find('Label (1)').gameObject
end

function this:OnEnable( obj )
	-- body
	price1.obj:SetActive(true)
	price1.img:SetActive(false)
	price1.Label1:SetActive(true)
	lock = false
end

function this:Start( obj )
	-- body
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDisable( obj )
	-- body
	lock = true
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)

	price1 = nil
	lock = nil
end

function this.UpdateBeat( ... )
	-- body
	if lock then
		return
	end
	--暂时一直刷把
	price1.Label.text = tonumber(tostring(UserInfo.GetInstance():GetPlayer().RealRmb))
end

return this