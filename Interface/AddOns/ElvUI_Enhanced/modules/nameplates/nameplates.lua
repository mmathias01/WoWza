local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local NP = E:GetModule('NamePlates')
local LSM = LibStub("LibSharedMedia-3.0")

local UnitCanAttack, UnitDetailedThreatSituation, GetThreatStatusColor = UnitCanAttack, UnitDetailedThreatSituation, GetThreatStatusColor
local format = string.format

function Hex(r, g, b)
	return format('|cFF%02x%02x%02x', r * 255, g * 255, b * 255)
end

hooksecurefunc(NP, 'SkinPlate', function(self, frame, nameFrame)
	if not frame.hp.threat then
		frame.hp.threat = frame.hp:CreateFontString(nil, "OVERLAY")
		frame.hp.threat:SetPoint("RIGHT", frame.hp, "RIGHT", -1, 1)
	end
	frame.hp.threat:FontTemplate(LSM:Fetch("font", self.db.font), self.db.fontSize, self.db.fontOutline)
end)

hooksecurefunc(NP, 'UpdateThreat', function(self, frame)
	if frame.hp.threat then
		frame.hp.threat:SetText()

		if self.db.showthreat then
			local unit = frame.unit
			if not unit then
				for i=1, 4 do
					if frame.guid == UnitGUID(('boss%d'):format(i)) then
						unit = ('boss%d'):format(i)
						break
					end
				end
			end

			if unit and not UnitIsPlayer(unit) and UnitCanAttack('player', unit) then
				local status, percent = select(2, UnitDetailedThreatSituation('player', unit))
				if (status) then
					frame.hp.threat:SetFormattedText('%s%.0f%%|r', Hex(GetThreatStatusColor(status)), percent)
				else
					frame.hp.threat:SetFormattedText('|cFF808080%s|r', L["None"])
				end
			end
		end
	end
end)
