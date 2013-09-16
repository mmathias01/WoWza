--[[
TODO:
	look if there is even a point to try and target scan for mortar cannon
]]--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Iron Juggernaut", 953, 864)
if not mod then return end
mod:RegisterEnableMob(71466)

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1
-- marking
local markableMobs = {}
local marksUsed = {}
local markTimer = nil
local mineCounter = 1
local crawlerMine = mod:SpellName(144673)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.custom_off_mine_marks = "Mine marker"
	L.custom_off_mine_marks_desc = "To help soaking assignments, try and mark the Crawler Mines with %s%s%s%s%s (in that order)(not all marks may be used), requires promoted or leader."
end
L = mod:GetLocale()
L.custom_off_mine_marks_desc = L.custom_off_mine_marks_desc:format(
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_1.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_2.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_3.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_4.blp:15\124t",
	"\124TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5.blp:15\124t"
)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{-8179, "FLASH"}, {144459, "HEALER"}, {144467, "TANK"}, -- Assaukt mode
		144485, {-8190, "FLASH", "ICON"}, {144498, "FLASH"}, -- Siege mode
		"custom_off_mine_marks",
		"stages", -8183, "berserk", "bosskill",
	}, {
		[-8179] = -8177,
		[144485] = -8178,
		["custom_off_mine_marks"] = L.custom_off_mine_marks,
		["stages"] = "general",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_SUCCESS", "MineArming", 144718) -- Detonation Sequence
	-- Siege mode
	self:Log("SPELL_PERIODIC_DAMAGE", "NapalmOil", 144498)
	self:Log("SPELL_AURA_REMOVED", "CutterLaserRemoved", 146325)
	self:Log("SPELL_AURA_APPLIED", "CutterLaserApplied", 146325)
	self:Log("SPELL_CAST_START", "ShockPulse", 144485)
	-- Assaukt mode
	self:Log("SPELL_AURA_APPLIED", "IgniteArmor", 144467)
	self:Log("SPELL_AURA_APPLIED_DOSE", "IgniteArmor", 144467)
	self:Log("SPELL_AURA_APPLIED", "LaserBurn", 144459)
	self:Log("SPELL_DAMAGE", "BorerDrill", 144218)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Death("Win", 71466)
end

function mod:OnEngage()
	self:Berserk(480) -- 25H PTR confirmed
	-- no need to start bars here we do it at regeneration
	phase = 1
	if self.db.profile.custom_off_mine_marks then
		wipe(markableMobs)
		wipe(marksUsed)
		markTimer = nil
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function setMark(unit, guid)
		for mark = 1, 5 do
			if not marksUsed[mark] then
				SetRaidTarget(unit, mark)
				markableMobs[guid] = "marked"
				marksUsed[mark] = guid
				return
			end
		end
	end

	local function markMobs()
		local continue
		for guid in next, markableMobs do
			if markableMobs[guid] == true then
				local unit = mod:GetUnitIdByGUID(guid)
				if unit then
					setMark(unit, guid)
				else
					continue = true
				end
			end
		end
		if not continue or not mod.db.profile.custom_off_mine_marks then
			mod:CancelTimer(markTimer)
			markTimer = nil
		end
	end

	function mod:UPDATE_MOUSEOVER_UNIT()
		local guid = UnitGUID("mouseover")
		if guid and markableMobs[guid] == true then
			setMark("mouseover", guid)
		elseif guid and self:MobId(guid) == 72050 and not markableMobs[guid] then
			markableMobs[guid] = true
			setMark("mouseover", guid)
		end
	end

	function mod:MineArming(args)
		if not markableMobs[args.sourceGUID] then
			markableMobs[args.sourceGUID] = true
			if self.db.profile.custom_off_mine_marks and not markTimer then
				markTimer = self:ScheduleRepeatingTimer(markMobs, 0.1)
			end
		end
	end

	function mod:ResetMarking()
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:CancelTimer(markTimer)
		markTimer = nil
		wipe(markableMobs)
		wipe(marksUsed)
	end
end

-- Siege mode
do
	local prev = 0
	function mod:NapalmOil(args)
		if not self:Me(args.destGUID) then return end
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(-8179, "Personal", "Info", CL["underyou"]:format(args.spellName))
			self:Flash(-8179)
		end
	end
end

function mod:CutterLaserRemoved(args)
	self:PrimaryIcon(-8190)
end

function mod:CutterLaserApplied(args)
	-- way too varied timer 11-21
	self:TargetMessage(-8190, args.destName, "Important", "Warning")
	self:PrimaryIcon(-8190, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(-8190)
	end
end

function mod:ShockPulse(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:Bar(args.spellId, 16)
end

-- Assaukt mode
function mod:IgniteArmor(args)
	local amount = args.amount or 0
	self:StackMessage(args.spellId, args.destName, args.amount, "Attention")
	self:CDBar(args.spellId, 9)
end

function mod:LaserBurn(args)
	self:Bar(args.spellId, 11) -- is there even a point for this?
	self:Message(args.spellId, "Important")
end

do
	local prev = 0
	function mod:BorerDrill(args)
		if not self:Me(args.destGUID) then return end
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(-8179, "Personal", "Info", CL["underyou"]:format(args.spellName))
			self:Flash(-8179)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unitId, spellName, _, _, spellId)
	if spellId == 144296 then -- Borer Drill
		self:Message(-8179, "Attention")
		self:CDBar(-8179, 19) -- Borer Drill
	elseif spellId == 144673 then -- Crawler Mine
		self:Message(-8183, "Urgent", nil, CL["count"]:format(spellName, mineCounter))
		mineCounter = mineCounter + 1
		if phase == 1 then
			self:Bar(-8183, 30, CL["count"]:format(spellName, mineCounter))
		else
			self:CDBar(-8183, 25, CL["count"]:format(spellName, mineCounter))
		end
		if self.db.profile.custom_off_mine_marks then
			self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
			self:ScheduleTimer("ResetMarking", 18) -- cast time is 15, we should be safe with 18
		end
	elseif spellId == 144492 then -- Napalm Oil
		self:Message(-8179, "Attention")
		self:CDBar(-8179, 20)
	elseif spellId == 146359 then -- Regeneration aka Assault mode
		phase = 1
		self:Message("stages", "Neutral", "Long", CL["phase"]:format(phase), false)
		self:Bar("stages", 120, CL["phase"]:format(2), 144498) -- maybe should use UNIT_POWER to adjust timer since there seems to be a 6 sec variance
		if self:Healer() then
			self:CDBar(144459, 8)
		end
		mineCounter = 1
		self:Bar(-8183, 30, CL["count"]:format(crawlerMine, mineCounter)) -- Crawler Mine
		self:CDBar(-8179, 19) -- Borer Drill
		self:StopBar(144485) -- Shock Pulse
		self:StopBar(-8179) -- Napalm Oil
		self:StopBar(CL["phase"]:format(1)) -- in case it overruns
	elseif spellId == 146360 then -- Depletion aka Siege mode
		phase = 2
		self:Message("stages", "Neutral", "Long", CL["phase"]:format(phase), false)
		self:Bar("stages", 64, CL["phase"]:format(1), 144464) -- maybe should use UNIT_POWER to adjust timer since there seems to be a 6 sec variance
		mineCounter = 1
		self:CDBar(-8183, 18, CL["count"]:format(crawlerMine, mineCounter)) -- Crawler Mine
		self:CDBar(-8179, 10) -- Napalm Oil
		self:Bar(144485 ,18) -- Shock Pulse
		self:StopBar(144459) -- Laser Burn
		self:StopBar(-8179) -- Borer Drill
		self:StopBar(144467) -- Ignite Armor
		self:StopBar(CL["phase"]:format(2)) -- in case it overruns
	end
end


