﻿local MT = MacroToolkit
local MTF
local L = MT.L
local LSM = MT.LS("LibSharedMedia-3.0")
local format, string, table, date, ipairs, pairs, select, tostring, strsplit, tonumber = format, string, table, date, ipairs, pairs, select, tostring, strsplit, tonumber
local GetNumMacros, GetMacroInfo, EditMacro, DeleteMacro, CreateMacro = GetNumMacros, GetMacroInfo, EditMacro, DeleteMacro, CreateMacro
local PanelTemplates_GetSelectedTab = PanelTemplates_GetSelectedTab
local CreateFrame, GetBindingText = CreateFrame, GetBindingText

MT.Spells = {}
MT.defaults = {
	profile = {
		override = false,
		stringcolour = "ffffffff", emotecolour = "ffeedd82", scriptcolour = "ff696969",
		commandcolour = "ff00bfff", spellcolour = "ff9932cc", targetcolour = "ffffd700",
		conditioncolour = "ff8b5a2b", defaultcolour = "ffffffff", errorcolour = "ffff0000",
		itemcolour = "fff08080", mtcolour = "ffcd2ea9", seqcolour ="ff006600",
		usecolours = true, unknown = false, replacemt = true, doublewide = false,
		viscondtions = true, visoptionsbutton = true, viscustom = true,
		visaddscript = true, visaddslot = true, viscrest = false,
		visbackup = true, visclear = true, visshare = true,
		visextend = true, viserrors = true, vismacrobox = true,
		visshorten = true, visbind = true, visdrake = false,
		--escape = true,
		x = (UIParent:GetWidth() - 638) / 2,
		y = (UIParent:GetHeight() - 424) / 2,
		scale = UIParent:GetScale(),
		height = 424,
		dynamicicon = true, abilityicons = true, achicons = true,
		invicons = true, itemicons = true, miscicons = true, spellicons = true,
		fonts = {edfont = "Friz Quadrata TT", edsize = 10, errfont = "Friz Quadrata TT", errsize = 10,
			mfont = "Friz Quadrata TT", mifont = "Friz Quadrata TT", misize = 10},
	},
	global = {custom = {}, extended = {}, extra = {}, allcharmacros = false},
	char = {extended = {}},
}

local function showtoolkit()
	local ignore = MTF:IsShown()
	if MT.MTSF then ignore = ignore or MT.MTSF:IsShown() end
	if MT.MTBF then ignore = ignore or MT.MTBF:IsShown() end
	if not ignore then MTF:Show() end
end

local function getExMacroIndex(ext)
	for mi = 1, _G.MAX_ACCOUNT_MACROS + _G.MAX_CHARACTER_MACROS do
		local name, icon, body = GetMacroInfo(mi)
		if name then
			local index = select(3, string.find(body, "MacroToolkitSecureButton(%d+)"))
			if (index or 0) == ext then return mi end
		end
	end
end

