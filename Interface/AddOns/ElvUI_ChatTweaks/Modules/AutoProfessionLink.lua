-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- <Borderline Amazing>, http://ba-guild.com
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Auto Profession Link", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Auto Profession Link"]
Module.namespace = string.gsub(Module.name, " ", "")

local find = string.find
local format = string.format
local upper = string.upper

local db, options
local defaults = {
	profile = {
		linkAll = false,
		spamDelay = 60,
		minDelay = 1,
		maxDelay = 5,
		afk = true,
		dnd = true,
		keywords = {
			"link", "show", "!", "list", "lf"
		},	
		throttle = {}	-- for spam throttling
	}
}

local last = {prof = nil, who = nil}
local response = "%s (Generated by ElvUI_ChatTweaks v%s)"
local events = {
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_WHISPER"
}
local professions = {
	[L["Enchanting"]]		= {"enchant", "enchanting"},
	[L["Jewelcrafting"]]	= {"jewelcrafting", "jc"},
	[L["Alchemy"]]			= "alch",
	[L["Blacksmithing"]]	= {"blacksmith", "bs"},
	[L["Engineering"]]		= "eng",
	[L["Leatherworking"]]	= {"leather", "lw"},
	[L["Tailoring"]]		= "tailor",
	[L["Inscription"]]		= "inscri",
	[L["Cooking"]]			= "cook",
	[L["All"]]				= "all",
}

local function ChannelName(name)
	return name:lower():gsub("_", " "):gsub("(%w+)", function(first)
		return first:gsub("^%l", upper)
	end)
end

local function GetSetting(str)
	local name = str:match("CHAT_MSG_(.+)")
	return ChannelName(name)
end

local function HasKeyword(message)
	if not message or not db.keywords or #db.keywords == 0 then return false end
	for _, value in pairs(db.keywords) do
		if message:find(value) then return true end
	end
	return false
end

local function GetProfession(message)
	if not message then return false end
	for key, value in pairs(professions) do
		if type(value) == "string" then
			if message:find(value) then return key end
		else
			for _, prof in pairs(value) do
				if message:find(prof) then return key end
			end
		end
	end
	return false
end

