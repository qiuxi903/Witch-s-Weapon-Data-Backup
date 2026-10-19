local AdTexPatch = {}
local this = AdTexPatch
local selfObj

function this:Awake( obj )
	-- body
	selfObj = obj
end

function this:OnEnable( obj )
	-- body
	Timer.New(function ()
		if not obj:Equals(nil) then
			local uiTexture = obj.transform:GetComponent("UITexture")
			uiTexture.mainTexture = AssetsManager.LoadTextureForLua("UI/UIImage/ActivityPlayMode/Activity_Double_002")
		end
		-- body
	end, 0.1, 1, true):Start()
end

function this:OnDisable()
	-- body
	Timer.New(function ()
		if not selfObj:Equals(nil) then
			selfObj:SetActive(true)
		end
			-- body
	end, 0.1, 1, true):Start()
end

return this