function MT:eventHandler(this, event, arg1, ...)
	if event == "ADDON_LOADED" then
		if arg1 == "MacroToolkit" then
			_G.SLASH_MACROTOOLKIT_CMD1 = format("%smac", MT.slash)
			_G.SLASH_MACROTOOLKIT_CMD2 = format("%smtoolkit", MT.slash)
			_G.SLASH_MACROTOOLKIT_CMD3 = format("%smacrotoolkit", MT.slash)
			SlashCmdList["MACROTOOLKIT_CMD"] = showtoolkit
			for i, s in ipairs(MT.scripts) do
				_G[format("SLASH_MACROTOOLKIT_%s%d", string.upper(s[2]), 1)] = format("%s%s", MT.slash, s[2])
				SlashCmdList[format("MACROTOOLKIT_%s", string.upper(s[2]))] = function(input) MT:DoMTMacroCommand(s[2], input) end
			end
			MT.db = MT.LS("AceDB-3.0"):New("MacroToolkitDB", MT.defaults, "profile")
			if not IsAddOnLoaded("Blizzard_MacroUI") then LoadAddOn("Blizzard_MacroUI") end
			if not MT.db.global.custom then MT.db.global.custom = {} end
			if not MT.db.global.extra then MT.db.global.extra = {} end
			for _, c in ipairs(MT.db.global.custom) do
				_G[format("SLASH_MACROTOOLKIT_CUSTOM_%s%d", string.upper(c.n), 1)] = format("%s%s", MT.slash, c.n)
				SlashCmdList[format("MACROTOOLKIT_CUSTOM_%s", string.upper(c.n))] = function(input) MT:DoCustomCommand(c.s, input) end
			end
		elseif arg1 == "Blizzard_MacroUI" then
			if MT.db.profile.override then
				MT.showmacroframe = ShowMacroFrame
				ShowMacroFrame = showtoolkit
			end
			local mtbutton = CreateFrame("Button", "MacroToolkitOpen", MacroFrame, "UIPanelButtonTemplate")
			mtbutton:SetText(L["Toolkit"])
			mtbutton:SetSize(94, 22)
			mtbutton:SetPoint("LEFT", MacroDeleteButton, "RIGHT")
			mtbutton:SetScript("OnClick",
				function()
					HideUIPanel(MacroFrame)
					MTF:Show()
				end)
		elseif arg1 == "Blizzard_TradeSkillUI" then
			--override code to handle tradeskill links
			local function btsui_onclick()
				local activeEditBox =  ChatEdit_GetActiveWindow()
				local activeMacroFrameText
				if MacroFrameText and MacroFrameText:IsShown() and MacroFrameText:HasFocus() then
					activeMacroFrameText = MacroFrameText
				elseif MacroToolkitText:IsShown() and MacroToolkitText:HasFocus() then
					activeMacroFrameText = MacroToolkitText
				end
				if activeMacroFrameText then
					local link = GetTradeSkillListLink()
					local text = format("%s%s", activeMacroFrameText:GetText(), link)
					if 255 >= strlenutf8(text) then activeMacroFrameText:Insert(link) end
				elseif activeEditBox then
					local link = GetTradeSkillListLink()
					if not ChatEdit_InsertLink(link) then assert(activeEditBox:GetName(), "Failed to add tradeskill link") end
				else ToggleDropDownMenu(1, nil, TradeSkillLinkDropDown, "TradeSkillLinkFrame", 25, 25) end
				PlaySound("igMainMenuOptionCheckBoxOn")
			end
			TradeSkillLinkButton:SetScript("OnClick", btsui_onclick)
		end
	elseif event == "PLAYER_LOGIN" then
		MT:BuildCommandList()
		MT:CreateOptions()
		MTF = MT:CreateMTFrame()
		MT:SetMacros(true)
		MT:CreateSecureFrames()
		--upgrade extended macro variables
		if MT.db.global.extended then
			if not type(MT.db.global.extended["1"]) == "table" then
				for i, e in pairs(MT.db.global.extended) do
					local index = getExMacroIndex(i)
					local name, icon = GetMacroInfo(index)
					MT.db.global.extended[i] = {name = name, icon = string.gsub(string.upper(icon), "INTERFACE\\ICONS\\", ""), body = e}
				end
				if MacroToolkitDB.char then
					for ch, chd in pairs(MacroToolkitDB.char) do
						if chd.extended then
							for i, e in pairs(chd.extended) do MacroToolkitDB.char[ch].extended[i] = {name = "", icon = "", body = e} end
						end
					end
				end
			end
		end
		if MT.db.char.extended then
			if not type(MT.db.char.extended["1"]) == "table" then
				for i, e in pairs(MT.db.char.extended) do
					local index = getExMacroIndex(i)
					local name, icon = GetMacroInfo(index)
					MT.db.char.extended[i].name = name
					MT.db.char.extended[i].icon = string.gsub(string.upper(icon), "INTERFACE\\ICONS\\", "")
				end
			end
		end
		if MT.db.global.allcharmacros then
			local numMacros = select(2, GetNumMacros())
			MT.db.char.macros = {}
			for m = _G.MAX_ACCOUNT_MACROS + 1, _G.MAX_ACCOUNT_MACROS + numMacros do
				local name, texture, body = GetMacroInfo(m)
				if not string.find(body, "MacroToolkitSecureButton") then
					MT.db.char.macros[m] = {name = name, icon = string.gsub(string.upper(texture), "INTERFACE\\ICONS\\", ""), body = body}
				end
			end
		end
		for i, e in pairs(MT.db.global.extended) do _G[format("MacroToolkitSecureButton%d", i)]:SetAttribute("macrotext", e.body) end
		for i, e in pairs(MT.db.char.extended) do _G[format("MacroToolkitSecureButton%d", i)]:SetAttribute("macrotext", e.body) end
		for i, e in pairs(MT.db.global.extra) do _G[format("MacroToolkitSecureButton%d", i)]:SetAttribute("macrotext", e.body) end
		if not MT.db.profile.usecolours then MacroToolkitFauxScrollFrame:Hide() end
		if not MT.db.profile.viserrors then
			MacroToolkitErrorBg:Hide()
			MacroToolkitErrorScrollFrame:Hide()
		end
		MTF:Hide()
		--if IsAddOnLoaded("ElvUI") then MT:LoadElvSkin() end
		MT.AC = MT.LS("AceComm-3.0")
		MT.AC:RegisterComm("MacroToolkit", function(...) MT:ReceiveMacro(...) end)
	end
end

function MT:GetBackups()
	local tab = PanelTemplates_GetSelectedTab(MTF)
	local var = (tab == 1) and "global" or "char"
	local backup = (tab == 3) and MT.db.global.ebackups or MT.db[var].backups
	local blist = {}
	for _, d in ipairs(backup) do blist[d.d] = d.d end
	return blist
end

function MT:ClearAllMacros()
	local tab = PanelTemplates_GetSelectedTab(MTF)
	local mstart = (tab == 1) and 1 or (_G.MAX_ACCOUNT_MACROS + 1)
	local mend = (tab == 1) and _G.MAX_ACCOUNT_MACROS or (_G.MAX_ACCOUNT_MACROS + _G.MAX_CHARACTER_MACROS)
	if tab < 3 then
		for m = mend, mstart, -1 do
			DeleteMacro(m)
			MT:MacroFrameUpdate()
			_G[format("MacroToolkitSecureButton%d", m)]:SetAttribute("macrotext", "")
		end
		local var = (tab == 1) and "global" or "char"
		MT.db[var].extended = {}
	else
		MT.db.global.extra = {}
		MT:MacroFrameUpdate()
	end
	MT:HideDetails()
	MacroToolkitText:SetText("")
	MacroToolkitFauxText:SetText("")
	MTF.selectedMacro = nil
	MacroToolkitSelMacroName:SetText("")
end

