LibraryModel = {}

local LibraryData

local function GetData( ... )
	-- body
	if not LibraryData then
		LibraryData = Utils.loadCsvFile("Config/ClientExel/DictionaryLibrary.csv",'	')
		local t = {}
		local tempOneLevel
		local tempTwoLevel
		local tempStr
		local language = ManagerCsv.language
		local tempContent
		local tempID
		local tempPageIndex
		for i,v in ipairs(LibraryData) do
			if language == ManagerCsv.Language.tw then
				tempContent = v.content_tw
			elseif language == ManagerCsv.Language.jp then
				tempContent = v.content_jp
			elseif language == ManagerCsv.Language.kr then
				tempContent = v.content_kr
			elseif language == ManagerCsv.Language.en then
				tempContent = v.content_en
			else
				tempContent = v.content_chinese
			end
			if not tempContent or tempContent == '' then
				tempContent = v.content_chinese
			end
			tempStr = string.gsub(tempContent,'#','split',1)
			tempStr = string.split(tempStr,'split')

			tempID = v.ID
			tempID = string.split(tempID,'.')
			if tempID[1] == '0' then
				--不识别
			else
				if tempID[2] == '0' then
					--一级标题
					tempOneLevel = tonumber(tempID[1])
					if t[tempOneLevel] == nil then
						t[tempOneLevel] = {}
					end
					t[tempOneLevel].Title = tempStr[1]
					t[tempOneLevel].Content = tempStr[2]
					t[tempOneLevel].Data = {}
				else
					if tempID[3] == '0' then
						--二级标题
						tempTwoLevel = tonumber(tempID[2])
						if t[tempOneLevel].Data[tempTwoLevel] == nil then
							t[tempOneLevel].Data[tempTwoLevel] = {}
						end
						t[tempOneLevel].Data[tempTwoLevel].Title = tempStr[1]
						t[tempOneLevel].Data[tempTwoLevel].Content = tempStr[2]
						t[tempOneLevel].Data[tempTwoLevel].Data = {}
					else
						--分页 ：正文
						tempPageIndex = tonumber(tempID[3])
						if t[tempOneLevel].Data[tempTwoLevel].Data[tempPageIndex] == nil then
							t[tempOneLevel].Data[tempTwoLevel].Data[tempPageIndex] = {}
						end
						t[tempOneLevel].Data[tempTwoLevel].Data[tempPageIndex].Picture = v.Picture
						t[tempOneLevel].Data[tempTwoLevel].Data[tempPageIndex].Title = tempStr[1]
						t[tempOneLevel].Data[tempTwoLevel].Data[tempPageIndex].Content = tempStr[2]
					end
				end
			end
		end
		LibraryData = t
	end
	return LibraryData
end

function LibraryModel.GetData( ... )
	-- body
	local OneLevel,TwoLevel = ...
	local Data = GetData()
	if OneLevel and TwoLevel then
		return Data[OneLevel].Data[TwoLevel]
	end
	if OneLevel then
		return Data[OneLevel]
	end
	return Data
end