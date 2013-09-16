--[[
TODO:

]]--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kor'kron Dark Shaman", 953, 856)
if not mod then return end
mod:RegisterEnableMob(71859, 71858) -- Earthbreaker Haromm, Wavebinder Kardris

--------------------------------------------------------------------------------
-- Locals
--

local marksUsed = {}
local ashCounter = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.blobs = "Blobs"

	L.custom_off_mist_marks = "Toxic Mist"
	L.custom_off_mist_marks_desc = "To help healing assignments, mark the people who have Toxic Mist on them with %s%s%s%s%s%s (in that order)(not all marks may be used)(tanks are not marked), requires promoted or leader."
end
L = mod:GetLocale()
L.custom_off_mist_marks_desc = L.custom_off_mist_marks_desc:format( -- XXX cut down the number of marks used once we know the max amount used in 25H
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_1.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_2.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_3.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_4.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_6.blp:15\124t"
)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{144330, "FLASH"}, 144328,
		{-8132, "FLASH", "ICON", "SAY"}, -- Earthbreaker Haromm
		"custom_off_mist_marks",
		{144005, "FLASH"}, {143990, "FLASH", "ICON"}, 143973, -- Wavebinder Kardris
		144302, "berserk", "bosskill",
	}, {
		[144330] = "heroic",
		[-8132] = -8128, -- Earthbreaker Haromm
		["custom_off_mist_marks"] = L.custom_off_mist_marks,
		[144005] = -8134, -- Wavebinder Kardris
		[144302] = "general",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_SUCCESS", "Bloodlust", 144302)
	-- Earthbreaker Haromm
	self:Log("SPELL_AURA_APPLIED", "ToxicMistApplied", 144089)
	self:Log("SPELL_AURA_REMOVED", "ToxicMistRemoved", 144089)
	self:Log("SPELL_CAST_START", "FoulStream", 137399, 144090) -- SUCCESS has destName but is way too late, and "boss1target" should be reliable for it
	self:Log("SPELL_CAST_SUCCESS", "FoulStreamFallback", 137399, 144090)
	-- Wavebinder Kardris
	self:Log("SPELL_CAST_START", "FallingAsh", 143973)
	self:Log("SPELL_CAST_SUCCESS", "FoulGeyser", 143990) -- we can live with success for this since blobs don't spawn instantly, rather not do the whole target scanning again
	self:Log("SPELL_CAST_START", "ToxicStorm", 144005)
	self:Log("SPELL_DAMAGE", "ToxicStormDamage", 144017)
	-- heroic
	self:Log("SPELL_AURA_APPLIED", "IronPrison", 144330)
	self:Log("SPELL_CAST_START", "IronTomb", 144328)

	self:Death("Win", 71859)
end

function mod:OnEngage()
	self:Berserk(600, nil, nil, "Berserk (assumed)") -- XXX Assumed
	wipe(marksUsed)
	ashCounter = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- heroic
function mod:IronTomb(args)
	self:Bar(args.spellId, 31)
	self:Message(args.spellId, "Important", "Long")
end

do
	local function ironPrisonOverSoon(spellId)
		mod:Message(spellId, "Attention", "Warning", CL["soon"]:format(CL["removed"]:format(mod:SpellName(spellId))))
		mod:Flash(spellId)
	end
	function mod:IronPrison(args)
		if self:Me(args.destGUID) then
			self:Bar(args.spellId, 60)
			self:ScheduleTimer(ironPrisonOverSoon, 57)
		end
	end
end

-- Earthbreaker Haromm

do
	function mod:ToxicMistRemoved(args)
		if self.db.profile.custom_off_mist_marks then
			for i = 1, 7 do
				if marksUsed[i] == args.destName then
					marksUsed[i] = false
					SetRaidTarget(args.destName, 0)
				end
			end
		end
	end

	local function markMist(destName)
		for i = 1, 7 do
			if not marksUsed[i] then
				SetRaidTarget(destName, i)
				marksUsed[i] = destName
				return
			end
		end
	end
	function mod:ToxicMistApplied(args)
		if self.db.profile.custom_off_mist_marks then
			markMist(args.destName)
		end
	end
end

do
	local timer, foulStreamTarget = nil, nil
	local function warnFoulStream(player, guid)
		mod:PrimaryIcon(-8132, player)
		if mod:Me(guid) then
			mod:Say(-8132)
		end
		if mod:Range(player) < 8 then -- 8 is assumed, also a circular distance check is not the best for this
			mod:RangeMessage(-8132)
			mod:Flash(-8132)
		else
			mod:TargetMessage(-8132, player, "Positive", "Alarm")
		end
	end
	local function checkFoulStream()
		local boss = mod:MobId(UnitGUID("boss1")) == 71859 and "boss1" or "boss2"
		local player = mod:UnitName(boss.."target")
		if player and (not UnitDetailedThreatSituation(boss.."target", boss) and not mod:Tank(boss.."target")) then -- assuming tanks can't get it
			foulStreamTarget = UnitGUID(boss.."target")
			warnFoulStream(player, foulStreamTarget)
			mod:CancelTimer(timer)
			timer = nil
		end
	end
	function mod:FoulStream(args)
		self:CDBar(-8132, 32)
		foulStreamTarget = nil
		if not timer then
			timer = self:ScheduleRepeatingTimer(checkFoulStream, 0.05)
		end
	end
	function mod:FoulStreamFallback(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		 -- don't do anything if we warned for the target already
		if args.destGUID ~= foulStreamTarget then
			warnFoulStream(args.destName, args.destGUID)
		end
	end
end

-- Wavebinder Kardris

function mod:FallingAsh(args)
	-- this is for when the damage happens
	self:ScheduleTimer("Message", 15, args.spellId, "Attention", self:Healer() and "Info", CL["soon"]:format(CL["count"]:format(args.spellName, ashCounter)))
	ashCounter = ashCounter + 1
	self:Bar(args.spellId, 18, CL["count"]:format(args.spellName, ashCounter))
end

function mod:FoulGeyser(args)
	-- XXX still not 100% reliable, maybe should wait till the channel starts and annonce target then?
	self:SecondaryIcon(args.spellId, args.destName)
	self:ScheduleTimer("SecondaryIcon", 15, args.spellId)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert", L["blobs"])
	self:Bar(args.spellId, 32, L["blobs"])
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
	if self:Range(args.destName) < 5 then -- splash is 3 but want bigger warning so people know that blobs will be around that area
		self:RangeMessage(args.spellId, nil, "Alert", CL["near"]:format(L["blobs"]))
	end
end

do
	local prev = 0
	function mod:ToxicStormDamage(args)
		if not self:Me(args.destGUID) then return end
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Personal", "Info", CL["underyou"]:format(args.spellName))
			self:Flash(args.spellId)
		end
	end
end

function mod:ToxicStorm(args)
	self:Message(args.spellId, "Urgent")
	self:Bar(args.spellId, 32)
end

-- General

function mod:Bloodlust(args)
	self:Message(args.spellId, "Neutral", "Info")
end

