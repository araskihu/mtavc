local sx, sy = guiGetScreenSize()

local mediumF = dxCreateFont("fonts/Medium.otf", 12)
local regularF = dxCreateFont("fonts/Regular.otf", 12)
local fontawesomeF = dxCreateFont("fonts/fontawesome.otf", 14)

local panel = {}
panel.cPanel = "main"

panel.logow, panel.logoh = 239, 140
panel.w, panel.h = 325, 400
panel.x, panel.y = sx + panel.w, sy/2 - (panel.h + panel.logoh + 50)/2
panel.iw, panel.ih = 300, 45
panel.bgAlpha = 0
panel.tAlpha = 0
panel.iAlpha = 0

panel.rememberChecked = true

panel.lbHover, panel.rbHover = "out", "out"
panel.lbTick, panel.rbTick = getTickCount(), getTickCount()

panel.lr, panel.lg, panel.lb = 0, 0, 0
panel.rr, panel.rg, panel.rb = 0, 0, 0

panel.unEdit, panel.pwEdit = false, false
panel.unEditing, panel.pwEditing = false, false
panel.editLineTick = getTickCount()
panel.editLineTime = 250

panel.lPhase = "start"

addEventHandler("onClientResourceStart", resourceRoot, function()
	startLogin()
end)

function startLogin()
	fadeCamera(false)
	createPeds()
	setElementDimension(localPlayer, accountData["dimension"])
	setTimer(function()
		setCameraMatrix(accountData["loginCamera"][1], accountData["loginCamera"][2], accountData["loginCamera"][3], accountData["loginCamera"][4], accountData["loginCamera"][5], accountData["loginCamera"][6])
		fadeCamera(true)
		setTime(0, 0)
		showCursor(true)
	--	showChat(false)
		setPlayerHudComponentVisible("all", false)
		panel.cPanel = "main"
		addEventHandler("onClientRender", root, renderPanel)
		addEventHandler("onClientClick", root, clickPanel)
		addEventHandler("onClientKey", root, keyPanel)
		animate(0, 180, "InOutQuad", 2250, function(n)
			panel.bgAlpha = n
		end)
		animate(panel.x, sx - 25 - panel.w, "InOutQuad", 2000, function(n) panel.x = n end)

		if not isElement(panel.unEdit) and not isElement(panel.pwEdit) then
			inputX = sx - 25 - panel.w + (panel.w - panel.iw)/2
			panelY = panel.y + panel.logoh + 25
			panel.unEdit = guiCreateEdit(inputX + panel.ih, panelY + 12.5, panel.iw - panel.ih, panel.ih, "", true)
			panel.pwEdit = guiCreateEdit(inputX + panel.ih, panelY + 25 + panel.ih + 25, panel.iw - panel.ih, panel.ih, "", true)

			guiEditSetMaxLength(panel.unEdit, 13)
			guiEditSetMaxLength(panel.pwEdit, 24)

			guiSetInputMode("no_binds_when_editing")
		end
	end, 2000, 1)
end

