
CSVPool = {}

local function GetChannelGroup( data )
	-- body
	local arr = {}
	local channel_group = ManagerCsv.GetInstance().channel_group
	for i,v in ipairs(data) do
		if v.channel_group == 0 or v.channel_group == channel_group then
			table.insert(arr,v)
		end
	end
	return arr
end

local CSVServantEquipClient

function CSVPool.ServantEquipClient( ... )
	-- body
	if not CSVServantEquipClient then
		CSVServantEquipClient = Utils.loadCsvFile('Config/ClientExel/ServantEquipClient.csv')
	end
	return CSVServantEquipClient
end

local CSVServantStarInfo

function CSVPool.ServantStarInfo( ... )
	-- body
	if not CSVServantStarInfo then
		CSVServantStarInfo = Utils.loadCsvFile('Config/ClientExel/ServantStarInfo.csv')
	end
	return CSVServantStarInfo
end

local CSVActivityGameData

function CSVPool.ActivityGameData( ... )
	-- body
	if not CSVActivityGameData then
		CSVActivityGameData = Utils.loadCsvFile('Config/ClientExel/ActivityGameData.csv')
		CSVActivityGameData = GetChannelGroup( CSVActivityGameData )
	end
	return CSVActivityGameData
end

local CSVAchievementConfig

function CSVPool.AchievementConfig( ... )
	-- body
	if not CSVAchievementConfig then
		CSVAchievementConfig = Utils.loadCsvFile('Config/ClientExel/AchievementConfig.csv')
	end
	return CSVAchievementConfig
end

local CsvInstanceStructure
function CSVPool.InstanceStructure( ... )
	-- body
	if not CsvInstanceStructure then
		CsvInstanceStructure = Utils.loadCsvFile('Config/ClientExel/InstanceStructure.csv')
	end
	return CsvInstanceStructure
end

local CsvInstanceMobList
function CSVPool.InstanceMobList( ... )
	-- body
	if not CsvInstanceMobList then
		CsvInstanceMobList = Utils.loadCsvFile('Config/ClientExel/InstanceMobList.csv')
	end
	return CsvInstanceMobList
end

local CsvBattleEnvironment
function CSVPool.BattleEnvironment( ... )
	-- body
	if not CsvBattleEnvironment then
		CsvBattleEnvironment = Utils.loadCsvFile('Config/ClientExel/BattleEnvironment.csv')
	end
	return CsvBattleEnvironment
end

local CsvBuff
function CSVPool.Buff( ... )
	-- body
	if not CsvBuff then
		CsvBuff = Utils.loadCsvFile('Config/ClientExel/Buff.csv')
	end
	return CsvBuff
end