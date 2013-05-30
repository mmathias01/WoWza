 -------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- <Borderline Amazing>, http://ba-guild.com
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Channel Spam", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Channel Spam"]
Module.namespace = string.gsub(Module.name, " ", "")
Module.running = false

local random 	= math.random

local db, options
local defaults 	= {
	profile = {
		messageOne = "",
		messageTwo = "",
		spamMode = "alternate",
		interval = 60,
		channel = 2,
	}
}

local InsertLink
local channelSpam = L["Channel Spam has been |cff%s%s|r."]
local modeError = L["|cffff0000ERROR|r Both messages must be set in order to use the spam method |cffffff00%s|r"]
local firstMessage = false

function Module:SendMessages()
	if db.spamMode == "combined" then
		if db.messageOne then
			SendChatMessage(db.messageOne, "CHANNEL", nil, db.channel)
		end
		
		if db.messageTwo then
			SendChatMessage(db.messageTwo, "CHANNEL", nil, db.channel)
		end
	elseif db.spamMode == "random" then
		-- both messages must be set in order to use this method
		if (not db.messageOne and not db.messageTwo) or (db.messageOne:gsub(" ", "") == "" and db.messageTwo:gsub(" ", "") == "") then
			self:Print(modeError:format(L["RANDOM"]))
			return
		else
			local num = random(1, 2)
			SendChatMessage(num == 1 and db.messageOne or db.messageTwo, "CHANNEL", nil, db.channel)
		end
	else
		-- both messages must be set in order to use this method
		if (not db.messageOne and not db.messageTwo) or (db.messageOne:gsub(" ", "") == "" and db.messageTwo:gsub(" ", "") == "") then
			self:Print(modeError:format(L["ALTERNATE"]))
			return
		else
			SendChatMessage(firstMessage == false and db.messageOne or db.messageTwo, "CHANNEL", nil, db.channel)
			firstMessage = not firstMessage
		end
	end
end

function Module:OnEnable()
	InsertLink = ChatEdit_InsertLink
	ChatEdit_InsertLink = function(link)
		local ChatEdit1, ChatEdit2 = _G["AceGUI-3.0EditBox1"], _G["AceGUI-3.0EditBox2"]
		if ChatEdit1 and ChatEdit1:HasFocus() then
			ChatEdit1:Insert(link)
		elseif ChatEdit2 and ChatEdit2:HasFocus() then
			ChatEdit2:Insert(link)
		else
			InsertLink(link)
		end
	end
	
	self:RegisterChatCommand("chanspam", function(args)
		local first, second = self:GetArgs(args, 2)
		if first == "toggle" or first == "t" then
			if not Module.running then
				if (not db.messageOne and not db.messageTwo) or (db.messageOne:gsub(" ", "") == "" and db.messageTwo:gsub(" ", "") == "") then
					Module:Print("You must set at least one of the messages.")
				elseif not Module.running then
					Module:Print(channelSpam:format("00ff00", L["STARTED"]))
					
					-- since AceTimer-3.0 wont execute until after the interval, we have to do the first ourselves.
					Module:SendMessages()
					
					Module.spam = Module:ScheduleRepeatingTimer("SendMessages", db.interval)
					Module.running = true
				end
			else
				Module:Print(channelSpam:format("ff0000", L["STOPPED"]))
				Module:CancelTimer(Module.spam, true)
			end
		elseif first == "interval" or first == "i" then
			if Module.running == true then
				Module:Print(L["Timer is currently running, you must stop it first before changing the interval."])
			elseif second == "nil" or tonumber(second) < 30 or tonumber(second) > 600 then
				Module:Print(L["The interval must be a |cff00ff00%s|r between |cff00ff00%d|r and |cff00ff00%d|r."]:format("NUMBER", 30, 600))
			else
				db.interval = tonumber(second)
				Module:Print(L["Spam interval changed to |cffffff00%d|r"]:format(tonumber(db.interval)))
			end
		end
	end)
