--[[
TODO:

]]--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Siegecrafter Blackfuse", 953, 865)
if not mod then return end
mod:RegisterEnableMob(71504)

--------------------------------------------------------------------------------
-- Locals
--

local overloadCounter = 1
local markableMobs = {}
local marksUsed = {}
local markTimer
local assemblyLineCounter = 1
local shredder = EJ_GetSectionInfo(8199)
local sawbladeTarget

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.overcharged_crawler_mine = "Overcharged Crawler Mine" -- sadly this is needed since they have same mobId
	L.custom_off_mine_marker = "Mine marker"
	L.custom_off_mine_marker_desc = "Mark the mines for specific stun assignments. (All the marks are used)"

	L.saw_blade_near_you = "Saw blade near you (not on you)"
	L.saw_blade_near_you_desc = "You might want to turn this off to avoid spam if your raid is mostly bunched up according to your tactics."
	L.saw_blade_near_you_icon = 143265

	L.disabled = "Disabled"

	L.shredder_engage_trigger = "An Automated Shredder draws near!"
	L.laser_on_you = "Laser on you PEW PEW!"
	L.laser_say = "Laser PEW PEW"

	L.assembly_line_trigger = "Unfinished weapons begin to roll out on the assembly line."
	L.assembly_line_message = "Unfinished weapons (%d)"

	L.shockwave_missile_trigger = "Presenting... the beautiful new ST-03 Shockwave missile turret!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_off_mine_marker",
		-8408,
		{-8195, "FLASH", "SAY", "ICON"}, "saw_blade_near_you", 145365, {143385, "TANK"}, -- Siegecrafter Blackfuse
		-8199, 144208, 145444, -- Automated Shredders
		-8202, -8207, 143639, {-8208, "FLASH", "SAY"}, 143856, 144466, {-8212, "FLASH"},
		"berserk", "bosskill",
	}, {
		["custom_off_mine_marker"] = L.custom_off_mine_marker,
		[-8408] = "heroic",
		[-8195] = -8194, -- Siegecrafter Blackfuse
		[-8199] = -8199, -- Automated Shredders
		[-8202] = -8202, -- The Assembly Line
		["berserk"] = "general",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	-- heroic
	self:Log("SPELL_CAST_SUCCESS", "Overcharge", 145774)
	-- The Assembly Line
	self:Emote("AssemblyLine", L["assembly_line_trigger"])
	self:Log("SPELL_AURA_APPLIED", "CrawlerMine", 145269)
	self:Log("SPELL_AURA_APPLIED", "MagneticCrush", 144466)
	self:Log("SPELL_AURA_APPLIED", "Superheated", 143856)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Superheated", 143856)
	self:RegisterEvent("RAID_BOSS_WHISPER")
	self:Yell("ShockwaveMissile", L["shockwave_missile_trigger"])
	self:Log("SPELL_AURA_APPLIED", "ShockwaveMissileOver", 143639)
	self:Log("SPELL_AURA_APPLIED", "PatternRecognitionApplied", 144236)
	self:Log("SPELL_AURA_REMOVED", "PatternRecognitionRemoved", 144236)
	-- Automated Shredders
	self:Log("SPELL_CAST_SUCCESS", "AddMarkedMob", 145269) -- break in
	self:Emote("ShredderEngage", L["shredder_engage_trigger"])
	self:Log("SPELL_CAST_START", "DeathFromAbove", 144208)
	self:Log("SPELL_CAST_START", "DeathFromAboveApplied", 144210)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Overload", 145444)
	self:Log("SPELL_AURA_APPLIED", "Overload", 145444)
	-- Siegecrafter Blackfuse
	self:Log("SPELL_AURA_APPLIED_DOSE", "ElectrostaticCharge", 143385)
	self:Log("SPELL_AURA_APPLIED", "ProtectiveFrenzy", 145365)
	self:Log("SPELL_CAST_START", "Sawblade", 143265)
	self:Log("SPELL_CAST_SUCCESS", "SawbladeFallback", 143265)

	self:Death("ShredderDied", 71591)
	self:Death("Win", 71504)
end

function mod:OnEngage()
	self:Berserk(self:Heroic() and 540 or 600)
	assemblyLineCounter = 1
	self:Bar(-8199, 35, shredder, "INV_MISC_ARMORKIT_27") -- Shredder Engage
	self:CDBar(-8195, 9) -- Sawblade
	if self.db.profile.custom_off_mine_marker then
		wipe(markableMobs)
		wipe(marksUsed)
		markTimer = nil
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- heroic
-- marking
do
	local function setMark(unit, guid)
		for mark = 1, 8 do
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
	end

	function mod:UPDATE_MOUSEOVER_UNIT()
		local guid = UnitGUID("mouseover")
		if guid and markableMobs[guid] == true then
			setMark("mouseover", guid)
		elseif guid and UnitName("mouseover") == L.overcharged_crawler_mine and not markableMobs[guid] then -- overcharged crawler mine
			markableMobs[guid] = true
			setMark("mouseover", guid)
		end
	end

	function mod:AddMarkedMob(args)
		if not markableMobs[args.sourceGUID] and L.overcharged_crawler_mine == args.sourceName then
			markableMobs[args.sourceGUID] = true
			if self.db.profile.custom_off_mine_marker and not markTimer then
				markTimer = self:ScheduleRepeatingTimer(markMobs, 0.1)
			end
		end
	end

	function mod:Overcharge(args)
		self:Message(-8408, "Important", nil, CL["other"]:format(args.spellName, args.destName), false) -- maybe shorten args.destName?
		if self.db.profile.custom_off_mine_marker and self:MobId(args.destGUID) == 71790 then -- mines
			wipe(markableMobs)
			wipe(marksUsed)
			markTimer = nil
			self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
			if not markTimer then
				markTimer = self:ScheduleRepeatingTimer(markMobs, 0.1)
			end
		end
	end
end

-- The Assembly Line

do
	-- this helps people trying to figure out tactics
	local function beltItems()
		local items = ""
		local boss
		for i=1, 5 do
			boss = "boss"..i
			if UnitExists(boss) and mod:MobId(UnitGUID(boss)) ~= 71504 then
				items = ("%s - %s"):format(items, UnitName(boss)) -- I used to gsub this with to shorten it but guess that won't work for all localization, maybe use localized names instead?
			end
		end
		mod:Message(-8202, "Neutral", nil, CL["count"]:format("Items: "..items, assemblyLineCounter-1), false)
	end
	function mod:AssemblyLine()
		self:ScheduleTimer(beltItems, 13)
		self:Message(-8202, "Neutral", "Warning", L["assembly_line_message"]:format(assemblyLineCounter), "Inv_crate_03")
		assemblyLineCounter = assemblyLineCounter + 1
		self:Bar(-8202, 40, CL["count"]:format((EJ_GetSectionInfo(8202)), assemblyLineCounter), "Inv_crate_03")
	end
end

do
	local prev = 0
	function mod:CrawlerMine(args)
		local t = GetTime()
		if t-prev > 5 then
			prev = t
			self:Message(-8212, "Urgent", nil, -8212, 77976) -- mine like icon
		end
	end
end

do
	local prev = 0
	function mod:MagneticCrush(args)
		local t = GetTime()
		if t-prev > 15 then
			prev = t
			self:Message(args.spellId, "Important", "Long")
		end
	end
end

function mod:Superheated(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Info", CL["underyou"]:format(args.spellName))
	end
end

function mod:RAID_BOSS_WHISPER(_, msg, sender)
	if msg:find("Ability_Siege_Engineer_Superheated") then -- laser fixate
		-- might wanna do syncing to get range message working
		self:Message(-8208, "Personal", "Info", L.laser_on_you, 144040)
		self:Flash(-8208)
		self:Say(-8208, L.laser_say)
	elseif msg:find("Ability_Siege_Engineer_Detonate") then -- mine fixate
		self:Message(-8212, "Personal", "Info", CL["you"]:format(sender))
		self:Flash(-8212)
	elseif msg:find("143266") then -- Sawblade
		-- this is faster than target scanning, hence why we do it
		sawbladeTarget = UnitGUID("player")
		self:Message(-8195, "Positive", "Info", CL["you"]:format(self:SpellName(143266)))
		self:PrimaryIcon(-8195, "player")
		self:Flash(-8195)
		self:Say(-8195)
	end
end

function mod:ShockwaveMissile()
	self:Message(143639, "Urgent")
end

function mod:ShockwaveMissileOver(args)
	self:Message(args.spellId, "Urgent", nil, CL["over"]:format(args.spellName))
end

function mod:PatternRecognitionApplied(args)
	if self:Me(args.destGUID) then
		self:Bar(-8207, 60)
	end
end

function mod:PatternRecognitionRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(-8207, "Positive", CL["over"]:format(args.spellName))
	end
end

-- Automated Shredders

function mod:ShredderEngage()
	self:Message(-8199, "Attention", self:Tank() and "Long", shredder, "INV_MISC_ARMORKIT_27")
	self:Bar(-8199, 60, shredder, "INV_MISC_ARMORKIT_27")
	self:Bar(144208, 16) -- Death from Above
	overloadCounter = 1
	self:Bar(145444, 7, CL["count"]:format(self:SpellName(145444), overloadCounter)) -- Overload
end

function mod:DeathFromAboveApplied(args)
	self:Message(args.spellId, "Attention", "Alert")
end

function mod:DeathFromAbove(args)
	self:Message(args.spellId, "Attention", nil, CL["casting"]:format(args.spellName))
	self:Bar(args.spellId, 41)
end

function mod:Overload(args)
	local amount = args.amount or 1
	self:Message(args.spellId, "Urgent", nil, CL["count"]:format(args.spellName, amount))
	overloadCounter = amount + 1
	self:Bar(args.spellId, 11, CL["count"]:format(args.spellName, overloadCounter))
end

function mod:ShredderDied()
	self:StopBar(144208) -- Death from Above
	self:StopBar(CL["count"]:format(self:SpellName(145444), overloadCounter)) -- Overload
end

-- Siegecrafter Blackfuse

function mod:ElectrostaticCharge(args)
	self:CDBar(args.spellId, 17)
	self:StackMessage(args.spellId, args.destName, args.amount, "Attention", "Info")
end

function mod:ProtectiveFrenzy(args)
	self:Message(args.spellId, "Attention", "Long")
	local boss
	for i=1, 5 do
		boss = "boss"..i
		if UnitExists(boss) and UnitIsDead(boss) then
			self:Message(-8202, "Positive", nil, CL["other"]:format(L["disabled"], UnitName(boss)), false) -- maybe shorten the unit name?
		end
	end
end

do
	-- rather do this than syncing
	local timer = nil
	local function warnSawblade(self, target, guid)
		sawbladeTarget = guid
		self:PrimaryIcon(-8195, target)
		if not self:Me(guid) then -- we warn for ourself from the BOSS_WHISPER
			if self:Range(target) < 8 then -- 8 is guessed
				self:RangeMessage("saw_blade_near_you", "Personal", "Alarm", mod:SpellName(-8195), 143265)
				--mod:Flash(-8195) -- this is too much for our tactic
			else
				self:TargetMessage(-8195, target, "Positive", "Info")
			end
		end
	end
	function mod:Sawblade(args)
		self:CDBar(-8195, 11)
		sawbladeTarget = nil
		self:GetBossTarget(warnSawblade, 0.4, args.sourceGUID)
	end
	function mod:SawbladeFallback(args)
		 -- don't do anything if we warned for the target already
		if args.destGUID ~= sawbladeTarget then
			warnSawblade(self, args.destName, args.destGUID)
		end
	end
end

