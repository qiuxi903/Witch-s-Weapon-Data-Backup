local this = {}

function this:Start( obj )
	-- body
	local SoldOut = obj.transform:Find('Top/SoldOut'):GetComponent('UISprite')

	if SoldOut.spriteName == 'Mask-Recharge goods' then
		SoldOut.transform.localPosition = Vector3(3.8,-40,0)
	end

	local SoldOut = obj.transform:Find('Top/presell'):GetComponent('UISprite')

	if SoldOut.spriteName == 'Mask-Recharge goods' then
		SoldOut.transform.localPosition = Vector3(3.8,-40,0)
	end

end

return this