function MT:HexToRGB(hex)
    local ahex, rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6), string.sub(hex, 7, 8)
	return tonumber(rhex, 16) / 255, tonumber(ghex, 16) / 255, tonumber(bhex, 16) / 255, tonumber(ahex, 16) / 255
end

function MT:RGBToHex(r, g, b, a)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	a = a <= 1 and a >= 0 and a or 0
	return string.format("%.2x%.2x%.2x%.2x", a*255, r*255, g*255, b*255)
end

function MT:DoCustomCommand(luatext, input)
	local a1, a2, a3, a4 = strsplit(" ", input)
	if not a1 then a1, a2, a3, a4 = strsplit(",", input) end
	local script = string.format("local arg1, arg2, arg3, arg4 = \"%s\", \"%s\", \"%s\", \"%s\"\n%s", a1 or "", a2 or "", a3 or "", a4 or "", luatext)
	assert(loadstring(script))()
end

function MT:DoMTMacroCommand(command, parameters)
	if command == "mtce" then UIErrorsFrame:Clear()
	elseif command == "mteo" then UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
	elseif command == "mtex" then UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	elseif command == "mtrp" then SummonRandomCritter()
	elseif command == "mtso" then SetCVar("Sound_EnableSFX", 1)
	elseif command == "mtsx" then SetCVar("Sound_EnableSFX", 0)
	elseif command == "mtrt" then
		local t, m = strsplit(" ", parameters)
		SetRaidTarget(t, m)
	elseif command == "mtev" then VehicleExit()
	elseif command == "mtmc" then
		SetMapToCurrentZone()
		local x, y = GetPlayerMapPosition("player")
		print(format("%.1f %.1f", x*100, y*100))
	elseif command == "mttc" then ShowCloak(not ShowingCloak())
	elseif command == "mtth" then ShowHelm(not ShowingHelm())
	elseif command == "mtep" then for seat = 1,2 do if CanEjectPassengerFromSeat(seat) then EjectPassengerFromSeat(seat) end end
	elseif command == "mtsg" then
		local GetContainerItemInfo, GetItemInfo, UseContainerItem, cash = GetContainerItemInfo, GetItemInfo, UseContainerItem, 0
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local _, qty, _, _, _, _, itemlink = GetContainerItemInfo(bag, slot)
				if string.find(itemlink or "", "9d9d9d") then
					local vendorprice = select(11, GetItemInfo(itemlink)) * qty
					cash = cash + vendorprice
					UseContainerItem(bag, slot)
				end
			end
		end
		local gold = floor(cash / (_G.COPPER_PER_SILVER * _G.SILVER_PER_GOLD))
		local goldDisplay = BreakUpLargeNumbers(gold)
		local silver = floor((cash - (gold * _G.COPPER_PER_SILVER * _G.SILVER_PER_GOLD)) / _G.COPPER_PER_SILVER)
		local copper = mod(cash, _G.COPPER_PER_SILVER)
		local goldtexture = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
		local silvertexture = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
		local coppertexture = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
		print(format("%s: %s%s%s%s%s%s", L["Sell grey items"], gold, goldtexture, silver, silvertexture, copper, coppertexture))
	elseif command == "mtdg" then
		local GetContainerItemInfo, GetItemInfo, PickupContainerItem, DeleteCursorItem = GetContainerItemInfo, GetItemInfo, PickupContainerItem, DeleteCursorItem
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local itemlink = select(7, GetContainerItemInfo(bag, slot))
				if string.find(itemlink or "", "9d9d9d") then
					PickupContainerItem(bag, slot)
					DeleteCursorItem()
				end
			end
		end
	elseif command == "mtnb" then
		local UnitAura, UnitName = UnitAura, UnitName
		local msg = format("%s: ", L["No food buff"])
		local ppl = _G.NONE
		for member = 1, GetNumGroupMembers() do
			for buff = 1, 41 do
				local aura = UnitAura(format("raid%d", member), buff)
				if aura == L["Well Fed"] or aura == L["Food"] then break
				elseif buff == 41 and aura ~= L["Well Fed"] then ppl = format("%s%s ", ppl, UnitName(format("raid%d", member))) end
			end
		end
		SendChatMessage(format("%s%s", msg, ppl), MT.channel or "raid")
	elseif command == "mtnf" then
		local UnitAura, UnitName = UnitAura, UnitName
		local msg = format("%s: ", L["No flask"])
		local ppl = _G.NONE
		for member = 1, GetNumGroupMembers() do
			for buff = 1, 41 do
				local aura = UnitAura(format("raid%d", member), buff)
				if aura then
					if string.find(aura, L["Flask"])or string.find(aura, L["Distilled"])then break end
				elseif buff == 41 then ppl = format("%s%s ", ppl, UnitName(format("raid%d", member))) end
			end
		end
		SendChatMessage(format("%s%s", msg, ppl), "raid")
	end
end

function MT:FindScript(scriptname) for _, s in ipairs(MT.scripts) do if s[1] == scriptname then return s end end end

function MT:ShowShortened(chars)
	StaticPopupDialogs["MACROTOOLKIT_SHORTENED"] = {
		text = string.format((chars == 1) and L["Macro shortened by %d character"] or L["Macro shortened by %d characters"], chars),
		button1 = _G.OKAY, timeout = 0, exclusive = 1, whileDead = 1, hideOnEscape = 1}
	StaticPopup_Show("MACROTOOLKIT_SHORTENED")
end

