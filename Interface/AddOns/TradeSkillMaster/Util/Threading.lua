-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- This file contains code for running stuff in a pseudo-thread

local TSM = select(2, ...)
local private = {frames={}, threads={}}
TSMAPI.Threading = {}
local STATUS_YIELD = {}
local MAX_QUANTUM = 50


local ThreadPrototype = {
	Resume = function(self, runTime)
		self._runTime = runTime
		self._random = random(1, 1000)
		self._ticks = 0
		debugprofilestop() -- make sure no debug profile is running
		debugprofilestart()
		local status = self:_func(self._param)
		debugprofilestop()
		return status
	end,

	Yield = function(self, force)
		self._ticks = self._ticks + debugprofilestop()
		debugprofilestart()
		if force or self._ticks > self._runTime then
			coroutine.yield(STATUS_YIELD)
		end
	end,
	
	Sleep = function(self, seconds)
		self._sleeping = seconds
		coroutine.yield(STATUS_YIELD)
	end,
}



function private.RunScheduler(_, elapsed)
	-- deal with sleeping threads and try and assign requested quantums
	local quantums = {}
	local totalTime = min(elapsed * 1000, MAX_QUANTUM)
	local usedTime = 0
	for i, thread in ipairs(private.threads) do
		if thread._sleeping then
			thread._sleeping = thread._sleeping - elapsed
			if thread._sleeping <= 0 then
				thread._sleeping = nil
			end
		end
		quantums[i] = thread._sleeping and 0 or (thread._percent * totalTime)
		usedTime = usedTime + quantums[i]
	end
	
	-- scale everything down if the total is > the total time
	if usedTime > totalTime then
		for i=1, #quantums do
			quantums[i] = quantums[i] * (totalTime / usedTime)
		end
	end
	
	-- run the threads that aren't sleeping
	for i, thread in ipairs(private.threads) do
		if quantums[i] > 0 then
			-- resume running for a quantum based on its percent
			local status = thread:Resume(quantums[i])
			if status ~= STATUS_YIELD then
				tremove(private.threads, i)
				if thread._callback then thread._callback() end
			end
		end
	end
end

function TSMAPI.Threading:Start(func, percent, callback, param)
	local thread = CopyTable(ThreadPrototype)
	thread._func = coroutine.wrap(func)
	thread._percent = percent
	thread._callback = callback
	thread._param = param
	thread._sleeping = nil
	tinsert(private.threads, thread)
end

do
	private.frame = CreateFrame("Frame")
	private.frame:Hide()
	private.frame:SetScript("OnUpdate", private.RunScheduler)
	private.frame:Show()
	private.index = 1
end

-- EXAMPLE USAGE:

-- local function TestFunc(self, letter)
	-- for i = 1, 10 do
		-- self:Sleep(1)
		-- print(letter, i)
	-- end
-- end

-- function TSMTest()
	-- local start = GetTime()
	-- TSMAPI.Threading:Start(TestFunc, 1, function() print("DONE", GetTime()-start) end, "A")
	-- TSMAPI.Threading:Start(TestFunc, 1, function() print("DONE", GetTime()-start) end, "B")
-- end