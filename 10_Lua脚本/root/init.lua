
--[[
	辅助脚本
]]
require "bit"
require	"Utils"

--后续Model的添加到initModel.lua中
require 'projx/Model/initModel'
for i,v in ipairs(initModel) do
	require ('projx/Model/' .. v)
end

--后续UI的添加到initUI.lua中
require 'projx/UI/initUI'
for i,v in ipairs(initUI) do
	require ('projx/UI/' .. v)
end
--hacked 检测新老版本文件
--使用dictStatic中新增加的特殊字段
--[[ ios新版打包的中 撤销hack
local newDictionary = ManagerCsv.GetInstance():GetDictionaryStatic(81001)
if not newDictionary then
	print('not read latest csv version, so quit!')
	UnityEngine.Application.Quit()
else
	print('new ver csv loaded, no quit')
end
]]

local opName = VideoManager.GetOPName()
if opName then 
	VideoManager.GetInstance():Load(opName,VideoManager.MovieControlMode.Full,false,false,1)
else
	VideoManager.ClosePVToLoginFormal()
end

local isPrint = false
if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or UnityEngine.Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
	
else
	if not isPrint then
		print = function ( ... )
			-- body
		end
	end
end

--思伟屏蔽词hack，如果删除 直接这两行 2019-04-26 14:14:07 jp 1198sp1
--require 'projx/Patch/UtilLocalMessagePatch'
--UtilLocalMessagePatch.main()

--2019-05-20 16:19:21 login补丁 2019-05-20 16:19:36 jp1198sp3
--require 'projx/Patch/LoginFormalPatch'
--LoginFormalPatch.main()

--2019-06-11 14:10:37 jptest
--require 'projx/Patch/GLoaderPatch'
--GLoaderPatch.main()