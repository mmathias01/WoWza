-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Editbox History", "AceHook-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Editbox History"]
Module.namespace = string.gsub(Module.name, " ", "")

local insert, remove = table.insert, table.remove

local history, enabled = {}, false
local db
local editBox = DEFAULT_CHAT_FRAME.editBox
local defaults = {
	char = {
		history = {}
	}
}

function Module:AddHistoryLine(object, line)
	if not self:IsEnabled() or not enabled then return end
	
	local history = history
	insert(history, line)
	
	for i = 1, #history - object:GetHistoryLines() do
		remove(history, 1)
	end
end

function Module:OnEnable()
	enabled = false
	for _, line in ipairs(history) do
		editBox:AddHistoryLine(line)
	end
	enabled = true
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	history = self.db.char.history
	self:SecureHook(editBox, "AddHistoryLine")
	self.debug = ElvUI_ChatTweaks.db.profile.debugging
end

function Module:Info()
	return L["Remembers the history of the editbox across sessions."]
end