--用于修复战斗暂停时重复放技能的问题
--路径：UIBattlePause
local this = {}

local UISprite
function this:Awake( obj )
	-- body
	UISprite = MngrUI.uiRoot:Find('UIBattleSkill/BottomRight/cancelRelease')
    if not UISprite then
    	UISprite = MngrUI.uiRoot:Find('UIBattleSkill2/BottomRight/cancelRelease')
    end
    UISprite = UISprite:GetComponent('UISprite')
    UISprite.width = 10000
    -- for (int index = 0; index <= Input.touchCount; index++)
    -- {
    --     Input.touches[index].phase = TouchPhase.Canceled;
    -- }
    for i=0,UnityEngine.Input.touchCount - 1 do
    	UnityEngine.Input.touches[i].phase = 4
    end
end

function this:Start( obj )
	-- body
	-- local bitor = bit.bor(0,1,2,4,8,16,32,64,256,512,1024,2048,4096,8192,16384,32768)
	--System.Type.GetType("WaterBell.ProjX.View.UIFrame.UIScene"):InvokeMember("Reset", 256,System.Type.DefaultBinder, a, nil);
	-- require 'tolua.reflection'
 --    tolua.loadassembly('Assembly-CSharp')

 --    local UIBattleSkill = typeof("UIBattleSkill")
 --    local instance = tolua.createinstance(UIBattleSkill)
 --    local _skillJoystick = tolua.getproperty(UIBattleSkill, "_skillJoystick")
 --    _skillJoystick:hide()
    -- local func = tolua.getmethod(typeof(_skillJoystick), "hide")
    -- func:Call()        
    -- func:Destroy()
    -- func = nil
    -- local typejoystick = typeof("com.ling.uibattleskill.sign.UIBattleSkillViewSkillJoystick")
    -- local instance = tolua.createinstance(typejoystick)
    -- local hide = tolua.getmethod(typejoystick, "hide")
    -- func:Call()        
    -- func:Destroy()
    -- func = nil

    -- local constructor = tolua.getconstructor(typejoystick, typeof(Vector3):MakeArrayType())
    -- local obj = constructor:Call(array)        
    -- constructor:Destroy()

    -- local uibattleskill = GameObject.Find("UIBattleSkill");
    -- local objuibattleskill = uibattleskill.GetComponent("UIBattleSkill");
    -- local uibattleskillfiled = System.Type.GetType("UIBattleSkill").GetField("_skillJoystick", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
    -- local uibattleskillvalue = uibattleskillfiled.GetValue(objuibattleskill);
    -- local typejoystick = System.Type.GetType("com.ling.uibattleskill.sign.UIBattleSkillViewSkillJoystick");
    -- typejoystick.GetMethod("hide").Invoke(uibattleskillvalue, System.Reflection.BindingFlags.Public, null, null, null);

    -- local typearea = System.Type.GetType("com.ling.uibattleskill.sign.UIBattleSkillViewArea");
    -- local areafiled = typejoystick.GetField("_area", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
    -- typearea.GetMethod("hide").Invoke(areafiled.GetValue(uibattleskillvalue), System.Reflection.BindingFlags.Public, null, null, null);

   
end

function this:OnDestroy()
	-- body
	UISprite.width = 128
	UISprite = nil
end

return this