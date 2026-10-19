--2019-05-20 15:37:44 jp1198sp3
--用于LoginFormal界面的综合修订patch

LoginFormalPatch = {}
local this = LoginFormalPatch
local tRoleLoginView
local UserTypefield

local function ClickGuestJPBackBtn( ... )
    -- body
    local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
    Alert:setData(ManagerCsv.GetInstance():GetNameStatic('GuestJPLoginBackConfirm_Title1'),ManagerCsv.GetInstance():GetNameStatic('GuestJPLoginBackConfirm_Content1'))
    Alert:setListener(
        function ( ... )
            local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
            Alert:setData(ManagerCsv.GetInstance():GetNameStatic('GuestJPLoginBackConfirm_Title2'),ManagerCsv.GetInstance():GetNameStatic('GuestJPLoginBackConfirm_Content2'))
            Alert:setListener(
                function ( ... )
                    local obj = tRoleLoginView.Trs:GetComponent('RoleLoginView')
                    local bitor = bit.bor(0,1,2,4,8,16,32,64,256,512,1024,2048,4096,8192,16384,32768)
                    local func = tolua.gettypemethod(typeof('RoleLoginView'), 'OnClickJpBackBtn',bitor)
                    func:Call(obj)
                    func:Destroy()
                    func = nil
                end
            ,nil)
        end
    ,nil)
end

local function Init( ... )
    -- body 
    tRoleLoginView = {}
    local temp = MngrUI.uiRoot:Find('LoginMain/RoleLoginView')
    tRoleLoginView.Trs = temp
    tRoleLoginView.Obj = temp.gameObject
    tRoleLoginView.GuestJPBackBtn = temp:Find('TopRight/GuestJPBackBtn').gameObject
    UIEventListener.Get(tRoleLoginView.GuestJPBackBtn).onClick = ClickGuestJPBackBtn
    temp = temp:Find('TopRight/LoginType')
    temp.gameObject:SetActive(true)
    tRoleLoginView.LoginType = {}
    tRoleLoginView.LoginType.Label = temp:Find('Label'):GetComponent('UILabel')
end

function this.main( ... )
    -- body 
    require 'tolua.reflection'          
    tolua.loadassembly('Assembly-CSharp') 
    UserTypefield = tolua.getfield(typeof('WaterBell.ProjX.Data.NetIO.ProtocolConstant'), 'UserType')
    
    Init()
    UpdateBeat:Add(this.UpdateBeat,this)
    --UpdateBeat:Remove(this.UpdateBeat,this)
end

function this.UpdateBeat( ... )
    -- body
    --没想到其他检测方法了，非挂载方式的这种判断，本来就很蛋疼
    if not MngrUI.uiRoot:Find('LoginMain') then
        return
    end

    if tRoleLoginView.Obj:Equals(nil) then
        Init()
    end

    if not tRoleLoginView.Obj.activeSelf then
        return
    end
    
    local UserType = tonumber(UserTypefield:Get(null))
    -- public enum UserLoginType {
    --     phone = 1,
    --     email =2,
    --     guest = 3,
    --     wechat = 4,
    --     qq = 5,
    --     yijie=6,
    --     efun=7,
    --     jp_google = 8,
    --     jp_fb = 9,
    --     jp_Twitter = 10,
    --     jp_IOSGameCenter = 11,
    --     //guest
    --     unassign = -1
    -- }
    local str
    if UserType == 2 then
        str = 'Email'
    elseif UserType == 3 then
        str = 'Guest' 
    elseif UserType == 8 then
        str = 'Google'
    elseif UserType == 9 then
        str = 'Facebook'
    elseif UserType == 10 then
        str = 'Twitter'
    elseif UserType == 11 then
        str = 'GameCenter'
    else
        str = 'Unassign'
    end
    tRoleLoginView.GuestJPBackBtn:SetActive(UserType == 3)
    tRoleLoginView.LoginType.Label.text = str

end