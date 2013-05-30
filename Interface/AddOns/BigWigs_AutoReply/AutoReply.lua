--@Name: BigWigs [AutoReply]
--@Author: Kiezo
--@Version: 1.07
--@ToDo:
--===============================================================================

AR_VERSION = "1.07";
AR = LibStub("AceAddon-3.0"):NewAddon("Auto Reply", "AceEvent-3.0", "AceConsole-3.0")

-- CONSTANTS --
diffRef = {[0] = "", [3] = "[10]", [4] = "[25]", [5] = "[10H]", [6] = "[25H]", [7] = "[LFR]"}
blacklist = {"<BigWigs>", "<Deadly Boss Mods>", "<DBM>"}

arReportHealth = true
arFilterWhispers = true

local arDebug = false
local arEncounterInProgress = false
local arWhisperers = {}
local arEncounterName = ""

--===============================================================================
--INITIALIZATION
--===============================================================================
function AR:OnInitialize()

	self:RegisterEvent("CHAT_MSG_WHISPER")	
	self:RegisterEvent("CHAT_MSG_BN_WHISPER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	if BigWigsLoader then
		BigWigsLoader.RegisterMessage(AR, "BigWigs_OnBossEngage", "onBossEngage")
		BigWigsLoader.RegisterMessage(AR, "BigWigs_OnBossWipe", "onBossEnd")
		BigWigsLoader.RegisterMessage(AR, "BigWigs_OnBossWin", "onBossEnd")
		AR:dprint("BigWigsLoader present. Messages registered.")
	end

	self:RegisterChatCommand("ar", "SlashHandler")
end

function AR:SlashHandler(input)
	if not input or input:trim() == "" then
		print("Auto Reply |c00FF0000v"..AR_VERSION.."|r loaded successfully.")	
	elseif (input == "debug") then
		arDebug = not arDebug
		if (arDebug) then
			print("|c00FF0000AR|r: Debugging |c0000FF00ON|r.")
		else
			print("|c00FF0000AR|r: Debugging |c00FF0000OFF|r.")
		end

	elseif (input == "author") then
		print("|c00FF0000AR|r: Addon Author -  Kiezo - Bleeding Hollow [H] <Inverse Logic>. HUGE Thanks to Funkydude and the rest of the BigWigs authors.")	

	elseif (input == "filter") then
		arFilterWhispers = not arFilterWhispers
		if (arFilterWhispers) then
			print("|c00FF0000AR|r: Filtering |c0000FF00ON|r.")
		else
			print("|c00FF0000AR|r: Filtering |c00FF0000OFF|r.")
		end
	elseif (input == "reportHealth") then
		arReportHealth = not arReportHealth
		if (arReportHealth) then
			print("|c00FF0000AR|r: Reporting Health |c0000FF00ON|r.")
		else
			print("|c00FF0000AR|r: Reporting Health |c00FF0000OFF|r.")
		end
	else
		print("|c00FF0000AR|r: Not a recognized command.")
	end
end

function AR:PLAYER_ENTERING_WORLD()
	removeall(arWhisperers)
	arEncounterName = ""
	arEncounterInProgress = false
end

--===============================================================================
--HANDLING WHISPERS
--===============================================================================
function AR:onBossEngage(self, module)
	if (not module.moduleName or not module.encounterId) then return end
	AR:dprint("Boss Engaged: "..module.moduleName)

	arEncounterName = module.moduleName
	arEncounterInProgress = true
	removeall(arWhisperers)

	if arFilterWhispers then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", shouldFilterAutoReply)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", shouldFilterAutoReply)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", shouldFilterAutoReply)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", shouldFilterAutoReply)
	end
end

