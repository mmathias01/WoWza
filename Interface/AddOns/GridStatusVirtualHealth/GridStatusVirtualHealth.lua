--[[--------------------------------------------------------------------
	GridStatusVirtualHealth by Zid & Figâ EU-Krag'jin	
-- Create Date    : 12/04/2013 13:44:25
-- 5.3.0
-- Version 1.0.0
----------------------------------------------------------------------]]

local _
local L = Grid.L

local settings

local GridRoster = Grid:GetModule("GridRoster")
local frame = CreateFrame("Frame")
frame:Show();
local GridStatusVirtualHealth = Grid:NewStatusModule("GridStatusVirtualHealth")
GridStatusVirtualHealth.menuName = "GridStatusVirtualHealth"
GridStatusVirtualHealth.options = false

GridStatusVirtualHealth.defaultDB = {
	alert_virtual_health = {
		enable = true,
		priority = 50,
		range = false,
		color = { r = 0, g = 1, b = 0, a = 1 },
		text = "+%s",
		icon = nil,
		ignore_self = false,
		minimumValue = 0.1,
	},
}
frame:SetScript("OnUpdate",function()
	 if IsInRaid() then
	 	for i=1, 40 do
	 		if UnitGUID("raid"..i) ~= nil then
	 			local maxHealth = UnitHealthMax("raid"..i)
	 			GridStatusVirtualHealth:UpdateUnit(event, "raid"..i)
	 		end
	 	end 
	 else
	 	if UnitGUID("player") ~= nil then
	 			local maxHealth = UnitHealthMax("player")
	 			GridStatusVirtualHealth:UpdateUnit(event, "player")
	 		end
	 	for i=1, 4 do
	 		if UnitGUID("party"..i) ~= nil then
	 			local maxHealth = UnitHealthMax("party"..i)
	 			GridStatusVirtualHealth:UpdateUnit(event, "party"..i)
	 		end
	 	end 
	 end
end

 )

local vhOptions = {
	ignoreSelf = {
		type = "toggle", width = "double",
		name = L["Ignore Self"],
		desc = L["Ignore heals cast by you."],
		get = function()
			return GridStatusVirtualHealth.db.profile.alert_virtual_health.ignore_self
		end,
		set = function(_, v)
			GridStatusVirtualHealth.db.profile.alert_virtual_health.ignore_self = v
			GridStatusVirtualHealth:UpdateAllUnits()
		end,
	},
	minimumValue = {
		width = "double",
		type = "range", min = 0, max = 0.5, step = 0.05, isPercent = true,
		name = L["Minimum Value"],
		desc = L["Only show incoming heals greater than this percent of the unit's maximum health."],
		get = function()
			return GridStatusVirtualHealth.db.profile.alert_virtual_health.minimumValue
		end,
		set = function(_, v)
			GridStatusVirtualHealth.db.profile.alert_virtual_health.minimumValue = v
		end,
	},
}

function GridStatusVirtualHealth:PostInitialize()
	settings = GridStatusVirtualHealth.db.profile.alert_virtual_health
	if settings.minimumValue > 0.5 then
		settings.minimumValue = 0.1
	end
-- create a hidden tooltip
	CreateFrame( "GameTooltip", "GSAS_Scantip", nil, "GameTooltipTemplate" ); 
	GSAS_Scantip:SetOwner(UIParent, "ANCHOR_NONE")
	GSAS_Scantip:AddFontStrings(
					GSAS_Scantip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
					GSAS_Scantip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );
	self:RegisterStatus("alert_virtual_health", "Virtual Health", vhOptions, true)
end

function GridStatusVirtualHealth:OnStatusEnable(status)
	if status == "alert_virtual_health" then
		self:UpdateAllUnits()
	end
end

function GridStatusVirtualHealth:OnStatusDisable(status)
	if status == "alert_virtual_health" then
		self.core:SendStatusLostAllUnits("alert_virtual_health")
	end
end

function GridStatusVirtualHealth:PostReset()
	settings = GridStatusVirtualHealth.db.profile.alert_virtual_health
	self:UpdateAllUnits()
end

function GridStatusVirtualHealth:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit("UpdateAllUnits", unitid)
	end
end

local UnitGetIncomingHeals, UnitGUID, UnitHealth, UnitHealthMax, UnitIsDeadOrGhost = UnitGetIncomingHeals, UnitGUID, UnitHealth, UnitHealthMax, UnitIsDeadOrGhost

function GridStatusVirtualHealth:UpdateUnit(event, unitid)
	if UnitExists(unitid) then
		guid = UnitGUID(unitid)
	else return end

	if not GridRoster:IsGUIDInRaid(guid) then return end

	if not UnitIsDeadOrGhost(unitid) then
		local incoming = UnitGetIncomingHeals(unitid) or 0

		if incoming > 0 and settings.ignore_self then
			incoming = incoming - (UnitGetIncomingHeals(unitid, "player") or 0)
		end
		local maxHealth = UnitHealthMax(unitid)
		if incoming > 0 then			
			return self:SendIncomingHealsStatus(guid, incoming+UnitGetTotalAbsorbs(unitid), UnitHealth(unitid) + incoming + UnitGetTotalAbsorbs(unitid), maxHealth)
		end
		if (incoming+UnitGetTotalAbsorbs(unitid)) < 1 then
			return self.core:SendStatusLost(guid, "alert_virtual_health")
		end
		return self:SendIncomingHealsStatus(guid, 0+UnitGetTotalAbsorbs(unitid), UnitHealth(unitid)+UnitGetTotalAbsorbs(unitid), maxHealth)
		
	end

	--self.core:SendStatusLost(guid, "alert_virtual_health")
end

function GridStatusVirtualHealth:SendIncomingHealsStatus(guid, incoming, estimatedHealth, maxHealth)
	local incomingText = incoming
	if incoming > 9999 then
		incomingText = format("%.0fk", incoming / 1000)
	elseif incoming > 999 then
		incomingText = format("%.1fk", incoming / 1000)
	end
	self.core:SendStatusGained(guid, "alert_virtual_health",
		settings.priority,
		settings.range,
		settings.color,
		format(settings.text, incomingText),
		estimatedHealth,
		maxHealth,
		settings.icon)
end
	