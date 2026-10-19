--2019-04-26 13:47:54
--jp 1198sp1
--用于给屏蔽词不生效加一个hack

--！！！！！！！！！！！！！
--非挂载补丁，删除时一定要删除相应调用逻辑

UtilLocalMessagePatch = {}

local this = UtilLocalMessagePatch

function this.main( ... )
	-- body

	-- if (null != GameObject.Find("___________UtilStringDFA"))
 --    {
 --        GameObject.DestroyImmediate(GameObject.Find("___________UtilStringDFA"));
 --        UtilStringDFA._data.Clear();
 --        /// 给个延时
 --        GUtilListener.calledTime(UtilStringDFA.Init, 0.1f);
        
 --    }
 --    if (null != GameObject.Find("_UtilLocalMessage"))
 --    {
 --        GameObject.Destroy(GameObject.Find("_UtilLocalMessage"));
 --        GameObject go = AssetsManager.LoadAndInstantiate("UI/_UtilLocalMessage", AssetsManager.AssetsType.UnCare);
 --        go.name = "_UtilLocalMessage";

 --    }

 	local GameObject = UnityEngine.GameObject
 	local obj_UtilStringDFA = GameObject.Find("___________UtilStringDFA")
 	if not obj_UtilStringDFA then
 		return
 	end

 	require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp-firstpass')
    tolua.loadassembly('Assembly-CSharp')           
    local bitor = bit.bor(0,1,2,4,8,16,32,64,256,512,1024,2048,4096,8192,16384,32768)

 	local typeof_UtilStringDFA = typeof('UtilStringDFA')
 	local field = tolua.getfield(typeof_UtilStringDFA, '_data',bitor)
    field:Get(null):Clear()
    field:Destroy() 
    field = nil

 	GameObject.DestroyImmediate(obj_UtilStringDFA)

 	local func = tolua.getmethod(typeof_UtilStringDFA, 'Init')
    func:Call()
    func:Destroy()
    func = nil

	local obj_UtilLocalMessage = GameObject.Find("_UtilLocalMessage")
 	if obj_UtilLocalMessage then
 		GameObject.DestroyImmediate(GameObject.Find("_UtilLocalMessage"))
 		local go = AssetsManager.LoadAndInstantiate("UI/_UtilLocalMessage", AssetsManager.AssetsType.UnCare);
 		go.name = "_UtilLocalMessage";
 	end    
end