function AR:onBossEnd(self, module)
	if (not module.moduleName or not module.encounterId) then return end
	AR:dprint("Boss End: "..module.moduleName)

	local result = ""
	local playerList = ""
	if (self == "BigWigs_OnBossWipe") then result = "wiped on" else result = "defeated" end

	for i, whisperer in ipairs(arWhisperers) do
		if type(whisperer) == "string" then
			--this was a normal whisper sent
			SendChatMessage(string.format("<BigWigs> %s has %s %s %s.", UnitName("player"), result, AR:ReportRaidDifficulty(), arEncounterName), "WHISPER", nil, whisperer)
			playerList = playerList.." ".. whisperer
		else
			--this was a BNet whisper, so I have an ID instead
			BNSendWhisper(whisperer, string.format("<BigWigs> %s has %s %s %s.", UnitName("player"), result, AR:ReportRaidDifficulty(), arEncounterName), "WHISPER")
			playerList = playerList.." ".. AR:FriendNameForID(whisperer)
		end
	end

	if #arWhisperers > 0 and arFilterWhispers then
		print(string.format("|c00FF0000AR|r: Received whispers from:%s.", playerList))
	end

	removeall(arWhisperers)
	arEncounterName = ""
	arEncounterInProgress = false

	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", shouldFilterAutoReply)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", shouldFilterAutoReply)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", shouldFilterAutoReply)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BN_WHISPER", shouldFilterAutoReply)
end

function AR:CHAT_MSG_WHISPER(self, msg, sender)

	AR:dprint("Chat Whisper Received")
	if not arEncounterInProgress then return end

	if (type(sender) == "string" and sender~=UnitName("player") and not UnitInRaid(sender))then
		if (not AR:TableContains(arWhisperers, sender) or msg == "status") then
			if (not AR:TableContains(arWhisperers, sender)) then
				table.insert(arWhisperers, sender)
			end	

			local eDiff = AR:ReportRaidDifficulty()
			local chatMsg = ""

			if arReportHealth then
				local eHealth = AR:EncounterHealth()
				chatMsg = "<BigWigs> "..UnitName("player").." is currently in combat with "..eDiff.." "..arEncounterName.." "..string.format("%s", eHealth).."."
			else
				chatMsg = "<BigWigs> "..UnitName("player").." is currently in combat with "..eDiff.." "..arEncounterName.."."
			end

			SendChatMessage(chatMsg, "WHISPER", nil, sender)
		end
	end
end

function AR:CHAT_MSG_BN_WHISPER(self, msg, sender, _, _, _, _, _, _, _, _, _, _, pID)

	AR:dprint("BNet Whisper Received")
	if not arEncounterInProgress then return end

	if (type(pID) == "number" and sender~=select(2, BNGetInfo())) then
		if (not AR:TableContains(arWhisperers, pID) or msg == "status") then
			if (not AR:TableContains(arWhisperers, pID)) then
				table.insert(arWhisperers, pID)
			end

			local eDiff = AR:ReportRaidDifficulty()
			local chatMsg = ""

			if arReportHealth then
				local eHealth = AR:EncounterHealth()
				chatMsg = "<BigWigs> "..UnitName("player").." is currently in combat with "..eDiff.." "..arEncounterName.." "..string.format("%s", eHealth).."."
			else
				chatMsg = "<BigWigs> "..UnitName("player").." is currently in combat with "..eDiff.." "..arEncounterName.."."
			end

			BNSendWhisper(pID, chatMsg)
		end
	end
end

--===============================================================================
--UTILITY FUNCTIONS
--===============================================================================
function shouldFilterAutoReply(self, event, msg, author)
	for _, word in ipairs(blacklist) do
    		if (string.find(msg, word)) then
     			return true
		end
	end
	return false
end

function AR:EncounterHealth()

	if UnitExists("boss1") then
		return string.format("(%0.0f%%)", UnitHealth("boss1")/UnitHealthMax("boss1") * 100);
	else
		local tName = UnitName("target")
		if tName == "Nalak" or tName == "Oondasta" or tName == "Galleon" or tName == "Sha of Anger" then
			return string.format("(%0.0f%%)", UnitHealth("target")/UnitHealthMax("target") * 100)
		else
			AR:dprint("Boss health unavailable")
			return "(??%)"
		end
	end
end
		
function AR:TableContains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function AR:ReportRaidDifficulty()

	local diff = diffRef[select(3, GetInstanceInfo())]
	if diff then return diff else return "N/A" end
end

function AR:FriendNameForID(pID)
	for i=1, BNGetNumFriends() do
		local presenceID, presenceName = BNGetFriendInfo(i)
		if pID == presenceID then
			return presenceName
		end
	end
	return "Unknown"
end

--===============================================================================
--DEBUGGING FUNCTIONS
--===============================================================================
function removeall(table)
	for v, k in pairs(table) do
		table[v] = nil
	end
end

function AR:dprint(text)
	if (arDebug) then
		print("AutoReply: "..text)
	end
end