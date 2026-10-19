-- 功能：用于为周年庆抽卡增加一个10次的限定
-- 路径：
-- Lottery(Clone)___Temp_Lottery___UnloadOnClose
-- LotteryFrontPanel
-- Bottom
-- BgBox
-- Panel
-- KindButtons
-- LFP_Button(Clone)

--baseid 71
local this = {}

local rateid
local lockNum

local title
local tLFP_Button
local isLock
local DrawInfo

function this.Tips( ... )
	-- body
	NetworkAlertUI.TryShowWarningTipByTag('DrawLockTips')
end

function this:Start( obj )
	-- body
	lockNum = 10
	isLock = false
	--从运营活动中取字段名称
	local data = UIActivitiesModel.GetServerDataByID( 71 )
	if not data then
		isLock = true
		--return
	else
		rateid = data.activity_items[1].argument3
		title = data.title
	end
	tLFP_Button = {}
	tLFP_Button.Label_ApClose2 = obj.transform:Find('Label_ApClose2').gameObject
	local Count = obj.transform:Find('Container/Panel/Container/Count')
	tLFP_Button.Button1 = Count:Find('1'):GetComponent('ButtonEx')
	tLFP_Button.ButtonObj1 = tLFP_Button.Button1.gameObject
	tLFP_Button.Button10 = Count:Find('10'):GetComponent('ButtonEx')
	tLFP_Button.ButtonObj10 = tLFP_Button.Button10.gameObject
	tLFP_Button.Label = Count:Find('Label (1)'):GetComponent('UILabel')
	tLFP_Button.Label_Curreny10 = tLFP_Button.Button10.transform:Find('Label_Curreny'):GetComponent('UILabel')
	DrawInfo = WaterBell.ProjX.Common.Utils.AwardUtils.GetDrawInfo()
	LateUpdateBeat:Add(this.UpdateBeat,this)
end

function this:OnDestroy()
	-- body
	LateUpdateBeat:Remove(this.UpdateBeat,this)
	rateid = nil
 	lockNum = nil
	title = nil
	tLFP_Button = nil
	isLock = nil
	DrawInfo = nil
end

function this.UpdateBeat( ... )
	-- body
	--获取当前选择的索引
	if tLFP_Button.Label_ApClose2.activeSelf then
		for i=0,DrawInfo.Count - 1 do
			if DrawInfo[i].name and DrawInfo[i].name == tLFP_Button.Label.text then
				PatchModel.Lottery_CurSelectIndex = i
				tLFP_Button.Label_Curreny10.text = DrawInfo[i].drawTenCurrency
			end
		end
	end

	if isLock then
		return
	end
	if tLFP_Button.Label_ApClose2.activeSelf and string.find(tLFP_Button.Label.text,title) then
		if WaterBell.ProjX.Common.Utils.AwardUtils.GetTotalDrawNum(rateid) >= lockNum then
			isLock = true
			tLFP_Button.Button1.onClick = nil
			UIEventListener.Get(tLFP_Button.ButtonObj1).onClick = this.Tips
			tLFP_Button.Button10.onClick = nil
			UIEventListener.Get(tLFP_Button.ButtonObj10).onClick = this.Tips
		end
	end
end

return this