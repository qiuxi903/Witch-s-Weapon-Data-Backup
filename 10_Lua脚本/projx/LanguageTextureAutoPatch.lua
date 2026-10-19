--2019-08-07 13:59:37
--用于对Texture 的 多语言 自动切换

local this = {}

function this:Start( obj )
	-- body
	local UITexture = obj.transform:GetComponent('UITexture')
	local Texture = string.gsub('_' .. ManagerCsv.languageStr,'_cn','')
	Texture = "UI/UIImage/ActivityImg/Text/" .. UITexture.mainTexture.name .. Texture
	Texture = AssetsManager.LoadTextureForLua(Texture,AssetsManager.AssetsType.LuaAssets10)
	if Texture then
		UITexture.mainTexture = Texture
		UITexture:MakePixelPerfect()
	end
end

return this