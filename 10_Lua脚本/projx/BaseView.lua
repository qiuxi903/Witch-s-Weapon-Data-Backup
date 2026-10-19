BaseView = {}
BaseView.allView = {}
function BaseView:new(path,name,assetsType)
	local o = {}
	o.name = name
	o.path = path..name
	o.assetsType = assetsType
	setmetatable(o,{__index = self} )
	table.insert(BaseView.allView,o)
	return o
end

function BaseView:isNil()
    return self.page == nil or self.page:Equals(nil)
end

function BaseView:show( ... )
	-- body
	if not self:isNil() then
		self.page.gameObject:SetActive(true)
		self.active = true
		if self.hide2show then
			self.hide2show( ... )
		end
	else
		local uiRoot = MngrUI.uiRoot.gameObject
		local obj
		if self.assetsType then
			obj = AssetsManager.LoadResourceForLua(self.path,self.assetsType)
		else
			obj = AssetsManager.LoadResourceForLua(self.path)
		end
		if not uiRoot or not obj then
			print('gameobject is nil')
			return
		end
		self.page = NGUITools.AddChild(uiRoot,obj)
		self.page.name = self.name
		self.uiRoot = uiRoot
		self.active = true
		if self.init then
			self.init( ... )
		end
	end
end

function BaseView:hide( ... )
	-- body
	if not self:isNil() then
		self.page.gameObject:SetActive(false)
		self.active = false
	end
end

function BaseView:destory( ... )
	-- body
	if not self:isNil() then
		UnityEngine.GameObject.Destroy(self.page.gameObject)
	end
	
	if self.clear then
		self.clear( ... )
	end 
	self.page = nil
	self.active = false
end