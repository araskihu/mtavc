addCommandHandler("gcm", function()
	local sx, sy, sz, sx2, sy2, sz2 = getCameraMatrix()
	outputChatBox(sx .. ", " .. sy .. ", " .. sz .. ", " .. sx2 .. ", " .. sy2 .. ", " .. sz2)
end)

addCommandHandler("getpos", function()
	local x, y, z = getElementPosition(localPlayer)
	local rx, ry, rz = getElementRotation(localPlayer)
	outputChatBox(x .. ", " .. y .. ", " .. z)
	outputChatBox("Rotáció: " .. rz)
end)

bindKey("m", "down", function()
	showCursor(not isCursorShowing())
end)

function buttonClick(dX, dY, dSz, dM, eX, eY)
	if eX >= dX and eX <= dX+dSz and eY >= dY and eY <= dY+dM then
		return true
	else
		return false
	end
end

function walk()
	setControlState("walk", true)
end
walk()
setTimer(walk, 200, 0)