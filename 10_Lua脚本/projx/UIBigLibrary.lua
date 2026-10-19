UIBigLibrary = BaseView:new("UI/Prefab/UIPrefab/UIBigLibrary/","UIBigLibrary",AssetsManager.AssetsType.LuaAssets1)

local this = UIBigLibrary

local gridOneLevel
local gridTwoLevel
local objLibraryItem1
local objLibraryItem2
local objPrevious
local objNext
local labContentLabel
local texContentTexture
local curPageData
local curPageIndex
local curOneLevel
local curTwoLevel
local objSelectOneItem
local objSelectTwoItem
local tableOneLevel
local objEmpty
local objContent
local labPageIndex
local labContentTitle
local tSelect
local tColor

function this.clear( ... )
	-- body
	gridOneLevel = nil
	gridTwoLevel = nil
	objLibraryItem1 = nil
	objLibraryItem2 = nil
	objPrevious = nil
	objNext = nil

	labContentLabel = nil
	texContentTexture = nil

	curPageData = nil
	curPageIndex = nil
	curOneLevel = nil
	curTwoLevel = nil
	objSelectOneItem = nil
	objSelectTwoItem = nil
	tableOneLevel = nil
	objEmpty = nil
 	objContent = nil
 	labPageIndex = nil
 	labContentTitle = nil
 	tSelect = nil
 	tColor = nil
end

local function OnClose( ... )
	-- body
	this:destory()
	AssetsManager.UnloadType(this.assetsType,false)
end

local function PageSelectShowHide( ... )
	-- body
	objPrevious:SetActive(true)
	objNext:SetActive(true)
	if curPageIndex == 1 then
		objPrevious:SetActive(false)
	end
	if curPageIndex == #curPageData then
		objNext:SetActive(false)
	end
end

local function UpdatePage()
	-- body
	--默认是一个缺省也
	curPageData = LibraryModel.GetData( curOneLevel, curTwoLevel ).Data
	if curPageIndex > #curPageData then
		curPageIndex = #curPageData
	end
	if curPageIndex < 0 then
		curPageIndex = 0
	end
	for i,v in ipairs(curPageData) do
		if curPageIndex == i then
			labContentLabel.text = v.Content
			labContentTitle.text = v.Title
			local texture = AssetsManager.LoadTextureForLuaEx('UI/UIImage/Guide/LibraryImage/' .. v.Picture,this.assetsType)
			if texture then
				texContentTexture.mainTexture = texture
				texContentTexture.alpha = 1
			else
				texContentTexture.height = 2
				texContentTexture.alpha = 0
			end

			texContentTexture:MakePixelPerfect()
			break
		end
	end
	PageSelectShowHide()

	if #curPageData == 0 then
		labPageIndex.text = ''
	else
		labPageIndex.text = curPageIndex .. '/' .. #curPageData
	end
end

local function UpdateISNil( tag )
	-- body
	objEmpty:SetActive(tag)
	objContent:SetActive(not tag)
end

local function PreviousPage( ... )
	-- body
	if curPageIndex > 0 then
		curPageIndex = curPageIndex - 1
	end
	UpdatePage()
end

local function NextPage( ... )
	-- body
	if curPageIndex < #curPageData then
		curPageIndex = curPageIndex + 1
	end
	UpdatePage()
end

local function ClickTwo( obj )
	-- body
	if curOneLevel then
		tSelect[curOneLevel].Select:SetActive(false)
		tSelect[curOneLevel].Label.color = tColor.Normal
		if curTwoLevel then
			tSelect[curOneLevel].Child[curTwoLevel].Select:SetActive(false)
			tSelect[curOneLevel].Child[curTwoLevel].Label.color = tColor.Normal
		end
	end

	local name = string.split(obj.name, "_")
	curOneLevel = tonumber(name[1])
	curTwoLevel = tonumber(name[2])
	tSelect[curOneLevel].Select:SetActive(true)
	tSelect[curOneLevel].Label.color = tColor.Select
	tSelect[curOneLevel].Child[curTwoLevel].Select:SetActive(true)
	tSelect[curOneLevel].Child[curTwoLevel].Label.color = tColor.Select
	curPageIndex = 1
	UpdatePage()

	UpdateISNil(false)
end

local function LoadTwo()
	-- body
	--Utils.destoryChild( gridTwoLevel.gameObject )
	local oneChildGrid = tSelect[curOneLevel].Grid
	if oneChildGrid.gameObject.activeSelf and tSelect[curOneLevel].Select.activeSelf then
		return
		-- oneChildGrid.gameObject:SetActive(false)
		-- tSelect[curOneLevel].Select:SetActive(false)
	else
		oneChildGrid.gameObject:SetActive(true)
		tSelect[curOneLevel].Select:SetActive(true)
		tSelect[curOneLevel].Label.color = tColor.Select
		local data = LibraryModel.GetData( curOneLevel ).Data
		local obj
		local t
		for i,v in ipairs(data) do
			if oneChildGrid:GetChild(i - 1) then
				obj = oneChildGrid:GetChild(i - 1).gameObject
			else
				obj = NGUITools.AddChild(oneChildGrid.gameObject,objLibraryItem2)
			end
			obj:SetActive(true)
			UIEventListener.Get(obj).onClick = ClickTwo
			obj.name = curOneLevel .. "_" .. i
			obj.transform:Find("Label"):GetComponent("UILabel").text = v.Title
			t = {}
			t.Obj = obj
			t.Select = obj.transform:Find("Select").gameObject
			t.Select:SetActive(false)
			t.Label = obj.transform:Find('Label'):GetComponent('UILabel')
			t.Label.color = tColor.Normal
			tSelect[curOneLevel].Child[i] = t
		end
	end
	if curTwoLevel then
		ClickTwo(tSelect[curOneLevel].Child[curTwoLevel].Obj)
	end
	--ClickTwo(objSelectTwoItem.transform.parent.gameObject)
	oneChildGrid:Reposition()
	tableOneLevel:Reposition()