function MT:SetMacros(account, extra, copy)
	MTF.macroBase = account and 0 or _G.MAX_ACCOUNT_MACROS
	MTF.macroMax = account and _G.MAX_ACCOUNT_MACROS or _G.MAX_CHARACTER_MACROS
	if extra then
		if MT:CountExtra() > 0 then MTF.selectedMacro = 101
		else MTF.selectedMacro = nil end
		MTF.macroBase = 100
	elseif copy then
		MTF.selectedMacro = 1
		MTF.macroBase = 1
	else
		local numAccountMacros, numCharacterMacros = GetNumMacros()
		if (account and numAccountMacros or numCharacterMacros) > 0 then MTF.selectedMacro = MTF.macroBase + 1
		else MTF.selectedMacro = nil end
	end
end

function MT:FormatMacro(macrotext)
	if macrotext == "" then return "", "" end
	local lines = {strsplit("\n", macrotext)}
	local mout, eout = "", ""
	for n, l in ipairs(lines) do
		if l == "" then mout = format("%s\n", mout)
		else
			local f, err = MT:ParseMacro(l)
			if not f then break end
			mout = format("%s%s\n", mout, f)
			for _, e in ipairs(err) do eout = format("%s%s\n", eout, e) end
		end
	end
	mout = string.sub(mout, 1, strlenutf8(mout) - 1)
	return mout, eout
end

function MT:UpdateExtended(index, body, mindex)
	local var = (index > _G.MAX_ACCOUNT_MACROS) and "char" or "global"
	local mindex = tostring(mindex)
	if not MT.db[var].extended then MT.db[var].extended = {} end
	local name, icon = GetMacroInfo(index)
	MT.db[var].extended[mindex] = {name = name, icon = string.gsub(string.upper(icon), "INTERFACE\\ICONS\\", ""), body = body}
end

function MT:DeleteExtended(index)
	local var = (MTF.selectedMacro > _G.MAX_ACCOUNT_MACROS) and "char" or "global"
	index = tostring(index)
	MT.db[var].extended[index] = nil
end

function MT:ExtendClick(this)
	MTF.textChanged = true
	if not MacroToolkitText.extended then MT:ExtendMacro()
	else MT:UnextendMacro() end
end

function MT:GetNextIndex()
	local tab = PanelTemplates_GetSelectedTab(MTF)
	local index = (tab == 2) and (_G.MAX_ACCOUNT_MACROS + 1) or 1
	local mstart, mend = index, (tab == 2) and (_G.MAX_ACCOUNT_MACROS + _G.MAX_CHARACTER_MACROS) or _G.MAX_ACCOUNT_MACROS
	if tab == 3 then
		index = 101
		mstart = 101
		mend = 100 + _G.MAX_ACCOUNT_MACROS
	end
	for m = mstart, mend do
		local var = (m > _G.MAX_ACCOUNT_MACROS) and "char" or "global"
		local ex = (tab == 3) and MT.db.global.extra or MT.db[var].extended
		if not ex[tostring(m)] then index = m; break end
	end
	return tostring(index)
end

function MT:GetCurrentIndex(extra)
	if not MTF.selectedMacro then return end
	if not MacroToolkitText.extended then return end
	local body = select(3, GetMacroInfo(MTF.selectedMacro))
	local index = select(3, string.find(body, "MacroToolkitSecureButton(%d+)"))
	return index
end

local function checktooltip(showtooltip, body)
	if showtooltip then
		if showtooltip == _G.SLASH_SHOWTOOLTIP1 then
			local _, _, firstspell = MT:ShortenMacro(body)
			if firstspell then showtooltip = string.format("%s %s", _G.SLASH_SHOWTOOLTIP1, firstspell) end
		end
	end
	return showtooltip
end

function MT:ExtendMacro(save, macrobody, idx)
	local body = macrobody or MacroToolkitText:GetText()
	local index = save and MT:GetCurrentIndex() or MT:GetNextIndex()
	local securebutton = _G[format("MacroToolkitSecureButton%d", index)]
	local showtooltip = select(3, string.find(body, "(#showtooltip.-)\n"))
	local show = select(3, string.find(body, "(#show .-)\n"))
	showtooltip = checktooltip(showtooltip, body)
	if showtooltip then showtooltip = format("%s\n", showtooltip) else showtooltip = "" end
	if show then show = format("%s\n", show) else show = "" end
	MT:UpdateExtended(idx or MTF.selectedMacro, body, index)
	securebutton:SetAttribute("macrotext", body)
	local newbody = format("%s%s%s %s", showtooltip, show, MT.click, securebutton:GetName())
	if not idx then
		MacroToolkitText.extended = true
		_G[format("MacroToolkitButton%d", (MTF.selectedMacro - MTF.macroBase))].extended = true
	end
	local tmp = EditMacro(idx or MTF.selectedMacro, nil, nil, newbody)
	if not save and not idx then
		MacroToolkitExtend:SetText(L["Unextend"])
		MacroToolkitText:GetScript("OnTextChanged")(MacroToolkitText)
		MT:UpdateCharLimit()
	end
end

local function unextend(body)
	local mbody = select(3, GetMacroInfo(MTF.selectedMacro))
	local mindex = select(3, string.find(mbody, "MacroToolkitSecureButton(%d+)"))
	local securebutton = _G[format("MacroToolkitSecureButton%d", mindex)]
	MT:DeleteExtended(mindex)
	securebutton:SetAttribute("macrotext", "")
	MacroToolkitText.extended = nil
	_G[format("MacroToolkitButton%d", (MTF.selectedMacro - MTF.macroBase))].extended = nil
	MacroToolkitExtend:SetText(L["Extend"])
	EditMacro(MTF.selectedMacro, nil, nil, body)
	MT:MacroFrameUpdate()
	MT:UpdateCharLimit()
