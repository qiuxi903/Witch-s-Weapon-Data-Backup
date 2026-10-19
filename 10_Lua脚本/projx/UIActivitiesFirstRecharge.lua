UIActivitiesFirstRecharge = BaseView:new("UI/Prefab/UIPrefab/UIActivities/","UIActivitiesFirstRecharge",AssetsManager.AssetsType.LuaAssets3)

local this = UIActivitiesFirstRecharge
local AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
local ManagerCsv = ManagerCsv
function this.clear( ... )
	-- body
end

local function ClickClose( ... )
	-- body
	this:destory()
	MainScenePanelAdd.UpdateRed()
	LuaPanelHelper.GoBackMainScene()
end

function this.init( ... )
	-- body
	local Button = this.page.transform:Find('Button').gameObject
	local ButtonLabel = Button.transform:Find('Label'):GetComponent('UILabel')
	local ButtonSprite = Button:GetComponent('UISprite')
	local Close = this.page.transform:Find('TopLeft/Close').gameObject

	UIEventListener.Get(Close).onClick = ClickClose

	local Callback = function ( ... )
		-- body
		local Data = UIActivitiesModel.GetServerDataAllByID( 998 )
		if Data.IsReceive then
			--已经领取
			ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')
			ButtonSprite.spriteName = 'ButtonDisable'
		else
			if Data.CanReceive then
				ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReward2')
				ButtonSprite.spriteName = 'ButtonNormal'
				--可以领取
				UIEventListener.Get(Button).onClick = function ( ... )
					-- body
					local role_id = UserInfo.GetInstance():GetPlayer().RoleID
					local request_params = {roleid = tostring(role_id),baseid = tostring(Data.id)}
					Utils.SendMessage(ActivityModel.ActivityType.FirstRecharge.msgid, request_params, function(response)
						local bytes = response.bytes
						local LuaNetProxy = LuaNetProxy.New()
						LuaNetProxy:Callback(bytes)
						--刷新本地数据
						Data.CanReceive = false
						Data.IsReceive = true
						ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('OperateReceive')
						ButtonSprite.spriteName = 'ButtonDisable'

						UIEventListener.Get(Button).onClick = function ( ... )
							-- body
						end
						MainScenePanelAdd.UpdateUI()
					end)
				end
			else
				ButtonLabel.text = ManagerCsv.GetInstance():GetNameStatic('FirstBuyGoShop')
				ButtonSprite.spriteName = 'ButtonNormal'
				UIEventListener.Get(Button).onClick = function ( ... )
					-- body
					this:destory()
					UIActivitiesModel.GoOneShopPageByID( Data.activity_items[1].argument7,'UIActivitiesFirstRecharge.Callback')
				end
			end
		end
	end
	UIActivitiesModel.RequestActivitiesData( Callback )
end

function UIActivitiesFirstRecharge.Callback( ... )
	-- body
	this:show()
end