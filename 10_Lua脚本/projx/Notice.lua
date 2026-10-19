Notice = BaseView:new("UI/Prefab/","Notice")

local spriteArr = {
	"Item40_200",
	"Item40_201",
	"Item40_209",
	"Item40_210",
	"Item40_211",
}

local index
local goOtherSprite

local function clear( ... )
	-- body
	index = nil
	goOtherSprite = nil
end

function Notice.init( ... )
	-- body
	local page = Notice.page
	index = 1

	goOtherSprite = page.transform:Find('Center/goOther'):GetComponent('UISprite')
	goOtherSprite.spriteName = spriteArr[index]
	UIEventListener.Get(goOtherSprite.gameObject).onClick = Notice.goOther

	UIEventListener.Get(page.transform:Find('Right/close').gameObject).onClick = Notice.close
end

local function changeSprite( ... )
	-- body
	if index < #spriteArr then
		index = index + 1
		goOtherSprite.spriteName = spriteArr[index]
		return true
	end
	return false
end

function Notice.close( ... )
	-- body
	if not changeSprite() then
		Notice:destory()
	end
end

function Notice.goOther( ... )
	-- body
	last_selected_activity_id = index
	ActivityView:show()
end