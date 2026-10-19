local this = {}
local t = {'Servant40','Servant40_01','Servant40_02','Servant40_03'}
local Texture
local Sprite

local lastName

local function Sprite2Texture( name )
	-- body
	local mainTexture
	for i,v in ipairs(t) do
		mainTexture = AssetsManager.LoadTextureForLua("UI/UIImage/" .. v .. '/' .. name)
		if mainTexture then
			break
		end
	end

	Texture.mainTexture = mainTexture
	--Texture:MakePixelPerfect()
end

function this:Start( obj )
	-- body
	Sprite = obj.transform:GetComponent('UISprite')
	
	local name = Sprite.spriteName

	--尝试性从所有Servant40加载资源
	--UI/UIImage/
	--Servant40
	--Servant40_01
	--Servant40_02
	--Servant40_03
	Texture = obj:AddComponent(typeof(UITexture))
	Texture.width = Sprite.width
	Texture.height = Sprite.height
	lastName = name
	Sprite2Texture( name )

	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body

	 t = nil
	 Texture = nil
	 Sprite = nil

	 lastName = nil

	UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
	-- body
	if lastName ~= Sprite.spriteName then
		lastName = Sprite.spriteName
		Sprite2Texture( lastName )
	end
end

return this