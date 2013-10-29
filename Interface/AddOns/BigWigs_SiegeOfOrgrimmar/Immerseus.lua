
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Immerseus", 953, 852)
if not mod then return end
mod:RegisterEnableMob(71543)

--------------------------------------------------------------------------------
-- Locals
--

local blastCounter = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.win_yell = "Ah, you have done it!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		143574, {143579, "FLASH"},
		{143295, "FLASH"}, 143309, 143020, 143469, 143436,
		"berserk", "bosskill",
	}, {
		[143574] = "heroic",
		[143295] = "general",
	}
end

function mod:VerifyEnable(unit)
	if UnitCanAttack("player", unit) then
		return true
	end
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	-- heroic
	self:Log("SPELL_AURA_APPLIED", "SwellingCorruption", 143574)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SwellingCorruption", 143574)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ShaCorruption", 143579)
	-- normal
	self:Log("SPELL_CAST_START", "CorrosiveBlast", 143436) -- not tank only so people know when to not walk in front of the boss
	self:Log("SPELL_AURA_APPLIED", "CorrosiveBlastStack", 143436)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CorrosiveBlastStack", 143436)

	self:Emote("Splits", "143020")
	self:Emote("Reform", "143469")
	self:Log("SPELL_CAST_START", "Swirl", 143309)
	self:Log("SPELL_DAMAGE", "ShaBolt", 143295)
	self:Log("SPELL_PERIODIC_DAMAGE", "ShaPoolDamage", 143297)

	self:Yell("Win", L["win_yell"])
end

function mod:OnEngage()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "KillCheck")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "KillCheckMouseOver")

	blastCounter = 1

	self:Berserk(600)
	self:Bar(143309, 20.8) -- Swirl
	self:Bar(143436, 10) -- Corrosive Blast
	if self:Heroic() then
		self:CDBar(143574, 10) -- Swelling Corruption
	end
end

function mod:KillCheck()
	local hasBoss = UnitHealth("boss1") > 100 or UnitHealth("boss2") > 100 or UnitHealth("boss3") > 100 or UnitHealth("boss4") > 100 or UnitHealth("boss5") > 100
	if not hasBoss then
		self:ScheduleTimer("StartWipeCheck", 11)
	end
end

function mod:KillCheckMouseOver()
	if self:MobId(UnitGUID("mouseover")) == 71543 and not self:VerifyEnable("mouseover") then
		self:Win()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- heroic
function mod:SwellingCorruption(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, 77)
end

function mod:ShaCorruption(args)
	if self:Me(args.destGUID) and args.amount > 2 then
		self:Message(args.spellId, "Personal", "Info", CL["count"]:format(args.spellName, args.amount))
		if args.amount > 5 then
			self:Flash(args.spellId)
		end
	end
end

-- normal
do
	local blastTimers = { 34, 23, 30 } -- 23s cd, reset with swirl it seems
	function mod:CorrosiveBlast(args)
		self:Message(args.spellId, "Urgent", "Alarm")
		self:CDBar(args.spellId, blastTimers[blastCounter] or 23)
		blastCounter = blastCounter + 1
	end
end

function mod:CorrosiveBlastStack(args)
	if self:Tank() and self:Tank(args.destName) then
		self:StackMessage(args.spellId, args.destName, args.amount, "Urgent", "Warning")
	end
end

function mod:Splits()
	self:StopBar(143309) -- Swirl
	self:StopBar(143436) -- Corrosive Blast
	self:StopBar(143574) -- Swelling Corruption
	self:Message(143020, "Neutral")
end

function mod:Reform()
	blastCounter = 1
	self:Message(143469, "Neutral", nil, ("%s (%d%%)"):format(self:SpellName(143469), UnitPower("boss1")))
	self:Bar(143309, 24) -- Swirl 24.1 - 24.9
	self:Bar(143436, 14) -- Corrosive Blast 13.6 - 15.2
	if self:Heroic() then
		self:CDBar(143574, 10) -- Swelling Corruption
	end
end

function mod:Swirl(args)
	self:Message(args.spellId, "Important", "Long")
	--self:Bar(args.spellId, 13, CL["cast"]:format(args.spellName))
	self:Bar(args.spellId, 53)
end

do
	local prev = 0
	function mod:ShaPoolDamage(args)
		if not self:Me(args.destGUID) then return end
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(143295, "Personal", "Info", CL["underyou"]:format(args.spellName))
			self:Flash(143295)
		end
	end
	function mod:ShaBolt(args)
		if not self:Me(args.destGUID) then return end
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Personal", "Info", CL["you"]:format(args.spellName))
		end
	end
end

