addCommandHandler("gcm", function()
	local sx, sy, sz, sx2, sy2, sz2 = getCameraMatrix()
	outputChatBox(sx .. ", " .. sy .. ", " .. sz .. ", " .. sx2 .. ", " .. sy2 .. ", " .. sz2)
end)

addCommandHandler("getpos", function()
	local x, y, z = getElementPosition(localPlayer)
	outputChatBox(x .. ", " .. y .. ", " .. z)
end)

bindKey("m", "down", function()
	showCursor(not isCursorShowing())
end)