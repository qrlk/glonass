require 'lib.moonloader'
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("GLONASS")
script_version("25.06.2022")
script_author("qrlk")
script_description("/glonass")
script_url("https://github.com/qrlk/glonass")

-- https://github.com/qrlk/qrlk.lua.moonloader
local enable_sentry = true -- false to disable error reports to sentry.io
if enable_sentry then
  local sentry_loaded, Sentry = pcall(loadstring, [=[return {init=function(a)local b,c,d=string.match(a.dsn,"https://(.+)@(.+)/(%d+)")local e=string.format("https://%s/api/%d/store/?sentry_key=%s&sentry_version=7&sentry_data=",c,d,b)local f=string.format("local target_id = %d local target_name = \"%s\" local target_path = \"%s\" local sentry_url = \"%s\"\n",thisScript().id,thisScript().name,thisScript().path:gsub("\\","\\\\"),e)..[[require"lib.moonloader"script_name("sentry-error-reporter-for: "..target_name.." (ID: "..target_id..")")script_description("���� ������ ������������� ������ ������� '"..target_name.." (ID: "..target_id..")".."' � ���������� �� � ������� ����������� ������ Sentry.")local a=require"encoding"a.default="CP1251"local b=a.UTF8;local c="moonloader"function getVolumeSerial()local d=require"ffi"d.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local e=d.new("unsigned long[1]",0)d.C.GetVolumeInformationA(nil,nil,0,e,nil,nil,nil,0)e=e[0]return e end;function getNick()local f,g=pcall(function()local f,h=sampGetPlayerIdByCharHandle(PLAYER_PED)return sampGetPlayerNickname(h)end)if f then return g else return"unknown"end end;function getRealPath(i)if doesFileExist(i)then return i end;local j=-1;local k=getWorkingDirectory()while j*-1~=string.len(i)+1 do local l=string.sub(i,0,j)local m,n=string.find(string.sub(k,-string.len(l),-1),l)if m and n then return k:sub(0,-1*(m+string.len(l)))..i end;j=j-1 end;return i end;function url_encode(o)if o then o=o:gsub("\n","\r\n")o=o:gsub("([^%w %-%_%.%~])",function(p)return("%%%02X"):format(string.byte(p))end)o=o:gsub(" ","+")end;return o end;function parseType(q)local r=q:match("([^\n]*)\n?")local s=r:match("^.+:%d+: (.+)")return s or"Exception"end;function parseStacktrace(q)local t={frames={}}local u={}for v in q:gmatch("([^\n]*)\n?")do local w,x=v:match("^	*(.:.-):(%d+):")if not w then w,x=v:match("^	*%.%.%.(.-):(%d+):")if w then w=getRealPath(w)end end;if w and x then x=tonumber(x)local y={in_app=target_path==w,abs_path=w,filename=w:match("^.+\\(.+)$"),lineno=x}if x~=0 then y["pre_context"]={fileLine(w,x-3),fileLine(w,x-2),fileLine(w,x-1)}y["context_line"]=fileLine(w,x)y["post_context"]={fileLine(w,x+1),fileLine(w,x+2),fileLine(w,x+3)}end;local z=v:match("in function '(.-)'")if z then y["function"]=z else local A,B=v:match("in function <%.* *(.-):(%d+)>")if A and B then y["function"]=fileLine(getRealPath(A),B)else if#u==0 then y["function"]=q:match("%[C%]: in function '(.-)'\n")end end end;table.insert(u,y)end end;for j=#u,1,-1 do table.insert(t.frames,u[j])end;if#t.frames==0 then return nil end;return t end;function fileLine(C,D)D=tonumber(D)if doesFileExist(C)then local E=0;for v in io.lines(C)do E=E+1;if E==D then return v end end;return nil else return C..D end end;function onSystemMessage(q,type,i)if i and type==3 and i.id==target_id and i.name==target_name and i.path==target_path and not q:find("Script died due to an error.")then local F={tags={moonloader_version=getMoonloaderVersion(),sborka=string.match(getGameDirectory(),".+\\(.-)$")},level="error",exception={values={{type=parseType(q),value=q,mechanism={type="generic",handled=false},stacktrace=parseStacktrace(q)}}},environment="production",logger=c.." (no sampfuncs)",release=i.name.."@"..i.version,extra={uptime=os.clock()},user={id=getVolumeSerial()},sdk={name="qrlk.lua.moonloader",version="0.0.0"}}if isSampAvailable()and isSampfuncsLoaded()then F.logger=c;F.user.username=getNick().."@"..sampGetCurrentServerAddress()F.tags.game_state=sampGetGamestate()F.tags.server=sampGetCurrentServerAddress()F.tags.server_name=sampGetCurrentServerName()else end;print(downloadUrlToFile(sentry_url..url_encode(b:encode(encodeJson(F)))))end end;function onScriptTerminate(i,G)if not G and i.id==target_id then lua_thread.create(function()print("������ "..target_name.." (ID: "..target_id..")".."�������� ���� ������, ����������� ����� 60 ������")wait(60000)thisScript():unload()end)end end]]local g=os.tmpname()local h=io.open(g,"w+")h:write(f)h:close()script.load(g)os.remove(g)end}]=])
  if sentry_loaded and Sentry then
    pcall(Sentry().init, { dsn = "https://1772797c9fbc4d6b948fc6d3635ab634@o1272228.ingest.sentry.io/6529859" })
  end
end

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
  local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
  if updater_loaded then
    autoupdate_loaded, Update = pcall(Updater)
    if autoupdate_loaded then
      Update.json_url = "https://raw.githubusercontent.com/qrlk/glonass/master/version.json?" .. tostring(os.clock())
      Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
      Update.url = "https://github.com/qrlk/glonass"
    end
  end
end
-------------------------------------var----------------------------------------
color = 0x348cb2
local prefix = '['..string.upper(thisScript().name)..']: '
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
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
  while not isSampAvailable() do wait(100) end
  if data.options.autoupdate == 1 then
    -- ������ ���, ���� ������ ��������� �������� ����������
    if autoupdate_loaded and enable_autoupdate and Update then
      pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
    -- ������ ���, ���� ������ ��������� �������� ����������
  end
  inicfg.save(data, "glonass")
  sampRegisterChatCommand('glean', glean)
  sampRegisterChatCommand('glonassnot', cmdGlonassInform)
  sampRegisterChatCommand('glonass', glonassmenu)
  hotkey = 0
  if data.options.startmessage == 1 then
    sampAddChatMessage(('������� v'..thisScript().version..' �������. �����: qrlk.'),
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
  if not isPauseMenuActive() and (isPlayerPlaying(playerHandle) or isPlayerDead(playerHandle) == true) and sampIsChatInputActive() == false and isSampfuncsConsoleActive() == false and isKeyDown(80) and sampIsDialogActive() == false then
    sampShowDialog(983, "������� by qrlk - �������", string.format("[1] ����� ������ � �����������\n[2] �������� ���� ����������\n[3] ������� �������, ��������� �������\n[4] ������� �������, ��������� ����\n[5] ������� �������, ��������� ���������\n[6] ������� ������ � ���������� �������� \n[7] ������� ������ � ���������� �������� \n[8] ������� ������ � ���������� ����"), "�������", "�������", 2)
    while sampIsDialogActive() do
      wait(0)
      if isKeyDown(49) or isKeyDown(50) or isKeyDown(51) or isKeyDown(52) or isKeyDown(53) or isKeyDown(54) or isKeyDown(55) or isKeyDown(56) then
        if isKeyDown(49) then hotkey = 1 end
        if isKeyDown(50) then hotkey = 2 end
        if isKeyDown(51) then hotkey = 3 end
        if isKeyDown(52) then hotkey = 4 end
        if isKeyDown(53) then hotkey = 5 end
        if isKeyDown(54) then hotkey = 6 end
        if isKeyDown(55) then hotkey = 7 end
        if isKeyDown(56) then hotkey = 8 end
        sampCloseCurrentDialogWithButton(0)
      end
    end
    local resultMain, buttonMain, typ = sampHasDialogRespond(983)
    if buttonMain == 1 or hotkey > 0 then
      if hotkey > 0 then
        bhelp(hotkey - 1)
        hotkey = 0
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
    if calltype == 6 then sampSendChat('/f [��O�AC�]: ����� ������� ��������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
    if calltype == 7 then sampSendChat('/f [��O�AC�]: ����� ������� ��������. �������: '..BOL..'! N'..bcX..'E'..bcY..'Z'..bcZ..'!') calltype = -1 end
  end
end
--------------------------------------------------------------------------------
-------------------------------------RECEIVE------------------------------------
--------------------------------------------------------------------------------
-- ���� �������� ������
function iwillhelp()
  if not isPauseMenuActive() and isPlayerPlaying(playerHandle) and sampIsChatInputActive() == false and isKeyDown(221) and sampIsDialogActive() == false and isSampfuncsConsoleActive() == false then
    sampShowDialog(984, "������� by qrlk - ������� �����", string.format("[1] ������� ����� 10-34\n[2] ������� ����������\n[3] ������� �������, ������� ����� �������\n[4] ������� �������, ����� ����\n[5] ������� �������, ����� ��������\n[6] ������� ����� ���������� ��������\n[7] ������� ����� ���������� ��������\n[8] ������� ����� ���������� ����\n[9] ������� ����� �� ��������"), "�������", "�������", 2)
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
  if calltype == 5 and bolka ~= nil then
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
  if calltype == 6 and x11 ~= nil and y11 ~= nil then
    if doesPickupExist(pickup11) or doesPickupExist(pickup11a) or doesBlipExist(marker11) then removePickup(pickup11) removePickup(pickup11a) removeBlip(marker11) end
    sampSendChat('/f 10-4 ���������� ��������. ���������: '..math.ceil(getDistanceBetweenCoords2d(x11, y11, cX, cY))..' �.')
    result, pickup11 = createPickup(whichpickuptype(calltype), 19, x11, y11, z11 + 0.7)
    result, pickup11a = createPickup(whichpickuptype(calltype), 14, x11, y11, z11 + 0.7)
    marker11 = addSpriteBlipForCoord(x11, y11, z11, whichmarkertype(calltype))
  end
  if calltype == 7 and x12 ~= nil and y12 ~= nil then
    if doesPickupExist(pickup12) or doesPickupExist(pickup12a) or doesBlipExist(marker12) then removePickup(pickup12) removePickup(pickup12a) removeBlip(marker12) end
    sampSendChat('/f 10-4 ���������� ��������. ���������: '..math.ceil(getDistanceBetweenCoords2d(x12, y12, cX, cY))..' �.')
    result, pickup12 = createPickup(whichpickuptype(calltype), 19, x12, y12, z12 + 0.8)
    result, pickup12a = createPickup(whichpickuptype(calltype), 14, x12, y12, z12 + 0.8)
    marker12 = addSpriteBlipForCoord(x12, y12, z12, whichmarkertype(calltype))
  end
  if calltype == 8 and coordX ~= nil and coordY ~= nil then
    if doesBlipExist(marker0) then removeBlip(marker0) end
    sampSendChat('/f [��O�AC�] 10-4 '..kvadY..'-'..kvadX.. '. ���������: '..math.ceil(getDistanceBetweenCoords2d(coordX, coordY, cX, cY))..' �.')
    placeWaypoint(coordX, coordY, 0)
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
        if tempx ~= nil and tempy ~= nil and tempz ~= nil then
          x1 = tempx
          y1 = tempy
          z1 = tempz
          lastcall = 1
        end
      end
      -- ������ �������� ����������
      if string.find(lcs, '������� ���� ����������! �������:', 1, true) then
        coord(lcs)
        if tempx ~= nil and tempy ~= nil and tempz ~= nil then
          x2 = tempx
          y2 = tempy
          z2 = tempz
          lastcall = 2
        end
      end
      -- ������� ����
      if string.find(lcs, ' �������� �������, ����� �������.', 1, true) then
        coord(lcs)
        if tempx ~= nil and tempy ~= nil and tempz ~= nil then
          x3 = tempx
          y3 = tempy
          z3 = tempz
          lastcall = 3
        end
      end
      -- ����� ����
      if string.find(lcs, ' �������� �������, ����� ����.', 1, true) then
        coord(lcs)
        if tempx ~= nil and tempy ~= nil and tempz ~= nil then
          x4 = tempx
          y4 = tempy
          z4 = tempz
          lastcall = 4
        end
      end
      -- ������ ����
      if string.find(lcs, ' �������� �������, ����� ��������.', 1, true) then
        coord(lcs)
        if tempx ~= nil and tempy ~= nil and tempz ~= nil then
          x5 = tempx
          y5 = tempy
          z5 = tempz
          lastcall = 5
        end
      end
      if string.find(lcs, '��������', 1, true) then
        lastcall = 6
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
        if tempx ~= nil and tempy ~= nil and tempz ~= nil then
          x11 = tempx
          y11 = tempy
          z11 = tempz
          lastcall = 7
        end
      end
      -- ������ ����
      if string.find(lcs, ' ��������', 1, true) then
        coord(lcs)
        if tempx ~= nil and tempy ~= nil and tempz ~= nil then
          x12 = tempx
          y12 = tempy
          z12 = tempz
          lastcall = 8
        end
      end
    else
      if string.find(lcs, "(%A)-[0-9][0-9]") or string.find(lcs, "(%A)-[0-9]") then
        kvadY, kvadX = string.match(lcs, "(%A)-(%d+)")
        if kvadrat(kvadY) ~= nil and kvadX ~= nil and kvadY ~= nil and tonumber(kvadX) < 25 and tonumber(kvadX) > 0 then
          coordX = kvadX * 250 - 3125
          coordY = (kvadrat(kvadY) * 250 - 3125) * - 1
          lastcall = 9
        end
      end
    end
  end
end
-- ������� ������� ���������� �� ����������� chatcapture() ������
function coord(text)
  if string.find(text, "(%d+)E(%d+)Z(%d+)") then
    tempx, tempy, tempz = string.match(text, "(%d+)E(%d+)Z(%d+)")
    if tonumber(tempx) < 10000 and tonumber(tempy) < 10000 and tonumber(tempz) < 200 then
      tempx = tempx - 3000
      tempy = tempy - 3000
      tempz = tempz - 1
    else
      tempx = nil
      tempy = nil
      tempz = nil
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
  if getActiveInterior() == 0 then cX, cY, cZ = getCharCoordinates(playerPed) cX = math.ceil(cX) cY = math.ceil(cY) cZ = math.ceil(cZ)end
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
    [5] = 22,
    [6] = 52, -- �������
    [7] = 52, -- ����
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
    [6] = 1650, -- �������
    [7] = 18631, -- ����
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
    title = '��������� � ������� (��� ���� ����)',
    onclick = function()
      os.execute('explorer "http://qrlk.me/sampcontact"')
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
            data.options.autoupdate = 0 sampAddChatMessage(('[GLONASS]: �������������� ������� ���������'), color)
          else
            data.options.autoupdate = 1 sampAddChatMessage(('[GLONASS]: �������������� ������� ��������'), color)
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
    title = '�������������� �� ������ ���������!',
    onclick = function()
      os.execute('explorer "http://vk.com/qrlk.mods"')
    end
  },
  {
    title = '������� �������� �������',
    onclick = function()
      os.execute('explorer "http://qrlk.me/samp/glonass"')
    end
  },
  {
    title = '������� ����������',
    onclick = function()
      lua_thread.create(
        function()
          local changelogurl = "https://github.com/qrlk/glonass/blob/master/CHANGELOG.md"
          sampShowDialog(222228, "{ff0000}���������� �� ����������", "{ffffff}"..thisScript().name.." {ffe600}���������� ������� ���� changelog ��� ���.\n���� �� ������� {ffffff}�������{ffe600}, ������ ���������� ������� ������:\n        {ffffff}"..changelogurl.."\n{ffe600}���� ���� ���� ���������, �� ������ ������� ��� ������ ����.", "�������", "��������")
          while sampIsDialogActive() do wait(100) end
          local result, button, list, input = sampHasDialogRespond(222228)
          if button == 1 then
            os.execute('explorer "'..changelogurl..'"')
          end
        end
      )
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
  sampShowDialog(2342, "{348cb2}GLONASS v"..thisScript().version..". �����: qrlk.", "{ffcc00}����� ���� ������?\n{ffffff}� ����� ������������ ������ ��������� ���������?\n��� ���� ���� ������� ����� � ����������? �����������, ��� ����� � ���������� 2.0! \n�������� ��� \"� ���\" � \"� ���\", � ���� �������� �� ����� ������� �����, ����� ���������, ��� ��.\n{ffcc00}��� ������ ��������?\n{ffffff}��� ������ � /f ����� �������� ���� ������� ����������. \n� ���������� �������� ����� �� ��� �����������, ������� �� ��������.\n����� ����� �� ������ �� ������, �� � � ���� ������, ������� ����� ����� ������� ��� ������.\n{ffcc00}��� ��� �������?\n{ffffff}������� {00ccff}P{ffffff}, ����� ������� ���� ������. \n����� ���� ������ �� ��������� ��������� ��� ��������: �������� ���������, �����������, \n�������, ���������� � ��� �����.\n����� ������� ������ ��� ������ � ���������, ��� � ��������� 1-9 (��� ������� �������).\n{ffcc00}��� ��� �������?\n{ffffff}������� {00ccff}Z{ffffff}, ����� ������ ������� ��������� �����. \n{ffffff}������� {00ccff}]{ffffff}, ����� ������� ����, ����������� ���� ������.\n����� ������� �����, �������� ��� �� ����� � ���� \n�������� ��� ������� {00ccff}/glean{ffffff}.\nGLONASS ����������� ��� �� ��������� �������� � ���� � ����� ������� ����� �� �������.\n{ffcc00}��������� �������:\n    {00ccff}/glonass {ffffff}- ���� �������\n    {00ccff}/glean {ffffff}- ������� �����, ������\n    {00ccff}/glonasschangelog {ffffff}- changelog �������\n{00ccff}    /glonassnot{ffffff} - ��������/��������� ��������� ��� ����� � ����", "����")
end
--made by fyp
function submenus_show(menu, caption, select_button, close_button, back_button)
  select_button, close_button, back_button = select_button or 'Select', close_button or 'Close', back_button or 'Back'
  prev_menus = {}
  function display(menu, id, caption)
    local string_list = {}
    for i, v in ipairs(menu) do
      table.insert(string_list, type(v.submenu) == 'table' and v.title .. '	>>' or v.title)
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