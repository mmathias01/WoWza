
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Pride", 953, 867)
if not mod then return end
mod:RegisterEnableMob(71734)

--------------------------------------------------------------------------------
-- Locals
--

local titans, titanCounter = {}, 1
local auraOfPride, auraOfPrideGroup, auraOfPrideOnMe = mod:SpellName(146817), {}, nil
local swellingPrideCounter = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.projection_message = "Go to |cFF00FF00GREEN|r arrow!"
	L.projection_explosion = "Projection explosion"

	L.titan_pride = "Titan+Pride: %s"

	L.custom_off_titan_mark = "Gift of the Titans marker"
	L.custom_off_titan_mark_desc = "Mark people that have Gift of the Titans with {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}{rt8}, requires promoted or leader.\n|cFFFF0000Only 1 person in the raid should have this enabled to prevent marking conflicts.|r"
	L.custom_off_titan_mark_icon = 1
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		145215, 147207,
		"custom_off_titan_mark",
		{146595, "PROXIMITY"}, 144400, -8257, {-8258, "FLASH"}, {146817, "FLASH", "PROXIMITY"}, -8270, {144351, "DISPEL"}, {144358, "TANK", "FLASH", "EMPHASIZE"}, -8262, 144800, 144563, -8349,
		"altpower", "berserk", "bosskill",
	}, {
		[145215] = "heroic",
		["custom_off_titan_mark"] = L.custom_off_titan_mark,
		[146595] = "general",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	if IsEncounterInProgress() then
		self:OpenAltPower("altpower", 144343) -- Pride
	end

	-- heroic
	self:Log("SPELL_AURA_REMOVED", "WeakenedResolveOver", 147207)
	self:Log("SPELL_AURA_APPLIED", "Banishment", 145215)
	-- normal
	self:Log("SPELL_CAST_START", "UnleashedStart", 144832)
	self:Log("SPELL_CAST_SUCCESS", "Unleashed", 144832)
	self:Log("SPELL_AURA_APPLIED", "ImprisonApplied", 144574, 144684, 144683, 144636)
	self:Log("SPELL_CAST_START", "Imprison", 144563)
	self:Log("SPELL_CAST_SUCCESS", "SelfReflection", 144800)
	self:Log("SPELL_CAST_SUCCESS", "WoundedPride", 144358)
	self:Log("SPELL_CAST_SUCCESS", "MarkOfArrogance", 144351)
	self:Log("SPELL_AURA_REMOVED", "AuraOfPrideRemoved", 146817)
	self:Log("SPELL_AURA_APPLIED", "AuraOfPrideApplied", 146817)
	self:Log("SPELL_CAST_SUCCESS", "SwellingPrideSuccess", 144400)
	self:Log("SPELL_CAST_START", "SwellingPride", 144400)
	self:Log("SPELL_CAST_SUCCESS", "TitanGiftSuccess", 146595)
	self:Log("SPELL_AURA_APPLIED", "TitanGiftApplied", 144359, 146594)
	self:Log("SPELL_AURA_REMOVED", "TitanGiftRemoved", 144359, 146594)

	self:Death("Win", 71734)
end

function mod:OnEngage()
	swellingPrideCounter, titanCounter = 1, 1
	wipe(titans)
	wipe(auraOfPrideGroup)
	auraOfPrideOnMe = nil
	self:Bar(146595, 7) -- Titan Gift
	self:Bar(144400, 77, CL["count"]:format(self:SpellName(144400), swellingPrideCounter)) -- Swelling Pride
	self:Bar(-8262, 60, CL["big_add"], 144379) -- signature ability icon
	self:DelayedMessage(-8262, 55, "Urgent", CL["spawning"]:format(CL["big_add"]), 144379)
	self:Bar(144800, 25, CL["small_adds"])
	self:Bar(144563, 52.5) -- Imprison
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	if self:Heroic() then
		self:Bar(145215, 37) -- Banishment
	end
	if not self:LFR() then
		self:CDBar(144358, 11) -- Wounded Pride
		self:Berserk(600)
	end
	self:OpenAltPower("altpower", 144343) -- Pride
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- heroic
function mod:WeakenedResolveOver(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Positive", nil, CL["over"]:format(args.spellName))
	end
end

do
	local banishmentList, scheduled = mod:NewTargetList(), nil
	local function warnBanishment(spellId)
		mod:TargetMessage(spellId, banishmentList, "Attention")
		scheduled = nil
	end
	function mod:Banishment(args)
		banishmentList[#banishmentList+1] = args.destName
		if not scheduled then
			scheduled = self:ScheduleTimer(warnBanishment, 0.1, args.spellId)
		end
	end
end

-- normal
function mod:UnleashedStart()
	if not self:LFR() then
		self:CDBar(144358, 11) -- Wounded Pride
	end
	self:StopBar(CL["count"]:format(self:SpellName(144400), swellingPrideCounter)) -- Swelling Pride
	self:StopBar(144563) -- Imprison
	self:StopBar(145215) -- Banishment
	self:StopBar(CL["small_adds"])
	self:StopBar(CL["big_add"])
	self:CancelDelayedMessage(CL["spawning"]:format(CL["big_add"]))
end

function mod:Unleashed() -- Final Gift
	self:StopBar(146595) -- Gift of the Titans
	self:Message(-8349, "Neutral", "Info")
	self:Bar(144400, 74, CL["count"]:format(self:SpellName(144400), swellingPrideCounter)) -- Swelling Pride
	self:Bar(-8262, 60, CL["big_add"], 144379)
	self:DelayedMessage(-8262, 55, "Urgent", CL["spawning"]:format(CL["big_add"]), 144379)
	self:Bar(144800, 16.3, CL["small_adds"])
	self:Bar(144563, 43.6) -- Imprison
	if self:Heroic() then
		self:Bar(145215, 29) -- Banishment
	end
end

function mod:UNIT_HEALTH_FREQUENT(unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
	if hp < 33 then -- 30%
		self:Message(-8349, "Neutral", "Info", CL["soon"]:format(self:SpellName(-8349)))
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss1")
	end
end

do
	local prisoned, scheduled = mod:NewTargetList(), nil
	local function warnImprison()
		mod:TargetMessage(144563, prisoned, "Neutral")
		scheduled = nil
	end
	function mod:ImprisonApplied(args)
		prisoned[#prisoned+1] = args.destName
		if not scheduled then
			scheduled = self:ScheduleTimer(warnImprison, 0.1)
		end
	end
end

function mod:Imprison(args)
	self:Message(args.spellId, "Neutral", nil, CL["casting"]:format(args.spellName))
end

function mod:SelfReflection(args)
	self:Message(args.spellId, "Important", nil, CL["small_adds"])
end

function mod:WoundedPride(args)
	-- mainly warn the guy not getting the debuff
	local notOnMe = not self:Me(args.destGUID)
	if notOnMe then
		self:Flash(args.spellId)
	end
	self:TargetMessage(args.spellId, args.destName, "Important", notOnMe and "Warning", nil, nil, true) -- play sound for the other tanks
	self:CDBar(args.spellId, 30)
end

function mod:MarkOfArrogance(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:Message(args.spellId, "Important", "Alarm")
		self:Bar(args.spellId, 20)
	end
end

function mod:AuraOfPrideRemoved(args)
	self:CloseProximity(args.spellId)
	wipe(auraOfPrideGroup)
	auraOfPrideOnMe = nil
end

function mod:AuraOfPrideApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL["you"]:format(args.spellName))
		self:Flash(args.spellId)
		self:OpenProximity(args.spellId, 5)
		auraOfPrideOnMe = true
	else
		auraOfPrideGroup[#auraOfPrideGroup+1] = args.destName
	end
	if not auraOfPrideOnMe then
		self:OpenProximity(args.spellId, 5, auraOfPrideGroup)
	end
end

do
	local prev = 0
	local mindcontrolled = mod:NewTargetList()
	function mod:SwellingPrideSuccess(args)
		if not self:LFR() then
			self:CDBar(144358, 10.5) -- Wounded Pride, 10-11.2
		end
		if self:Heroic() then
			self:Bar(145215, 40) -- Banishment -- more frequently 40 than anything else
		end
		self:Bar(144563, 53) -- Imprison
		self:Bar(-8262, 60, CL["big_add"], 144379) -- when the add is actually up
		self:Bar(144800, 25.6, CL["small_adds"])
		self:DelayedMessage(-8262, 55, "Urgent", CL["spawning"]:format(CL["big_add"]), 144379, not self:Tank() and not self:Healer() and "Alert")
		-- lets do some fancy stuff
		local playerPower = UnitPower("player", 10)
		if playerPower > 24 and playerPower < 50 then
			self:Message(-8257, "Personal", "Alarm", CL["underyou"]:format(self:SpellName(144911))) -- bursting pride
		elseif playerPower > 49 and playerPower < 75 then
			self:Message(-8258, "Personal", "Warning", L["projection_message"], "Achievement_pvp_g_01.png") -- better fitting icon imo
			self:Flash(-8258, "Achievement_pvp_g_01.png")
			self:Bar(-8258, 6, L["projection_explosion"])
		end
		for i=1, GetNumGroupMembers() do
			local unit = GetRaidRosterInfo(i)
			local power = UnitPower(unit, 10)
			if power > 24 and power < 50 and self:Range(unit) < 5 and (playerPower < 25 or playerPower > 49) then -- someone near have it, but not the "player"
				local t = GetTime()
				if t-prev > 2 then -- don't spam
					prev = t
					self:RangeMessage(-8257) -- bursting pride
				end
			elseif power == 100 then
				mindcontrolled[#mindcontrolled+1] = unit
				self:ScheduleTimer("TargetMessage", 0.1, -8270, mindcontrolled, "Attention")
			end
		end
	end
end

function mod:SwellingPride(args)
	self:Message(args.spellId, "Attention", "Info", CL["count"]:format(args.spellName, swellingPrideCounter)) -- play sound so people can use personal CDs
	swellingPrideCounter = swellingPrideCounter + 1
	self:Bar(args.spellId, 77, CL["count"]:format(args.spellName, swellingPrideCounter))
end

do
	local isOnMe = nil
	local function titansCasted()
		if isOnMe then
			isOnMe = nil
			mod:OpenProximity(146595, 8, titans, true)
		end
		titanCounter = 1
		wipe(titans)
	end
	function mod:TitanGiftRemoved(args)
		if self:Me(args.destGUID) then
			self:CloseProximity(146595)
		end
		if self.db.profile.custom_off_titan_mark then
			SetRaidTarget(args.destName, 0)
		end
	end
	function mod:TitanGiftApplied(args)
		local _, _, _, _, _, _, prideExpires = UnitDebuff(args.destName, auraOfPride) -- this is to check if the person has aura of pride then later spawn remaining duration bar
		if self:Me(args.destGUID) then
			isOnMe = true
			if prideExpires then -- Aura of Pride 5 yard aoe
				self:Message(146595, "Neutral", "Long", CL["you"]:format(("%s + %s"):format(args.spellName,auraOfPride)))
				self:Flash(146817) -- Aura of Pride flash
			else
				self:Message(146595, "Positive", "Long", CL["you"]:format(args.spellName))
			end
		else
			titans[#titans+1] = args.destName
		end

		if self.db.profile.custom_off_titan_mark then
			if prideExpires then
				local remaining = prideExpires-GetTime()
				self:TargetBar(146595, remaining, args.destName, L["titan_pride"])
				self:ScheduleTimer(SetRaidTarget, remaining, args.destName, titanCounter)
			else
				SetRaidTarget(args.destName, titanCounter)
			end
			titanCounter = titanCounter + 1
		end
	end
	function mod:TitanGiftSuccess(args)
		self:Bar(args.spellId, 25)
		self:ScheduleTimer(titansCasted, 0.3)
	end
end

