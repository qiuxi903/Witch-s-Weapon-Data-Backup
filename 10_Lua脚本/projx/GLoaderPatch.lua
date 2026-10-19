--调用下GLoader.ReloadManifest()
GLoaderPatch = {}
function GLoaderPatch.main()
	-- body
	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp-firstpass')

    local t = typeof('GLoader')
    local func = tolua.getmethod(t, 'ReloadManifest')
    func:Call()
    func:Destroy()
    func = nil
end