function renderPanel()
	if panel.cPanel == "main" then
		inputX = panel.x + (panel.w - panel.iw)/2
		panelY = panel.y + panel.logoh + 25
		dxDrawImage(panel.x + (panel.w - panel.logow)/2, panel.y, panel.logow, panel.logoh, "files/logovc.png")
		dxDrawRoundedRectangle(panel.x, panelY, panel.w, panel.h, tocolor(0, 0, 0, panel.bgAlpha))

		-- username input
		dxDrawRoundedRectangle(inputX, panelY + 12.5, panel.iw, panel.ih, tocolor(0, 0, 0, panel.bgAlpha))
		dxDrawRoundedRectangle(inputX, panelY + 12.5, panel.ih, panel.ih, tocolor(0, 0, 0, panel.bgAlpha), "left-top-bottom")
		dxDrawText("", inputX + panel.ih/2, panelY + 12.5 + panel.ih/2, inputX + panel.ih/2, panelY + 12.5 + panel.ih/2, tocolor(255, 255, 255, 255), 1, fontawesomeF, "center", "center")

		unText = guiGetText(panel.unEdit) or ""
		dxDrawText(unText, inputX + panel.ih + 10, panelY + 12.5 + panel.ih/2, inputX, panelY + 12.5 + panel.ih/2, tocolor(255, 255, 255, 255), 1, mediumF, "left", "center")

		-- password input
		dxDrawRoundedRectangle(inputX, panelY + 25 + panel.ih + 25, panel.iw, panel.ih, tocolor(0, 0, 0, panel.bgAlpha))
		dxDrawRoundedRectangle(inputX, panelY + 25 + panel.ih + 25, panel.ih, panel.ih, tocolor(0, 0, 0, panel.bgAlpha), "left-top-bottom")
		dxDrawText("", inputX + panel.ih/2, panelY + 25 + panel.ih + 25 + panel.ih/2, inputX + panel.ih/2, panelY + 25 + panel.ih + 25 + panel.ih/2, tocolor(255, 255, 255, 255), 1, fontawesomeF, "center", "center")

		pwText2 = ""
		pwText = guiGetText(panel.pwEdit) or ""
		pwLength = string.len(pwText)

		if pwLength > 0 then
			pwText2 = ""
		end

		for i = 1, pwLength do
			pwText2 = pwText2 .. "*"
		end

		dxDrawText(pwText2, inputX + panel.ih + 10, panelY + 25 + panel.ih + 30 + panel.ih/2, inputX, panelY + 25 + panel.ih + 30 + panel.ih/2, tocolor(255, 255, 255, 255), 1, mediumF, "left", "center")

		lineAlpha = 0

		if panel.unEditing or panel.pwEditing then
			local now = getTickCount()
			local elapsedTime = now - panel.editLineTick
			local progress = elapsedTime / panel.editLineTime
			if panel.lPhase == "start" then
				lineAlpha = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "InOutQuad")

				if now >= panel.editLineTick + panel.editLineTime + 500 then
					panel.editLineTick = getTickCount()
					panel.lPhase = "end"
				end
			elseif panel.lPhase == "end" then
				lineAlpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress, "InOutQuad")

				if now >= panel.editLineTick + panel.editLineTime then
					panel.editLineTick = getTickCount()
					panel.lPhase = "start"
				end
			end
		end

		if panel.unEditing then
			dxDrawRectangle(inputX + panel.ih + 10 + dxGetTextWidth(unText, 1, mediumF) + 3, panelY + 12.5 + panel.ih/4, 2, panel.ih/2, tocolor(255, 255, 255, lineAlpha))
		elseif panel.pwEditing then
			dxDrawRectangle(inputX + panel.ih + 10 + dxGetTextWidth(pwText2, 1, mediumF) + 3, panelY + 25 + panel.ih + 25 + panel.ih/4, 2, panel.ih/2, tocolor(255, 255, 255, lineAlpha))
		end

		dxDrawRoundedRectangle(inputX, panelY + 25 + panel.ih*3 + 25, 25, 25, tocolor(0, 0, 0, panel.bgAlpha))
		dxDrawText("Remember me", inputX + 40, panelY + 25 + panel.ih*3 + 25 + 25/2, inputX, panelY + 25 + panel.ih*3 + 25 + 25/2, tocolor(255, 255, 255, 255), 1, regularF, "left", "center")

		if panel.rememberChecked then
			dxDrawText("", inputX + 25/2, panelY + 25 + panel.ih*3 + 25 + 25/2, inputX + 25/2, panelY + 25 + panel.ih*3 + 25 + 25/2, tocolor(235, 138, 184, 255), 0.7, fontawesomeF, "center", "center")
		end

		dxDrawText("An awesome open-source project", inputX, panelY + panel.h/2 + 35, inputX, panelY, tocolor(255, 255, 255, 255), 1, regularF, "left", "top")

		dxDrawRoundedRectangle(inputX, panelY + panel.h - panel.ih*2 - 25, panel.iw, panel.ih, tocolor(panel.lr, panel.lg, panel.lb, panel.bgAlpha))
		dxDrawText("Sign In", inputX + panel.iw/2, panelY + panel.h - panel.ih*2 - 25 + panel.ih/2, inputX + panel.iw/2, panelY + panel.h - panel.ih*2 - 25 + panel.ih/2, tocolor(255, 255, 255, 255), 1, mediumF, "center", "center")

		dxDrawRoundedRectangle(inputX, panelY + panel.h - panel.ih - 12.5, panel.iw, panel.ih, tocolor(panel.rr, panel.rg, panel.rb, panel.bgAlpha))
		dxDrawText("Sign Up", inputX + panel.iw/2, panelY + panel.h - panel.ih - 12.5 + panel.ih/2, inputX + panel.iw/2, panelY + panel.h - panel.ih - 12.5 + panel.ih/2, tocolor(255, 255, 255, 255), 1, mediumF, "center", "center")

		-- hover effects

		if isMouseInPosition(inputX, panelY + panel.h - panel.ih*2 - 25, panel.iw, panel.ih) then
			if panel.lbHover == "out" then
				panel.lbHover = "on"
				panel.lbTick = getTickCount()
			end
		elseif not isMouseInPosition(inputX, panelY + panel.h - panel.ih*2 - 25, panel.iw, panel.ih) then
			if panel.lbHover == "on" then
				panel.lbHover = "out"
				panel.lbTick = getTickCount()
			end
		end

		if isMouseInPosition(inputX, panelY + panel.h - panel.ih - 12.5, panel.iw, panel.ih) then
			if panel.rbHover == "out" then
				panel.rbHover = "on"
				panel.rbTick = getTickCount()
			end
		elseif not isMouseInPosition(inputX, panelY + panel.h - panel.ih - 12.5, panel.iw, panel.ih) then
			if panel.rbHover == "on" then
				panel.rbHover = "out"
				panel.rbTick = getTickCount()
			end
		end

		if panel.lbHover == "on" then
			local now = getTickCount()
			local elapsedTime = now - panel.lbTick
			local duration = 500
			local progress = elapsedTime / duration
			panel.lr, panel.lg, panel.lb = interpolateBetween(panel.lr, panel.lg, panel.lb, 235, 138, 184, progress, "InOutQuad")
		elseif panel.lbHover == "out" then
			local now = getTickCount()
			local elapsedTime = now - panel.lbTick
			local duration = 500
			local progress = elapsedTime / duration
			panel.lr, panel.lg, panel.lb = interpolateBetween(panel.lr, panel.lg, panel.lb, 0, 0, 0, progress, "InOutQuad")
		end

		if panel.rbHover == "on" then
			local now = getTickCount()
			local elapsedTime = now - panel.rbTick
			local duration = 500
			local progress = elapsedTime / duration
			panel.rr, panel.rg, panel.rb = interpolateBetween(panel.rr, panel.rg, panel.rb, 235, 138, 184, progress, "InOutQuad")
		elseif panel.rbHover == "out" then
			local now = getTickCount()
			local elapsedTime = now - panel.rbTick
			local duration = 500
			local progress = elapsedTime / duration
			panel.rr, panel.rg, panel.rb = interpolateBetween(panel.rr, panel.rg, panel.rb, 0, 0, 0, progress, "InOutQuad")
		end

		--dxDrawText("Vice Roleplay", panel.x, panel.y, panel.x, panel.y, tocolor(255, 255, 255, 255), 1, mediumF, "left", "top")
	end
