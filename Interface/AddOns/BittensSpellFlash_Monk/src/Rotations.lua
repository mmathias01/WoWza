local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local SPELL_POWER_CHI = SPELL_POWER_CHI
local select = select
local string = string
local wipe = wipe

local lastPowerStrike = 0

a.Rotations = { }

function a.PreFlash()
	local info = c.GetQueuedInfo()
	if info then
		info.Cost = a.GetEnergyCost(info.Name) or info.Cost
	end
	a.Regen = select(2, GetPowerRegen())
	a.Power = c.GetPower(a.Regen)
	
	if info then
		info.Cost = a.GetChiCost(info.Name)
	end
	a.Chi = c.GetPower(0, SPELL_POWER_CHI)
	a.MissingChi = s.MaxPower("player", SPELL_POWER_CHI) - a.Chi
	
--c.Debug("Power Calcs", a.Chi, a.Power, a.Regen,
--c.HasBuff("Combo Breaker: Blackout Kick"), c.HasBuff("Combo Breaker: Tiger Palm"))
end

-------------------------------------------------------------------------- Noob
a.Rotations.Noob = {
	FlashInCombat = function()
		if s.Flashable(c.GetID("Blackout Kick")) then
			c.PriorityFlash(
				"Tiger Palm for Tiger Power", "Blackout Kick", "Jab")
		else
			c.PriorityFlash("Tiger Palm", "Jab")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Roll")
	end,
}

-------------------------------------------------------------------- Brewmaster
local uncontrolledMitigationBuffs = {
	"Diffuse Magic",
	"Zen Meditation",
	"Ring of Peace",
	"Staggering", -- 2pT15
}
a.Rotations.Brewmaster = {
	Spec = 1,
	
	UsefulStats = { 
		"Agility", "Dodge", "Parry", "Tanking Hit", "Stamina", "Crit", "Haste" 
	},
	
	FlashInCombat = function()
		a.Trained = s.HasSpell(c.GetID("Brewmaster Training"))
		a.Shuffle = c.GetBuffDuration("Shuffle")
		if c.IsQueued("Blackout Kick") then
			a.Shuffle = a.Shuffle + 6
		end
		c.FlashAll(
			"Purifying Brew",
			"Summon Black Ox Statue", 
			"Spear Hand Strike", 
			"Provoke")
		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationBuffs,
			"Elusive Brew at 10",
			"Guard",
			"Dampen Harm",
			"Fortifying Brew",
			"Elusive Brew")
		if c.AoE then
			c.PriorityFlash(
				"Rushing Jade Wind for Brewmaster",
				"Blackout Kick for Shuffle",
				"Expel Harm for Brewmaster",
				"Blackout Kick for AoE",
				"Keg Smash",
				"Spinning Crane Kick")
		elseif c.IsSolo() then
			c.PriorityFlash(
				"Touch of Death",
				"Chi Wave",
				"Keg Smash",
				"Chi Burst",
				"Tiger Palm for Tiger Power",
				"Blackout Kick",
				"Expel Harm for Brewmaster",
				"Jab for Brewmaster",
				"Zen Sphere",
				"Tiger Palm for Brewmaster")
		else
			c.PriorityFlash(
				"Touch of Death",
				"Blackout Kick for Shuffle",
				"Keg Smash for Dizzying Haze",
				"Expel Harm for Brewmaster",
				"Chi Wave for Brewmaster",
				"Zen Sphere",
				"Chi Burst for Brewmaster",
				"Blackout Kick for Extended Shuffle",
				"Keg Smash for Chi",
				"Jab for Brewmaster",
				"Tiger Palm for Brewmaster")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Stance of the Sturdy Ox", "Legacy of the Emperor", "Roll")
	end,
	
	ExtraDebugInfo = function()
		return string.format("c:%d e:%.1f s:%.1f b:%.1f", 
			a.Chi, a.Power, a.Shuffle, c.GetBusyTime())
	end,
}

