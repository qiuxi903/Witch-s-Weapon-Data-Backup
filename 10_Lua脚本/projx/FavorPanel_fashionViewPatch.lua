local this = {}

function this:OnEnable( obj )
	-- body
	local function Check( ... )
		-- body
		--local normalImg = obj.transform:Find('Container/normalImg').gameObject
		--normalImg:SetActive(false)
		--normalImg:SetActive(true)
		local texture = obj:GetComponent("UITexture")
		--local pre = texture.mainTexture
		--texture.mainTexture = nil
		--texture.mainTexture = pre;
		--normalImg:SendMessage("MarkAsChanged")
		if obj.activeSelf then
			texture:SendMessageUpwards("ReDraw",1)
		end
    end 

    Timer.New(function ()
		if not obj:Equals(nil) then
			Check()
		end
			-- body
	end, 0.1, 1, true):Start()
end

return this
