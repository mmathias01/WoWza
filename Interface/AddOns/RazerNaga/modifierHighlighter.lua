--[[
	modifierHighlighter.lua
		Handles modifier key detection, highlighting, and fading
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local ModHighlighter = RazerNaga:NewModule('ModHighlighter', 'AceEvent-3.0'); RazerNaga.ModHighlighter = ModHighlighter


--[[ throttled event handler for modifier state changed, since keyboard combos can happen very quickly ]]--
local ModifierStateChangedTimer = RazerNaga:CreateTimer(0.03)
function ModifierStateChangedTimer:OnFinished()
	ModHighlighter:HighlightModifiers()
	ModHighlighter:FadeBars()
end


--[[ Events ]]--

function ModHighlighter:Load()
	self:UpdateEventRegistration()
	RazerNaga.Envoy:RegisterMany(self, 'HIGHLIGHT_MODIFIERS_UPDATE', 'TBAR_UPDATE_AUTO_FADE')
end

function ModHighlighter:Unload()
	self:UnregisterEvent('MODIFIER_STATE_CHANGED')
	RazerNaga.Envoy:UnregisterAll(self)
end

function ModHighlighter:MODIFIER_STATE_CHANGED()
	ModifierStateChangedTimer:Start()
end

function ModHighlighter:HIGHLIGHT_MODIFIERS_UPDATE(msg, enable)
	self:UpdateEventRegistration()
	self:HighlightModifiers()
end

function ModHighlighter:TBAR_UPDATE_AUTO_FADE(msg, enable)
	self:UpdateEventRegistration()
	self:FadeBars()
end

function ModHighlighter:UpdateEventRegistration()
	if self:IsAutoBindingEnabled() and (self:HighlightingModifiers() or self:FadingBars()) then
		self:RegisterEvent('MODIFIER_STATE_CHANGED')
	else
		self:UnregisterEvent('MODIFIER_STATE_CHANGED')
	end
end


--[[ Configuration ]]--

function ModHighlighter:SetHighlightModifiers(enable)
	RazerNaga.db.profile.highlightModifiers = enable or false
	RazerNaga.Envoy:Send('HIGHLIGHT_MODIFIERS_UPDATE', self:HighlightingModifiers())
end

function ModHighlighter:HighlightingModifiers()
	return RazerNaga.db.profile.highlightModifiers
end

function ModHighlighter:FadingBars()
	local Anansi = RazerNaga:GetModule('Anansi', true)
	return Anansi and Anansi.Config:AutoFadingTBars()
end

function ModHighlighter:IsAutoBindingEnabled()
	return RazerNaga.AutoBinder:IsAutoBindingEnabled()
end

function ModHighlighter:GetActiveFrameModifier(frame)
	local BindingsLoader = RazerNaga.BindingsLoader
	return BindingsLoader:IsAutoBindingEnabled(frame) and BindingsLoader:GetFrameModifier(frame) 
end


--[[ Highlighting ]]--

function ModHighlighter:GetCurrentModifierCombo()
	if IsControlKeyDown() and IsAltKeyDown() and IsShiftKeyDown() then
		return 'ALT-CTRL-SHIFT'
	elseif IsControlKeyDown() and IsAltKeyDown() then
		return 'ALT-CTRL'
	elseif IsControlKeyDown() and IsShiftKeyDown() then
		return 'CTRL-SHIFT'
	elseif IsAltKeyDown() and IsShiftKeyDown() then
		return 'ALT-SHIFT'
	elseif IsControlKeyDown() then
		return 'CTRL'
	elseif IsAltKeyDown() then
		return 'ALT'
	elseif IsShiftKeyDown() then
		return 'SHIFT'
	end
	return nil
end

function ModHighlighter:HighlightModifiers()
	local modifier = nil
	if self:HighlightingModifiers() and self:IsAutoBindingEnabled() then
		modifier = self:GetCurrentModifierCombo()
	end

	if modifier then
		for id, frame in RazerNaga.Frame:GetAll() do
			if self:GetActiveFrameModifier(frame) == modifier then
				frame:ShowHighlight()
			else
				frame:HideHighlight()
			end
		end
	else
		for id, frame in RazerNaga.Frame:GetAll() do
			frame:HideHighlight()
		end
	end
end

function ModHighlighter:FadeBars()
	for id, frame in RazerNaga.Frame:GetAll() do
		if RazerNaga.BindingsLoader:IsAutoBindingEnabled(frame) then
			frame:Fade()
		end
	end
end