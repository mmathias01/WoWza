-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- <Borderline Amazing>, http://ba-guild.com
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local E, _, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local _G = getfenv(0)
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)

-- load globals
ElvUI_ChatTweaks = LibStub("AceAddon-3.0"):NewAddon("ElvUI_ChatTweaks", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
ElvUI_ChatTweaks.version = GetAddOnMetadata("ElvUI_ChatTweaks", "Version")
ElvUI_ChatTweaks.addonName = "ElvUI_ChatTweaks"
ElvUI_ChatTweaks.hexColor = ""
ElvUI_ChatTweaks.abbrev = L["ElvUI_CT"]
ElvUI_ChatTweaks.options = {
	type = "group",
	name = ElvUI_ChatTweaks.addonName,
	args = {},
}
ElvUI_ChatTweaks.L = L

local DEFAULT_WIDTH = 890;
local DEFAULT_HEIGHT = 651;

local concat = table.concat
local insert = table.insert
local sort = table.sort

-- about page
local fields = {"Title", "Version", "Author", "X-Category", "X-License", "X-Email", "Email", "eMail", "X-Website", "X-Credits", "X-Localizations", "X-Donate", "X-Paypal"}
local fieldName = "|cff1784d1%s:|r"

-- for all modules
local prototype = {
	Decorate = function(self, chatframe) end,
	Popout = function(self, chatframe, srcchatframe) end,
	TempChatFrames = {},
	AddTempChat = function(self, name) insert(self.TempChatFrames, name) end,
	AlwaysDecorate = function(self, chatframe) end,
}

ElvUI_ChatTweaks:SetDefaultModulePrototype(prototype)
ElvUI_ChatTweaks:SetDefaultModuleState(false)

-- hook the print function of aceconsole
ElvUI_ChatTweaks.Print_ = ElvUI_ChatTweaks.Print
ElvUI_ChatTweaks.Print = function(self, ...)
	local tmp = {}
	local out = string.join("", ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.abbrev, "|r: %s")
	for i = 1, select("#", ...) do
		tmp[i] = tostring(select(i, ...))
	end
	DEFAULT_CHAT_FRAME:AddMessage(out:format(tostring(select(1, ...))))
end

local function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do insert(a, n) end
	sort(a, f)
	local i = 0
	local iter = function()
		i = i + 1
		if a[i] == nil then 
			return nil
		else 
			return a[i], t[a[i]]
		end
	end
	return iter
end

--[[ Ace3 Framework Events ]]--
function ElvUI_ChatTweaks:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("ElvUI_ChatTweaksDB", self.defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "SetUpdateConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "SetUpdateConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "SetUpdateConfig")
	
	-- add to elvui's config
	-- trying to make this addon feel more like a part
	-- of elvui, instead of being independant, even though it is
	-- a required dep
	LibStub("LibElvUIPlugin-1.0"):RegisterPlugin(self.addonName, function()
		E.Options.args.chat.args.ChatTweaks = {
			type = "group",
			name = L["Tweaks"],
			args = {
				showect = {
					type = "execute",
					name = L["Show ElvUI Chat Tweaks Config Window"],
					desc = L["Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."],
					width = "double",
					func = function() ElvUI_ChatTweaks:ToggleConfig(true); E:ToggleConfig(); end,
				},
			},
		}
	end)
end

function ElvUI_ChatTweaks:OnEnable()
	-- add the modules' options tables
	for k, v in self:IterateModules() do
		self.options.args[k:gsub(" ", "_")] = {
			type = "group",
			name = v.name or k,
			--guiInline = true,
			args = nil
		}
		local t
		if v.GetOptions then
			t = v:GetOptions()
			t.settingsHeader = {
				type = "header",
				name = L["Settings"],
				order = 12
			}
		end
		t = t or {}
		t.toggle = {
			type = "toggle",
			name = v.toggleLabel or (L["Enable "] .. (v.name or k)),
			width = "double",
			desc = v:Info() and v:Info() or (L["Enable "] .. (v.name or k)),
			order = 11,
			get = function() return self.db.profile.modules[k] ~= false or false end,
			set = function(_, value)
				self.db.profile.modules[k] = value
				if value then
					self:EnableModule(k)
					self:Print((L["Enabled %s%s|r module."]):format(self.hexColor, k))
				else
					self:DisableModule(k)
					self:Print((L["Disabled %s%s|r module."]):format(self.hexColor, k))
				end
			end
		}
		t.enableAll = {
			type = "execute",
			order = 7,
			name = L["Enable All Modules"],
			func = function() StaticPopup_Show("ECT_ENABLE_ALL") end,
		}
		t.disableAll = {
			type = "execute",
			order = 8,
			name = L["Disable All Modules"],
			func = function() StaticPopup_Show("ECT_DISABLE_ALL") end,
		}
		t.header = {
			type = "header",
			name = v.name or k,
			order = 9
		}
		if v.Info then
			t.description = {
				type = "description",
				name = v:Info() .. "\n\n",
				order = 10
			}
		end
		self.options.args[k:gsub(" ", "_")].args = t
	end

	for k, v in self:IterateModules() do
		if self.db.profile.modules[k] ~= false then v:Enable() end
	end
	
	AceConfig:RegisterOptionsTable(self.addonName, self.options)
	AceConfigDialog:SetDefaultSize(self.addonName, DEFAULT_WIDTH, DEFAULT_HEIGHT)

	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	AceConfig:RegisterOptionsTable(self.addonName .. "Profiles", self.options.args.profiles)
	self.options.args.profiles.order = -10
	
	self.options.args.about = {
		type = "group",
		order = -9,
		name = L["About"],
		args = {}
	}
	
	local i = 1
	for _, field in pairs(fields) do
		local val = GetAddOnMetadata(self.addonName, field)
		if val then
			self.options.args.about.args[field] = {
				type = "description",
				order = i,
				width = "normal",
				name = fieldName:format(field:gsub("X%-", "")),
			}
			i = i + 1
			self.options.args.about.args[field .. "_value"] = {
				type = "description",
				order = i,
				width = "double",
				name = val,
			}
			i = i + 1
		end
	end
	
	self.options.args.about.args.dummy = {
		type = "description",
		order = 99,
		width = "full",
		name = "\n\n",
	}
	
	self.options.args.about.args.about = {
		type = "description",
		order = 100,
		width = "full",
		name = L["    When I first started using ElvUI around the beginning of Cataclysm's release I noticed that there were some chat functionality that I wanted, but wasn't included with ElvUI.  I came across Prat and Chatter, but found that they had too many modules that I didn't want and both addons do use a fair bit of memory.  So I decided to write my own version, which is when ElvUI_ChatTweaks was born.  Since then I have made sure that this addon is as bug free as possible, as well as being up to date with the latest API available, and I am constantly adding new functionality.  If there's any features you'd like to see added please contact me and I'll see what I can do.\n\nThanks,\n|cffffff00Lockslap|r"],
	}
	
	self:AddMenuHook(self, {
		text = L["ElvUI ChatTweaks"],
		func = function()
			local mode = "Close"
			if not AceConfigDialog.OpenFrames[self.addonName] then
				mode = "Open"
			end
			AceConfigDialog[mode](AceConfigDialog, self.addonName)
		end,
		notCheckable = 1
	})
	self:RawHook("FCF_Tab_OnClick", true)
	
	-- chat command
	self:RegisterChatCommand("ct", function(args)
		local cmd = self:GetArgs(args)
		if not cmd or cmd == "" or cmd == "config" then
			self:ToggleConfig()
		elseif cmd == "version" or cmd == "ver" then
			self:Print((L["You are running version |cff1784d1%s|r."]):format(self.version))
		elseif cmd == "modules" or cmd == "mods" then
			local modStatus, enabled, disabled = {}, 0, 0
			for name, module in self:IterateModules() do
				modStatus[name] = module:IsEnabled() and true or false
				if module:IsEnabled() then enabled = enabled + 1
				else disabled = disabled + 1 end
			end
			
			if not modStatus then
				self:Print(L["|cffff0000No modules found.|r"])
			else
				local moduleName = "    +|cff00ffff%s|r - %s"
				local enabledModule  = L["|cff00ff00Enabled|r"]
				local disabledModule = L["|cffff0000Disabled|r"]
				self:Print(format(L[" |cffffff00%d|r Total Modules (|cff00ff00%d|r Enabled, |cffff0000%d|r Disabled)"], (enabled + disabled), enabled, disabled))
				for name, status in pairsByKeys(modStatus) do
					print(format(moduleName, name, status == true and enabledModule or disabledModule))
				end
			end
		elseif cmd == "help"  or cmd == "?" then
			self:PrintHelp()
		end
	end)
	
	-- hook every module's print function
	for name, module in self:IterateModules() do
		module.Print_ = module.Print
		module.Print = function(self, ...)
			local out = string.join("", ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.abbrev, "|r: %s")
			DEFAULT_CHAT_FRAME:AddMessage(out:format(tostring(select(1, ...))))
		end
	end
end

function ElvUI_ChatTweaks:PrintHelp()
	local argStr  = L["   |cff00ff00/ct %s|r - %s"]
	local arg2Str = L["   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"]
	local clrStr  = L["   |cff00ff00%s|r or |cff00ff00%s|r - %s"]
	local cmdStr  = L["   |cff00ff00%s|r - %s"]
	self:Print(L["Available Chat Command Arguments"])
	print(format(argStr, "config", L["Opens configuration window."]))
	print(format(arg2Str, "modules", "mods", L["Prints module status."]))
	print(format(arg2Str, "help", "?", L["Print this again."]))
	print(format(arg2Str, "version", "ver", L["Print Addon Version"]))
	-- determine if clear chat command module is enabled
	
	for name, module in self:IterateModules() do
		if module:IsEnabled() and name == "Clear Chat Commands" then
			print(format(clrStr, "/clr", "/clear", L["Clear current chat."]))
			print(format(clrStr, "/clrall", "/clearall", L["Clear all chat windows."]))
		elseif module:IsEnabled() and name == "GKick Command" then
			print(format(cmdStr, "/gkick", L["Alternate command to kick someone from guild."]))
		elseif module:IsEnabled() and name == "Group Say Command" then
			print(format(cmdStr, "/gs", L["Talk to your group based on party/raid status."]))
		elseif module:IsEnabled() and name == "Tell Target" then
			print(format(cmdStr, "/tt", L["Send a tell to your target."]))
		elseif module:IsEnabled() and name == "Developer Tools" then
			print(format(cmdStr, "/ctdev", L["Various Developer Tools"]))
		end
	end
end

do
	local info, menuHooks = {}, {}
	function ElvUI_ChatTweaks:AddMenuHook(module, hook)
		menuHooks[module] = hook
	end
	
	function ElvUI_ChatTweaks:RemoveMenuHook(module)
		menuHooks[module] = nil
	end
	
	function ElvUI_ChatTweaks:FCF_Tab_OnClick(...)
		self.hooks.FCF_Tab_OnClick(...)
		for module, v in pairs(menuHooks) do
			local menu
			if type(v) == "table" then
				menu = v
			else
				menu = module[v](module, ...)
			end
			UIDropDownMenu_AddButton(menu)
		end
	end
end

function ElvUI_ChatTweaks:FCF_OpenTemporaryWindow(chatType, chatTarget, sourceChatFrame, selectWindow)
	local frame = self.hooks.FCF_OpenTemporaryWindow(chatType, chatTarget, sourceChatFrame, selectWindow)
	if frame then
		for k, v in self:IterateModules() do
			if not frame.isDecorated then
				v:AddTempChat(frame:GetName())
			end
			if v:IsEnabled() and not frame.isDecorated then
				v:Decorate(frame)
			end
			if v:IsEnabled() then
				v:Popout(frame, sourceChatFrame or DEFAULT_CHAT_FRAME)
			end
			v:AlwaysDecorate(frame)
		end
	end
	FCFDock_ForceReanchoring(GENERAL_CHAT_DOCK)
	return frame
end

function ElvUI_ChatTweaks:ToggleConfig(dontPrint)
	--InterfaceOptionsFrame_OpenToCategory(ElvUI_ChatTweaks.frames.general)	
	local mode = "Close"
	if not AceConfigDialog.OpenFrames[self.addonName] then
		mode = "Open"
		
		if not dontPrint then
			self:Print(L["Showing Configuration Options"])
		end
	end
	AceConfigDialog[mode](AceConfigDialog, self.addonName)
end


function ElvUI_ChatTweaks:SetUpdateConfig(event, database, newProfileKey)
	self.db = database.profile
	self:UpdateConfig()
end

function ElvUI_ChatTweaks:UpdateConfig()
	for _, v in self:IterateModules() do
		if v:IsEnabled() then
			v:Disable()
			v:Enable()
		end
	end
end

function ElvUI_ChatTweaks:ModuleEnabled(module)
	for name, value in self:IterateModules() do
		if name:lower():gsub(" ", "") == module:lower():gsub(" ", "") then
			return value:IsEnabled()
		end
	end
	return false
end

function ElvUI_ChatTweaks:GetModuleStatus()
	local active, inactive, total = 0, 0, 0
	for _, value in self:IterateModules() do
		if value:IsEnabled() then
			active = active + 1
		else
			inactive = inactive + 1
		end
		total = total + 1
	end
	return active, inactive, total
end

function ElvUI_ChatTweaks:NumModules()
	local total = 0
	for _, value in self:IterateModules() do
		total = total + 1
	end
	return total
end

function ElvUI_ChatTweaks:EnableAllModules()
	for name, module in self:IterateModules() do
		if self.db.profile.debugging then
			self:Print((L["Enabled %s%s|r module."]):format(self.hexColor, name))
		end
		module:Enable()
	end
end

function ElvUI_ChatTweaks:DisableAllModules()
	for name, module in self:IterateModules() do
		if self.db.profile.debugging then
			self:Print((L["Disabled %s%s|r module."]):format(self.hexColor, name))
		end
		module:Disable()
	end
end

function ElvUI_ChatTweaks:PLAYER_ENTERING_WORLD(event, ...)
	self.abbrev = self.db.profile.shorten and L["ElvUI_CT"] or L["ElvUI_ChatTweaks"]
	if self.db.profile.welcome == true then
		self:Print((L["Version %s%s|r is loaded. Type %s/ct|r if you need help."]):format(self.hexColor, self.version, self.hexColor))
	end
	
	if IsAddOnLoaded("Prat-3.0") then
		print(L["You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."])
	end
	
	if IsAddOnLoaded("Chatter") then
		print(L["You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."])
	end
	
	self.NotifyTimer = self:ScheduleTimer("SendMessage", 12)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end
ElvUI_ChatTweaks:RegisterEvent("PLAYER_ENTERING_WORLD")

-- auto update notify
function ElvUI_ChatTweaks:SendMessage()
	local inInstance, instanceType = IsInInstance()
	
	if self.db.profile.debugging then
		self:Print((L["Addon Version Sent, Version: |cffffff00%s|r"]):format(tostring(self.version)))
	end
	
	if inInstance and instanceType == "pvp" or instanceType == "arena" then
		SendAddonMessage("self", self.version, "INSTANCE_CHAT")
	else
		if IsInRaid() and GetNumGroupMembers() > 0 then
			SendAddonMessage("self", self.version, IsLFGModeActive(LE_LFG_CATEGORY_LFR) and "INSTANCE_CHAT" or "RAID")
		elseif not IsInRaid() and GetNumSubgroupMembers() > 0 then
			SendAddonMessage("self", self.version, IsLFGModeActive(LE_LFG_CATEGORY_LFD) and "INSTANCE_CHAT" or "PARTY")
		elseif IsInGuild() then
			SendAddonMessage("self", self.version, "GUILD")
		end
	end
	
	if self.NotifyTimer then
		self:CancelTimer(self.NotifyTimer)
		self.NotifyTimer = nil
	end
end

function ElvUI_ChatTweaks:CHAT_MSG_ADDON(event, prefix, message, channel, sender)
	if not self.db.profile.notify then return end
	if sender == UnitName("player") then return end
	
	if prefix == "self" and not self.receivedOutOfDateMessage then
		if tonumber(message) ~= nil and tonumber(message) > tonumber(self.version) then
			if self.db.profile.debugging then self:Print((L["Your Version: |cffffff00%d|r, Latest Version: |cffffff00%d|r"]):format(tonumber(self.version), tonumber(message))) end
			self:Print((L["Your version of %s is out of date.  Latest version is |cff1784d1%d|r."]):format(self.addon, message))
			self.receivedOutOfDateMessage = true	-- to prevent receiving this message more than once
		end
	end
end
ElvUI_ChatTweaks:RegisterEvent("CHAT_MSG_ADDON")

local function ValueColorUpdate(hex, r, g, b)
	ElvUI_ChatTweaks.hexColor = hex
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

--[[ Ace3 Options ]]--
ElvUI_ChatTweaks.options.args = {
	header = {
		type = "header",
		order = 1,
		name = L["Version"] .. (": |cff99ff33%s|r"):format(ElvUI_ChatTweaks.version),
		width = "full",
	},
	description = {
		type = "description",
		order = 2,
		name = L["This addon is designed to add a lot of the functionality of full fledged chat addons like Prat or Chatter, but without a lot of the unneeded bloat.  I wrote it to be as lightweight as possible, while still powerful enough to accomplish it's intended function.\n"],
		width = "full",
	},
	welcome = {
		type = "toggle",
		order = 3,
		name = L["Welcome Message"],
		desc = L["Show welcome message when logging in."],
		get = function() return ElvUI_ChatTweaks.db.profile.welcome end,
		set = function(_, value) ElvUI_ChatTweaks.db.profile.welcome = value end,
	},
	shorten = {
		type = "toggle",
		order = 4,
		name = L["Use Short Name"],
		desc = (L["Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."]):format(ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.hexColor),
		get = function() return ElvUI_ChatTweaks.db.profile.shorten end,
		set = function(_, value)
			ElvUI_ChatTweaks.db.profile.shorten = value
			ElvUI_ChatTweaks.abbrev = value and L["ElvUI_CT"] or L["ElvUI_ChatTweaks"]
		end,
	},
	notify = {
		type = "toggle",
		order = 5,
		name = L["New Version Notify"],
		desc = L["Notify on new release?"],
		get = function() return ElvUI_ChatTweaks.db.profile.notify end,
		set = function(_, value) ElvUI_ChatTweaks.db.profile.notify = value end,
	},
	debugging = {
		type = "toggle",
		order = 6,
		name = L["Enable Debugging"],
		desc = L["Enable various debugging messages to help with errors or undesired functioning."],
		get = function() return ElvUI_ChatTweaks.db.profile.debugging end,
		set = function(_, value) ElvUI_ChatTweaks.db.profile.debugging = value; StaticPopup_Show("ECT_RLUI"); end,
	},
	toggleEC = {
		type = "execute",
		order = 7,
		name = L["Open ElvUI's Config"],
		desc = L["Click to toggle ElvUI's config window.  This will also close this window."],
		func = function() ElvUI_ChatTweaks:ToggleConfig(); E:ToggleConfig(); end,
	},
}

ElvUI_ChatTweaks.defaults = {
	profile = {
		welcome = true,
		notify = true,
		debugging = false,
		shorten = true,
		modules  = {
			-- modules disabled by default
			["Achievement Filter"] = false,
			["Addon Messages"] = false,
			["Alt Names"] = false,
			["Auction Message Filtering"] = false,
			["Automatic Chat Logging"] = false,
			["Auto Congratulate"] = false,
			["Auto Ding"] = false,
			["Auto Farewell"] = false,
			["Auto Welcome"] = false,
			["Channel Names"] = false,
			["Channel Sounds"] = false,
			["Chat Tabs"] = false,
			["Data Broker"] = false,
			["Developer Tools"] = false,
			["Emote Filter"] = false,
			["Fun Filters"] = false,
			["Lost Control Disable"] = false,
			["Magic 8-Ball"] = false,
			["Materials Farming"] = false,
			["Pet Battles"] = false,
			["Popup Messages"] = false,
			["Reroute Auction Messages"] = false,
			["Spam Log"] = false,
			["Strip Links"] = false,
			["Substitutions"] = false,
			["Text Justification"] = false,
		}
	}
}