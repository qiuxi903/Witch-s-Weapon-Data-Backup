--用于修复战斗暂停时重复放技能的问题
--路径：UIBattlePause
local this = {}
local GameObject = UnityEngine.GameObject
local Input = UnityEngine.Input

local pauseBtnCollider
local cancelBtn 
local cancelTrans
local uiRootTrans

local isCancelBtnVisbleInPreFrame
local MaxCD=10
local currCD
local cancelBtnPath1="UIBattleSkill/BottomRight/cancelRelease"
local cancelBtnPath2="UIBattleSkill2/BottomRight/cancelRelease"

local frameUpdateCount=0  --用于update计数

local skillBtnLayoutMode  --1 = line， 2 = arc
local skillAnimLeftTexParentNodeTrans -- 左侧技能动画的上级节点 offset
local mainAnimBtnSprite -- 动画开关的节点下btnAnim的sprite

local specialSkillRoleObj 
local specialObjRootPath1="servant_133"
local specialObjRootPath2="servant_131"

	-- set visble attr at last cmd of valid update-loop
local touchCountInPreFrame = 0
		
function this:Awake( obj )
	-- body	
end


function this:Start( obj )
	-- body
	print("time patch start")
	uiRootTrans = MngrUI.uiRoot
	pauseBtnCollider = uiRootTrans:Find('UIBattleTime/pause'):GetComponent("BoxCollider")
	
	cancelTrans = uiRootTrans:Find(cancelBtnPath1)
    if not cancelTrans then
    	cancelTrans = uiRootTrans:Find(cancelBtnPath2)
    end
	
	
	cancelBtn = cancelTrans.gameObject
	print("time patch start2")
	UpdateBeat:Add(this.UpdateBeat,this)
	isCancelBtnVisbleInPreFrame=false
	currCD =0
	
	mainAnimBtnSprite = uiRootTrans:Find('UIBattleAutoButton/alpha/btnAnim/btnBG'):GetComponent("UISprite")
	
	skillAnimLeftTexParentNodeTrans = uiRootTrans:Find('UIBattleSkillUnAnim/TopLeft/offset')
	
	
end

function this:OnDestroy()
	-- body

	
	UpdateBeat:Remove(this.UpdateBeat,this)
	uiRootTrans =nil
	cancelTrans=nil
	cancelBtn = nil
	pauseBtnCollider =nil
	mainAnimBtnSprite =nil
	skillAnimLeftTexParentNodeTrans =nil
end

