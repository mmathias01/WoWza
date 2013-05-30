local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, ProfileDB, GlobalDB
local addon, ns = ...
ns.oUF = ElvUF
local oUF = ns.oUF
local LSM = LibStub("LibSharedMedia-3.0");
local EP = LibStub("LibElvUIPlugin-1.0")
local CXP = E:NewModule("CustomXP", "AceTimer-3.0", "AceEvent-3.0")
local M = E:GetModule('Misc');

local floor = math.floor

--Replacement of text formats on unitframes.
local styles = {
	['CURRENT'] = '%s',
	['CURRENT_MAX'] = '%s - %s',
	['CURRENT_PERCENT'] =  '%s ( %s%% )',
	['CURRENT_MAX_PERCENT'] = '%s - %s ( %s%% )',
	['CURRENT_RESTED'] = '%s | R: %s',
	['CURRENT_MAX_RESTED'] = '%s - %s | R: %s',
	['CURRENT_PERCENT_RESTED'] =  '%s ( %s%% ) | R: %s',
	['CURRENT_MAX_PERCENT_RESTED'] = '%s - %s ( %s%% ) | R: %s',
	['TONEXT'] = '%s',
	['BUBBLES'] = '%s',
	['RESTED'] = 'R: %s'
}

P.general.experience["tag"] = "[xp:current-max-percent]"
P.general.reputation["tag"] = "[rep:name]: [rep:standing] ([rep:current-max-percent]"

function CXP:GetFormattedText(style, min, max, rested)
	assert(styles[style], 'Invalid format style: '..style)
	assert(min, 'You need to provide a current value. Usage: E:GetFormattedText(style, min, max)')
	
	if max == 0 then max = 1 end
	
	local useStyle = styles[style]
	
	local percentValue
	if max ~= nil then
		percentValue = floor(min / max * 100)
	end

	if style == 'TONEXT' then
		local deficit = max - min
		if deficit <= 0 then
			return ''
		else
			return string.format(useStyle, deficit)
		end
	elseif style == 'CURRENT' or ((style == 'CURRENT_MAX' or style == 'CURRENT_MAX_PERCENT' or style == 'CURRENT_PERCENT') and min == max) then
			return string.format(styles['CURRENT'], min)
	elseif style == 'CURRENT_MAX' then
			return string.format(useStyle, min, max)
	elseif style == 'CURRENT_PERCENT' then
			return string.format(useStyle, min, percentValue)
	elseif style == 'CURRENT_MAX_PERCENT' then
			return string.format(useStyle, min, max, percentValue)
	elseif style == 'CURRENT_RESTED' or ((style == 'CURRENT_MAX_RESTED' or style == 'CURRENT_MAX_PERCENT_RESTED' or style == 'CURRENT_PERCENT_RESTED') and min == max) then
			return string.format(styles['CURRENT_RESTED'], min, rested)
	elseif style == 'CURRENT_MAX_RESTED' then
			return string.format(useStyle, min, max, rested)
	elseif style == 'CURRENT_PERCENT_RESTED' then
			return string.format(useStyle, min, percentValue, rested)
	elseif style == 'CURRENT_MAX_PERCENT_RESTED' then
			return string.format(useStyle, min, max, percentValue, rested)
	elseif style == "BUBBLES" then
		local bubbles = floor(20 * (max - min) / max)
		return string.format(useStyle, bubbles)
	elseif style == "RESTED" then
		if not rested then rested = 0 end
		return string.format(useStyle,rested)
	end
end

--local current, max = UnitXP("player"), UnitXPMax("player")
--local level = UnitLevel("player")
ElvUF.Tags.Events['xp:current'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)

	return CXP:GetFormattedText('CURRENT', min, max)
end