end

function Module:OnDisable()
	ChatEdit_InsertLink = InsertLink
	self:UnregisterChatCommand("chanspam")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.profile
	self.debug = ElvUI_ChatTweaks.db.profile.debugging
end

function Module:Info()
	return L["Allows you to spam a message to General or Trade chat every X seconds.  Useful for guild recruitment or profession links."]
end

function Module:GetOptions()
	if not options then
		options = {
			messageOne = {
				type = "input",
				order = 13,
				width = "double",
				name = "",
				desc = L["First message to send.  You can include links.\n\n|cffffffMake sure you hit [ENTER] after you finish typing your message.|r"],
				disabled = function() return Module.running end,
				get = function() return db.messageOne end,
				set = function(_, value) db.messageOne = value end,
			},
			messageOneReset = {
				type = "execute",
				order = 14,
				name = L["Reset"],
				func = function() db.messageOne = "" end,
			},
			messageTwo = {
				type = "input",
				order = 15,
				width = "double",
				name = "",
				desc = L["Second message to send.  You can include links.\n\n|cffffffMake sure you hit [ENTER] after you finish typing your message.|r"],
				disabled = function() return Module.running end,
				get = function() return db.messageTwo end,
				set = function(_, value) db.messageTwo = value end,
			},
			messageTwoReset = {
				type = "execute",
				order = 16,
				name = L["Reset"],
				func = function() db.messageTwo = "" end,
			},
			spamMode = {
				type = "select",
				order = 17,
				name = L["Spam Mode"],
				desc = L["Method by which to send the messages.\n\n|cffff00Alternate is alternating between the two messages.\nCombined is both messages at once.\nRandom will randomly pick one of the messages to send.|r"],
				disabled = function() return Module.running end,
				values = {
					["alternate"]	= L["Alternate"],
					["combined"]	= L["Combined"],
					["random"]		= L["Random"]
				},
				get = function() return db.spamMode end,
				set = function(_, value) db.spamMode = value end,
			},
			interval = {
				type = "range",
				order = 18,
				name = L["Spam Interval"],
				desc = L["Time, in seconds, between messages being sent."],
				disabled = function() return Module.running end,
				get = function() return db.interval end,
				set = function(_, value) db.interval = value end,
				min = 30, max = 600, step = 30,	-- minimum: 30 seconds, maximum: 10 minutes, step is 30 seconds
			},
			channel = {
				type = "select",
				order = 19,
				name = L["Channel"],
				desc = L["Channel to output the messages to."],
				values = {
					[1]	= L["General"],
					[2]	= L["Trade"],
				},
				disabled = function() return Module.running end,
				get = function() return db.channel end,
				set = function(_, value) db.channel = value end,
			},
			header = {
				type = "description",
				order = 20,
				name = "",
				width = "full"
			},
			start = {
				type = "execute",
				order = 21,
				name = L["Start"],
				disabled = function() return Module.running end,
				func = function()
					if (not db.messageOne and not db.messageTwo) or (db.messageOne:gsub(" ", "") == "" and db.messageTwo:gsub(" ", "") == "") then
						Module:Print("You must set at least one of the messages.")
					elseif not Module.running then
						Module:Print(channelSpam:format("00ff00", L["STARTED"]))
						
						-- since AceTimer-3.0 wont execute until after the interval, we have to do the first ourselves.
						Module:SendMessages()
						
						Module.spam = Module:ScheduleRepeatingTimer("SendMessages", db.interval)
						Module.running = true
					else
						Module:Print(L["Channel Spam is already running."])
					end
				end,
			},
			stop = {
				type = "execute",
				order = 22,
				name = L["Stop"],
				disabled = function() return not Module.running end,
				func = function()
					if Module.running then
						Module:Print(channelSpam:format("ff0000", L["STOPPED"]))
						Module:CancelTimer(Module.spam, true)
						Module.running = false
					end
				end,
			},
		}
	end
	return options
end