end

function MT:UnextendMacro()
	local body = MacroToolkitText:GetText()
	if strlenutf8(body) > 255 then
		StaticPopupDialogs.MACROTOOLKIT_DELETEBACKUP.text = L["Your macro will be truncated to 255 characters. Are you sure?"]
		StaticPopupDialogs.MACROTOOLKIT_DELETEBACKUP.OnAccept = function() unextend(string.sub(body, 1, 255)) end
		StaticPopup_Show("MACROTOOLKIT_DELETEBACKUP")
	else unextend(body) end
end

function MT:GetExtendedBody(index, tab)
	local var = (tab == 1) and "global" or "char"
	if not MT.db[var].extended then return ""
	elseif not MT.db[var].extended[index] then return ""
	else return MT.db[var].extended[index].body end
end

function MT:UpdateCharLimit()
	if not MTF.selectedMacro then return end
	local extended = MacroToolkitText.extended
	local dct = MacroToolkitText:GetText()
	local chars = strlenutf8(dct)
	local limit = extended and 1024 or 255
	if MTF.selectedMacro > 100 or extended then
		if chars > 1024 then
			local ft = string.sub(dct, 1, 1024)
			MacroToolkitText:SetText(ft)
		end
	elseif chars > 255 and not extended then
		local ft = string.sub(dct, 1, 255)
		MacroToolkitText:SetText(ft)
	end
	MacroToolkitLimit:SetFormattedText(L["%d of %d characters used"], chars, limit)
end

function MT:UpdateErrors(errortext)
	MacroToolkitErrors:SetText(errortext)
	local icon, tt = MacroToolkitErrorIcon, GameTooltip
	if errortext ~= "" then
		icon:Show()
		icon:SetScript("OnEnter",
			function()
				tt:SetOwner(icon, "ANCHOR_LEFT")
				tt:ClearLines()
				tt:AddLine(_G.ERRORS)
				local lines = {strsplit("\n", errortext)}
				for _, l in ipairs(lines) do tt:AddLine(format("|cffffffff%s", l)) end
				tt:Show()
			end)
	else icon:Hide() end
end

function MT:CountExtra()
	local count = 0
	for i, e in pairs(MT.db.global.extra) do count = count + 1 end
	return count
end

function MT:SelOnClick(this)
	if InCombatLockdown() then return end
	this:SetChecked(nil)
	PickupMacro(MTF.selectedMacro)
end