ElvUF.Tags.Events['xp:tonext'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:tonext'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)

	return CXP:GetFormattedText('TONEXT', min, max)
end

ElvUF.Tags.Events['xp:current-percent'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current-percent'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)

	return CXP:GetFormattedText('CURRENT_PERCENT', min, max)
end

ElvUF.Tags.Events['xp:current-max'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current-max'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)

	return CXP:GetFormattedText('CURRENT_MAX', min, max)
end

ElvUF.Tags.Events['xp:current-max-percent'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current-max-percent'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)

	return CXP:GetFormattedText('CURRENT_MAX_PERCENT', min, max)
end

ElvUF.Tags.Events['xp:rested'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:rested'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)
	local rested = GetXPExhaustion()

	return CXP:GetFormattedText('RESTED',min,max,rested)
end

ElvUF.Tags.Events['xp:current-rested'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current-rested'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)
	local rested = GetXPExhaustion()

	if rested and rested > 0 then
		return CXP:GetFormattedText('CURRENT_RESTED', min, max, rested)
	else 
		return CXP:GetFormattedText('CURRENT', min, max)
	end
end

ElvUF.Tags.Events['xp:current-percent-rested'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current-percent-rested'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)
	local rested = GetXPExhaustion()
	
	if rested and rested > 0 then
		return CXP:GetFormattedText('CURRENT_PERCENT_RESTED', min, max, rested)
	else 
		return CXP:GetFormattedText('CURRENT_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['xp:current-max-rested'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current-max-rested'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)
	local rested = GetXPExhaustion()
	
	if rested and rested > 0 then
		return CXP:GetFormattedText('CURRENT_MAX_RESTED', min, max, rested)
	else 
		return CXP:GetFormattedText('CURRENT_MAX', min, max)
	end
end

ElvUF.Tags.Events['xp:current-max-percent-rested'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:current-max-percent-rested'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)
	local rested = GetXPExhaustion()
	
	if rested and rested > 0 then
		return CXP:GetFormattedText('CURRENT_MAX_PERCENT_RESTED', min, max, rested)
	else 
		return CXP:GetFormattedText('CURRENT_MAX_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['xp:bars'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:bars'] = function(unit)
	local min, max = UnitXP(unit), UnitXPMax(unit)

	return CXP:GetFormattedText('BUBBLES', min, max, rested)
end

ElvUF.Tags.Events['xp:level'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:level'] = function(unit)
	local level = UnitLevel(unit)

	return CXP:GetFormattedText('CURRENT', level)
end

ElvUF.Tags.Events['xp:nextlevel'] = 'PLAYER_XP_UPDATE'
ElvUF.Tags.Methods['xp:nextlevel'] = function(unit)
	local level = UnitLevel(unit)

	return CXP:GetFormattedText('CURRENT', level + 1)
end

ElvUF.Tags.Events['rep:name'] = 'UPDATE_FACTION'
ElvUF.Tags.Methods['rep:name'] = function(unit)
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	
	if not name then return '' end

	return name
end

ElvUF.Tags.Events['rep:standing'] = 'UPDATE_FACTION'
ElvUF.Tags.Methods['rep:standing'] = function(unit)
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	
	if not name then return '' end

	return _G['FACTION_STANDING_LABEL'..reaction]
end

ElvUF.Tags.Events['rep:current'] = 'UPDATE_FACTION'
ElvUF.Tags.Methods['rep:current'] = function(unit)
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	local numFactions = GetNumFactions();
	
	if not name then return '' end

	return CXP:GetFormattedText('CURRENT', value - min, max - min)
end

-- value - min, max - min, (value - min) / (max - min) * 100)

ElvUF.Tags.Events['rep:tonext'] = 'UPDATE_FACTION'
ElvUF.Tags.Methods['rep:tonext'] = function(unit)
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	local numFactions = GetNumFactions();
	
	if not name then return '' end

	return CXP:GetFormattedText('TONEXT', value - min, max - min)
end

ElvUF.Tags.Events['rep:current-percent'] = 'UPDATE_FACTION'
ElvUF.Tags.Methods['rep:current-percent'] = function(unit)
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	local numFactions = GetNumFactions();
	
	if not name then return '' end

	return CXP:GetFormattedText('CURRENT_PERCENT', value - min, max - min)
end

ElvUF.Tags.Events['rep:current-max'] = 'UPDATE_FACTION'
ElvUF.Tags.Methods['rep:current-max'] = function(unit)
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	local numFactions = GetNumFactions();
	
	if not name then return '' end

	return CXP:GetFormattedText('CURRENT_MAX', value - min, max - min)
end

ElvUF.Tags.Events['rep:current-max-percent'] = 'UPDATE_FACTION'
ElvUF.Tags.Methods['rep:current-max-percent'] = function(unit)
	local name, reaction, min, max, value = GetWatchedFactionInfo()
	local numFactions = GetNumFactions();
	
	if not name then return '' end

	return CXP:GetFormattedText('CURRENT_MAX_PERCENT', value - min, max - min)
end

local OnEnter = function(self)
	local check
	local frame
	if self == ElvUI_ExperienceBar then
		check = "xp"
		frame = ElvUI_ExpCustomXP
	elseif self == ElvUI_ReputationBar then
		check = "rep"
		frame = ElvUI_RepCustomXP
	end
	if CXP.mouse[check] then
		for _, fs in pairs(frame.__mousetags) do
		 	fs:SetAlpha(1)
		end
	end
end

local OnLeave = function(self)
	local check
	local frame
	if self == ElvUI_ExperienceBar then
		check = "xp"
		frame = ElvUI_ExpCustomXP
	elseif self == ElvUI_ReputationBar then
		check = "rep"
		frame = ElvUI_RepCustomXP
	end
	if CXP.mouse[check] then
		for _, fs in pairs(frame.__mousetags) do
		 	fs:SetAlpha(0)
		end
	end
end

function CXP:SpawnXPText(frame)
	local parent = _G["ElvUI_ExperienceBar"]
	if not parent then return end

	frame:SetSize(parent:GetSize())
	frame:ClearAllPoints()
	frame:SetAllPoints(parent)
	frame:EnableMouse(false)
	frame:Show()
	frame:SetParent(parent)
	parent:HookScript('OnEnter',OnEnter)
	parent:HookScript('OnLeave',OnLeave)

	local fs = frame:CreateFontString(fsname, "THINOUTLINE")
	-- Dummy font
	fs:FontTemplate(LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, "THINOUTLINE")
	fs:SetJustifyH("CENTER")
	fs:Point("CENTER", frame, "CENTER", 0, 2)
	frame.ExpText = fs
	self.frames['xp'] = frame
end

function CXP:SpawnRepText(frame)
	local parent = _G["ElvUI_ReputationBar"]
	if not parent then return end

	frame:SetSize(parent:GetSize())
	frame:ClearAllPoints()
	frame:SetAllPoints(parent)
	frame:EnableMouse(false)
	frame:Show()
	frame:SetParent(parent)
	parent:HookScript('OnEnter',OnEnter)
	parent:HookScript('OnLeave',OnLeave)

	local fs = frame:CreateFontString(fsname, "THINOUTLINE")
	-- Dummy font
	fs:FontTemplate(LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, "THINOUTLINE")
	fs:SetJustifyH("CENTER")
	fs:SetPoint("CENTER")

	frame.RepText = fs
	self.frames['rep'] = frame

	local f = CreateFrame("Frame")
	f:RegisterEvent("UPDATE_FACTION")
	f:SetScript("OnEvent",function(self,event)
		frame.RepText:UpdateTag()
	end)
end

function CXP:UpdateTag(frameKey)
	local frame = self.frames[frameKey]
	local tagstr
	local key
	if frameKey == 'xp' then
		tagstr = E.db.general.experience.tag
		key = 'ExpText'
		if tagstr:find('%[mouseover%]') then
			self.mouse['xp'] = true
		else
			self.mouse['xp'] = false
		end
	elseif frameKey == 'rep' then
		tagstr = E.db.general.reputation.tag
		key = 'RepText'
		if tagstr:find('%[mouseover%]') then
			self.mouse['rep'] = true
		else
			self.mouse['rep'] = false
		end
	end
	frame:Tag(frame[key],tagstr)
end

function CXP:Initialize()
	E.db.general.experience.textFormat = "NONE"
	E.db.general.reputation.textFormat = "NONE"

	self.mouse = {}
    self.frames = {}
	
	oUF:RegisterStyle('ElvUI_CustomXP',function(frame,unit)
        CXP:SpawnXPText(frame)
    end)

    oUF:SetActiveStyle('ElvUI_CustomXP')
    oUF:Spawn("player", "ElvUI_ExpCustomXP")

    oUF:RegisterStyle('ElvUI_CustomRep',function(frame,unit)
        CXP:SpawnRepText(frame)
    end)

    oUF:SetActiveStyle('ElvUI_CustomRep')
    oUF:Spawn("player", "ElvUI_RepCustomXP")

	self:UpdateTag('xp')
	self:UpdateTag('rep')

	local initOptions = function()
	    E.Options.args.general.args.experience.args.textFormat = nil
	    E.Options.args.general.args.experience.args.tag = {
	        type = 'input',
	        width = 'full',
	        name = L['Text Format'],
	        desc = L['TEXT_FORMAT_DESC'],
	        order = 4,
	        get = function(info) return E.db.general.experience.tag end,
	        set = function(info,value) E.db.general.experience.tag = value; CXP:UpdateTag('xp') end,
		}

		E.Options.args.general.args.reputation.args.textFormat = nil
	    E.Options.args.general.args.reputation.args.tag = {
	        type = 'input',
	        width = 'full',
	        name = L['Text Format'],
	        desc = L['TEXT_FORMAT_DESC'],
	        order = 4,
	        get = function(info) return E.db.general.reputation.tag end,
	        set = function(info,value) E.db.general.reputation.tag = value; CXP:UpdateTag('rep') end,
		}
	end
	EP:RegisterPlugin(addon,initOptions)
end

E:RegisterModule(CXP:GetName())