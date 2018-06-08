--������ �������� �� ������ ����� ����� �� �����: http://www.rubbishman.ru/samp
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("GLONASS")
script_version("2.0")
script_author("James_Bond/rubbishman/Coulson")
script_description("/glonass")
-------------------------------------var----------------------------------------
color = 0x348cb2
local sampev = require 'lib.samp.events'
local inicfg = require 'inicfg'
local dlstatus = require('moonloader').download_status
local data = inicfg.load({
	options =
	{
		startmessage = 1,
		autoupdate = 1,
	},
}, 'glonass')
--------------------------------------------------------------------------------
-------------------------------------ONLOAD-------------------------------------
--------------------------------------------------------------------------------
function onload()
	if not doesDirectoryExist("moonloader\\config") then createDirectory("moonloader\\config") end
	if not doesFileExist("moonloader\\config\\glonass.ini") then
		inicfg.save(data, "glonass")
		sampAddChatMessage(('������ ������ GLONASS. ��� ������ .ini: moonloader\\config\\glonass.ini'), color)
	end
	inicfg.save(data, "glonass")
	sampRegisterChatCommand('glean', glean)
	sampRegisterChatCommand('glonassnot', cmdGlonassInform)
	sampRegisterChatCommand('glonass', glonassmenu)
	sampRegisterChatCommand('glonasslog', changelog)
	hotkey = 0
	folme = lua_thread.create_suspended(followme)
	ifolu5 = lua_thread.create_suspended(ifolu5)
	ifolu6 = lua_thread.create_suspended(ifolu6)
	ifolu7 = lua_thread.create_suspended(ifolu7)
	ifolu8 = lua_thread.create_suspended(ifolu8)
	folme:terminate()
	ifolu5:terminate()
	ifolu6:terminate()
	ifolu7:terminate()
	ifolu8:terminate()
end
--------------------------------------------------------------------------------
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
	while not isSampAvailable() do wait(100) end
	if data.options.autoupdate == 1 then
		update()
		while update ~= false do wait(100) end
	end
	onload()
	if data.options.startmessage == 1 then
		sampAddChatMessage(('������� v'..thisScript().version..' �������. �����: James_Bond/rubbishman/Coulson.'),
		color)
		sampAddChatMessage(('��������� - /glonass. ��������� ��� ��������� - /glonassnot'), color)
	end
	while true do
		if menutrigger ~= nil then menu() menutrigger = nil end
		wait(0)
		chatcapture()
		whereami()
		cleaner()
		callhelp()
		iwillhelp()
		fastresponde()
	end
end
--------------------------------------------------------------------------------
--------------------------------------SEND--------------------------------------
--------------------------------------------------------------------------------
-- ���� �������� ������
function callhelp()
	if not isPauseMenuActive() and isPlayerPlaying(playerHandle) and sampIsChatInputActive() == false and isSampfuncsConsoleActive() == false and isKeyDown(80) and sampIsDialogActive() == false then
		sampShowDialog(983, "������� by rubbishman - �������", string.format("[1] ����� ������ � �����������\n[2] �������� ���� ����������\n[3] ������� �������, ��������� �������\n[4] ������� �������, ��������� ����\n[5] ������� �������, ��������� ���������\n[6] �������� �� ���� (����������)\n[7] ����� ������ � ������, ������� (����������)\n[8] ����� ������ � ������, ������ (����������)\n[9] ���� ���� (����������, ������ � ����)\n[10] ������� ������ � ���������� �������� \n[11] ������� ������ � ���������� �������� \n[12] ������� ������ � ���������� ���� "), "�������", "�������", 2)
		while sampIsDialogActive() do
			wait(0)
			if isKeyDown(49) or isKeyDown(50) or isKeyDown(51) or isKeyDown(52) or isKeyDown(53) or isKeyDown(54) or isKeyDown(55) or isKeyDown(56) or isKeyDown(57) then
				if isKeyDown(49) then hotkey = 1 end
				if isKeyDown(50) then hotkey = 2 end
				if isKeyDown(51) then hotkey = 3 end
				if isKeyDown(52) then hotkey = 4 end
				if isKeyDown(53) then hotkey = 5 end
				if isKeyDown(54) then hotkey = 6 end
				if isKeyDown(55) then hotkey = 7 end
				if isKeyDown(56) then hotkey = 8 end
				if isKeyDown(57) then hotkey = 9 end
				if isKeyDown(58) then hotkey = 10 end
				sampCloseCurrentDialogWithButton(0)
			end
		end
		local resultMain, buttonMain, typ = sampHasDialogRespond(983)
		if buttonMain == 1 or hotkey > 0 then
			if hotkey > 0 then
				bhelp(hotkey - 1) hotkey = 0
			else
				bhelp(typ)
			end
		end
	end