end

function clickPanel(b, s, x, y)
	if b == "left" and s == "down" then
		if panel.cPanel == "main" then
			if exports["vc_core"]:buttonClick(inputX + panel.ih, panelY + 12.5, panel.iw - panel.ih, panel.ih, x, y) then
				if not isElement(panel.unEdit) then return end
				if panel.pwEditing then panel.pwEditing = false end
				if not panel.unEditing then
					panel.editLineTick = getTickCount()
					panel.lPhase = "start"
				end
				panel.unEditing = true
				if guiEditSetCaretIndex(panel.unEdit, string.len(guiGetText(panel.unEdit) or "")) then
					guiBringToFront(panel.unEdit)
				end
			elseif exports["vc_core"]:buttonClick(inputX + panel.ih, panelY + 25 + panel.ih + 25, panel.iw - panel.ih, panel.ih, x, y) then
				if not isElement(panel.pwEdit) then return end
				if panel.unEditing then panel.unEditing = false end
				if not panel.pwEditing then
					panel.editLineTick = getTickCount()
					panel.lPhase = "start"
				end
				panel.pwEditing = true
				if guiEditSetCaretIndex(panel.pwEdit, string.len(guiGetText(panel.pwEdit) or "")) then
					guiBringToFront(panel.pwEdit)
				end
			else
				if panel.unEditing then panel.unEditing = false end
				if panel.pwEditing then panel.pwEditing = false end
			end
			if exports["vc_core"]:buttonClick(inputX, panelY + panel.h - panel.ih*2 - 25, panel.iw, panel.ih, x, y) then
				if string.len(guiGetText(panel.unEdit) or "") < 3 then exports["vc_notification"]:showBox("error", "A felhasználónévnek legalább 3 karakternek kell lennie.") return end
				if string.len(guiGetText(panel.pwEdit) or "") < 6 then exports["vc_notification"]:showBox("error", "A jelszónak legalább 6 karakternek kell lennie.") return end
			elseif exports["vc_core"]:buttonClick(inputX, panelY + panel.h - panel.ih - 12.5, panel.iw, panel.ih, x, y) then
				if string.len(guiGetText(panel.unEdit) or "") < 3 then exports["vc_notification"]:showBox("error", "A felhasználónévnek legalább 3 karakternek kell lennie.") return end
				if string.len(guiGetText(panel.pwEdit) or "") < 6 then exports["vc_notification"]:showBox("error", "A jelszónak legalább 6 karakternek kell lennie.") return end
			end
		end
	end
