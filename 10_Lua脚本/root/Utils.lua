Utils = {}

--- inc path:
--package.path = UnityEngine.Application.dataPath .. "/config/lua/test/?.lua"
--package.path = UnityEngine.Application.dataPath .."/config/lua/3rd/pbc/?.lua"
--[[
	常用量别名
	命名空间对应表
]]
Destroy = UnityEngine.GameObject.Destroy
UserInfoHelper = WaterBell.ProjX.Data.Entity.UserInfoHelper
UserInfo = WaterBell.ProjX.Data.Entity.UserInfo
ShopInfoHelper = WaterBell.ProjX.Data.Entity.ShopInfoHelper
UISceneManager = WaterBell.ProjX.View.UIFrame.UISceneManager
UISceneState = WaterBell.ProjX.View.UIFrame.UISceneState
ClothUIData = WaterBell.ProjX.View.Panel.ClothUIData
UISceneID = WaterBell.ProjX.View.UIFrame.UISceneID
ShopData = WaterBell.ProjX.View.Panel.ShopData
ReminderInfoHelper = WaterBell.ProjX.Data.Entity.ReminderInfoHelper
AwardUtils = WaterBell.ProjX.Common.Utils.AwardUtils
UITool = WaterBell.ProjX.View.Panel.UITool
Package = WaterBell.ProjX.Data.Entity.Package
GameObject = UnityEngine.GameObject
UIDataBase = WaterBell.ProjX.View.Panel.UIDataBase

-- import protobuff.
local protobuf = require "3rd/pbc/protobuf"

local inspect = require("inspect")
local pbCache = {}

-- Parse protobuff:
function Utils.ParseProtobufEx(response, pbfiles, namespace)
	local tbl = {}
	local byteBuffer
	local tag,value = table.containKey(pbCache,namespace)
	if tag then
		byteBuffer = value
	else
		byteBuffer = LuaFramework.ByteBuffer.New()
		for index, value in ipairs(pbfiles) do
			-- read to buffer:
			--[[
			local file = io.open(LuaFramework.Util.DataPath .. "lua/3rd/pbc/".. value ..".pb", "rb")
			if not file then
				file = io.open(LuaFramework.Util.ASPath() .. "lua/3rd/pbc/".. value ..".pb", "rb")
			end
			if not file then
				print("缺少文件:"..value..".pb")
			end
			local buffer = file:read("*a")
			file:close()
			]]
			--local buffer = LuaFramework.Util.GetSAPB(value .. ".txt")
			-- protobuf parse:
			local buffer = AssetsManager.LoadBytesLua('Config/PBC/' .. value .. '.txt')
			protobuf.register(byteBuffer:ReadBuffer(buffer))
		end
		pbCache[namespace] = byteBuffer
	end
	
	local content, err = protobuf.decode(namespace, byteBuffer:ReadBuffer(response.bytes), response.length)
	local isError = false
	local result = inspect(content)
	if string.match(result,"adslfj0o128123lkjnasdf89") then
		isError = true
	else
		isError = false
		protobuf.extract(content)
	end
	table.insert(tbl,isError)
	table.insert(tbl,content)
	return tbl
end

function Utils.SendMessageEx(mode,code, keyvalues, callback)
	if mode == 1 then
		Utils.SendMessage(code, keyvalues, callback)
	else
		Utils.SendMessageInBackGround(code, keyvalues, callback)
	end
end

-- Send net message: 3
function Utils.SendMessage(code, keyvalues, callback)
	proxy = LuaNetProxy.New()
	for k, v in pairs(keyvalues) do
		proxy:AppendKeyValue(k, v)
	end

	proxy.ondata = callback
	proxy:InitParams(code)
	proxy:SendMsg()
end

function Utils.SendMessageInBackGround(code, keyvalues, callback)
	proxy = LuaNetProxy.New()
	for k, v in pairs(keyvalues) do
		proxy:AppendKeyValue(k, v)
	end

	proxy.ondata = callback
	proxy:InitParams(code)
	proxy:TrySendMsgInBackGround()
