UIOldUserRegressionSystemSign = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIOldUserRegressionSystemSign")
local this = UIOldUserRegressionSystemSign

function this.init( ... )
	-- body
	local Data = UIActivitiesModel.GetServerDataAllByID( 993 )
	local Item = this.page.transform:Find('Item')
	local Center = this.page.transform:Find('Center')
	local OffsetXY = Center:Find('OffsetXY')
	local OffsetX = OffsetXY.localPosition.x
	local OffsetY = OffsetXY.localPosition.y
	local Root = Center:Find('Root')
	local strFormat = ManagerCsv.GetInstance():GetNameStatic('OperateFormatDay')

	local canSign = Utils.getSeverTime() - Data.DaysSignTime >= 60 * 60 * 24 or Data.DaysSignRewardTag == 0
	local signDay = Data.DaysSignRewardTag + 1
	if signDay > #Data.activity_items then
		canSign = false
	end

	local SignText_AlreadySignedIn = ManagerCsv.GetInstance():GetNameStatic('SignText_AlreadySignedIn')
	local SignText_WillSignIn = ManagerCsv.GetInstance():GetNameStatic('SignText_WillSignIn')
	local SignText_SignIn = ManagerCsv.GetInstance():GetNameStatic('SignText_SignIn')

	for i=1,10 do
		local temp = NGUITools.AddChild(Root.gameObject,Item.gameObject)
		temp = temp.transform
		temp:Find('Day'):GetComponent('UILabel').text = string.format(strFormat,i)

		local reward = Data.activity_items[i].rewards[1]

		local trs = AwardUtils.GetInstance():LoadAwardSprite(reward.id,reward.type,reward.num,temp:Find('Root'),reward.value,1)
		local Mid = trs:Find('Mid')
		Mid:Find('SuperScript').gameObject:SetActive(false)
		Mid:Find('IconFrame').gameObject:SetActive(false)
		local Num = Mid:Find('Num'):GetComponent('UILabel')
		Num.gameObject:SetActive(false)
		temp:Find('Num'):GetComponent('UILabel').text = Num.text

		local BG = temp:Find('BG'):GetComponent('UISprite')
		local Title = temp:Find('Title'):GetComponent('UILabel')
		
		if i < signDay then
			--已经签到的
			BG.spriteName = 'olduser_kuang01_03'
			Title.text = SignText_AlreadySignedIn

		elseif i > signDay then
			--还没有签到的
			BG.spriteName = 'olduser_kuang01_01'
			Title.text = SignText_WillSignIn
		else
			--当前的天数
			BG.spriteName = canSign and 'olduser_kuang01_02' or 'olduser_kuang01_01'
			Title.text = SignText_WillSignIn

			local Button = this.page.transform:Find('Button')
			local Button_Normal = Button:Find('Normal')
			local Button_Select = Button:Find('Select')

			Button_Select.gameObject:SetActive(canSign)
			Button_Normal.gameObject:SetActive(not canSign)

			if canSign then
				UIEventListener.Get(Button_Select.gameObject).onClick = function ( ... )
					--发送签到协议
					local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
					local request_params = {roleid = tostring(role_id),baseid = tostring(Data.id)}
					local msgid = ActivityModel.getCode( Data.id,Data.type )
					Utils.SendMessage(msgid, request_params, function(response)
						local bytes = response.bytes
						local LuaNetProxy = LuaNetProxy.New()
						LuaNetProxy:Callback(bytes)
						--刷新本地数据，刷新表现
						Data.DaysSignRewardTag = Data.DaysSignRewardTag + 1
						Data.DaysSignTime = Utils.getSeverTime()
						
						BG.spriteName = 'olduser_kuang01_03'
						Title.text = SignText_AlreadySignedIn

						Button_Select.gameObject:SetActive(false)
						Button_Normal.gameObject:SetActive(true)

						UIEventListener.Get(Button_Select.gameObject).onClick = function ( ... )
							-- body
						end
						UIOldUserRegressionSystem.UpdateRed()
						if i == 1 or i == 3 or i == 5 then
							Utils.GetRoleInfoByMsg()
						end
					end)
				end
			end
		end

		if i < 5 then
			--第一行四个
			temp.localPosition = Vector3.New(OffsetX * (i - 1),0,0)
		elseif i < 8 then
			--第二行3个
			temp.localPosition = Vector3.New(OffsetX * (i - 5) + OffsetX / 2, - OffsetY,0)
		elseif i < 10 then
			--第三行2个
			temp.localPosition = Vector3.New(OffsetX * (i - 8) + OffsetX, - OffsetY * 2,0)
		elseif i == 10 then
			--第四行1个
			temp.localPosition = Vector3.New(OffsetX + OffsetX / 2, - OffsetY * 3,0)
		end

	end
end