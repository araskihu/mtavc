Off = {}
NightElements = {}


function isNightElement(Object)

local id = getElementID(Object)

if type(ObjectDefintions[id]) == 'table' then
	if tonumber(ObjectDefintions[id].On) then
		NightElements[id] = NightElements[id] or {}
		Off[id] = Off[id] or false
		NightElements[id][#NightElements[id]+1] = Object
		
					if getLowLODElement(Object) then
						NightElements[id][#NightElements[id]+1] = getLowLODElement(Object)
			end
		end
	end
end

function NightReload()
	NightElements = {}
	for i,v in pairs(getElementsByType('object',resourceRoot)) do
		isNightElement(v)
	end
end


function isInTimeRange(Start,End)
hour = getTime()

	if Start > End then
		return (hour < Start and hour > End)
	else
		return (not (hour < End and hour > Start))
	end
end


function Check2()

	
for i,v in pairs(NightElements) do
	
	if not tonumber(ObjectDefintions[i].On) then
		NightReload()
	else
	
	if isInTimeRange(tonumber(ObjectDefintions[i].On),tonumber(ObjectDefintions[i].Off)) then
		if not Off[i] then
			Off[i] = true
				for iA,vA in pairs(v) do
					if isElement(vA) then
						setObjectScale(vA,0)
					end
				end
			end
	else
		if Off[i] then
			Off[i] = false
				for iA,vA in pairs(v) do
					if isElement(vA) then
						setObjectScale(vA,1)
						end
					end
				end
			end
		end
	end
end

setTimer(Check2,1000,0)