end

function keyPanel(key, state)
	if not state then return end
	if key == "tab" then
		if panel.unEditing then
			panel.unEditing = false
			panel.editLineTick = getTickCount()
			panel.lPhase = "start"
			panel.pwEditing = true
		elseif panel.pwEditing then
			panel.pwEditing = false
			panel.editLineTick = getTickCount()
			panel.lPhase = "start"
			panel.unEditing = true
		end
	end
end

addCommandHandler("resetlogin", function()
	setCameraTarget(localPlayer)
	showCursor(false)
	showChat(true)
	setPlayerHudComponentVisible("all", true)
	removeEventHandler("onClientRender", root, renderPanel)
end)

-- HELPS

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

function isMouseInPosition(x, y, width, height)
	if not isCursorShowing() then return false end
    local cx, cy = getCursorPosition()
    local cx, cy = cx * sx, cy * sy
    if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
        return true
    else
        return false
    end
end

local anims = {}

function table.find(l, f) -- find element v of l satisfying f(v)
	for _, v in pairs(l) do
		if v == f then
			return true
		end
	end
	return false
end

function animate(f, t, easing, duration, onChange, onEnd)
	assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
	assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
	assert(type(easing) == "string" or (type(easing) == "number" and easing >= 1), "Bad argument @ 'animate' [Invalid easing at argument 3]")
	assert(type(duration) == "number", "Bad argument @ 'animate' [expected function at argument 4, got "..type(duration).."]")
	assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
	table.insert(anims, {from = f, to = t, easing = easing, duration = duration, start = getTickCount(), onChange = onChange, onEnd = onEnd})
	return #anims
end

function destroyAnimation(a)
	if anims[a] then
		table.remove(anims, a)
	end
end

addEventHandler("onClientRender", root, function( )
	local now = getTickCount()
	for k,v in ipairs(anims) do
		v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
		if now >= v.start+v.duration then
			if type(v.onEnd) == "function" then
				v.onEnd()
			end
			table.remove(anims, k)
		end
	end
end)