end

---
--- 根据时间戳获取日期
---
function GetTimeStamp(time)
	return os.date("%Y.%m.%d",time)
end

---
---	比较两个日期，判断哪个日期在前面，哪个日期在后面
---
function DiffDate(date1 , date2)
	local y1 = tostring(string.sub(date1,1,4))
	local y2 = tostring(string.sub(date2,1,4))
	local m1 = tostring(string.sub(date1,6,7))
	local m2 = tostring(string.sub(date2,6,7))
	local d1 = tostring(string.sub(date1,9,10))
	local d2 = tostring(string.sub(date2,9,10))
	local result = false
	if tonumber(y1) >  tonumber(y2) then
		result = true
	else
		if tonumber(m1) > tonumber(m2) then
			result = true
		else
			if tonumber(d1) > tonumber(d2) then
				result = true
			else
				result = false
			end
		end
	end
	return result
end

--将一个%Y:%m:%d:%H:%m:%s(2017:01:01:01:01:01)结构的字符时间转化为时间戳
function Utils.TimeString2Int( time )
	-- body
	local day = tonumber(string.sub(time,9,10))
	local month = tonumber(string.sub(time,6,7))
	local year = tonumber(string.sub(time,1,4))
	local hour = tonumber(string.sub(time,12,13))
	local minute = tonumber(string.sub(time,15,16))
	local second = tonumber(string.sub(time,18,19))
	return os.time({day=day, month=month, year=year, hour=hour, minute=minute, second=second})
end


function Remove(list)
	local i = #list
	while i >= 1 do
		if list[i] ~= nil then
			table.remove(list,i)
		else
			i = i - 1
		end
	end
end

---
---	去掉重复元素【去掉重复的userdata】
---
function Utils.uniqueUserData(t,bArray)
	local check = {}
	local n = {}
	local idx = 1
	for k, v in pairs(t) do
		if not check[v.name] then
			if bArray then
				n[idx] = v
				idx = idx + 1
			else
				n[k] = v
			end
			check[v.name] = true
		end
	end
	return n
end

---
---	标签分隔符
---	当按钮上的文本少于2个字的时候，文本中间要插入2个空白符
---
function SegmentationLabel(text)
	if string.len(text) <= 6 then
		text = string.sub(text,1,3) .. "  " .. string.sub(text,4,6)
	end
	return text
end


---
---	字符串截取
---
function GetStrByChar( strurl, strchar, bafter)
	local ts = string.reverse(strurl)
	local param1, param2 = string.find(ts, strchar)  -- 这里以"/"为例
	local m = string.len(strurl) - param2 + 1
	local result = ""
	if (bafter == true) then
		result = string.sub(strurl, m + 1, string.len(strurl))
	else
		result = string.sub(strurl, 1, m - 1)
	end

	return result
end

---
---	 设置字体颜色和风格(暂不在lua代码层里设置字库)
---
function SetFontStyle(label,r,g,b,style,size)
	if label and r and g and b then
		local color = Color.New(r/255,g/255,b/255)
		label.color = color
	end 
	if style then
		label.fontStyle = style
	end
	if size then
		label.fontSize = size
	end
end

function Utils.split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end

