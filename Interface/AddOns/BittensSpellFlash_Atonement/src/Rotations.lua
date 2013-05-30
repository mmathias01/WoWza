local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetSpellLink = GetSpellLink
local GetTime = GetTime
local GetUnitName = GetUnitName
local SendChatMessage = SendChatMessage
local UnitExists = UnitExists
local UnitInRange = UnitInRange
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsUnit = UnitIsUnit
local select = select
local string = string
local tostring = tostring

a.Rotations = {}

local lastRapture = 0
local shieldBurst = 0

local function healingNeeded()
	for unit in c.GetGroupMembers() do
		if s.HealthPercent(unit) < c.GetOption("HealPercent")
			and (UnitInRange(unit) or UnitIsUnit(unit, "player"))
			and not UnitIsDeadOrGhost(unit) then
			
			return true
		end
	end
	return false
end

a.Rotations.Atonement = {
	Spec = 1,
	
	FlashInCombat = function()
		local now = GetTime()
		if s.MyBuff(c.GetID("Power Word: Shield"), a.ShieldTarget) then
			shieldBurst = now
		end
		a.HealingNeeded = healingNeeded()
		a.Mana = 
			100 * c.GetPower(select(2, GetPowerRegen())) / s.MaxPower("player")
		
		local conserve = a.Mana < c.GetOption("ConservePercent")
		if conserve then
			if (now - lastRapture > 12 and now - shieldBurst > 2) then
				c.FlashAll("Power Word: Shield")
			end
		end
		c.FlashAll("Shadowfiend", "Mindbender")
		
		if not a.HealingNeeded 
			and a.Mana < c.GetOption("OnlyHealPercent") then
			
			c.PriorityFlash("Power Word: Solace")
			return
		end
		
		c.FlashAll("Power Infusion")
		if conserve then
			c.PriorityFlash(
				"Power Word: Solace",
				"Penance",
				"Holy Fire",
				"Shadow Word: Death",
				"Smite Glyphed",
				"Shadow Word: Pain",
				"Smite")
		else
			c.PriorityFlash(
				"Shadow Word: Death",
				"Penance",
				"Shadow Word: Pain",
				"Power Word: Solace",
				"Holy Fire",
				"Smite")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Power Word: Fortitude", "Inner Fire")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Power Word: Shield") then
			a.ShieldTarget = info.Target
			c.Debug("Event", "PW:S on", a.ShieldTarget)
		end
	end,
	
	Energized = function(spellID)
		if spellID == c.GetID("Rapture") then
			lastRapture = GetTime()
			shieldBurst = 0
			c.Debug("Event", "Rapture!")
		end
	end,
	
	LeftCombat = function()
		c.Debug("Event", "Clearing announcement history")
	end,
	
	ExtraDebugInfo = function()
		return string.format("%.1f %s", a.Mana, tostring(a.HealingNeeded))
	end,
}
