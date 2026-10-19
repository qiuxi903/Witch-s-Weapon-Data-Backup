UIActivityPageSelectPay = BaseView:new("UI/Prefab/UIPrefab/UIActivity/","UIActivityPageSelectPay")

local this = UIActivityPageSelectPay

local tAlipay
local tWechat

local callBack

function UIActivityPageSelectPay.clear( ... )
 	-- body
 	tAlipay = nil
 	tWechat = nil
 	callBack = nil
end

local function slectPay( obj )
	-- body
	local name = obj.name

	tAlipay.Selected:SetActive(name == 'Alipay')
	tWechat.Selected:SetActive(name == 'Wechat')
end

local function close( ... )
	-- body
	this:destory()
end

local function yesClick( ... )
	-- body
	if tAlipay.Selected.activeSelf then
		if callBack then
			callBack('Alipay')
		end
	else
		if callBack then
			callBack('Wechat')
		end
	end
	close()
end

function UIActivityPageSelectPay.init( ... )
	-- body
	--传递参数：回调
	callBack = ...

	local Alipay = this.page.transform:Find('DialogBox/Alipay').gameObject
	local Wechat = this.page.transform:Find('DialogBox/Wechat').gameObject

	tAlipay = {}
	tAlipay.gameObject = Alipay
	tAlipay.Label = Alipay.transform:Find('Label'):GetComponent('UILabel')
	tAlipay.Selected = Alipay.transform:Find('Selected').gameObject

	tWechat = {}
	tWechat.gameObject = Wechat
	tWechat.Label = Wechat.transform:Find('Label'):GetComponent('UILabel')
	tWechat.Selected = Wechat.transform:Find('Selected').gameObject
	tWechat.Selected:SetActive(false)

	UIEventListener.Get(Alipay).onClick = slectPay
	UIEventListener.Get(Wechat).onClick = slectPay

	UIEventListener.Get(this.page.transform:Find('DialogBox/Button_Yes').gameObject).onClick = yesClick
	UIEventListener.Get(this.page.transform:Find('Button_CloseBg').gameObject).onClick = close
	
end