--[[
## Title: GridStatusAbsorbshields
## Notes: Grid status showing the remaining value left on absorption buffs and debuffs.
## Author: Eldrikt
## Special thanks to Johnny C. Lam and his addon GridStatusAbsrobs
]]--

local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusAbsorbshields")
local GridRoster = Grid:GetModule("GridRoster")
local GridStatusAbsorbshields = Grid:NewStatusModule("GridStatusAbsorbshields")

GridStatusAbsorbshields.menuName = L["Absorb Shields"]

local absorbShieldStatus = "AbsorbShieldStatus"



GridStatusAbsorbshields.defaultDB = {
	[absorbShieldStatus] = {
		text = L["Absorb Shields"],
		enable = true,
		color = { r = 1.0, g = 1.0, b = 0.0, a = 0.8 },
		priority = 90,
		range = false,
	},
}

local absorbDamageOptions = {} 

function GridStatusAbsorbshields:PostInitialize()
	self:RegisterStatus(absorbShieldStatus, L["Absorb Shields"], absorbDamageOptions,true)
	
	-- create a hidden tooltip
	CreateFrame( "GameTooltip", "GSAS_Scantip", nil, "GameTooltipTemplate" ); 
	GSAS_Scantip:SetOwner(UIParent, "ANCHOR_NONE")
	GSAS_Scantip:AddFontStrings(
					GSAS_Scantip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
					GSAS_Scantip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );
	
end

function GridStatusAbsorbshields:PostReset()
	self:UpdateAllUnitAbsorbs()
end

function GridStatusAbsorbshields:EnabledStatusCount()
	local enable_count = 0
	for status, settings in pairs(self.db.profile) do
		if type(settings) == "table" and settings.enable then
			enable_count = enable_count + 1
		end
	end
	return enable_count
end

function GridStatusAbsorbshields:OnStatusEnable(status)
	self:RegisterMessage("Grid_UnitJoined", "ScanUnitAuras")
	self:RegisterEvent("UNIT_AURA", "ScanUnitAuras")
	--self:RegisterEvent("UNIT_DAMAGE", "UnitDamage")
	--self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CLEU")
	self:UpdateAllUnitAbsorbs()
end

function GridStatusAbsorbshields:OnStatusDisable(status)
	self.core:SendStatusLostAllUnits(status)
	if self:EnabledStatusCount() == 0 then
		self:UnregisterMessage("Grid_UnitJoined")
		self:UnregisterEvent("UNIT_AURA")
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

function GridStatusAbsorbshields:UpdateAllUnitAbsorbs()
	for guid, unitid in GridRoster:IterateRoster() do
		self.ClearUnit(guid)
		self:ScanUnitAuras("UpdateAllUnitAbsorbs", unitid)
	end
end

local maxHealth = 0
-- holds absorb information for each unit
local activeAbsorbs = {}

-- remove absorb information about a unit in the table
function GridStatusAbsorbshields.ClearUnit(guid)
	if not guid then return end
	activeAbsorbs[guid] = nil
end

local function HumanizeNumber(number)
	if number < 1000 then
		return string.format("%.0f", number)
	elseif number < 100000 then
		return string.format("%.1fk", number/1000)
	elseif number < 1000000 then
		return string.format("%.0fk", number/1000)
	elseif number < 100000000 then
		return string.format("%.1fm", number/1000000)
	else
		return string.format("%.0fm", number/1000000)
	end
end

--Update status on grid
function GridStatusAbsorbshields:UpdateAbsorbDamageStatus(guid, unit, absorbs)
	local settings = self.db.profile[absorbShieldStatus]
	if settings.enable then
		if absorbs and absorbs > 0 then
			local text = HumanizeNumber(absorbs)
			self.core:SendStatusGained(guid, absorbShieldStatus, settings.priority, nil, settings.color, text)
			return
		end
	end
	self.core:SendStatusLost(guid, absorbShieldStatus)
end

function GridStatusAbsorbshields:CLEU(event,...)
	local timestamp, type, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		if type == "SPELL_DAMAGE" or type == "SWING_DAMAGE" then
			--DEFAULT_CHAT_FRAME:AddMessage(type.." "..sourceName.." "..destName.." "..sourceGUID.." "..destGUID.." ")
		end
	end
end

function GridStatusAbsorbshields:UnitDamage(...)
	local arg1, arg2, arg3 = select(1,...)
	if (arg1) then DEFAULT_CHAT_FRAME:AddMessage("1"..arg1) end
	if (arg2) then DEFAULT_CHAT_FRAME:AddMessage(arg2) end
	if (arg3) then DEFAULT_CHAT_FRAME:AddMessage(arg3) end
	self:ScanUnitAuras(arg1, arg2)
end

-- the main event handler
function GridStatusAbsorbshields:ScanUnitAuras(event, unit)
	local guid = UnitGUID(unit)
	if not GridRoster:IsGUIDInRaid(guid) then
		self.ClearUnit(guid)
		return
	end

	--DEFAULT_CHAT_FRAME:AddMessage(event.." "..unit.." "..guid)
	self:Debug("ScanUnitAuras", event, unit, guid)
	
	-- Only perform the expensive scan of buffs if the damage absorption status is enabled.
	if self.db.profile[absorbShieldStatus].enable then
		
		local absorbs = ScanUnitAbsorbs(unit)

		-- Update damage absorption status.
		if activeAbsorbs[guid] ~= absorbs then 
			activeAbsorbs[guid] = absorbs 
			--DEFAULT_CHAT_FRAME:AddMessage("absorbs="..absorbs..",guid="..guid..",unit="..unit)
			self:UpdateAbsorbDamageStatus(guid, unit, absorbs)	
		end
	end
end

-- Scans all auras on the given unit
-- if the second line in the aura tooltip contains the word "Absorb" followed by a number
-- add that number to the total absorb value
-- returns the sum of all absorbs given by auras on a unit
function ScanUnitAbsorbs(unit)
	local absorbs = 0

	local i = 1
	local name = UnitBuff(unit, i)
	--for each aura on the unit
	while name do
		--fetch the tooltip of the spell
		GSAS_Scantip:ClearLines()
		GSAS_Scantip:SetUnitBuff(unit,name)
		local textline = GSAS_ScantipTextLeft2:GetText();
		if textline then
			--check the second line
			local absrb = strmatch(textline, "Absorb%a+ %d+")
			if absrb then
				--the line contains the string Absorb, get the number
				local absrbval = strmatch(absrb,"%d+")
				absorbs = absorbs + absrbval --and add it to the grand total
			end
		end
		--increment the counters for the loop
		i = i + 1
		name = UnitAura(unit, i, filter)
	end
	return absorbs
end --ScanUnitAbsorbs
	
