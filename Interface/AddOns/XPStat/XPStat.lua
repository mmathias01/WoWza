XPStat = LibStub("AceAddon-3.0"):NewAddon("XPStat", "AceConsole-3.0", "AceTimer-3.0", "AceEvent-3.0")

local defaults = {
	profile = {
		display = 'xprate'
	}
}

local options = {
	name = 'XPStat',
	handler = XPStat,
	type = 'group',
	args = {
		display = {
			type = 'select',
			name = 'display',
			desc = 'Which value should be displayed',
			get = function(var) return XPStat.db[var[#var]] end,
			set = function(var, val) XPStat.db[var[#var]] = val end,
			style = 'dropdown',
			values = {
				xprate = 'XP per hour',
				timetolevel = 'Time to next level',
			}
		},
	},
}

function XPStat:OnInitialize()
	-- This AddOn is useless on max-level characters, so we disable it
	if UnitLevel('player') == 90 then
		self:Print("You are max level! XPStats will now disable itself...")
		self:SetEnabledState(false)
		return
	end

	self:Print("XPStat ".. GetAddOnMetadata("XPStat", "Version") .."\nAuthor: ".. GetAddOnMetadata("XPStat", "Author"))

	-- Set up SavedVariables, Config and Profiles
	self.db_root = LibStub("AceDB-3.0"):New("XPStatDB")
	self.db = self.db_root.profile

	local cfgreg = LibStub("AceConfigRegistry-3.0")
	cfgreg:RegisterOptionsTable("XPStat", options)
	cfgreg:RegisterOptionsTable("XPStat Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db_root))

	local cfgdiag = LibStub("AceConfigDialog-3.0")
	cfgdiag:AddToBlizOptions("XPStat", "XPStat")
	cfgdiag:AddToBlizOptions("XPStat Profiles", "Profiles", "XPStat")

	self.conf = LibStub("AceConfig-3.0"):RegisterOptionsTable("XPStat", options, {"xpstat", "xps"})

	-- Create LDB object
	self:CreateLDB()
end

function XPStat:OnEnable()
	-- Initialise member variables
	self.tooltip = GameTooltip
	self.showTooltip = false
	self:Reset()

	-- Register for events
	self:RegisterEvent("PLAYER_XP_UPDATE") -- Whenever the player's XP changes

	-- Call the Update method every second
	self:ScheduleRepeatingTimer('Update', 1)
end

function XPStat:OnDisable()
	self:UnregisterEvent("PLAYER_XP_UPDATE")
end

function XPStat:Reset()
	self.time = 0
	self.gainedXP = 0
	self.lastXP =  UnitXP('player')
	self.lastXPMax = UnitXPMax('player')
	self.sessionStart = time()
end

function XPStat:Update()
	self.time = self.time + 1
	self.ldb.text = format("%d XP/hr", self:xp_per_hour())

	if self.showTooltip then self:UpdateTooltip() end
end

function XPStat:UpdateTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine("XPStat ".. GetAddOnMetadata("XPStat", "Version") .." |cff999999by ".. GetAddOnMetadata("XPStat", "Author") .."|r")
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("Current XP stats:")

	GameTooltip:AddDoubleLine("Total XP gained:",			string.format("%d", XPStat.gainedXP), 1,1,1, 1,1,1)
	GameTooltip:AddDoubleLine("XP gained per hour:",		string.format("%d XP/hr", XPStat:xp_per_hour()), 1,1,1, 1,1,1)
	GameTooltip:AddDoubleLine("Time to level up:",			string.format("%s", FormatDuration(XPStat:time_to_level())), 1,1,1, 1,1,1)
	GameTooltip:AddDoubleLine("Session start time:", 		string.format("%s", date('%c', XPStat.sessionStart)), 1,1,1, 1,1,1)
	GameTooltip:AddDoubleLine("Session length:", 			string.format("%s", FormatDuration(XPStat.time)), 1,1,1, 1,1,1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("|Cff00ff00Left-click|r to reset session.")
	GameTooltip:Show()
end

function XPStat:CreateLDB()
	-- Grab the LDB library but don't get upset if it's not available
	local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1", true)

	if DataBroker then
		XPStat.ldb = DataBroker:NewDataObject("XPStat", {
			type = "data source",
			icon = "Interface\\AddOns\\XPStat\\star",
			text = "Loading...",
			OnClick = function(btn)
				XPStat:Reset()
			end,
			OnEnter = function(self)
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
				XPStat:UpdateTooltip()
				XPStat.showTooltip = true
			end,
			OnLeave = function(self)
				XPStat.showTooltip = false
				GameTooltip:Hide()
			end
		})
	end
end



-------------------------------------------------------------------------------
-- Event Handlers
-------------------------------------------------------------------------------
function XPStat:PLAYER_XP_UPDATE(event, ...)
	currentXP = UnitXP('player')

	-- This should only be true after a level up; in this case we need
	-- to calculate how much experience was gained differently
	if currentXP < self.lastXP then
		gained = self.lastXPMax - self.lastXP + currentXP

		self.lastXPMax = UnitXPMax('player')
	else
		gained = currentXP - self.lastXP
	end

	self.lastXP = currentXP
	self.gainedXP = self.gainedXP + gained
end

-------------------------------------------------------------------------------
-- XP Value Calculation Methods
-------------------------------------------------------------------------------
function XPStat:xp_per_hour()
	return self.gainedXP / (self.time / 3600)
end

function XPStat:time_to_level()
	if (self:xp_per_hour() <= 0) then return 0 end
	return (UnitXPMax('player') - UnitXP('player')) / self:xp_per_hour() * 3600
end

-------------------------------------------------------------------------------
-- Miscellaneous helper functions
-------------------------------------------------------------------------------
function FormatDuration(t)
	if t <= 0 then return 'n/a' end

	local str = {}

	local days = floor(t / 86400)
	local hours = mod(floor(t / 3600), 24)
	local minutes = mod(floor(t / 60), 60)
	local seconds = mod(floor(t), 60)

	-- days
	if days > 0 then table.insert(str, format("%d d", days)) end
	if hours > 0 then table.insert(str, format("%d h", hours)) end
	if minutes > 0 then table.insert(str, format("%d m", minutes)) end
	if seconds > 0 then table.insert(str, format("%d s", seconds)) end

	return table.concat(str, ", ")
end
