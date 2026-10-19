local this = {}

local function AtlasPoolAddPatch( ... )
	-- body
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp-firstpass')   
    local bitor = bit.bor(0,1,2,4,8,16,32,64,256,512,1024,2048,4096,8192,16384,32768)

    local t = typeof('AtlasPool')

    local func = tolua.getmethod(t, 'getInstance')
    local instance = func:Call()
    func:Destroy()
    func = nil

    local field = tolua.getfield(t, 'atlasDic',bitor)
    local atlasDic = field:Get(instance)

    local bool = atlasDic:ContainsKey("Servant10_04")
    if not bool then
   	 	atlasDic:Add("Servant10_04","UI/Atlas/Servant/Servant10_04/Servant10")
   	end

	field:Destroy()
    field = nil

end

function this:Awake( ... )
	-- body
	AtlasPoolAddPatch()
end

function this:OnDestroy()
	-- body
	AtlasPoolAddPatch()
end

return this