--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Ji-Kun Assist", 930)
if not mod then return end
mod:RegisterEnableMob(69712)

local mainMod = BigWigs:GetBossModule("Ji-Kun")

local ML = mainMod:GetLocale("enUS", true)

local nest = 0

local L = mod:NewLocale("enUS", true)
if L then
	L.assist = "Ji-Kun Assist"
	L.assist_desc = "It's highly recommended to emphasize this!. Message warning 5 seconds before it's your turn to go to a nest, also specifically tell you to either go up/down. You can find which group is next inside the {} on the bars."
	L.your_nest_soon = "Your nest in 5 sec!"
	L.go = "GO %s NOW!"
end
local L = mod:NewLocale("itIT", true)
if L then
	L.assist = "Ji-Kun Assist"
	L.assist_desc = "È caldamente raccomandato enfatizzare questo avviso!. Il messaggio avvisa 5 secondi prima che sia il tuo turno di volare verso un nido, inoltre avvisa il tuo gruppo se andare sopra o sotto. Puoi vedere quale nido è stato chiamato guardando le {} sulle barre."
	L.your_nest_soon = "Prossimo nido tra 5 secondi!"
	L.go = "VOLA %s ADESSO!"
end
L = mod:GetLocale()

function mod:GetOptions()
	return {
		"assist",
	}, {
		["assist"] = "general",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
end

function mod:OnEngage()
	nest = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local jikun_assignment = {
	[4] = {
1,
2,
3,
4,
5,
1,
2,
3,
1,
4,
2,
5,
3,
4,
5,
1,
2,
1,
3,
2,
1,
3,
2,
4,
5,
3,
1,
4,
	},
	[6] = {
1,
2,
3,
4,
1,
5,
2,
3,
1,
4,
2,
5,
3,
1,
4,
2,
5,
1,
3,
2,
4,
1,
3,
5,
2,
4,
1,
3,
5,
2,
4,
5,
3,
1,
4,
2,
5,
	},
}

do
	local function preWarnNest()
		mod:Message("assist", "Personal", "Long", L["your_nest_soon"], false)
	end
	local function stopMainModBars(nextNest)
		mainMod:StopBar(("(%d) %s"):format(nextNest, ML["lower_nest"]))
		mainMod:StopBar(("(%d)%s+(%d)%s"):format(nextNest, ML["down"], nextNest+1, ML["up"]))
		mainMod:StopBar(("(%d)%s+(%d)%s"):format(nextNest, ML["up"], nextNest+1, ML["down"]))
		mainMod:StopBar(("(%d) %s"):format(nextNest, ML["upper_nest"]))
		mainMod:StopBar(("(%d) %s (%s)"):format(nextNest, ML["down"], ML["add"]))
		mainMod:StopBar(("(%d)%s(%s)+(%d)%s"):format(nextNest, ML["down"], ML["add"], nextNest+1, ML["up"]))
		mainMod:StopBar(("(%d)%s+(%d)%s(%s)"):format(nextNest, ML["down"], nextNest+1, ML["up"], ML["add"]))
		mainMod:StopBar(("(%d)%s+(%d)%s(%s)+(%d)%s"):format(nextNest, ML["up"], nextNest+1, ML["down"], ML["add"], nextNest+2, ML["up"]))
		mainMod:StopBar(("(%d)%s+(%d)%s+(%d)%s"):format(nextNest, ML["down"], nextNest+1, ML["up"], nextNest+2, ML["down"]))
		mainMod:StopBar(("(%d)%s+(%d)%s+(%d)%s"):format(nextNest, ML["up"], nextNest+1, ML["down"], nextNest+2, ML["up"]))
	end
	function mod:CHAT_MSG_MONSTER_EMOTE(_, msg)
		if msg:find(ML["upper_hatch_trigger"]) or msg:find(ML["lower_hatch_trigger"]) then
			local myGroup = 0
			for i=1, GetNumGroupMembers() do
				if UnitName("player") == GetRaidRosterInfo(i) then
					myGroup = select(3, GetRaidRosterInfo(i))
				end
			end
			local diff = self:Difficulty()
			nest = nest + 1
			local nextNest = nest + 1
			local text = (msg:find(ML["upper_hatch_trigger"])) and L["go"]:format(ML["upper_nest"]) or L["go"]:format(ML["lower_nest"])
			local icon = (msg:find(ML["upper_hatch_trigger"])) and "misc_arrowlup" or "misc_arrowdown"
			if diff == 4 then -- 25 N
				if not jikun_assignment[4][nest+2] then print("BigWigs_JiKunASsist: Need more data!") return end
				if myGroup == jikun_assignment[4][nest] then
					self:Message("assist", "Personal", "Long", text, icon)
				end
				if nest == 4 or nest == 8 or nest == 10 or nest == 14 or nest == 17 or nest == 19 or nest == 21 or nest == 24 or nest == 26 then
					if myGroup == jikun_assignment[4][nest+1] or myGroup == jikun_assignment[4][nest+2] then
						self:ScheduleTimer(preWarnNest, 25)
					end
				else
					if myGroup == jikun_assignment[4][nest+1] then
						self:ScheduleTimer(preWarnNest, 25)
					end
				end
				if nest < 4 or nest == 12 or nest == 13 or nest == 23 then
					self:Bar("assist", 30, ("{%d} %s"):format(jikun_assignment[4][nest+1], ML["lower_nest"]), "misc_arrowdown")
				elseif nest == 4 or nest == 8 or nest == 10 or nest == 14 or nest == 17 or nest == 19 or nest == 21 or nest == 24 or nest == 26 then -- up and down at same time
					self:Bar("assist", 30, ("{%d}%s+{%d}%s"):format(jikun_assignment[4][nest+1], ML["down"], jikun_assignment[4][nest+2], ML["up"]), 134347)
				elseif nest == 6 or nest == 7 or nest == 16 then
					self:Bar("assist", 30, ("{%d} %s"):format(jikun_assignment[4][nest+1], ML["upper_nest"]), "misc_arrowlup")
				end
			elseif diff == 6 then -- 25 H
				if not jikun_assignment[6][nest+3] then print("BigWigs_JiKunASsist: Need more data!") return end
				if myGroup == jikun_assignment[6][nest] then
					self:Message("assist", "Personal", "Long", text, icon)
				end
				if nest < 3 or nest == 7 or nest == 12 then
					if myGroup == jikun_assignment[6][nest+1] then
						self:ScheduleTimer(preWarnNest, 25)
					end
				elseif nest == 3 or nest == 5 or nest == 8 or nest == 10 or nest == 13 or nest == 15 or nest == 17 or nest == 19 or nest == 24 or nest == 29 then
					if myGroup == jikun_assignment[6][nest+1] or myGroup == jikun_assignment[6][nest+2] then
						self:ScheduleTimer(preWarnNest, 25)
					end
				elseif nest == 21 or nest == 26 or nest == 31 or nest == 34 then
					if myGroup == jikun_assignment[6][nest+1] or myGroup == jikun_assignment[6][nest+2] or myGroup == jikun_assignment[6][nest+3] then
						self:ScheduleTimer(preWarnNest, 25)
					end
				end
				if nest < 3 or nest == 12 then
					self:Bar("assist", 30, ("{%d} %s"):format(jikun_assignment[6][nextNest], ML["lower_nest"]), "misc_arrowdown")
				elseif nest == 3 or nest == 8 or nest == 17 or nest == 19 or nest == 29 then
					self:Bar("assist", 30, ("{%d}%s+{%d}%s"):format(jikun_assignment[6][nextNest], ML["down"], jikun_assignment[6][nextNest+1], ML["up"]), 134347)
				elseif nest == 13 or nest == 15 or nest == 24 then
					self:Bar("assist", 30, ("{%d}%s+{%d}%s"):format(jikun_assignment[6][nextNest], ML["up"], jikun_assignment[6][nextNest+1], ML["down"]), 134347) -- this is intentional, because this is how blizzard announces it too!
				elseif nest == 7 then
					self:Bar("assist", 30, ("{%d} %s"):format(jikun_assignment[6][nextNest], ML["upper_nest"]), "misc_arrowlup")
				elseif nest == 1 then
					self:Bar("assist", 30, ("{%d} %s (%s)"):format(jikun_assignment[6][nextNest], ML["down"], ML["add"]), "misc_arrowdown")
				elseif nest == 5 then
					self:Bar("assist", 30, ("{%d}%s(%s)+{%d}%s"):format(jikun_assignment[6][nextNest], ML["down"], ML["add"], jikun_assignment[6][nextNest+1], ML["up"]), 134347)
				elseif nest == 10 then
					self:Bar("assist", 30, ("{%d}%s+{%d}%s(%s)"):format(jikun_assignment[6][nextNest], ML["down"], jikun_assignment[6][nextNest+1], ML["up"], ML["add"]), 134347)
				elseif nest == 21 then
					self:Bar("assist", 30, ("{%d}%s+{%d}%s(%s)+{%d}%s"):format(jikun_assignment[6][nextNest], ML["up"], jikun_assignment[6][nextNest+1], ML["down"], ML["add"], jikun_assignment[6][nextNest+2], ML["up"]), 134347)
				elseif nest == 26 or nest == 34 then
					self:Bar("assist", 30, ("{%d}%s+{%d}%s+{%d}%s"):format(jikun_assignment[6][nextNest], ML["down"], jikun_assignment[6][nextNest+1], ML["up"], jikun_assignment[6][nextNest+2], ML["down"]), 134347)
				elseif nest == 31 then
					self:Bar("assist", 30, ("{%d}%s+{%d}%s+{%d}%s"):format(jikun_assignment[6][nextNest], ML["up"], jikun_assignment[6][nextNest+1], ML["down"], jikun_assignment[6][nextNest+2], ML["up"]), 134347)
				end
			end
			self:ScheduleTimer(stopMainModBars, 0.1, nextNest)
		end
	end
end