-------------------------------------------------------------------- Mistweaver
a.Rotations.Mistweaver = {
	Spec = 2,
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		if c.IsCasting("Soothing Mist") or c.IsQueued("Soothing Mist") then
			a.SoothDamage = s.HealthDamagePercent(a.SoothTarget)
		else
			a.SoothDamage = 0
		end
		
		c.FlashAll(
			"Spear Hand Strike", 
			"Mana Tea", 
			"Enveloping Mist",
			"Surging Mist", 
			"Uplift",
			"Summon Jade Serpent Statue")
		if s.HasSpell(c.GetID("Muscle Memory"))
			and (s.PowerPercent("player") > c.GetOption("MeleeCutoff")
				or c.HasBuff("Muscle Memory")) then
			
			c.PriorityFlash(
				"Touch of Death for Mistweaver",
				"Blackout Kick for Serpent's Zeal",
				"Expel Harm for Mistweaver",
				"Tiger Palm for Mistweaver",
				"Jab for Mistweaver",
				"Crackling Jade Lightning")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Stance of the Wise Serpent", "Legacy of the Emperor", "Roll")
	end,
	
	CastQueued = function(info)
		if c.InfoMatches(info, "Soothing Mist") then
			a.SoothTarget = info.Target
			c.Debug("Event", "Soothing Mist cast at", a.SoothTarget)
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("%d, %s, %.1f", 
			a.Chi, a.SoothTarget or "none", a.SoothDamage or 0)
	end,
}

-------------------------------------------------------------------- Windwalker
a.SefTargets = { }

a.Rotations.Windwalker = {
	Spec = 3,
	
	UsefulStats = { "Agility", "Melee Hit", "Strength", "Crit", "Haste" },
	
	FlashInCombat = function()
		if not c.HasBuff("Storm, Earth, and Fire") then
			wipe(a.SefTargets)
		end
		
		c.FlashAll(
			"Storm, Earth, and Fire",
			"Tigereye Brew", 
			"Chi Brew",
			"Energizing Brew", 
			"Spear Hand Strike")
		if c.AoE then
			c.PriorityFlash(
				"Rising Sun Kick for Debuff",
				"Tiger Palm for Tiger Power",
				"Invoke Xuen, the White Tiger",
				"Rushing Jade Wind",
				"Spinning Crane Kick",
				"Flying Serpent Kick 1",
				"Chi Wave",
				"Zen Sphere",
				"Chi Burst")
		else
			c.PriorityFlash(
				"Touch of Death",
				"Rising Sun Kick for Debuff",
				"Tiger Palm for Tiger Power",
				"Invoke Xuen, the White Tiger",
				"Rising Sun Kick",
				"Fists of Fury",
				"Blackout Kick under Combo Breaker",
				"Chi Wave for Windwalker",
				"Tiger Palm under Combo Breaker",
				"Expel Harm for Windwalker",
				"Jab for Windwalker",
				"Blackout Kick without blocking RSK",
				"Chi Wave",
				"Chi Burst",
				"Flying Serpent Kick 1",
				"Zen Sphere")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Stance of the Fierce Tiger", 
			"Legacy of the Emperor", 
			"Legacy of the White Tiger", 
			"Roll")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Storm, Earth, and Fire") then
			a.SefTargets[info.TargetID] = true
			c.Debug("Event", 
				"Storm, Earth, and Fire on", info.Target, info.TargetID)
		end
	end,
	
	CastFailed = function(info)
		if c.InfoMatches(info, "Storm, Earth, and Fire") then
			a.SefTargets[info.TargetID] = true
			c.Debug("Event", 
				"Storm, Earth, and Fire removed from", 
				info.Target, 
				info.TargetID)
		end
	end,
	
	AuraApplied = function(spellID)
		if c.IdMatches(spellID, "Tigereye Brew") then
			local syncBuff = c.GetOption("TigerSyncBuff")
			if string.len(syncBuff) == 0 then
				a.BrewIsBuffed = false
			else
				a.BrewIsBuffed = s.Buff(syncBuff, "player")
				c.Debug("Event", 
					"Tigereye Brew is buffed with", syncBuff, ":", 
					a.BrewIsBuffed)
			end
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("%d, %.1f", a.Chi, a.Power)
	end,
}
