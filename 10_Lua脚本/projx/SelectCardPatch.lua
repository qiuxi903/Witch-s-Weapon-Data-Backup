--选关界面没有魔女不能进入关卡
--SelectCard(Clone)
local this = {}

local disFightingBtn
local fightingBtn
local servant
local check

local hpWidget
local slider

local tag1
local tag2

function this:OnEnable( obj )
	-- body
	check = true
end

function this:Start( obj )
	-- body
	disFightingBtn = obj.transform:Find('Center/selectedView/Btn/Center/disFightingBtn').gameObject
	fightingBtn = obj.transform:Find('Center/selectedView/Btn/Center/fightingBtn').gameObject
	servant = {}
	local servantBox = obj.transform:Find('Center/selectedView/servantBox')
	for i=1,servantBox.childCount do
		servant[i] = servantBox:GetChild(i - 1).transform:Find('servant').gameObject
	end

	hpWidget = obj.transform:Find('TopRight/Panel/hpWidget')
	slider = hpWidget:Find('slider'):GetComponent('UISprite')

	--NetworkAlertUI.TryShowWarningTipBox(GlobalErrorMsgManager.GetInstance().GetItem(GlobalErrorCode.BATTLE_NEED_SELECT_SV));
	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDisable( obj )
	-- body
	check = false
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)

	  disFightingBtn = nil
	 fightingBtn = nil
	 servant = nil
	 check = nil
	 hpWidget = nil
	 slider = nil
	 tag1 = nil
	 tag2 = nil
end

function this.UpdateBeat( ... )
	-- body
	if not check then
		return
	end
	tag1 = false
	for i=1,#servant do
		if servant[i].activeSelf then
			tag1 = true
		end
	end
	tag2 = true
	if hpWidget.gameObject.activeSelf then
		tag2 = slider.fillAmount ~= 0
	end

	disFightingBtn:SetActive(not(tag1 and tag2))
	fightingBtn:SetActive(tag1 and tag2)
end

return this