end

local function ClickOne( obj )
	-- body
	if curOneLevel then
		if curOneLevel == tonumber(obj.name) then
			return
		else
			tSelect[curOneLevel].Grid.gameObject:SetActive(false)
			tSelect[curOneLevel].Select:SetActive(false)
			tSelect[curOneLevel].Label.color = tColor.Normal
			if curTwoLevel then
				tSelect[curOneLevel].Child[curTwoLevel].Select:SetActive(false)
				tSelect[curOneLevel].Child[curTwoLevel].Label.color = tColor.Normal
				curTwoLevel = nil
			end
		end
	end

	curOneLevel = tonumber(obj.name)
	curTwoLevel = 1
	LoadTwo()
	--UpdateISNil(true)
end

local function LoadOne( ... )
	-- body
	--Utils.destoryChild( gridOneLevel.gameObject )
	tSelect = {}
	local data = LibraryModel.GetData()
	local obj
	local t
	for i,v in ipairs(data) do
		if gridOneLevel:GetChild(i - 1) then
			obj = gridOneLevel:GetChild(i - 1).gameObject
		else
			obj = NGUITools.AddChild(gridOneLevel.gameObject,objLibraryItem1)
		end
		obj:SetActive(true)
		
		UIEventListener.Get(obj).onClick = ClickOne
		obj.name = i
		obj.transform:Find("Label"):GetComponent("UILabel").text = v.Title

		t = {}
		t.Select = obj.transform:Find("Select").gameObject
		t.Select:SetActive(false)
		t.Grid = obj.transform:Find("Grid"):GetComponent('UIGrid')
		t.Grid.gameObject:SetActive(false)
		t.Child = {}
		t.Label = obj.transform:Find("Label"):GetComponent('UILabel')
		t.Label.color = tColor.Normal
		t.Obj = obj
		table.insert(tSelect,t)
	end
	tableOneLevel:Reposition()
	gridOneLevel.transform.parent:GetComponent('UIScrollView'):ResetPosition()
end

function this.init( ... )
	-- body
	local tempOneLevel,tempTwoLevel,tempPageIndex = ...

	gridOneLevel = this.page.Find("OneLevel/Grid"):GetComponent("UIGrid")
	--gridTwoLevel = this.page.Find("TwoLevel/Grid"):GetComponent("UIGrid")
	tableOneLevel = gridOneLevel.transform:GetComponent('UITable')

	objLibraryItem1 = this.page.transform:Find('OneItem').gameObject
	objLibraryItem1:SetActive(false)
	objLibraryItem2 = this.page.transform:Find('TwoItem').gameObject
	objLibraryItem2:SetActive(false)
	objPrevious = this.page.Find("Previous")
	objNext = this.page.Find("Next")

	labContentLabel = this.page.Find("ContentLabel"):GetComponent("UILabel")
	labContentTitle = this.page.Find('ContentTitle'):GetComponent("UILabel")
	texContentTexture = this.page.Find("ContentTexture"):GetComponent("UITexture")

	UIEventListener.Get(this.page.Find("Close")).onClick = OnClose

	UIEventListener.Get(objPrevious).onClick = PreviousPage
	UIEventListener.Get(objNext).onClick = NextPage
	local Center = this.page.transform:Find('Center')
	objContent = Center:Find('Content').gameObject
	objEmpty = Center:Find('Empty').gameObject
	UpdateISNil(true)
	labPageIndex = objContent.transform:Find('PageSelect/Label'):GetComponent('UILabel')

	tColor = {}
	tColor.Select = Color.white
	tColor.Normal = labContentLabel.color

	LoadOne()

	--如果外部指定标签页，那就打开个标签页
	if tempOneLevel and tempTwoLevel and tempPageIndex then
		if not tSelect[tempOneLevel] then
			return
		end
		if not tSelect[tempOneLevel].Child[tempTwoLevel] then
			return
		end

		ClickOne(tSelect[tempOneLevel].Obj)
		ClickTwo(tSelect[tempOneLevel].Child[tempTwoLevel].Obj)
		curPageIndex = tempPageIndex
		UpdatePage()
	end
end

function UIBigLibrary.AddShow( ... )
	-- body
	UIBigLibrary:show( ... )
end

UIBigLibraryButton = BaseView:new("UI/Prefab/UIPrefab/UIBigLibrary/","UIBigLibraryButton")
local UIBigLibraryButton = UIBigLibraryButton
function UIBigLibraryButton.init( ... )
	-- body
	UIEventListener.Get(UIBigLibraryButton.page.gameObject).onClick = function ( ... )
		-- body
		UIBigLibrary:show()
	end
end
function UIBigLibraryButton.showOnMainScene( ... )
	-- body
	--UIBigLibraryButton:show()
end