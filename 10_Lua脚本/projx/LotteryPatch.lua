-- 功能：用于为周年庆抽卡增加一个10次的限定
-- 路径：
-- Lottery(Clone)___Temp_Lottery___UnloadOnClose

--baseid 71
local this = {}

local rateid
local lockNum

local title
local tLottery
local isLock
local DrawInfo
local GoBackMainSceneLock

function this.Tips( ... )
	-- body
	NetworkAlertUI.TryShowWarningTipByTag('DrawLockTips')
end

function urlChange( s )
	-- body
	local s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
	s = string.gsub(s, "%%5B", "[")
	s = string.gsub(s, "%%5D", "]")
	s = string.gsub(s, "%%3D", "=")
	s = string.gsub(s, "%%26", "&")
    return string.gsub(s, " ", "+")
end

function this.OpenUrl( ... )
	-- body
	local url = ''
	local allTagArg = ''
	for i=0,DrawInfo.Count - 1 do
		if DrawInfo[i].tagArg ~= '' then
			if i == (DrawInfo.Count - 1) then
				allTagArg = allTagArg .. DrawInfo[i].tagArg
			else
				allTagArg = allTagArg .. DrawInfo[i].tagArg .. "&"
			end
		end
	end
	if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
		url = ManagerCsv.GetInstance():GetConstant("DRAW_URL_IOS").value1
	else
		url = ManagerCsv.GetInstance():GetConstant("DRAW_URL_ANDROID").value1
	end
	--local cn4str = '%E6%B7%B7%E6%B2%8C%E6%BC%94%E7%AE%97[%E5%89%8D%E7%AF%87]=4&%E6%B7%B7%E6%B2%8C%E6%BC%94%E7%AE%97[%E5%90%8E%E7%AF%87]=5&%E7%B4%A2%E6%89%98%E6%96%AF%E7%A5%88%E6%84%BF=0'
	local arg = urlChange(allTagArg)
	url = url .. string.split(DrawInfo[PatchModel.Lottery_CurSelectIndex].tagArg,'=')[2] .. ".html" .. "?" .. arg
	WaterBell.ProjX.Common.Utils.AwardUtils.OpenWebURLNotie(url,true,nil)
end

function this:Start( obj )
	-- body
	lockNum = 10
	isLock = false
	--从运营活动中取字段名称
	local data = UIActivitiesModel.GetServerDataByID( 71 )
	if not data then
		--return
		isLock = true
	else
		rateid = data.activity_items[1].argument3
		title = data.title
	end
	tLottery = {}
	local tButton_Redraw = {}
	tLottery.ResultPanel = obj.transform:Find('ResultPanel').gameObject
	tButton_Redraw.ButtonEx = obj.transform:Find('ResultPanel/Bottom/Button_Redraw'):GetComponent('ButtonEx')
	tButton_Redraw.Label = tButton_Redraw.ButtonEx.transform:Find('Label'):GetComponent('UILabel')
	tButton_Redraw.ButtonExObj = tButton_Redraw.ButtonEx.gameObject
	tLottery.tButton_Redraw = tButton_Redraw
	local ProbButton = {}
	ProbButton.ButtonEx = obj.transform:Find('LotteryFrontPanel/ProbButton'):GetComponent('ButtonEx')
	ProbButton.ButtonExObj = ProbButton.ButtonEx.gameObject
	tLottery.ProbButton = ProbButton
	DrawInfo = WaterBell.ProjX.Common.Utils.AwardUtils.GetDrawInfo()

	UpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	UpdateBeat:Remove(this.UpdateBeat,this)
	rateid = nil
 	lockNum = nil
	title = nil
	tLottery = nil
	isLock = nil
	DrawInfo = nil
	GoBackMainSceneLock = nil
end

function this.UpdateBeat( ... )
	-- body
	if tLottery.ProbButton.ButtonEx.onClick then
		tLottery.ProbButton.ButtonEx.onClick = nil
		UIEventListener.Get(tLottery.ProbButton.ButtonExObj).onClick = this.OpenUrl
	end
	--判断点星星界面存在时，当前卡池是否已经结束
	--fix 判断是不是活动抽卡
	if tLottery.ResultPanel.activeSelf and DrawInfo[PatchModel.Lottery_CurSelectIndex].isApDraw then
		if DrawInfo[PatchModel.Lottery_CurSelectIndex].apCloseTime:CompareTo(GUtilTime.serverTimeFormat) < 0 then
			if not GoBackMainSceneLock then
				--开启一个对话框，提示已经过期，直接返回主界面
				local Alert = GUtilUISuper.show(typeof(UIAlert),"UIAlert",nil,true)
				--OperateSelect 确认加入阵营？
				Alert:setButton(true,'返回',nil)
				Alert:setData('提示','当前卡池已关闭，请返回主界面！')
				Alert:setListener(function ( ... )
					-- body
					GoBackMainSceneLock = true
					WaterBell.ProjX.View.UIFrame.UISceneManager.getInstance():GoBackMainScene()
				end,nil)
			end
		end
	end

	if isLock then
		return
	end
	if tLottery.ResultPanel.activeSelf and string.find(tLottery.tButton_Redraw.Label.text,title) then
		if WaterBell.ProjX.Common.Utils.AwardUtils.GetTotalDrawNum(rateid) >= lockNum then
			isLock = true
			tLottery.tButton_Redraw.ButtonEx.onClick = nil
			UIEventListener.Get(tLottery.tButton_Redraw.ButtonExObj).onClick = this.Tips
		end
	end
end

return this