function this.UpdateBeat( ... )
	-- body
	
	--[[
		update设计职责
		0 监控Input touch
		  两点以上触屏时，目前不允许暂停
		
		1 监控 skillBtnLayoutMode及识别cancelBtn，须知晓当前是何种操作模式
			因为手动操作模式下，会有特殊case要处理
			此项监控由于有Find在主逻辑，需要低频运行
			
		2 监控  cancelBtn的激活状态 这个拖拽技能必然触发的UI作
			当其激活时，不可点暂停
			当其由激活转为未激活时，倒计时几帧 恢复暂停
			需要逐帧运行
			
		3 监控 手动模式 + 非技能拖拽时，是否直接召唤出了技能
			关动画时，可以检测左侧弹出的机能头像 
			开动画时，又有特殊的识别方案

	--]]


	 
	 
	local isSetEnableFlag=false 
	
	--======================= #Task0  touch限制 ==================
	if Input.touchCount >1 then 
		pauseBtnCollider.enabled=false
		isSetEnableFlag=true
	else
		-- 只要有触点为空或只有1个时，就增加恢复暂停的时间
		if touchCountInPreFrame >=2 then
		currCD = MaxCD
		end
		
	end
	touchCountInPreFrame = Input.touchCount 
	
	--======================= #Task1  skillBtnLayoutMode及识别cancelBtn ==================
	-- prevent change mode after awake/start
	-- 降低检查频度 每3帧检查一次
	
	
	
	frameUpdateCount= frameUpdateCount+1
	if frameUpdateCount>2 and  uiRootTrans~=nil then
		frameUpdateCount=0
		cancelTrans = uiRootTrans:Find(cancelBtnPath1)
		if cancelTrans ~= nil then	
			cancelBtn = cancelTrans.gameObject
			skillBtnLayoutMode =1 --横线
			--print("1 line")
		else	 
			cancelBtn = uiRootTrans:Find(cancelBtnPath2).gameObject
			skillBtnLayoutMode =2 --弧形
			--print("2 arc")
		end

	end 
	
	--======================= #Task2 cancelBtn的激活状态  ===============
	--仅适用于 拖动释放的case
	--skillBtnLayoutMode==1 or 2 均适用
	if  isSetEnableFlag ==false and cancelBtn ~= nil and (not cancelBtn:Equals(nil)) then  -- Equals检测是因为切换时 c#侧清理了UI对象
			
		if cancelBtn.activeInHierarchy  then 
		
			pauseBtnCollider.enabled=false
			isSetEnableFlag =true
		else
			
			if isCancelBtnVisbleInPreFrame==true then
			-- 前一帧激活 而当前未激活时的case
				currCD = MaxCD
				print("set maxcd pBtn ")				
			end		
		
			
		end
		
		-- set visble attr at last cmd of valid update-loop
		isCancelBtnVisbleInPreFrame = cancelBtn.activeInHierarchy
	else 
		--case1 切换操作模式 并且赶上 在frameUpdate的间隙帧时将触发额外的 enable锁定，但每次只锁当前1帧
		--case2 胜利失败隐藏ui后可能触发
		print("cant find cancelBtn at this moment")
		isCancelBtnVisbleInPreFrame = false
		
		if pauseBtnCollider ~= nil and (not pauseBtnCollider:Equals(nil)) then  -- Equals检测是因为切换时 c#侧清理了UI对象
			pauseBtnCollider.enabled=false
			
		end
		
		isSetEnableFlag =true --走到特殊流程时 就不做后续处理了
	end 
	
	

	--======================= #2 机制B 不通过cancelBtn 判断 ===============
	if isSetEnableFlag ==false and skillBtnLayoutMode==2 then 
		
		
		local  isAnimOpen = mainAnimBtnSprite.spriteName=="Button_Animation_Open"
		
		
		if isAnimOpen ==false then
		--case 2.1 没有开启动画播放时，可以判断左侧的出场角色小头像的存在与否
		
			if skillAnimLeftTexParentNodeTrans.childCount >4 then
				-- 2019-0210 这个节点下目前已存在4个skillView，只要释放技能就有更多child
				--hack flag,这是取巧的办法，一旦该节点下prefab改动 上述判定就会失效
				
				--立即禁用，并且计时恢复
				pauseBtnCollider.enabled=false
				isSetEnableFlag =true
				currCD = MaxCD
			else
				pauseBtnCollider.enabled=true
				isSetEnableFlag =true
			end
		
		else
			--开启动画播放时
			--如果是正常播了动画，镜头返回时不能立即暂停，这类case都不会出问题			
			--但目前黑骑士和狐狸，本身没有召唤动画，没有其他界面元素可以借助减少判定任务
			
			--处理策略：对魔女黑骑133 狐狸131 做硬性补丁
			
			specialSkillRoleObj = GameObject.Find(specialObjRootPath1)
			if specialSkillRoleObj == nil then
				specialSkillRoleObj = GameObject.Find(specialObjRootPath2)
			end 
			
			if specialSkillRoleObj ~= nil then
				--这个case中 只要有上述两个特殊角色的 召唤动画角色在场，就不允许暂停
				pauseBtnCollider.enabled=false
				isSetEnableFlag =true
				currCD = MaxCD
			end
		end
		
	end
	
	-- ===================== each frame cd -1,min is 0 =======================
	--没有直接强制设定 enable时，就会进入 cd计时机制内
	if isSetEnableFlag ==false  and  currCD==0 then
		
		pauseBtnCollider.enabled=true
		isSetEnableFlag =true
	end 
			
		 
		 
	currCD =currCD-1
	if currCD<0 then 
		currCD =0
	end
	
end

return this 