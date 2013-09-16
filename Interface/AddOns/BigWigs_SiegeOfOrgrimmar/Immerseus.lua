--[[
TODO:
	corosive blast could potentially get a fancy warning, so people know when they are in front of the boss, could greatly help melee if they run out of room around the boss
]]--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Immerseus", 953, 852)
if not mod then return end
mod:RegisterEnableMob(71543)

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
		143574,
		{143295, "FLASH"}, 143309, -7992, 143469, 143436,
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
	self:Berserk(600, nil, nil, "Berserk (assumed)") -- XXX Assumed
	self:Bar(143309, 20.8) -- Swirl
	self:Bar(143436, 10) -- Corrosive Blast
	if self:Heroic() then
		self:CDBar(143574, 10) -- Swelling Corruption
	end
end

-- XXX TEST OUT USING THE VERIFY ENABLE CHECK AS THE BOSS KILL EVENT NEXT WEEK
function mod:KillCheck()
	local hasBoss = UnitHealth("boss1") > 100 or UnitHealth("boss2") > 100 or UnitHealth("boss3") > 100 or UnitHealth("boss4") > 100 or UnitHealth("boss5") > 100
	if not hasBoss then
		self:ScheduleTimer("StartWipeCheck", 10)
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

-- add personal too high stack warning

-- normal
function mod:CorrosiveBlast(args)
	self:Message(args.spellId, "Urgent", self:Tank() and "Warning")
	self:CDBar(args.spellId, 35)
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
	self:Message(-7992, "Neutral")
end

function mod:Reform()
	self:Message(143469, "Neutral")
	self:Bar(143309, 24) -- Swirl 24.1 - 24.9
	self:Bar(143436, 14) -- Corrosive Blast 13.6 - 15.2
	if self:Heroic() then
		self:CDBar(143574, 10) -- Swelling Corruption
	end
end

function mod:Swirl(args)
	self:Message(args.spellId, "Important", "Long")
	self:Bar(args.spellId, 48) -- Most people probably never encounter one before split
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

