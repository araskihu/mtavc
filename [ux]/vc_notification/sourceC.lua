local sx, sy = guiGetScreenSize()

local mediumF = dxCreateFont("fonts/Medium.otf", 12)
local fontawesome = dxCreateFont("fonts/fontawesome.otf", 14)

local notifications = {}

local animationLength = 1000

local typeIcons = {
	--[[["info"] = {"", 46, 134, 250},
	["warning"] = {"", 248, 148, 6},
	["error"] = {"", 217, 30, 24},
	["success"] = {"", 46, 204, 113},
	["jail"] = {"", 247, 202, 24},
	["kick"] = {"", 248, 148, 6},
	["ban"] = {"", 217, 30, 24},]]
	["info"] = {"", 255, 255, 255},
	["warning"] = {"", 255, 255, 255},
	["error"] = {"", 255, 255, 255},
	["success"] = {"", 255, 255, 255},
	["jail"] = {"", 255, 255, 255},
	["kick"] = {"", 255, 255, 255},
	["ban"] = {"", 255, 255, 255},
}

-- NOTIFICATIONS

function showBox(nType, msg)
	if not nType or not msg then return end
	if nType == "info" or nType == "warning" or nType == "error" or nType == "success" or nType == "jail" or nType == "kick" or nType == "ban" then
		table.insert(notifications, {nType, msg, true, 30, 130, 255, getTickCount(), "slideup", sy + 80})
	end
end

addEvent("showBox", true)
addEventHandler("showBox", root, function(type, msg)
	showBox(type, msg)
end)

addEventHandler("onClientRender", root, function()
	if #notifications == 0 then return end

	now = getTickCount()
	elapsedTime = now - notifications[1][7]
	progress = elapsedTime / animationLength

	if notifications[1][8] == "slideup" then
		notifications[1][9] = interpolateBetween(sy + 80, 0, 0, sy - (notifications[1][4] or 30) - 30, 0, 0, progress, "InOutQuad")
		if now >= notifications[1][7] + animationLength then
			notifications[1][9] = sy - (notifications[1][4] or 30) - 30
			notifications[1][7] = getTickCount()
			notifications[1][8] = "open"
		end
	elseif notifications[1][8] == "open" then
		notifications[1][4] = interpolateBetween(30, 0, 0, dxGetTextWidth(notifications[1][2], 0.7, mediumF) + 45, 0, 0, progress, "InOutQuad")

		if now >= notifications[1][7] + animationLength then
			notifications[1][4] = dxGetTextWidth(notifications[1][2], 0.7, mediumF) + 45
			setTimer(function()
				notifications[1][7] = getTickCount()
				notifications[1][8] = "close"
			end, string.len(notifications[1][2]) * 50, 1)
		end
	elseif notifications[1][8] == "close" then
		notifications[1][4] = interpolateBetween(dxGetTextWidth(notifications[1][2], 0.7, mediumF) + 45, 0, 0, 30, 0, 0, progress, "InOutQuad")
		if now >= notifications[1][7] + animationLength then
			notifications[1][7] = getTickCount()
			notifications[1][8] = "slidedown"
		end
	elseif notifications[1][8] == "slidedown" then
		notifications[1][9] = interpolateBetween(sy - (notifications[1][4] or 30) - 30, 0, 0, sy + 80, 0, 0, progress, "InOutQuad")
		if now >= notifications[1][7] + animationLength then
			notifications[1][9] = sy + 80
			table.remove(notifications, 1)
			if #notifications == 0 then return end
			notifications[1][8] = "slideup"
			notifications[1][7] = getTickCount()
		end
	end

	nWidth = notifications[1][4] or 30
	nAlpha = notifications[1][5] or 0
	nText = notifications[1][2] or ""

	dxDrawRoundedRectangle(sx/2 - nWidth/2, notifications[1][9], nWidth, 30, tocolor(0, 0, 0, nAlpha))
	dxDrawRoundedRectangle(sx/2 - nWidth/2, notifications[1][9], 30, 30, tocolor(235, 138, 184, notifications[1][6]))
	dxDrawText(typeIcons[notifications[1][1]][1], (sx/2 - nWidth/2) + 15, notifications[1][9] + 15, (sx/2 - nWidth/2) + 15, notifications[1][9] + 15, tocolor(typeIcons[notifications[1][1]][2], typeIcons[notifications[1][1]][3], typeIcons[notifications[1][1]][4], notifications[1][6]), 1, fontawesome, "center", "center")
	dxDrawText(nText, sx/2 - nWidth/2 + 40, notifications[1][9] + 5, sx/2 - nWidth/2 + nWidth - 5, notifications[1][9] + 27, tocolor(255, 255, 255, 255), 0.7, mediumF, "left", "center", true, false, false)
end)

--[[addCommandHandler("box", function(cmd, type, ...)
	local text = table.concat({...}, " ")
	showBox(type, text)
end)]]

function dxDrawRoundedRectangle(x, y, w, h, color, side)
	side = split(side or "all", "-")
	--iprint(side)
	if table.find(side, "all") then
		-- top
		dxDrawRectangle(x + 3, y - 2, w - 6, 1, color)
		dxDrawRectangle(x + 1, y - 1, w - 2, 1, color)

		-- bottom
		dxDrawRectangle(x + 3, y + h + 1, w - 6, 1, color)
		dxDrawRectangle(x + 1, y + h, w - 2, 1, color)

		-- left
		dxDrawRectangle(x - 2, y + 3, 1, h - 6, color)
		dxDrawRectangle(x - 1, y + 1, 1, h - 2, color)

		-- right
		dxDrawRectangle(x + w + 1, y + 3, 1, h - 6, color)
		dxDrawRectangle(x + w, y + 1, 1, h - 2, color)
	end
	if table.find(side, "left") then
		dxDrawRectangle(x - 2, y + 3, 1, h - 6, color)
		dxDrawRectangle(x - 1, y + 1, 1, h - 2, color)
	end
	if table.find(side, "right") then
		dxDrawRectangle(x + w + 1, y + 3, 1, h - 6, color)
		dxDrawRectangle(x + w, y + 1, 1, h - 2, color)
	end
	if table.find(side, "top") then
		dxDrawRectangle(x + 3, y - 2, w - 6, 1, color)
		dxDrawRectangle(x + 1, y - 1, w - 2, 1, color)
	end
	if table.find(side, "bottom") then
		dxDrawRectangle(x + 3, y + h + 1, w - 6, 1, color)
		dxDrawRectangle(x + 1, y + h, w - 2, 1, color)
	end

	-- inside
	dxDrawRectangle(x, y, w, h, color)
end

function table.find(l, f) -- find element v of l satisfying f(v)
	for _, v in pairs(l) do
		if v == f then
			return true
		end
	end
	return false
end