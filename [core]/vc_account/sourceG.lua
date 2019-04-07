accountData = {
	["dimension"] = 100,
	["loginCamera"] = {512.93969726563, -94.527702331543, 12.821999549866, 512.17889404297, -93.881683349609, 12.760172843933},
	["characterCamera"] = {477.95208740234, -64.689300537109, 11.493900299072, 477.265625, -65.361099243164, 11.215593338013},
}

function createPeds()
	thePed1 = createPed(138, 498.59033203125, -70.798622131348, 11.452848434448, 155.78576660156)
	setPedAnimation(thePed1, "dancing", "dan_left_a")
	setElementFrozen(thePed1, true)
	setElementDimension(thePed1, accountData["dimension"])

	thePed2 = createPed(137, 497.45361328125, -72.777137756348, 11.452848434448, 329.1471862793)
	setPedAnimation(thePed2, "dancing", "dan_right_a")
	setElementFrozen(thePed2, true)
	setElementDimension(thePed2, accountData["dimension"])

	thePed3 = createPed(68, 497.24365234375, -75.562294006348, 11.446062088013, 308.93200683594)
	setPedAnimation(thePed3, "dancing", "dnce_m_a")
	setElementFrozen(thePed3, true)
	setElementDimension(thePed3, accountData["dimension"])

	thePed4 = createPed(12, 483.42919921875, -86.869911193848, 11.446062088013, 297.33578491211)
	setPedAnimation(thePed4, "dancing", "dan_up_a")
	setElementFrozen(thePed4, true)
	setElementDimension(thePed4, accountData["dimension"])

	thePed5 = createPed(21, 487.06982421875, -88.342567443848, 11.446062088013, 311.43695068359)
	setPedAnimation(thePed5, "dancing", "dnce_m_a")
	setElementFrozen(thePed5, true)
	setElementDimension(thePed5, accountData["dimension"])

	thePed6 = createPed(55, 502.84136962891, -92.472969055176, 10.18327903747, 304.97689819336)
	setPedAnimation(thePed6, "GHANDS", "gsign2")
	setElementFrozen(thePed6, true)
	setElementDimension(thePed6, accountData["dimension"])

	thePed7 = createPed(59, 503.84820556641, -91.680976867676, 10.161170959473, 124.73791503906)
	setPedAnimation(thePed7, "GHANDS", "gsign4")
	setElementFrozen(thePed7, true)
	setElementDimension(thePed7, accountData["dimension"])

	thePed8 = createPed(206, 492.17047119141, -95.388008117676, 10.461842536926, 358.96453857422)
	setPedAnimation(thePed8, "GHANDS", "gsign2")
	setElementFrozen(thePed8, true)
	setElementDimension(thePed8, accountData["dimension"])
	--


	--Igazoltatás.
	thePed9 = createPed(98, 502.73199462891, -75.370429992676, 10.042825698853, 268.67199707031)
	setPedAnimation(thePed9, "COP_AMBIENT", "Coplook_loop", -1, true, false, false, false)
	setElementFrozen(thePed9, true)
	setElementDimension(thePed9, accountData["dimension"])

	thePed10 = createPed(266, 503.74273681641, -76.220039367676, 10.10337638855, 48.865203857422)
	setPedAnimation(thePed10, "COP_AMBIENT", "Coplook_shake", -1, true, false, false, false)
	setElementFrozen(thePed10, true)
	setElementDimension(thePed10, accountData["dimension"])

	thePed11 = createPed(267, 503.89605712891, -74.744453430176, 10.112128257751, 105.67083740234)
	setPedAnimation(thePed11, "COP_AMBIENT", "Coplook_think", -1, true, false, false, false)
	setElementFrozen(thePed11, true)
	setElementDimension(thePed11, accountData["dimension"])
	--


	--Járművek.
	vehicle1 = createVehicle(598, 509.98590087891, -73.706367492676, 10.409617233276, 0, 0, 180.07567443848)  -- Rendőrkocsi
	setElementDimension(vehicle1, accountData["dimension"])

	vehicle2 = createVehicle(506, 510.14801025391, -81.362617492676, 10.209617233276, 0, 0, 180.51635742188)  -- BMW M5
	setElementDimension(vehicle2, accountData["dimension"])

	vehicle3 = createVehicle(400, 500.14605712891, -97.467109680176, 10.714624977112, 0, 0, 89.399871826172)  -- BMW M5
	setElementDimension(vehicle3, accountData["dimension"])

	vehicle4 = createVehicle(541, 491.71539306641, -97.491523742676, 10.31513824463, 0, 0, 90)  -- Ugráló
	setElementDimension(vehicle4, accountData["dimension"])

	vehicle5 = createVehicle(439, 510.06402587891, -90.828437805176, 10.221513824463, 0, 0, 179.01447753906)  -- BMW M5
	setElementDimension(vehicle5, accountData["dimension"])
			
	--

	--Játékkezdés háttér.
	thePed12 = createPed(55, 483.69262695312, -77.891220092773, 11.445568084717, 283.00390625)
	setPedAnimation(thePed12, "GHANDS", "gsign2")
	setElementFrozen(thePed12, true)
	setElementDimension(thePed12, accountData["dimension"])

	thePed13 = createPed(205, 486.07055664062, -77.788681030273, 11.445568084717, 81.324768066406)
	setPedAnimation(thePed13, "GHANDS", "gsign4")
	setElementFrozen(thePed13, true)
	setElementDimension(thePed13, accountData["dimension"])

	thePed14 = createPed(12, 474.64794921875, -66.27269744873, 9.9436388015747, 263.42047119141)
	setPedAnimation(thePed14, "dancing", "dan_up_a")
	setElementFrozen(thePed14, true)
	setElementDimension(thePed14, accountData["dimension"])

	thePed15 = createPed(21, 478.68798828125, -67.00804901123, 9.9436388015747, 69.39892578125)
	setPedAnimation(thePed15, "dancing", "dnce_m_a")
	setElementFrozen(thePed15, true)
	setElementDimension(thePed15, accountData["dimension"])

	thePed16 = createPed(138, 479.50146484375, -62.02172088623, 9.9436388015747, 187.03135681152)
	setPedAnimation(thePed16, "dancing", "dan_left_a")
	setElementFrozen(thePed16, true)
	setElementDimension(thePed16, accountData["dimension"])

	thePed17 = createPed(137, 476.16650390625, -59.97679901123, 9.9436388015747, 212.41564941406)
	setPedAnimation(thePed17, "dancing", "dan_right_a")
	setElementFrozen(thePed17, true)
	setElementDimension(thePed17, accountData["dimension"])

	thePed18 = createPed(68, 481.94287109375, -66.70043182373, 9.9436388015747, 45.382476806641)
	setPedAnimation(thePed18, "dancing", "dnce_m_a")
	setElementFrozen(thePed18, true)
	setElementDimension(thePed18, accountData["dimension"])

	playerPed = createPed(26, 472.26235961914, -70.340110778809, 10.445568084717, 316)
	setPedAnimation(playerPed, "dancing", "dnce_m_a")
	setElementFrozen(playerPed, true)
	setElementDimension(playerPed, accountData["dimension"])
end

function createCars()

end