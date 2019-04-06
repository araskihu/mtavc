local systemCams = {
	{},
}

local aState = false

addCommandHandler("alogin", function()
	aState = not aState
	fadeCamera(false)
	setTime(0, 0)
	setTimer(function()
		if aState then setCameraMatrix(512.93969726563, -94.527702331543, 12.821999549866, 512.17889404297, -93.881683349609, 12.760172843933) end
		fadeCamera(true)
	end, 2000, 1)
	setElementDimension(localPlayer, accountData["dimension"])
	if not aState then
		setElementDimension(localPlayer, 0)
		setCameraTarget(localPlayer)
	end
end)