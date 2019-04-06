
function string.count (text, search)
	if ( not text or not search ) then return false end
 
	return select ( 2, text:gsub ( search, "" ) )
end

	Tree = {"veg_",'palm','feuillu'}
	Trees = {}
	
function isVegElement(Object)
	for i,v in pairs(Tree) do
		if (string.count((getElementID(Object) or ''),v) or 0) > 0 then
			Trees[Object] = true -- This assigns the object as a tree
		end
	end
end

function VegReload()
	Trees = {}
	for i,v in pairs(getElementsByType('object',resourceRoot)) do
		isVegElement(v)
	end
end


JustDone = {}

function moveStuff()
	Weather1,Weather2 = getWeather()

	if Weather1 == 8 then
		Limit = 10
			else
		Limit = 3
	end


	for i,v in pairs(Trees) do
		if isElement(i) then
			if isElementStreamedIn(i) then
				local x,y,z = getElementPosition(i)

	if JustDone[i] then 
		local nx,ny = unpack(JustDone[i])
			JustDone[i] = nil
		moveObject ( i, 5000,x,y,z,-nx,-ny,0 )
	else
			local xr,yr = math.random(Limit-3,Limit),math.random(Limit-3,Limit)
				JustDone[i] = {xr,yr}
					moveObject ( i, 5000,x,y,z,xr,yr,0 )
				end
			end
		end
	end
end

moveStuff()

setTimer ( moveStuff, 5000, 0)
