--[[
TODO:

]]--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Norushen", 953, 866)
if not mod then return end
mod:RegisterEnableMob(72276, 71977, 71976, 71967) -- Amalgam of Corruption, Manifestation of Corruption, Essence of Corruption, Norushen

--------------------------------------------------------------------------------
-- Locals
--

local bigAddSpawnCounter, bigAddKillCounter = 0, 0
local throttlePlayers = {} -- Throttle users that have BW & DBM installed >.>
local bigAddKills = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.pre_pull = "Pre pull"
	L.pre_pull_desc = "Timer bar for the RP before the boss engage"
	L.pre_pull_trigger = "Very well, I will create a field to keep your corruption quarantined."

	L.big_adds = "Big adds"
	L.big_adds_desc = "Warning for killing big adds inside/outside"
	L.big_add_icon = 147082
	L.big_add = "Big add (%d)"
	L.big_add_killed = "Big add killed! (%d)"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{-8218, "TANK_HEALER"}, {146124, "TANK"}, 145226, 145132,-- Amalgam of Corruption
		"big_adds",
		-8220, 144482, 144514, 144649, 144628,
		"stages", "pre_pull", "altpower", "berserk", "bosskill",
	}, {
		[-8218] = -8216, -- Amalgam of Corruption
		["big_adds"] = L.big_adds, -- Big add
		[-8220] = -8220, -- Look Within
		["stages"] = "general",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Yell("PrePull", L.pre_pull_trigger)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEDED", "PrePull", "target")
	-- Look Within
	self:Log("SPELL_CAST_START", "TitanicSmash", 144628)
	self:Log("SPELL_CAST_START", "HurlCorruption", 144649)
	self:Log("SPELL_CAST_SUCCESS", "LingeringCorruption", 144514)
	self:Log("SPELL_CAST_START", "TearReality", 144482)
	self:Log("SPELL_AURA_REMOVED", "LookWithinRemoved", 144849, 144850, 144851) -- Test of Serenity (DPS), Test of Reliance (HEALER), Test of Confidence (TANK)
	self:Log("SPELL_AURA_APPLIED", "LookWithinApplied", 144849, 144850, 144851) -- Test of Serenity (DPS), Test of Reliance (HEALER), Test of Confidence (TANK)
	-- Amalgam of Corruption
	self:Log("SPELL_AURA_APPLIED_DOSE", "Fusion", 145132)
	self:Log("SPELL_AURA_APPLIED", "Fusion", 145132)
	self:Log("SPELL_AURA_APPLIED", "BlindHatred", 145226)
	self:Log("SPELL_CAST_START", "UnleashedAnger", 145216)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SelfDoubt", 146124)
	self:Log("SPELL_AURA_APPLIED", "SelfDoubt", 146124)
	self:Log("SPELL_CAST_SUCCESS", "UnleashCorruption", 145769) -- Spawns big adds in phase 2
	self:Log("SPELL_AURA_APPLIED", "Phase2", 146179) -- Phase 2, "Frayed"
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")

	self:AddSyncListener("BlindHatred")
	self:AddSyncListener("InsideBigAddDeath", 0)
	self:AddSyncListener("OutsideBigAddDeath", 0)
	self:AddSyncListener("Phase2BigAddSpawn")
	self:AddSyncListener("Phase2")

	self:RegisterMessage("DBM_AddonMessage", "OnDBMSync") -- Catch DBM users killing big adds

	self:Death("Deaths", 71977, 72264) -- Manifestation of Corruption, Unleashed Manifestation of Corruption
	self:Death("Win", 72276) -- Amalgam of Corruption
end

function mod:OnEngage()
	bigAddSpawnCounter, bigAddKillCounter = 0, 0
	self:Berserk(self:LFR() and 600 or 418)
	self:Bar(145226, 25) -- Blind Hatred
	wipe(bigAddKills)
	wipe(throttlePlayers)
	self:OpenAltPower("altpower", 147800) -- Corruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PrePull(unitId, spellName, _, _, spellId)
	if spellId and type(spellId) == "number" and spellId == 145188 then -- Norushen needs to be targeted
		self:Bar("pre_pull", 25, L["pre_pull"], "ABILITY_TITANKEEPER_QUARANTINE.BLP")
		self:UnregisterUnitEvent("UNIT_SPELLCAST_SUCCEDED", "target")
	else -- this is always there, but needs localization
		self:Bar("pre_pull", 26, L["pre_pull"], "ABILITY_TITANKEEPER_QUARANTINE.BLP")
	end
end

-- Look Within
-- TANK
function mod:TitanicSmash(args)
	self:Message(args.spellId, "Attention", "Info")
	self:CDBar(args.spellId, 15)
end

function mod:HurlCorruption(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:Bar(args.spellId, 20)
end

-- HEALER
function mod:LingeringCorruption(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:Bar(args.spellId, 15)
end

-- DPS
function mod:TearReality(args)
	self:Message(args.spellId, "Attention", "Info")
	self:CDBar(args.spellId, 8) -- any point for this?
end

do
	local scheduled, lookWithinList = nil, mod:NewTargetList()
	local function warnLookWithinRemoved()
		mod:TargetMessage(-8220, lookWithinList, "Neutral", nil, CL["over"]:format(EJ_GetSectionInfo(8220)))
		scheduled = nil
	end
	function mod:LookWithinRemoved(args)
		lookWithinList[#lookWithinList+1] = args.destName
		if not scheduled then
			scheduled = self:ScheduleTimer(warnLookWithinRemoved, 1) -- we care about people coming out, not so much going in
		end
		self:StopBar(-8220, args.destName) -- other tank bar

		if self:Me(args.destGUID) then
			self:StopBar(-8220) -- personal bar
			-- tank
			self:StopBar(144628) -- Titanic Smash
			self:StopBar(144649) -- Hurl Corruption
			-- healer
			self:StopBar(144514) -- Lingering Corruption
			-- dps
			self:StopBar(144482) -- Tear Reality
		end
	end
end

function mod:LookWithinApplied(args)
	if self:Me(args.destGUID) then
		self:Bar(-8220, 60, nil, args.spellId)
	elseif args.spellId == 144851 and self:Tank() then -- Test of Confidence (TANK) mainly for the other tank
		self:TargetBar(-8220, 60, args.destName, nil, args.spellId)
	end
end

function mod:Phase2()
	self:Sync("Phase2")
end

function mod:UnleashCorruption()
	self:Sync("Phase2BigAddSpawn") -- Big adds spawning outside in p2
end

function mod:OnSync(sync, rest, player)
	if sync == "BlindHatred" then
		self:Message(145226, "Important", "Long")
		self:Bar(145226, 60)
	elseif sync == "Phase2" then
		self:Message("stages", "Neutral", "Warning", CL["phase"]:format(2), 146179)
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss1")
	elseif sync == "InsideBigAddDeath" then
		local t = GetTime()
		if throttlePlayers[player] and (t - throttlePlayers[player]) < 5 then
			return
		end
		throttlePlayers[player] = t

		bigAddSpawnCounter = bigAddSpawnCounter + 1
		self:Message("big_adds", "Urgent", "Alarm", CL["incoming"]:format(L["big_add"]:format(bigAddSpawnCounter)), 147082)
	elseif sync == "Phase2BigAddSpawn" then
		bigAddSpawnCounter = bigAddSpawnCounter + 1
		self:Message("big_adds", "Urgent", "Alarm", L["big_add"]:format(bigAddSpawnCounter), 147082)
	elseif sync == "OutsideBigAddDeath" and rest and rest ~= "" then -- XXX backwards compat
		if bigAddKills[rest] then return else bigAddKills[rest] = true end -- Custom throttle to catch 2 big adds dieing outside at the same time
		bigAddKillCounter = bigAddKillCounter + 1
		if bigAddKillCounter > bigAddSpawnCounter then
			bigAddSpawnCounter = bigAddKillCounter -- Compensate for no boss mod players :[
		end
		self:Message("big_adds", "Attention", "Alert", L["big_add_killed"]:format(bigAddKillCounter), 147082) -- this could probably live wouthout sound but this way people know for sure that they need to check if it is their turn to soak
	end
end

function mod:OnDBMSync(_, player, prefix, _, _, event)
	if prefix == "M" and event == "ManifestationDied" then
		self:OnSync("InsideBigAddDeath", nil, player)
	end
end

function mod:Deaths(args)
	if args.mobId == 71977 then -- Big add inside (Manifestation of Corruption)
		self:Sync("InsideBigAddDeath")
	elseif args.mobId == 72264 then -- Big add outside (Unleashed Manifestation of Corruption)
		self:Sync("OutsideBigAddDeath", args.destGUID)
	end
end

-- Amalgam of Corruption
function mod:Fusion(args)
	local amount = args.amount or 1
	self:Message(args.spellId, "Attention", nil, CL["count"]:format(args.spellName, amount))
end

function mod:UNIT_HEALTH_FREQUENT(unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
	if hp < 56 then -- 50%
		self:Message("stages", "Neutral", "Info", CL["soon"]:format(CL["phase"]:format(2)), 146179)
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss1")
	end
end

function mod:BlindHatred()
	self:Sync("BlindHatred")
end

function mod:UnleashedAnger(args)
	self:Message(-8218, "Attention")
	self:CDBar(-8218, 10)
end

function mod:SelfDoubt(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "Attention", "Info")
	self:CDBar(args.spellId, 16)
end