function MT:MacroFrameUpdate()
	local numMacros, tab
	local numAccountMacros, numCharacterMacros = GetNumMacros()
	local macroButtonName, macroButton, macroIcon, macroName, macroUnbound
	local name, texture, body
	local selectedName, selectedBody, selectedIcon
	local tab = PanelTemplates_GetSelectedTab(MTF)
	local exmacros = {}

	numMacros = (MTF.macroBase == 0) and numAccountMacros or numCharacterMacros
	tab = PanelTemplates_GetSelectedTab(MTF)
	if MT.MTCF then if MT.MTCF:IsShown() then tab = 4 end end
	if tab == 3 then
		numMacros = MT:CountExtra()
		for i, exm in pairs(MT.db.global.extra) do table.insert(exmacros, {name = exm.name, texture = exm.texture, body = exm.body, index = i}) end
		table.sort(exmacros, function(a, b) return a.name < b.name end)
	elseif tab == 2 then
		if numMacros == _G.MAX_CHARACTER_MACROS then MacroToolkitCopyButton:Disable()
		else MacroToolkitCopyButton:Enable() end
	elseif tab == 4 then
		numMacros = 0
		if MT.charcopy then
			if MacroToolkitDB.char[MT.charcopy].extended then
				for i, exm in pairs(MacroToolkitDB.char[MT.charcopy].extended) do
					if tonumber(i) > _G.MAX_ACCOUNT_MACROS then
						local mname = (exm.name == "") and "xxx" or exm.name
						local micon = (exm.icon == "") and "INV_MISC_QUESTIONMARK" or exm.icon
						table.insert(exmacros, {name = mname, texture = micon, body = exm.body, extended = true})
						numMacros = numMacros + 1
					end
				end
			end
			if MT.db.global.allcharmacros then
				if MacroToolkitDB.char[MT.charcopy].macros then
					for _, m in pairs(MacroToolkitDB.char[MT.charcopy].macros) do
						table.insert(exmacros, {name = m.name, texture = m.icon, body = m.body})
						numMacros = numMacros + 1
					end
				end
			end
			table.sort(exmacros, function(a, b) return a.name < b.name end)
		end
	end
	local maxMacroButtons = (tab == 4) and _G.MAX_CHARACTER_MACROS or max(_G.MAX_ACCOUNT_MACROS, _G.MAX_CHARACTER_MACROS)
	local fsize = select(2, MacroToolkitButton1Name:GetFont())
	local font = LSM:Fetch(LSM.MediaType.FONT, MT.db.profile.fonts.mifont)
	local k1, k2
	local bname = (tab == 4) and "MacroToolkitCButton" or "MacroToolkitButton"
	for i = 1, maxMacroButtons do
		macroButtonName = format("%s%d", bname, i)
		macroButton = _G[macroButtonName]
		macroIcon = _G[format("%sIcon", macroButtonName)]
		macroName = _G[format("%sName", macroButtonName)]
		macroUnbound = _G[format("%sUnbound", macroButtonName)]
		macroName:SetFont(font, MT.db.profile.fonts.misize)
		if i <= MTF.macroMax then
			if i <= numMacros then
				macroUnbound:Hide()
				if tab == 3 then
					local em = exmacros[i]
					if em then
						name, texture, body = em.name, format("Interface\\Icons\\%s", em.texture), em.body
						local commandName = format("CLICK MacroToolkitSecureButton%d:LeftButton", em.index)
						k1, k2 = GetBindingKey(commandName)
						if not (k1 or k2) then macroUnbound:Show() end
						macroButton.extra = tonumber(em.index)
					end
				elseif tab == 4 then
					local em = exmacros[i]
					name, texture, body = em.name, format("Interface\\Icons\\%s", em.texture), em.body
				else name, texture, body = GetMacroInfo(MTF.macroBase + i) end
				macroIcon:SetTexture(texture)
				macroName:SetText(name)
				macroButton:Enable()
				-- Highlight Selected Macro
				local pos
				if MTF.selectedMacro then pos = ((tab == 3) and MTF.extrapos or (MTF.selectedMacro - MTF.macroBase)) end
				if tab == 4 then pos = MT.MTCF.selectedMacro end
				if MTF.selectedMacro and i == pos then
					macroButton:SetChecked(1)
					if tab < 4 then MacroToolkitSelMacroName:SetText(name)
					else MacroToolkitCSelMacroName:SetText(name) end
					local s, e, index = string.find(body, "MacroToolkitSecureButton(%d+)")
					if index then
						body = MT:GetExtendedBody(index, tab)
						MacroToolkitText.extended = true
						MacroToolkitExtend:SetText(L["Unextend"])
						macroButton.extended = true
						if MT.db.profile.visextend then MacroToolkitExtend:Show() end
						MacroToolkitSelMacroButton:SetScript("OnClick", function(this) MT:SelOnClick(this) end)
					elseif tab == 3 then
						MacroToolkitText.extended = true
						macroButton.extended = true
						MacroToolkitExtend:Hide()
						MacroToolkitSelMacroButton:SetScript("OnClick", function(this) this:SetChecked(nil) end)
						if not (k1 or k2) then MacroToolkitLimit:SetText(_G.NOT_BOUND)
						else
							if k1 then MacroToolkitLimit:SetText(GetBindingText(k1, "KEY_"))
							elseif k2 then MacroToolkitLimit:SetText(GetBindingText(k2, "KEY_")) end
						end
					else
						MacroToolkitText.extended = nil
						macroButton.extended = nil
						MacroToolkitExtend:SetText(L["Extend"])
						if MT.db.profile.visextend then MacroToolkitExtend:Show() end
						MacroToolkitSelMacroButton:SetScript("OnClick", function(this) MT:SelOnClick(this) end)
					end
					body = body or ""
					local m, e = MT:FormatMacro(body)
					if tab < 4 then
						MacroToolkitText:SetText(body)
						MacroToolkitFauxText:SetText(m)
						MT:UpdateErrors(e)
						MacroToolkitSelMacroButton:SetID(i)
						MacroToolkitSelMacroButtonIcon:SetTexture(texture)
						if MT.MTPF then MT.MTPF.selectedIconTexture = string.gsub(string.upper(texture), "INTERFACE\\ICONS\\", "") end
					else
						MacroToolkitCText:SetText(body)
						MacroToolkitCFauxText:SetText(m)
						MacroToolkitCSelMacroButton:SetID(i)
						MacroToolkitCSelMacroButtonIcon:SetTexture(texture)
					end
				else macroButton:SetChecked(0) end
				if tab == 4 then macroButton.extended = exmacros[i].extended end
			else
				macroButton:SetChecked(0)
				if tab == 3 then macroButton.extra = 100 end
				macroIcon:SetTexture("")
				macroName:SetText("")
				macroUnbound:Hide()
			end
			macroButton:Show()
		else macroButton:Hide() end
	end

	-- Macro Details
	if MTF.selectedMacro ~= nil then
		MT:ShowDetails()
		MacroToolkitDelete:Enable()
		MacroToolkitShorten:Enable()
		MacroToolkitExtend:Enable()
		MacroToolkitBackup:Enable()
		MacroToolkitShare:Enable()
		MacroToolkitBind:Enable()
		MacroToolkitConditions:Enable()
	else
		MT:HideDetails()
		MacroToolkitDelete:Disable()
		MacroToolkitShorten:Disable()
		MacroToolkitExtend:Disable()
		MacroToolkitBackup:Disable()
		MacroToolkitShare:Disable()
		MacroToolkitBind:Disable()
		MacroToolkitConditions:Disable()
	end
	
	--Update New Button
	if numMacros < MTF.macroMax then MacroToolkitNew:Enable()
	else MacroToolkitNew:Disable() end

	-- Disable Buttons
	if MT.MTPF then
		if MT.MTPF:IsShown() then
			MacroToolkitEdit:Disable()
			MacroToolkitDelete:Disable()
			MacroToolkitShorten:Disable()
			MacroToolkitExtend:Disable()
			MacroToolkitBackup:Disable()
			MacroToolkitClear:Disable()
			MacroToolkitShare:Disable()
			MacroToolkitBind:Disable()
			MacroToolkitConditions:Disable()
		else
			MacroToolkitEdit:Enable()
			MacroToolkitDelete:Enable()
			MacroToolkitShorten:Enable()
			MacroToolkitExtend:Enable()
			MacroToolkitBackup:Enable()
			MacroToolkitClear:Enable()
			MacroToolkitShare:Enable()
			MacroToolkitBind:Enable()
			MacroToolkitConditions:Enable()
		end
	end

	if not MTF.selectedMacro then
		MacroToolkitDelete:Disable()
		MacroToolkitShorten:Disable()
		MacroToolkitExtend:Disable()
		MacroToolkitShare:Disable()
		MacroToolkitBind:Disable()
	end
	
	if numMacros > 0 then MacroToolkitClear:Enable()
	else MacroToolkitClear:Disable() end
