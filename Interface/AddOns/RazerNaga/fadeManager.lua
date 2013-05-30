--[[
	fadeManager.lua
		Handles fading out frames when not moused over
		Necessary since using the blizzard fading functions can cause issues in combat
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')

--[[ Animation Timer ]]--

function RazerNaga:CreateTimer(duration)
	local timer = CreateFrame('Frame'); timer:Hide()
	timer.duration = duration or 0
	
	timer:SetScript('OnUpdate', function(self, elapsed)
		local nextUpdate = self.nextUpdate - elapsed
		if nextUpdate > 0 then
			self.nextUpdate = nextUpdate
		else
			self:Hide()
			if self.OnFinished then
				self:OnFinished()
			end
		end
	end)

	timer.Start = function(self)
		self.nextUpdate = self.duration
		self:Show()
	end

	timer.Stop = function(self)
		self:Hide()
	end

	timer.IsPlaying = function(self)
		return self:IsShown()
	end

	return timer
end

--[[ Code to watch frames as they're moused over ]]--

local MouseOverWatcher = RazerNaga:CreateTimer()
local watched = {}

MouseOverWatcher.duration = 0.15

function MouseOverWatcher:OnFinished()
	for f in pairs(watched) do
		if f:IsFocus() then
			if not f.focused then
				f.focused = true
				f:Fade()
			end
		else
			if f.focused then
				f.focused = nil
				f:Fade()
			end
		end
	end

	if next(watched) then
		self:Start()
	end
end

function MouseOverWatcher:Add(f)
	if watched[f] then return end

	watched[f] = true
	f.focused = f:IsFocus() and true or nil
	f:UpdateAlpha()

	if not self:IsPlaying() then
		self:Start()
	end
end

function MouseOverWatcher:Remove(f)
	if not watched[f] then return end

	watched[f] = nil
	f.focused = nil
	f:UpdateAlpha()
end

RazerNaga.MouseOverWatcher = MouseOverWatcher