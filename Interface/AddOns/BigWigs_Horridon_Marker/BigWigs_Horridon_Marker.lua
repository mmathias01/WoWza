--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Horridon Marker", 930)
if not mod then return end
mod:RegisterEnableMob(68476, 69374)

--------------------------------------------------------------------------------
-- Lua Configuration
--

--change the numbers here for different marking order
-- 1 -> Star
-- 2 -> Circle
-- 3 -> Diamond
-- 4 -> Triangle
-- 5 -> Moon
-- 6 -> Square
-- 7 -> Cross
-- 8 -> Skull
--Default Order is Star, Circle, Diamond, Triangle, Moon, Square
--Example "skull then pointy marks" order
--local marks = {8,7,1,3,4,6}

-- ***** EDIT BELOW THIS LINE ***** --

local marks = {1,2,3,4,5,6}

-- ***** DO NOT EDIT BELOW THIS LINE ***** --

--------------------------------------------------------------------------------
-- Upvalues
--

local counter = 1
local adds = {}
local timer = nil
local next = next

local mobs = {
	[69164] = true, --Gurubashi Venom Priest
	[69175] = true, --Farraki Wastewalker
	[69178] = true, --Drakkari Frozen Warlord
	[69177] = true, --Amani Warbear
	[69176] = true, --Amani'shi Beast Shaman
}

--------------------------------------------------------------------------------
-- Localization
--

local mainMod = BigWigs:GetBossModule("Horridon")
local L = mainMod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	if not self:LFR() then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:Emote("Doors", L["door_trigger"])

		self:Log("SPELL_CAST_START", "Casts",
			136587, -- Venom Priests (Venom Bolt Volley)
			136725, -- Wastewalker (Sand Trap)
			136719, -- Wastewalker (Blazing Sunlight)
			136564, -- Frozen Warlord (Frozen Orb)
			136480  -- Beast Shaman (Chain Lightning)
		) 
		self:Log("SPELL_CAST_SUCCESS", "Casts", 136463) -- Warbear (Swipe)

		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	end

	self:Death("Disable", 68476)
end

function mod:OnEngage()
	counter = 1
	timer = nil
	wipe(adds)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local function mark(mobId, counter)
	SetRaidTarget(mobId, marks[counter])
end

function mod:Doors()
	wipe(adds)
	counter = 1
end

function mod:UPDATE_MOUSEOVER_UNIT()
	local GUID = UnitGUID("mouseover")
	if GUID and mobs[self:MobId(GUID)] and adds[GUID] ~= "marked" then
		mark("mouseover", counter)
		adds[GUID] = "marked"
		counter = counter + 1
		if counter > 6 then counter = 1 end
	end
end

function mod:PLAYER_TARGET_CHANGED()
	local GUID = UnitGUID("target")
	if GUID and mobs[self:MobId(GUID)] and adds[GUID] ~= "marked" then
		mark("target", counter)
		adds[GUID] = "marked"
		counter = counter + 1
		if counter > 6 then counter = 1 end
	end
end

do
	local function checkTargets()
		local continue
		for guid in next, adds do
			if adds[guid] ~= "marked" then
				local mobId = mod:GetUnitIdByGUID(guid)
				if mobId then
					mark(mobId, counter)
					adds[guid] = "marked"
					counter = counter + 1
					if counter > 6 then counter = 1 end
				else
					continue = true
				end
			end
		end
		if not continue then
			mod:CancelTimer(timer)
			timer = nil
		end
	end

	function mod:Casts(args)
		if mobs[self:MobId(args.sourceGUID)] and not adds[args.sourceGUID] then
			adds[args.sourceGUID] = true
			if not timer then
				timer = self:ScheduleRepeatingTimer(checkTargets, 0.2)
			end
		end
	end
end