end

function MT:ContainerOnLoad(this)
	local button
	local maxMacroButtons = (this:GetName() == "MacroToolkitCButtonContainer") and _G.MAX_CHARACTER_MACROS or max(_G.MAX_ACCOUNT_MACROS, _G.MAX_CHARACTER_MACROS)
	local bname = (this:GetName() == "MacroToolkitCButtonContainer") and "MacroToolkitCButton" or "MacroToolkitButton"
	for i = 1, maxMacroButtons do
		button = CreateFrame("CheckButton", format("%s%d", bname, i), this, "MacroToolkitButtonTemplate")
		button:SetScript("OnClick", function(this, button) MT:MacroButtonOnClick(this, button) end)
		button:SetScript("OnDragStart", function(this) PickupMacro(MTF.macroBase + this:GetID()) end)
		button:SetID(i)
		if i == 1 then button:SetPoint("TOPLEFT", this, "TOPLEFT", 6, -6)
		elseif mod(i, _G.NUM_MACROS_PER_ROW) == 1 then button:SetPoint("TOP", _G[format("%s%d", bname, i - _G.NUM_MACROS_PER_ROW)], "BOTTOM", 0, -10)
		else button:SetPoint("LEFT", _G[format("%s%d", bname, i - 1)], "RIGHT", 13, 0) end
	end
end

function MT:MacroButtonOnClick(this, button)
	MT:SaveMacro()
	local tab = PanelTemplates_GetSelectedTab(MTF)
	MTF.selectedMacro = (tab == 3) and this.extra or (MTF.macroBase + this:GetID())
	if MT.MTCF then
		if MT.MTCF:IsShown() then
			tab = 4
			if _G[format("%sName", this:GetName())]:GetText() then
				MT.MTCF.selectedMacro = this:GetID()
				MacroToolkitCopy:Enable()
			end
		end
	end
	local name
	if tab == 3 then
		MTF.extra = this.extra
		MTF.extrapos = this:GetID()
		if MT.db.global.extra[tostring(this.extra)] then name = MT.db.global.extra[tostring(this.extra)].name end
	elseif tab == 4 then name = _G[format("%sName", this:GetName())]:GetText()
	else name = GetMacroInfo(MTF.selectedMacro) end
	if not name then
		if CursorHasMacro() and tab < 3 then
			local _, mid = GetCursorInfo()
			local name, texture, body = GetMacroInfo(mid)
			local tab = PanelTemplates_GetSelectedTab(MTF)
			texture = string.gsub(string.upper(texture), "INTERFACE\\ICONS\\", "")
			local s, e, index = string.find(body, "MacroToolkitSecureButton(%d+)")
			if s then
				local bg, bc = MT.db.global.extended[index], MT.db.char.extended[index]
				if bg and tab == 2 then
					local ni = MT:GetNextIndex()
					MT.db.char.extended[ni] = bg
					MT.db.global.extended[index] = nil
				elseif bc and tab == 1 then
					local ni = MT:GetNextIndex()
					MT.db.global.extended[ni] = bc
					MT.db.char.extended[index] = nil
				end
			end
			CreateMacro(name, texture, body, tab == 2)
			MT:MacroFrameUpdate()
			DeleteMacro(mid)
			ClearCursor()
		else
			MTF.selectedMacro = nil
			MT:HideDetails()
		end
	end
	MacroToolkitText.extended = button.extended
	MT:MacroFrameUpdate()
	if MT.MTPF then MT.MTPF:Hide() end
	MacroToolkitText:ClearFocus()
end

function MT:HideDetails()
	MacroToolkitEdit:Hide()
	MacroToolkitLimit:Hide()
	MacroToolkitText:Hide()
	MacroToolkitFauxText:Hide()
	MacroToolkitSelMacroName:Hide()
	MacroToolkitSelBg:Hide()
	MacroToolkitSelMacroButton:Hide()
end

function MT:ShowDetails()
	MacroToolkitEdit:Show()
	MacroToolkitLimit:Show()
	MacroToolkitEnterText:Show()
	MacroToolkitText:Show()
	MacroToolkitFauxText:Show()
	MacroToolkitSelMacroName:Show()
	MacroToolkitSelBg:Show()
	MacroToolkitSelMacroButton:Show()
	MacroToolkitShorten:Enable()
	MacroToolkitExtend:Enable()
end

function MT:SaveMacro()
	if MTF.textChanged and MTF.selectedMacro then
		if MTF.selectedMacro > 100 then
			MT.db.global.extra[tostring(MTF.extra)].body = MacroToolkitText:GetText()
			_G[format("MacroToolkitSecureButton%d", MTF.selectedMacro)]:SetAttribute("macrotext", MacroToolkitText:GetText())
		else
			if MacroToolkitText.extended then MT:ExtendMacro(true)
			else EditMacro(MTF.selectedMacro, nil, nil, MacroToolkitText:GetText()) end
		end
		MTF.textChanged = nil
	end