end
-- ���������� �������� ������
function bhelp(calltype)
	whereami()
	if cX ~= nil and cY ~= nil and cZ ~= nil then
		color = 0xEFB21
		bcX = math.ceil(cX + 3000)
		bcY = math.ceil(cY + 3000)
		bcZ = math.ceil(cZ)
		while bcZ < 1 do bcZ = bcZ + 1 end
		if calltype == 0 then sampSendChat('/f [��O�AC�]: 10-34 '..BOL..'! ��� ����������: N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
		if calltype == 1 then sampSendChat('/f [��O�AC�]: ������� ���� ����������! �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
		if calltype == 2 then sampSendChat('/f [��O�AC�]: �������� �������, ����� �������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
		if calltype == 3 then sampSendChat('/f [��O�AC�]: �������� �������, ����� ����. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
		if calltype == 4 then sampSendChat('/f [��O�AC�]: �������� �������, ����� ��������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
		if calltype == 5 then
			if folme:status() == 'dead' then
				sampSendChat('/f [��O�AC�]: �������� �� ����! �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!')
				folme:run(calltype)
			else
				sampSendChat('/f [��O�AC�]: ����� ���������� ��������!')
				folme:terminate()
			end
			calltype = -1
		end
		if calltype == 6 then
			if folme:status() == 'dead' then
				sampSendChat('/f [��O�AC�]: ������! � �������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!')
				folme:run(calltype)
			else
				sampSendChat('/f [��O�AC�]: ����� OXOTHIK ��������!')
				folme:terminate()
			end
			calltype = -1
		end
		if calltype == 7 then
			if folme:status() == 'dead' then
				sampSendChat('/f [��O�AC�]: ������! � ������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!')
				folme:run(calltype)
			else
				sampSendChat('/f [��O�AC�]: ����� JERTVA ��������!')
				folme:terminate()
			end
			calltype = -1
		end
		if calltype == 8 then
			if folme:status() == 'dead' then
				sampSendChat('/f [��O�AC�]: ���� ����. �������: '..KVX..'! ����������: N'..bcX..'E'..bcY..'Z'..bcZ..'!')
				folme:run(calltype)
			else
				sampSendChat('/f [��O�AC�]: ����� FURA ��������!')
				folme:terminate()
			end
			calltype = -1
		end
		if calltype == 9 then
			if whichhospital(BOL) ~= nil then
				if whichhospital(BOL) == 1 then sampSendChat('/f [��O�AC�] ����� ������� ���� ��������, ������� '..BOL) typ = -1 end
				if whichhospital(BOL) == 2 then sampSendChat('/f [��O�AC�] ����� ������� �������� � ��, ������� '..BOL) typ = -1 end
				if whichhospital(BOL) == 3 then sampSendChat('/f [��O�AC�] ����� ������� �������� �����, ������� '..BOL) typ = -1 end
				if whichhospital(BOL) == 4 then sampSendChat('/f [��O�AC�] ����� ������� �������� � ��, ������� '..BOL) typ = -1 end
				if whichhospital(BOL) == 5 then sampSendChat('/f [��O�AC�] ����� ������� �������� � �����, ������� '..BOL) typ = -1 end
				if whichhospital(BOL) == 6 then sampSendChat('/f [��O�AC�] ����� ������� �������� � ��, ������� '..BOL) typ = -1 end
				if whichhospital(BOL) == 7 then sampSendChat('/f [��O�AC�] ����� ������� �������� � ��, ������� '..BOL) typ = -1 end
			else
				sampSendChat('/f [��O�AC�] ���� �������� ��������, ��� �������: '..BOL) typ = -1
			end
		end
		if calltype == 10 then sampSendChat('/f [��O�AC�]: ����� ������� ��������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
		if calltype == 11 then sampSendChat('/f [��O�AC�]: ����� ������� ��������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
	end
end
-- ���������� �����, ������� ���������� ��������� ������������ ���������
function followme(typ)
	while true do
		wait(1)
		whereami()
		math.randomseed(os.time())
		wait(math.random(5000, 15000))
		fcX = math.ceil(cX + 3000)
		fcY = math.ceil(cY + 3000)
		fcZ = math.ceil(cZ)
		while fcZ < 0 do fcZ = fcZ + 1 end
		if typ == 5 then sampSendChat('/f [��O�AC�]: ����� FOLLOW! �������: '..BOL..'! N'..fcX..'E'..fcY..'Z'..fcZ..'!') end
		if typ == 6 then sampSendChat('/f [��O�AC�]: ����� OXOTHIK! �������: '..BOL..'! N'..fcX..'E'..fcY..'Z'..fcZ..'!') end
		if typ == 7 then sampSendChat('/f [��O�AC�]: ����� JERTVA! �������: '..BOL..'! N'..fcX..'E'..fcY..'Z'..fcZ..'!') end
		if typ == 8 then sampSendChat('/f [��O�AC�]: ���������� ����: '..BOL..'! N'..fcX..'E'..fcY..'Z'..fcZ..'!') end
	end
end
--------------------------------------------------------------------------------
-------------------------------------RECEIVE------------------------------------
--------------------------------------------------------------------------------
-- ���� �������� ������
function iwillhelp()
	if not isPauseMenuActive() and isPlayerPlaying(playerHandle) and sampIsChatInputActive() == false and isKeyDown(221) and sampIsDialogActive() == false and isSampfuncsConsoleActive() == false then
		sampShowDialog(984, "������� by rubbishman - ������� �����", string.format("[1] ������� ����� 10-34\n[2] ������� ����������\n[3] ������� �������, ������� ����� �������\n[4] ������� �������, ����� ����\n[5] ������� �������, ����� ��������\n[6] ������� \"�������� �� ����\" (������������)\n[7] ������� ����� ������ � ������, ������� (������������)\n[8] ������� ����� ������ � ������, ������ (����������)\n[9] ����������� ���������� ���� (����������)\n[10] ������� ����� ���������� ��������\n[11] ������� ����� ���������� ��������\n[12] ������� ����� ���������� ����\n[13] ������� ����� �� ��������"), "�������", "�������", 2)
		while sampIsDialogActive() do
			wait(0)
			if isKeyDown(49) or isKeyDown(50) or isKeyDown(51) or isKeyDown(52) or isKeyDown(53) or isKeyDown(54) or isKeyDown(55) or isKeyDown(56) or isKeyDown(57) then
				if isKeyDown(49) then hotkey = 1 end
				if isKeyDown(50) then hotkey = 2 end
				if isKeyDown(51) then hotkey = 3 end
				if isKeyDown(52) then hotkey = 4 end
				if isKeyDown(53) then hotkey = 5 end
				if isKeyDown(54) then hotkey = 6 end
				if isKeyDown(55) then hotkey = 7 end
				if isKeyDown(56) then hotkey = 8 end
				if isKeyDown(57) then hotkey = 9 end
				if isKeyDown(58) then hotkey = 10 end
				sampCloseCurrentDialogWithButton(0)
			end
		end
		local resultMain, buttonMain, typ = sampHasDialogRespond(984)
		if buttonMain == 1 or hotkey > 0 then
			if hotkey > 0 then
				bihelp(hotkey - 1) hotkey = 0
			else
				bihelp(typ)
			end
		end
	end
end
-- ������� �������� ���������� ������ �� ������� ������� Z
function fastresponde()
	if lastcall ~= nil and sampIsDialogActive() == false and not isPauseMenuActive() and isPlayerPlaying(playerHandle) and sampIsChatInputActive() == false and isKeyDown(90) then bihelp(lastcall - 1) wait(300) end
end
-- ���������� �������� ������
function bihelp(calltype)
	whereami()
	if calltype == 0 and x1 ~= nil and y1 ~= nil then
		if doesPickupExist(pickup1) or doesPickupExist(pickup1a) or doesBlipExist(marker1) then removePickup(pickup1) removePickup(pickup1a) removeBlip(marker1) end
		sampSendChat('/f 10-4 10-34! ���������: '..math.ceil(getDistanceBetweenCoords2d(x1, y1, cX, cY))..' �.')
		result, pickup1 = createPickup(whichpickuptype(calltype), 19, x1, y1, z1)
		result, pickup1a = createPickup(whichpickuptype(calltype), 14, x1, y1, z1)
		marker1 = addSpriteBlipForCoord(x1, y1, z1, whichmarkertype(calltype))
	end
	if calltype == 1 and x2 ~= nil and y2 ~= nil then
		if doesPickupExist(pickup2) or doesPickupExist(pickup2a) or doesBlipExist(marker2) then removePickup(pickup2) removePickup(pickup2a) removeBlip(marker2) end
		sampSendChat('/f ������ ���� ����������. ���������: '..math.ceil(getDistanceBetweenCoords2d(x2, y2, cX, cY))..' �.')
		result, pickup2 = createPickup(whichpickuptype(calltype), 19, x2, y2, z2)
		result, pickup2a = createPickup(whichpickuptype(calltype), 14, x2, y2, z2)
		marker2 = addSpriteBlipForCoord(x2, y2, z2, whichmarkertype(calltype))
	end
	if calltype == 2 and x3 ~= nil and y3 ~= nil then
		if doesPickupExist(pickup3) or doesPickupExist(pickup3a) or doesBlipExist(marker3) then removePickup(pickup3) removePickup(pickup3a) removeBlip(marker3) end
		sampSendChat('/f 10-4 �������, ������� ����� �������. ���������: '..math.ceil(getDistanceBetweenCoords2d(x3, y3, cX, cY))..' �.')
		result, pickup3 = createPickup(whichpickuptype(calltype), 19, x3, y3, z3)
		result, pickup3a = createPickup(whichpickuptype(calltype), 14, x3, y3, z3)
		marker3 = addSpriteBlipForCoord(x3, y3, z3, whichmarkertype(calltype))
	end
	if calltype == 3 and x4 ~= nil and y4 ~= nil then
		if doesPickupExist(pickup4) or doesPickupExist(pickup4a) or doesBlipExist(marker4) then removePickup(pickup4) removePickup(pickup4a) removeBlip(marker4) end
		sampSendChat('/f 10-4 �������, � �������� ����� ����. ���������: '..math.ceil(getDistanceBetweenCoords2d(x4, y4, cX, cY))..' �.')
		result, pickup4 = createPickup(whichpickuptype(calltype), 19, x4, y4, z4)
		result, pickup4a = createPickup(whichpickuptype(calltype), 14, x4, y4, z4)
		marker4 = addSpriteBlipForCoord(x4, y4, z4, whichmarkertype(calltype))
	end
	if calltype == 4 and x5 ~= nil and y5 ~= nil then
		if doesPickupExist(pickup5) or doesPickupExist(pickup5a) or doesBlipExist(marker5) then removePickup(pickup5) removePickup(pickup5a) removeBlip(marker5) end
		sampSendChat('/f 10-4 �������, �������� ��� � ����. ���������: '..math.ceil(getDistanceBetweenCoords2d(x5, y5, cX, cY))..' �.')
		result, pickup5 = createPickup(whichpickuptype(calltype), 19, x5, y5, z5)
		result, pickup5a = createPickup(whichpickuptype(calltype), 14, x5, y5, z5)
		marker5 = addSpriteBlipForCoord(x5, y5, z5, whichmarkertype(calltype))
	end
	if calltype == 5 then
		if ifolu5:status() == 'dead' then
			sampSendChat('/f 10-4, ������ ���� ����������, ������ �� �����')
			ifolu5:run()
		else
			sampSendChat('/f 10-26 ����� ����������!')
			removePickup(pickup6a)
			removePickup(pickup6)
			removeBlip(marker6)
			ifolu5:terminate()
		end
	end
	if calltype == 6 then
		if ifolu6:status() == 'dead' then
			sampSendChat('/f 10-4 ������, ����� ��������')
			ifolu6:run()
		else
			sampSendChat('/f 10-26 ������, ����� ��������')
			removePickup(pickup7a)
			removePickup(pickup7)
			removeBlip(marker7)
			ifolu6:terminate()
		end
	end
	if calltype == 7 then
		if ifolu7:status() == 'dead' then
			sampSendChat('/f 10-4 ������, ����� ������')
			ifolu7:run()
		else
			sampSendChat('/f 10-26 ������, ����� ������')
			removePickup(pickup8a)
			removePickup(pickup8)
			removeBlip(marker8)
			ifolu7:terminate()
		end
	end
	if calltype == 8 then
		if ifolu8:status() == 'dead' then
			sampSendChat('/f 10-4 ����, ���������� ����������')
			ifolu8:run()
		else
			sampSendChat('/f 10-26 ����, �� ���������� ����������')
			removePickup(pickup9a)
			removePickup(pickup9)
			removeBlip(marker9)
			ifolu8:terminate()
		end
	end
	if calltype == 9 and bolka ~= nil then
		if bolka == 0 then
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			sampSendChat('/f 10-4 ���������� ��������')
		end
		if bolka == 1 then
			sampSendChat('/f 10-4 ���������� ����� ��������. ���������: '..math.ceil(getDistanceBetweenCoords2d(1485 - 3000, 5525 - 3000, cX, cY))..' �.')
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			result, pickup10 = createPickup(11738, 19, 1485 - 3000, 5525 - 3000, 56 - 0.5)
			result, pickup10a = createPickup(11738, 14, 1485 - 3000, 5525 - 3000, 56 - 0.5)
			marker10 = addSpriteBlipForCoord(1485 - 3000, 5525 - 3000, 56 - 0.5, whichmarkertype(calltype))
		end
		if bolka == 2 then sampSendChat('/f 10-4 ���������� �������� ��. ���������: '..math.ceil(getDistanceBetweenCoords2d(4608 - 3000, 4821 - 3000, cX, cY))..' �.')
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			result, pickup10 = createPickup(11738, 19, 4608 - 3000, 4821 - 3000, 11 - 1)
			result, pickup10a = createPickup(11738, 14, 4608 - 3000, 4821 - 3000, 11 - 1)
			marker10 = addSpriteBlipForCoord(4608 - 3000, 4821 - 3000, 11 - 1, whichmarkertype(calltype))
		end
		if bolka == 3 then sampSendChat('/f 10-4 ���������� �������� �����. ���������: '..math.ceil(getDistanceBetweenCoords2d(4244 - 3000, 3332 - 3000, cX, cY))..' �.')
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			result, pickup10 = createPickup(11738, 19, 4244 - 3000, 3332 - 3000, 20 - 1)
			result, pickup10a = createPickup(11738, 14, 4244 - 3000, 3332 - 3000, 20 - 1)
			marker10 = addSpriteBlipForCoord(4244 - 3000, 3332 - 3000, 20 - 1, whichmarkertype(calltype))
		end
		if bolka == 4 then sampSendChat('/f 10-4 ���������� �������� � ��. ���������: '..math.ceil(getDistanceBetweenCoords2d(4178 - 3000, 1677 - 3000, cX, cY))..' �.')
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			result, pickup10 = createPickup(11738, 19, 4178 - 3000, 1677 - 3000, 15 - 1.4)
			result, pickup10a = createPickup(11738, 14, 4178 - 3000, 1677 - 3000, 15 - 1.4)
			marker10 = addSpriteBlipForCoord(4178 - 3000, 1677 - 3000, 15 - 1.4, whichmarkertype(calltype))
		end
		if bolka == 5 then sampSendChat('/f 10-4 ���������� �������� � �����. ���������: '..math.ceil(getDistanceBetweenCoords2d(5035 - 3000, 1595 - 3000, cX, cY))..' �.')
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			result, pickup10 = createPickup(11738, 19, 5035 - 3000, 1595 - 3000, 18 - 1.4)
			result, pickup10a = createPickup(11738, 14, 5035 - 3000, 1595 - 3000, 18 - 1.4)
			marker10 = addSpriteBlipForCoord(5035 - 3000, 1595 - 3000, 18 - 1.4, whichmarkertype(calltype))
		end
		if bolka == 6 then sampSendChat('/f 10-4 ���������� �������� � ��. ���������: '..math.ceil(getDistanceBetweenCoords2d(346 - 3000, 3639 - 3000, cX, cY))..' �.')
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			result, pickup10 = createPickup(11738, 19, 346 - 3000, 3639 - 3000, 15 - 1)
			result, pickup10a = createPickup(11738, 14, 346 - 3000, 3639 - 3000, 15 - 1)
			marker10 = addSpriteBlipForCoord(346 - 3000, 3639 - 3000, 15 - 1, whichmarkertype(calltype))
		end
		if bolka == 7 then sampSendChat('/f 10-4 ���������� �������� � ��. ���������: '..math.ceil(getDistanceBetweenCoords2d(2682 - 3000, 4052 - 3000, cX, cY))..' �.')
			if doesPickupExist(pickup10) or doesPickupExist(pickup10a) or doesBlipExist(marker10) then removePickup(pickup10) removePickup(pickup10a) removeBlip(marker10) end
			result, pickup10 = createPickup(11738, 19, 2682 - 3000, 4052 - 3000, 21 - 1)
			result, pickup10a = createPickup(11738, 14, 2682 - 3000, 4052 - 3000, 21 - 1)
			marker10 = addSpriteBlipForCoord(2682 - 3000, 4052 - 3000, 21 - 1, whichmarkertype(calltype))
		end
	end
	if calltype == 10 and x11 ~= nil and y11 ~= nil then
		if doesPickupExist(pickup11) or doesPickupExist(pickup11a) or doesBlipExist(marker11) then removePickup(pickup11) removePickup(pickup11a) removeBlip(marker11) end
		sampSendChat('/f 10-4 ���������� ��������. ���������: '..math.ceil(getDistanceBetweenCoords2d(x11, y11, cX, cY))..' �.')
		result, pickup11 = createPickup(whichpickuptype(calltype), 19, x11, y11, z11 + 0.7)
		result, pickup11a = createPickup(whichpickuptype(calltype), 14, x11, y11, z11 + 0.7)
		marker11 = addSpriteBlipForCoord(x11, y11, z11, whichmarkertype(calltype))
	end
	if calltype == 11 and x12 ~= nil and y12 ~= nil then
		if doesPickupExist(pickup12) or doesPickupExist(pickup12a) or doesBlipExist(marker12) then removePickup(pickup12) removePickup(pickup12a) removeBlip(marker12) end
		sampSendChat('/f 10-4 ���������� ��������. ���������: '..math.ceil(getDistanceBetweenCoords2d(x12, y12, cX, cY))..' �.')
		result, pickup12 = createPickup(whichpickuptype(calltype), 19, x12, y12, z12 + 0.8)
		result, pickup12a = createPickup(whichpickuptype(calltype), 14, x12, y12, z12 + 0.8)
		marker12 = addSpriteBlipForCoord(x12, y12, z12, whichmarkertype(calltype))
	end
	if calltype == 12 and coordX ~= nil and coordY ~= nil then
		if doesBlipExist(marker0) then removeBlip(marker0) end
		sampSendChat('/f [��O�AC�] 10-4 '..kvadY..'-'..kvadX.. '. ���������: '..math.ceil(getDistanceBetweenCoords2d(coordX, coordY, cX, cY))..' �.')
		marker0 = addSpriteBlipForCoord(coordX, coordY, 0, 37)
	end
end
-- ���������� �����, ������� ���������� ������������ ������ FOLLOW
function ifolu5()
	if5 = 5
	x6b = 0
	y6b = 0
	while true do
		wait(50)
		if x6b ~= x6 or y6b ~= y6 then
			x6b = x6
			y6b = y6
			if doesPickupExist(pickup6) or doesPickupExist(pickup6a) or doesBlipExist(marker6) then removePickup(pickup6) removePickup(pickup6a) removeBlip(marker6) end
			result, pickup6 = createPickup(whichpickuptype(if5), 19, x6, y6, z6)
			result, pickup6a = createPickup(whichpickuptype(if5), 14, x6, y6, z6)
			marker6 = addSpriteBlipForCoord(x6, y6, z6, whichmarkertype(if5))
		end
	end
end
-- ���������� �����, ������� ���������� ������������ ������ ��������
function ifolu6()
	if6 = 6
	x7b = 0
	y7b = 0
	while true do
		wait(100)
		if x7b ~= x7 or y7b ~= y7 then
			x7b = x7
			y7b = y7
			if doesPickupExist(pickup7) or doesPickupExist(pickup7a) or doesBlipExist(marker7) then removePickup(pickup7) removePickup(pickup7a) removeBlip(marker7) end
			result, pickup7 = createPickup(whichpickuptype(if6), 19, x7, y7, z7)
			result, pickup7a = createPickup(whichpickuptype(if6), 14, x7, y7, z7)
			marker7 = addSpriteBlipForCoord(x7, y7, z7, whichmarkertype(if6))
		end
	end
end
-- ���������� �����, ������� ���������� ������������ ������ ������
function ifolu7()
	if7 = 7
	x8b = 0
	y8b = 0
	while true do
		wait(100)
		if x8b ~= x8 or y8b ~= y8 then
			x8b = x8
			y8b = y8
			if doesPickupExist(pickup8) or doesPickupExist(pickup8a) or doesBlipExist(marker8) then removePickup(pickup8) removePickup(pickup8a) removeBlip(marker8) end
			result, pickup8 = createPickup(whichpickuptype(if7), 19, x8, y8, z8)
			result, pickup8a = createPickup(whichpickuptype(if7), 14, x8, y8, z8)
			marker8 = addSpriteBlipForCoord(x8, y8, z8, whichmarkertype(if7))
		end
	end
end
-- ���������� �����, ������� ���������� ������������ ������ ����
function ifolu8()
	if8 = 8
	x9b = 0
	y9b = 0
	while true do
		wait(100)
		if x9b ~= x9 or y9b ~= y9 then
			x9b = x9
			y9b = y9
			if doesPickupExist(pickup9) or doesPickupExist(pickup9a) or doesBlipExist(marker9) then removePickup(pickup9) removePickup(pickup9a) removeBlip(marker9) end
			result, pickup9 = createPickup(whichpickuptype(if8), 19, x9, y9, z9)
			result, pickup9a = createPickup(whichpickuptype(if8), 14, x9, y9, z9)
			marker9 = addSpriteBlipForCoord(x9, y9, z9, whichmarkertype(if8))
		end
	end
end
--------------------------------------------------------------------------------
-------------------------------------HELP---------------------------------------
--------------------------------------------------------------------------------
--hook
function sampev.onServerMessage(color, text)
	lcs = text
end
-- �������, ������� ����������� ���, ������� ����������
function chatcapture()
	if lcs ~= nil then
		if string.find(lcs, '[��O�AC�]', 1, true) then
			-- 10-34
			if string.find(lcs, '10-34', 1, true) then
				coord(lcs)
				x1 = tempx
				y1 = tempy
				z1 = tempz
				lastcall = 1
			end
			-- ������ �������� ����������
			if string.find(lcs, '������� ���� ����������! �������:', 1, true) then
				coord(lcs)
				x2 = tempx
				y2 = tempy
				z2 = tempz
				lastcall = 2
			end
			-- ������� ����
			if string.find(lcs, ' �������� �������, ����� �������.', 1, true) then
				coord(lcs)
				x3 = tempx
				y3 = tempy
				z3 = tempz
				lastcall = 3
			end
			-- ����� ����
			if string.find(lcs, ' �������� �������, ����� ����.', 1, true) then
				coord(lcs)
				x4 = tempx
				y4 = tempy
				z4 = tempz
				lastcall = 4
			end
			-- ������ ����
			if string.find(lcs, ' �������� �������, ����� ��������.', 1, true) then
				coord(lcs)
				x5 = tempx
				y5 = tempy
				z5 = tempz
				lastcall = 5
			end
			if string.find(lcs, ' �������� �� ����!', 1, true) then
				coord(lcs)
				x6 = tempx
				y6 = tempy
				z6 = tempz
				lastcall = 6
			end
			if string.find(lcs, ' FOLLOW!', 1, true) then
				coord(lcs)
				x6 = tempx
				y6 = tempy
				z6 = tempz
				lastcall = 6
			end
			if string.find(lcs, ' ������! � �������.', 1, true) then
				coord(lcs)
				x7 = tempx
				y7 = tempy
				z7 = tempz
				lastcall = 7
			end
			if string.find(lcs, ' ����� OXOTHIK!', 1, true) then
				coord(lcs)
				x7 = tempx
				y7 = tempy
				z7 = tempz
				lastcall = 7
			end
			if string.find(lcs, ' ������! � ������. ', 1, true) then
				coord(lcs)
				x8 = tempx
				y8 = tempy
				z8 = tempz
				lastcall = 8
			end
			if string.find(lcs, ' ����� JERTVA!', 1, true) then
				coord(lcs)
				x8 = tempx
				y8 = tempy
				z8 = tempz
				lastcall = 8
			end
			if string.find(lcs, ' ���� ����. �������:', 1, true) then
				coord(lcs)
				x9 = tempx
				y9 = tempy
				z9 = tempz
				lastcall = 9
			end
			if string.find(lcs, '���������� ����: ', 1, true) then
				coord(lcs)
				x9 = tempx
				y9 = tempy
				z9 = tempz
				lastcall = 9
			end
			if string.find(lcs, '��������', 1, true) then
				lastcall = 10
				bolka = 0
				if string.find(lcs, '����� ������� ���� ��������', 1, true) then
					bolka = 1
				end
				if string.find(lcs, '����� ������� �������� � ��', 1, true) then
					bolka = 2
				end
				if string.find(lcs, '����� ������� �������� �����', 1, true) then
					bolka = 3
				end
				if string.find(lcs, '����� ������� �������� � ��', 1, true) then
					bolka = 4
				end
				if string.find(lcs, '����� ������� �������� � �����', 1, true) then
					bolka = 5
				end
				if string.find(lcs, '����� ������� �������� � ��', 1, true) then
					bolka = 6
				end
				if string.find(lcs, '����� ������� �������� � ��', 1, true) then
					bolka = 7
				end
			end
			-- ������ ��������
			if string.find(lcs, ' ��������', 1, true) then
				coord(lcs)
				x11 = tempx
				y11 = tempy
				z11 = tempz
				lastcall = 11
			end
			-- ������ ����
			if string.find(lcs, ' ��������', 1, true) then
				coord(lcs)
				x12 = tempx
				y12 = tempy
				z12 = tempz
				lastcall = 12
			end
		else
			if string.find(lcs, "(%A)-[0-9][0-9]") or string.find(lcs, "(%A)-[0-9]") then
				kvadY, kvadX = string.match(lcs, "(%A)-(%d+)")
				if kvadrat(kvadY) ~= nil and kvadX ~= nil and kvadY ~= nil and tonumber(kvadX) < 25 and tonumber(kvadX) > 0 then
					coordX = kvadX * 250 - 3125
					coordY = (kvadrat(kvadY) * 250 - 3125) * - 1
					lastcall = 13
				end
			end
		end
	end
end
-- ������� ������� ���������� �� ����������� chatcapture() ������
function coord(text)
	if string.find(text, "(%d+)E(%d+)Z(%d+)") then
		tempx, tempy, tempz = string.match(text, "(%d+)E(%d+)Z(%d+)")
		if tempx < 5000 and tempy < 5000 and tempz < 200 then
			tempx = tempx - 3000
			tempy = tempy - 3000
			tempz = tempz - 1
		end
	end
end
-- ���� ���� �����, ������� ������� ��������������� �����/����
function cleaner()
	if hasPickupBeenCollected(pickup1) or hasPickupBeenCollected(pickup1a) then removeBlip(marker1) removePickup(pickup1) removePickup(pickup1a) end
	if hasPickupBeenCollected(pickup2) or hasPickupBeenCollected(pickup2a) then removeBlip(marker2) removePickup(pickup2) removePickup(pickup2a) end
	if hasPickupBeenCollected(pickup3) or hasPickupBeenCollected(pickup3a) then removeBlip(marker3) removePickup(pickup3) removePickup(pickup3a) end
	if hasPickupBeenCollected(pickup4) or hasPickupBeenCollected(pickup4a) then removeBlip(marker4) removePickup(pickup4) removePickup(pickup4a) end
	if hasPickupBeenCollected(pickup5) or hasPickupBeenCollected(pickup5a) then removeBlip(marker5) removePickup(pickup5) removePickup(pickup5a) end
	if hasPickupBeenCollected(pickup6) or hasPickupBeenCollected(pickup6a) then removeBlip(marker6) removePickup(pickup6) removePickup(pickup6a) end
	if hasPickupBeenCollected(pickup7) or hasPickupBeenCollected(pickup7a) then removeBlip(marker7) removePickup(pickup7) removePickup(pickup7a) end
	if hasPickupBeenCollected(pickup8) or hasPickupBeenCollected(pickup8a) then removeBlip(marker8) removePickup(pickup8) removePickup(pickup8a) end
	if hasPickupBeenCollected(pickup9) or hasPickupBeenCollected(pickup9a) then removeBlip(marker9) removePickup(pickup9) removePickup(pickup9a) end
	if hasPickupBeenCollected(pickup10) or hasPickupBeenCollected(pickup10a) then removeBlip(marker10) removePickup(pickup10) removePickup(pickup10a) end
	if hasPickupBeenCollected(pickup11) or hasPickupBeenCollected(pickup11a) then removeBlip(marker11) removePickup(pickup11) removePickup(pickup11a) end
	if hasPickupBeenCollected(pickup12) or hasPickupBeenCollected(pickup12a) then removeBlip(marker12) removePickup(pickup12) removePickup(pickup12a) end
end
--�������� �����, �������, ��������� ���������� �������
function glean()
	removeBlip(marker0)
	removeBlip(marker1)
	removeBlip(marker2)
	removeBlip(marker3)
	removeBlip(marker4)
	removeBlip(marker5)
	removeBlip(marker6)
	removeBlip(marker7)
	removeBlip(marker8)
	removeBlip(marker9)
	removeBlip(marker10)
	removeBlip(marker11)
	removeBlip(marker12)
	removePickup(pickup1)
	removePickup(pickup2)
	removePickup(pickup3)
	removePickup(pickup4)
	removePickup(pickup5)
	removePickup(pickup6)
	removePickup(pickup7)
	removePickup(pickup8)
	removePickup(pickup9)
	removePickup(pickup10)
	removePickup(pickup11)
	removePickup(pickup12)
	removePickup(pickup1a)
	removePickup(pickup2a)
	removePickup(pickup3a)
	removePickup(pickup4a)
	removePickup(pickup5a)
	removePickup(pickup6a)
	removePickup(pickup7a)
	removePickup(pickup8a)
	removePickup(pickup9a)
	removePickup(pickup10a)
	removePickup(pickup11a)
	removePickup(pickup12a)
	folme:terminate()
	ifolu5:terminate()
	ifolu6:terminate()
	ifolu7:terminate()
	ifolu8:terminate()
end
-- ����������� �������� � ������� ��������� �����, ���������� ��������
-- ���������� ��� ���������
function whereami()
	local KV = {
		[1] = "�",
		[2] = "�",
		[3] = "�",
		[4] = "�",
		[5] = "�",
		[6] = "�",
		[7] = "�",
		[8] = "�",
		[9] = "�",
		[10] = "�",
		[11] = "�",
		[12] = "�",
		[13] = "�",
		[14] = "�",
		[15] = "�",
		[16] = "�",
		[17] = "�",
		[18] = "�",
		[19] = "�",
		[20] = "�",
		[21] = "�",
		[22] = "�",
		[23] = "�",
		[24] = "�",
	}
	local X, Y, Z = getCharCoordinates(playerPed)
	X = math.ceil((X + 3000) / 250)
	Y = math.ceil((Y * - 1 + 3000) / 250)
	Y = KV[Y]
	KVX = (Y.."-"..X)
	if getActiveInterior() == 0 then BOL = KVX end
	if getActiveInterior() == 0 then cX, cY, cZ = getCharCoordinates(playerPed) cX = math.ceil(cX) cY = math.ceil(cY) cZ = math.ceil(cZ)
	end
end
-- ����������� �������� �� ��������
function whichhospital(KV)
	local KVB = {
		["�-6"] = 1, -- MMC
		["�-7"] = 1,
		["�-6"] = 1,
		["�-7"] = 1,
		["�-19"] = 2, --LVH
		["�-17"] = 3, -- ����
		["�-18"] = 3,
		["�-17"] = 3,
		["�-18"] = 3,
		["�-17"] = 4, -- �����������
		["�-18"] = 4,
		["�-17"] = 4,
		["�-18"] = 4,
		["�-20"] = 5, -- �����
		["�-21"] = 5,
		["�-20"] = 5,
		["�-21"] = 5,
		["�-1"] = 6, -- ��
		["�-2"] = 6,
		["�-1"] = 6,
		["�-2"] = 6,
		["�-11"] = 7, -- ��
		["�-12"] = 7,
		["�-11"] = 7,
		["�-12"] = 7,
	}
	return KVB[KV]
end
-- ����������� ���� ������� �� ���� ������
function whichmarkertype(asda)
	local mtypes = {
		[0] = 18, -- 10-34
		[1] = 56, -- ����������
		[2] = 55, -- �������, �������
		[3] = 55, -- �������, ���� �����
		[4] = 55, -- �������, �������
		[5] = 56,
		[6] = 19,
		[7] = 53,
		[8] = 51,
		[9] = 22,
		[10] = 52, -- �������
		[11] = 52, -- ����
	}
	return mtypes[asda]
end
-- ����������� ���� ������ �� ���� ������
function whichpickuptype(asdad)
	local ptypes = {
		[0] = 19605, -- 10-34
		[1] = 19605, -- ����������
		[2] = 19605, -- �������, �������
		[3] = 19605, -- �������, ���� �����
		[4] = 19605, -- �������, �������
		[5] = 19605,
		[6] = 19605,
		[7] = 19605,
		[8] = 19605,
		[10] = 1650, -- �������
		[11] = 18631, -- ����
	}
	return ptypes[asdad]
end
-- ������� kvadrat() ���������� ���������� ����� �������� (string)
function kvadrat(param)
	local KV = {
		["�"] = 1,
		["�"] = 2,
		["�"] = 3,
		["�"] = 4,
		["�"] = 5,
		["�"] = 6,
		["�"] = 7,
		["�"] = 8,
		["�"] = 9,
		["�"] = 10,
		["�"] = 11,
		["�"] = 12,
		["�"] = 13,
		["�"] = 14,
		["�"] = 15,
		["�"] = 16,
		["�"] = 17,
		["�"] = 18,
		["�"] = 19,
		["�"] = 20,
		["�"] = 21,
		["�"] = 22,
		["�"] = 23,
		["�"] = 24,
		["�"] = 1,
		["�"] = 2,
		["�"] = 3,
		["�"] = 4,
		["�"] = 5,
		["�"] = 6,
		["�"] = 7,
		["�"] = 8,
		["�"] = 9,
		["�"] = 10,
		["�"] = 11,
		["�"] = 12,
		["�"] = 13,
		["�"] = 14,
		["�"] = 15,
		["�"] = 16,
		["�"] = 17,
		["�"] = 18,
		["�"] = 19,
		["�"] = 20,
		["�"] = 21,
		["�"] = 22,
		["�"] = 23,
		["�"] = 24,
	}
	return KV[param]
end
-- ������� ��������/��������� �����������
function cmdGlonassInform()
	if data.options.startmessage == 1 then
		data.options.startmessage = 0 sampAddChatMessage(('����������� ��������� GLONASS ��� ������� ���� ���������'), color)
	else
		data.options.startmessage = 1 sampAddChatMessage(('����������� ��������� GLONASS ��� ������� ���� ��������'), color)
	end
	inicfg.save(data, "glonass")
end
--------------------------------------------------------------------------------
-------------------------------------MENU---------------------------------------
--------------------------------------------------------------------------------
mod_submenus_sa = {
	{
		title = '���������� � �������',
		onclick = function()
			wait(100)
			cmdGlonassInfo()
		end
	},
	{
		title = ' '
	},
	{
		title = '{AAAAAA}���������'
	},
	{
		title = '��������� �������',
		submenu = {
			{
				title = '��������/��������� ����������� ��� �������',
				onclick = function()
					cmdGlonassInform()
				end
			},
			{
				title = '��������/��������� ��������������',
				onclick = function()
					if data.options.autoupdate == 1 then
						data.options.autoupdate = 0 sampAddChatMessage(('[PISSER]: �������������� ������� ���������'), color)
					else
						data.options.autoupdate = 1 sampAddChatMessage(('[PISSER]: �������������� ������� ��������'), color)
					end
					inicfg.save(data, "glonass")
				end
			},
		}
	},
	{
		title = '�������� �����, �������� � ������',
		onclick = function()
			wait(100)
			glean()
		end
	},
	{
		title = ' '
	},
	{
		title = '{AAAAAA}����������'
	},
	{
		title = '������� ����������',
		onclick = function()
			changelog()
		end
	},
	{
		title = '������������� ��������',
		onclick = function()
			lua_thread.create(goupdate)
		end
	},
}
function menu()
	submenus_show(mod_submenus_sa, '{348cb2}GLONASS v'..thisScript().version..'', '�������', '�������', '�����')
end
function glonassmenu()
	menutrigger = 1
end
--�������
function cmdGlonassInfo()
	sampShowDialog(2342, "{348cb2}GLONASS v"..thisScript().version..". �����: James_Bond/rubbishman/Coulson.", "{ffcc00}����� ���� ������?\n{ffffff}� ����� ������������ ������ ��������� ���������?\n��� ���� ���� ������� ����� � ����������? �����������, ��� ����� � ���������� 2.0! \n�������� ��� \"� ���\" � \"� ���\", � ���� �������� �� ����� ������� �����, ����� ���������, ��� ��.\n{ffcc00}��� ������ ��������?\n{ffffff}���� ��� ������ ������ GLONASS{ffffff}: {348cb2}�������{ffffff} � {348cb2}����������{ffffff}.\n{348cb2} ������� �����:{ffffff}\n��� ������� ������ � /f ����� �������� ���� ������� ����������. \n� ���������� �������� ����� �� ��� �����������, ������� �� ��������.\n����� ����� �� ������ �� ������, �� � � ���� ������, ������� ����� ����� ������� ��� ������.\n{348cb2}  ���������� �����:\n{ffffff}��� ���������� �� �� �� �����, �� ���������� �������, ������� ����� ��������� ���� \n���������� ������ 3-7 ������. ���������� ����� ���������� ��� ������ � ����������.\n����� ���������� ���� � ���, �������� ��� �� ����� � ���� ������ ������ ��� ������� {00ccff}/glean{ffffff}.\n{ffcc00}��� ��� �������?\n{ffffff}������� {00ccff}P{ffffff}, ����� ������� ���� ������. \n����� ���� ������ �� ��������� ��������� ��� ��������: �������� ���������, �����������, \n�������, ����������, ����� ������ � ��� �����.\n����� ������� ������ ��� ������ � ���������, ��� � ��������� 1-9 (��� ������� �������).\n{ffcc00}��� ��� �������?\n{ffffff}������� {00ccff}Z{ffffff}, ����� ������ ������� ��������� �����. \n{ffffff}������� {00ccff}]{ffffff}, ����� ������� ����, ����������� ���� ������.\n����� ������� �����/��������� ����������� ����������, �������� ��� �� ����� � ���� \n�������� ��� ������� {00ccff}/glean{ffffff}.\nGLONASS ����������� ��� �� ��������� �������� � ���� � ����� ������� ����� �� �������.\n{ffcc00}��������� �������:\n    {00ccff}/glonass {ffffff}- ���� �������\n    {00ccff}/glean {ffffff}- ������� �����, ������ � ���������� �������� ��������\n    {00ccff}/glonasslog {ffffff}- changelog �������\n{00ccff}    /glonassnot{ffffff} - ��������/��������� ��������� ��� ����� � ����", "����")
end
function changelog()
	sampShowDialog(2342, "{348cb2}GLONASS: ������� ������.", "{ffcc00}v2.0 [10.12.17]\n{ffffff}������ ������� �� SAMP.Lua.\n������ �������� ��������, ������ ���� � ������.\n{ffcc00}v1.3 [01.11.17]\n{ffffff}��������� ���� {00ccff}/glonass{ffffff} ��� ��������.\n{ffffff}���������� �������� ��������.\n��������� ����� \"����\".\n{ffcc00}v1.2 [28.10.17]\n{ffffff}�������� �� ������ ������.\n{ffcc00}v1.1 [25.10.17]\n{ffffff}������ ����� �������.\n{ffffff}� ������� ����� ������ �����, ������������ ��������� ������ �������.\n���������� ��, ��� ������ � ������.\n�� ������ ������ ������ ���������, ������������ �������� ��������.", "�������")
end
--made by fyp
function submenus_show(menu, caption, select_button, close_button, back_button)
	select_button, close_button, back_button = select_button or 'Select', close_button or 'Close', back_button or 'Back'
	prev_menus = {}
	function display(menu, id, caption)
		local string_list = {}
		for i, v in ipairs(menu) do
			table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  >>' or v.title)
		end
		sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, 4)
		repeat
			wait(0)
			local result, button, list = sampHasDialogRespond(id)
			if result then
				if button == 1 and list ~= -1 then
					local item = menu[list + 1]
					if type(item.submenu) == 'table' then -- submenu
						table.insert(prev_menus, {menu = menu, caption = caption})
						if type(item.onclick) == 'function' then
							item.onclick(menu, list + 1, item.submenu)
						end
						return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
					elseif type(item.onclick) == 'function' then
						local result = item.onclick(menu, list + 1)
						if not result then return result end
						return display(menu, id, caption)
					end
				else -- if button == 0
					if #prev_menus > 0 then
						local prev_menu = prev_menus[#prev_menus]
						prev_menus[#prev_menus] = nil
						return display(prev_menu.menu, id - 1, prev_menu.caption)
					end
					return false
				end
			end
		until result
	end
	return display(menu, 31337, caption or menu.title)
end
--------------------------------------------------------------------------------
------------------------------------UPDATE--------------------------------------
--------------------------------------------------------------------------------
function update()
	local fpath = os.getenv('TEMP') .. '\\glonass-version.json'
	downloadUrlToFile('http://rubbishman.ru/dev/samp/glonass/version.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
		local f = io.open(fpath, 'r')
		if f then
			local info = decodeJson(f:read('*a'))
			updatelink = info.updateurl
			if info and info.latest then
				version = tonumber(info.latest)
				if version > tonumber(thisScript().version) then
					lua_thread.create(goupdate)
				else
					update = false
				end
			end
		end
	end
end)
end
--���������� ���������� ������
function goupdate()
sampAddChatMessage(("[GLONASS]: ���������� ����������. �������� ����������.."), color)
sampAddChatMessage(("[GLONASS]: ������� ������: "..thisScript().version..". ����� ������: "..version), color)
wait(300)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
	if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
	sampAddChatMessage(("[GLONASS]: ���������� ���������!"), color)
	thisScript():reload()
end
end)
end