function Module:PopulateTriggers(triggers)
	if not db.keywords or #db.keywords == 0 then return end
	db.keywords = {}
	for _, value in pairs(triggers) do
		if value ~= nil and value ~= "" then
			db.keywords[#db.keywords + 1] = value
		end
	end
end	

function Module:TriggersToString()
	local trigs = ""
	if not db.keywords or #db.keywords == 0 then return "" end
	for i = 1, #db.keywords do
		if db.keywords[i] ~= nil and db.keywords[i]:trim() ~= "" then
			trigs = trigs .. db.keywords[i] .. "\n"
		end
	end
	return trigs
end

function Module:SendLink(settings)
	SendChatMessage(format(response, select(2, GetSpellLink(settings[2])), ElvUI_ChatTweaks.version), "WHISPER", nil, settings[1])
end

function Module:EventHandler(channel, message, author)
	if not message or message:find("ElvUI_ChatTweaks") then return end
	
	if not db[GetSetting(channel)] then return end
	if author == UnitName("player") then return end	-- don't let the play ask himself for a link
	
	-- dont run if afk/dnd and appropriate setting is enabled
	if db.afk and UnitIsAFK("player") then return end
	if db.dnd and UnitIsDND("player") then return end
	
	local msg = message:lower()	-- we'll need it for comparative reasons
	
	if HasKeyword(msg) then
		local profession = GetProfession(msg)
		if profession ~= false then
			local delay = random(db.minDelay, db.maxDelay)
			
			if db.throttle[author] == nil or db.throttle[author].time <= (time() - db.spamDelay) then
				-- make sure the player has the profession
				if db.linkAll and profession == L["All"] then
					-- link all professions
					local profString, prof = "", "%s "
					for key, _ in pairs(professions) do
						if IsUsableSpell(key) then
							profString = profString .. format(prof, select(2, GetSpellLink(key)))
						end
					end
					if profString:trim() ~= "" then
						self:ScheduleTimer("SendLink", delay, {author, profession})
					end
				elseif IsUsableSpell(profession) then
					self:ScheduleTimer("SendLink", delay, {author, profession})
				end
				db.throttle[author] = {
					time = time(),
					responded = false,
				}
			elseif db.throttle[author] ~= nil and db.throttle[author].responded == false and db.throttle[author].time > (time() - db.spamDelay) then
				SendChatMessage(format(L["You can only send a request once every %d seconds.  You last sent a request at %s."], db.spamDelay, date("%X", db.throttle[author].time)), "WHISPER", nil, author)
				db.throttle[author].responded = true
			end
		end
	end
end

function Module:OnEnable()
	local i = 1
	for _, event in pairs(events) do
		self:RegisterEvent(event, "EventHandler")
		local name = event:match("CHAT_MSG_(.+)")
		local setting = ChannelName(name)
		db[setting] = db[setting] or false
		if not options.channels.args[name] then
			options.channels.args[name] = {
				type = "toggle",
				order = 20 + i,
				name = setting,
				desc = L["Monitor text in this channel for link triggers."],
				get = function() return db[setting] end,
				set = function(_, value) db[setting] = value end,
			}
			i = i + 1
		end
	end
end

function Module:OnDisable()
	for _, event in pairs(events) do
		self:UnregisterEvent(event)
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.profile
	self.debug = ElvUI_ChatTweaks.db.profile.debugging
end

function Module:Info()
	return L["Automatically link someone the profession they requested via various keywords."]
end

function Module:GetOptions()
	if not options then
		options = {
			linkAll = {
				type = "toggle",
				order = 13,
				name = L["Link All Professions"],
				desc = L["Allow someone to request a link of all your professions."],
				get = function() return db.linkAll end,
				set = function(_, value) db.linkAll = value end,
			},
			spamDelay = {
				type = "range",
				order = 14,
				name = L["Spam Delay"],
				desc = L["The time, in seconds, it takes for the same person to trigger the addon again."],
				get = function() return db.spamDelay end,
				set = function(_, value) db.spamDelay = value end,
				min = 5, max = 120, step = 1,
			},
			minDelay = {
				type = "range",
				order = 15,
				name = L["Minimum Delay"],
				desc = L["Minimum time, in seconds, to wait before whispering someone the link."],
				get = function() return db.minDelay end,
				set = function(_, value)
					db.minDelay = value
					options.maxDelay.min = value
				end,
				min = 0, max = 30, step = 1,
			},
			maxDelay = {
				type = "range",
				order = 16,
				name = L["Maximum Delay"],
				desc = L["Maximum time, in seconds, to wait before whispering someone the link."],
				get = function() return db.maxDelay end,
				set = function(_, value)
					db.maxDelay = value
					options.minDelay.max = value
				end,
				min = 0, max = 30, step = 1,
			},
			keywords = {
				type 		= "input",
				order = 17,
				width = "full",
				multiline = true,
				name = L["Triggers"],
				desc = L["These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested."],
				get = function() return Module:TriggersToString() end,
				set = function(_, value) Module:PopulateTriggers({strsplit("\n", value:trim())}) end,
			},
			channels = {
				type = "group",
				order = 20,
				guiInline = true,
				name = L["Channels to Monitor"],
				args = {}
			},
			disableIf = {
				type = "group",
				order = 99,
				name = L["Disable if..."],
				guiInline = true,
				args = {
					afk = {
						type = "toggle",
						order = 1,
						name = L["AFK"],
						desc = L["Disable while you're AFK flagged."],
						get = function() return db.afk end,
						set = function(_, value) db.afk = value end,
					},
					dnd = {
						type = "toggle",
						order = 2,
						name = L["Busy"],
						desc = L["Disable while you're DND flagged."],
						get = function() return db.dnd end,
						set = function(_, value) db.dbd = value end,
					},
				}
			},
		}
	end
	return options
end