--用于c#打开lua的页面，或调用一些方法
--参数：自定义的页面id
function Utils.ShowPageC2L( ... )
	-- body
	local id = ...
	if id == 0 then
		--主界面扩展UI
		--请求下运营活动数据，用于支持主界面运营活动红点
		if ActivityModel.IsNeedUpdateData then
			ActivityModel.getData2MainScene()
		else
			ActivityModel.checkAllRed2CSharp( ActivityModel.ServerData )
		end
		for i,v in ipairs(BaseView.allView) do
			if v.showOnMainScene then
				v.showOnMainScene()
			end
		end
		-- add by gus
		-- 临时修改下聊天中标签错误问题 1.1.6去掉
		-- GUtilListener.dispatchTime("CHANGE_LANGUAGE", 1);
		require('projx/Patch/MainBattleBtnEffetPatch')
		MainBattleBtnEffetPatch.main()
	elseif id == 1 then
		--运营活动
		--ActivityView:show()
		UIActivitiesButtons:show(true)
	elseif id == 2 then
		--公告
		Notice:show()
	elseif id == 999 then
		--重启游戏
		print("重启游戏")
		--所有加载过得view,调用clearOnReload
		for i,v in ipairs(BaseView.allView) do
			if v.clearOnReload then
				v.clearOnReload()
			end
		end
		UIChatSys.ClearData()
		UIActivitiesModel.IsOpenCafe = false
		ActivityModel.SendMessageFirst = false
		ActivityModel.IsNeedUpdateData = false
	elseif id == 1000 then
		--跨天
		for i,v in ipairs(BaseView.allView) do
			if v.onNewDay then
				v.onNewDay()
			end
		end
		--刷新运营活动数据
		ActivityModel.getData2MainScene()
	end
end

--获取当前服务器时间的时间戳
function Utils.getSeverTime( ... )
	-- body
	return tonumber(tostring(GUtilTime.toUtcTimestamp()))
end

