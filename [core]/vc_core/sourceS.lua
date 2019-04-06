local sX, sY, sZ = 513.4, -87, 10.39

addEventHandler("onPlayerJoin", root, function()
	spawnPlayer(source, sX, sY, sZ, 0, 184)
	fadeCamera(source, true)
end)