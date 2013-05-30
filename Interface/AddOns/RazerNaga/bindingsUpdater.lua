--[[
	A frame for managing bindings updating.
	This is useful because in practice, updating binding text generates a lot of CPU usage on action bars
--]]

local BindingsUpdater = CreateFrame('Frame'); BindingsUpdater:Hide()
RazerNaga.BindingsUpdater = BindingsUpdater
BindingsUpdater.enabled = true


function BindingsUpdater:OnEvent(event, ...)
	local a = self[event]
	if a then
		a(self, event, ...)
	end
end

function BindingsUpdater:UPDATE_BINDINGS(event)
	self:UpdateFrames()
	self:UnregisterEvent('UPDATE_BINDINGS')
end

function BindingsUpdater:UpdateFrames()
	if not BindingsUpdater.enabled then return end

	for _, frame in RazerNaga.Frame:GetAll() do
		if frame.UPDATE_BINDINGS then
			frame:UPDATE_BINDINGS()
		end
	end
end

hooksecurefunc('SetBinding', BindingsUpdater.UpdateFrames)
hooksecurefunc('SetBindingClick', BindingsUpdater.UpdateFrames)
hooksecurefunc('SetBindingItem', BindingsUpdater.UpdateFrames)
hooksecurefunc('SetBindingMacro', BindingsUpdater.UpdateFrames)
hooksecurefunc('SetBindingSpell', BindingsUpdater.UpdateFrames)
hooksecurefunc('LoadBindings', BindingsUpdater.UpdateFrames)