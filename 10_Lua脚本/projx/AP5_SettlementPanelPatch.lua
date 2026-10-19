local this = {}

function this:Start( obj )
	-- body
	local OtherInfo = obj.transform:Find('OtherInfo')
	if not OtherInfo.gameObject.activeSelf then
		return
	end
	local temp
	local tLabel_Value = {}
	for i=1,OtherInfo.childCount do
		temp = OtherInfo:GetChild(i - 1)
		temp = temp.transform:Find('Label_Value'):GetComponent('UILabel')
		table.insert(tLabel_Value,temp)
	end

	local AddScore = 0

	for i=1,4 do
		AddScore = AddScore + tonumber(tLabel_Value[i].text)
	end

	local Score = obj.transform:Find('Score/Label (1)'):GetComponent('UILabel')

	tLabel_Value[5].text = tonumber(Score.text) - AddScore
end

return this