end

local function getMacroIcon(texture) for i, t in ipairs(MT.MACRO_ICON_FILENAMES) do if string.upper(t) == texture then return i end end end

function MT:GetBackupName()
	local tab = PanelTemplates_GetSelectedTab(MTF)
	local mtype = _G[format("MacroToolkitFrameTab%d", tab)]:GetText()
	StaticPopupDialogs.MACROTOOLKIT_BACKUPNAME.text = format("|cffeedd82%s|r\n\n%s", mtype, L["Enter a name for this backup"])
	StaticPopup_Show("MACROTOOLKIT_BACKUPNAME")
end

function MT:SetBackupName(dialog)
	local name = dialog.editBox:GetText() or ""
	dialog:Hide()
	MT:BackupMacros(name)
end

function MT:BackupMacros(backupname)
	local name, texture, body, fname
	local macros = {n=backupname, d=date(L["datetime format"]), m={}}
	local tab = PanelTemplates_GetSelectedTab(MTF)
	local var = (tab == 1) and "global" or "char"
	local start = (tab == 1) and 1 or (_G.MAX_ACCOUNT_MACROS + 1)
	local finish = (tab == 1) and _G.MAX_ACCOUNT_MACROS or (_G.MAX_ACCOUNT_MACROS + _G.MAX_CHARACTER_MACROS)
	if tab == 3 then
		var = "global"
		start = 101
		finish = 100 + MT:CountExtra()
	end
	MT:RefreshPlayerSpellIconInfo()
	for m = start, finish do
		if start > 100 then
			local em = MT.db.global.extra[tostring(m)]
			name, texture, body = em.name, em.texture, em.body
		else name, texture, body = GetMacroInfo(m) end
		if name then
			if string.find(body, "MacroToolkitSecureButton") then body = _G[format("MacroToolkitSecureButton%d", m)]:GetAttribute("macrotext") end
			fname = string.gsub(string.upper(texture), "INTERFACE\\ICONS\\", "")
			table.insert(macros.m, {index = m, icon = fname, body = body, name = name})
		end
	end
	if not MT.db[var].backups then MT.db[var].backups = {} end
	table.insert(MT.db[var].backups, macros)
	MT:SetLastBackupDate()
	MT:GetLastBackupDate()
	MT.MACRO_ICON_FILENAMES = nil
	collectgarbage()
end

function MT:SetLastBackupDate()
	local tab = PanelTemplates_GetSelectedTab(MTF)
	local var = (tab == 1) and "global" or "char"
	local backup = (tab == 3) and MT.db.global.ebackups or MT.db[var]
	backup.lastbackup = date(L["datetime format"])
end

function MT:IsSecureAction(action)
	if string.find(action, "TARGET") or string.find(action, "ACTIONBUTTON") then return true end
	local secureactions = {"TURNLEFT", "TURNRIGHT", "STRAFERIGHT", "STRAFELEFT", "MOVEBACKWARD", "ATTACKTARGET", "MOVEFORWARD", "SITORSTAND", "PITCHUP", "PITCHDOWN", "TOGGLEAUTORUN", "TOGGLERUN"}
	for _, a in ipairs(secureactions) do
		if action == a then return true end
	end
end

--*****************************
--code to handle clicking links
--*****************************
local function MTChatEdit_InsertLink(linktext)
	if MacroToolkitText and MacroToolkitText:IsVisible() then
		--if string.find(linktext, "|H") then return false end --why was this here???
		local item
		if string.find(linktext, "item:", 1, true) then item = GetItemInfo(linktext)
		else linktext = select(3, string.find(linktext, "h%[(.*)%]|h")) end
		if not linktext then return end
		local cursorPosition = MacroToolkitText:GetCursorPosition()
		if cursorPosition == 0 or string.sub(MacroToolkitText:GetText(), cursorPosition, cursorPosition) == "\n" then
			if item then
				if GetItemSpell(linktext) then MacroToolkitText:Insert(format("%s %s\n", _G.SLASH_USE1, item))
				else MacroToolkitText:Insert(format("%s %s\n", _G.SLASH_EQUIP1, item)) end
			else MacroToolkitText:Insert(format("%s %s\n", _G.SLASH_CAST1, linktext)) end
		else MacroToolkitText:Insert(item or linktext) end
		MacroToolkitText:GetScript("OnTextChanged")(MacroToolkitText)
		MTF.textChanged = 1
		return true
	end
	return false
end

local function MTSpellButton_OnModifiedClick(this, button)
	if IsModifiedClick("CHATLINK") then
		if MTF:IsShown() then
			local slot = SpellBook_GetSpellBookSlot(this)
			if slot > _G.MAX_SPELLS then return end
			local spellName, subSpellName = GetSpellBookItemName(slot, SpellBookFrame.bookType)
			if spellName and not IsPassiveSpell(slot, SpellBookFrame.bookType) then
				if subSpellName and (string.len(subSpellName) > 0) then ChatEdit_InsertLink(format("%s(%s)", spellName, subSpellName))
				else ChatEdit_InsertLink(spellName) end
			end
			return
		end
	end
end

hooksecurefunc("SpellButton_OnModifiedClick", MTSpellButton_OnModifiedClick)
hooksecurefunc("ChatEdit_InsertLink", MTChatEdit_InsertLink)