function table.print( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

function table.containKey( t,key )
	-- body
	for k,v in pairs(t) do
		if k == key then
			return true,v
		end
	end
	return false
end

function table.containValue( t,value )
	-- body
	for k,v in pairs(t) do
		if v == value then
			return true,k
		end
	end
	return false
end

function table.clone( object )
    local lookup_table = {}
    local function copyObj( object )
        if type( object ) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs( object ) do
            new_table[copyObj( key )] = copyObj( value )
        end
        return setmetatable( new_table, getmetatable( object ) )
    end
    return copyObj( object )
end

-- 检测前三个字节是否是 EF BB BF 也就是BOM标记；如果是就去掉，只保留后面的字节。
local function TryRemoveUtf8BOM(ret)
    if string.byte(ret,1)==239 and string.byte(ret,2)==187 and string.byte(ret,3)==191 then
        ret=string.char( string.byte(ret,4,string.len(ret)) )
    end
    return ret;
end

--用于获取csv表
function Utils.loadCsvFile(...) 
    -- 读取文件
    local filePath,delimiter = ...
    if not delimiter then
    	delimiter = ','
    end
    local data = AssetsManager.LoadText(filePath);
    -- 按行划分
    local lineStr = Utils.split(data, '\n\r');

    --[[
        第一行是字段，第二行是类型，第三行是描述
    ]]
    local titles = string.split(TryRemoveUtf8BOM(lineStr[1]), delimiter);
    local types = string.split(lineStr[2], delimiter);
    local ID = 1;
    local arrs = {};
    local fillContent
    for i = 4, #lineStr, 1 do
        -- 一行中，每一列的内容
        local content = string.split(lineStr[i], delimiter);

        -- 以标题作为索引，保存每一列的内容，取值的时候这样取：arrs[1].Title
        arrs[ID] = {};
        for j = 1, #titles, 1 do
        	if types[j] == "string" then
        		fillContent = content[j]
        	else 
        		fillContent = tonumber(content[j] == "" and "0" or content[j])
        	end
            arrs[ID][titles[j]] = fillContent
        end

        ID = ID + 1;
    end

    return arrs;
end

function Utils.destoryChild( parent )
	-- body
	if not parent then
		return
	end
	local count = parent.transform.childCount
	for i=1,count do
		Destroy(parent.transform:GetChild(i - 1).gameObject)
	end
end

local function GetTable2ActivityGamePanel( ... )
	-- body
	local t = {}
	local obj = UnityEngine.GameObject.Find("UI Root (3D)/ActivityGameModeOne(Clone)")
	if not obj then
		obj = UnityEngine.GameObject.Find("UI Root (3D)/ActivityGameModeOne(Clone)___Temp_ActivityGamePanel___UnloadOnClose")
	end
	t.obj = obj
	t.slider = obj.transform:Find("SelectMode/Slider"):GetComponent("UISlider")
	t.levels = {}
	t.lastCount = 0
	local levelObj = obj.transform:Find("Levels/Levels")
	for i=0,levelObj.transform.childCount - 2 do
		local childObj = levelObj:GetChild(i).transform:Find("PassIcon")
		table.insert(t.levels,childObj)
	end
	return t
end  
--[[
local table2ActivityGamePanel

function Utils.UpdateBeat( ... )
	-- body
	local isActivityGamePanel = UIFrame.UISceneManager.getInstance():CheckSceneIsShow(UIFrame.UISceneID.ACTIVITY_PLAY_RULE_1_LEVEL_SCENE:ToInt())
	if isActivityGamePanel then
		if not table2ActivityGamePanel or table2ActivityGamePanel.obj:Equals(nil)  then
			table2ActivityGamePanel = GetTable2ActivityGamePanel()
			local count = 0

			for i,v in ipairs(table2ActivityGamePanel.levels) do
				if v.gameObject.activeSelf then
					count = count + 1;
				end
			end
			if count == 0 then
				table2ActivityGamePanel.slider.value = 0
			end
		end

		local count = 0

		for i,v in ipairs(table2ActivityGamePanel.levels) do
			if v.gameObject.activeSelf then
				count = count + 1;
			end
		end

		if count < table2ActivityGamePanel.lastCount then
			--改变value
			table2ActivityGamePanel.slider.value = 0
		end
		table2ActivityGamePanel.lastCount = count
	else 
		table2ActivityGamePanel = nil
	end
end
local UpdateBeat = UpdateBeat
local handle = UpdateBeat:CreateListener(Utils.UpdateBeat,1)
UpdateBeat:AddListener(handle)
]]

--剩余时间展示规则 大于一天 XXX天，小于一天 X时X分X秒
local strDay = ManagerCsv.GetInstance():GetNameStatic('CE40644')--天
local strHour = ManagerCsv.GetInstance():GetNameStatic('CE40645')--小时
local strMinute = ManagerCsv.GetInstance():GetNameStatic('CE40646')--分钟
local strSecond = ManagerCsv.GetInstance():GetNameStatic('CE40647')--秒

--参数：时间差值(秒)
function Utils.showRemainingTime( time )
	-- body
	if not time then
		print('Utils.showRemainingTime( time )参数不能为空')
		return
	end
	local str = ''
	if time > 24 * 60 * 60 then
		str = math.floor(time/(24 * 60 * 60)) .. strDay
	else
		local hour = math.floor(time / (60 * 60))
		local minute = math.floor((time - hour * 60 * 60)/60)
		local second = time - hour * 60* 60 - minute * 60

		str = hour .. strHour .. minute .. strMinute .. second .. strSecond
	end

	return str
end

--给gamneObject添加ButtonEx 用于引导系统
--obj 游戏物体 
--btnType ButtonEx 类型 
--btnTypeKey ButtonEx 类型下子索引 可为空
function Utils.AddButtonEX( obj,btnType,btnTypeKey )
	if not obj or not btnType then
		return
	end
	local btnEx = obj:GetComponent(typeof(ButtonEx))
	if not btnEx then
		btnEx = obj:AddComponent(typeof(ButtonEx))
	end
	btnEx.btnType = btnType
	if btnTypeKey then
		btnEx.btnTypeKey = tostring(btnTypeKey)
	end
end

function Utils.GetRoleInfoByMsg( ... )
	-- body
	local role_id = WaterBell.ProjX.Data.Entity.UserInfo.GetInstance():GetPlayer().RoleID
	local request_params = {roleid = tostring(role_id)}
	local msgid = 20002
	Utils.SendMessage(msgid, request_params, 
		function(response)
			local bytes = response.bytes
			require 'tolua.reflection'          
		    tolua.loadassembly('Assembly-CSharp')

		    local t = typeof('WaterBell.ProjX.Data.NetIO.RoleGetRoleInfoLogic')
		    local func = tolua.getmethod(t, 'ParseProtoBuf',typeof('System.Byte[]'))
		    func:Call(bytes)
		    func:Destroy()
		    func = nil
		end)
end