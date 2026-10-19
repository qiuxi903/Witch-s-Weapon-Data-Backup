--2019-04-27 16:17:17
--1198sp1
--用于低等级时 给作战小飞机加一个增强特效

MainBattleBtnEffetPatch = {}

function MainBattleBtnEffetPatch.main()
	-- body
	local lockLv = 10
	if UserInfo.GetInstance():GetPlayer().Level > lockLv then
		return
	end
	local parent = GameObject.Find('3D/Container (1)/feixingqi/fxq/Bone_root')
	if parent.Find('UIEffect2MainBattleBtn') then
		return
	end

	local obj = AssetsManager.LoadResources("UI/Prefab/UIPrefab/UIEffect2MainBattleBtn", AssetsManager.AssetsType.UnCare);
	obj = NGUITools.AddChild(parent,obj)
	obj.name = 'UIEffect2MainBattleBtn'
end