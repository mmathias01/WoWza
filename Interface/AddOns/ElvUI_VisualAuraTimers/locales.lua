-- English localization file for enUS and enGB.
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "enUS", true);

if not L then return end
L['Above Icons'] = true;
L["Always Show Text"] = true;
L['Below Icons'] = true;
L["Buffs Threshold"] = true;
L["Buffs"] = true;
L['Changes the statusbar to use a static color instead of going from green to red the lower duration it has.'] = true;
L['Choose where you want the statusbar to be positioned. If you position it on the left or right side of the icon I advice you to increase Horizontal Spacing for Buffs and Debuffs. Changing this requires you to reload UI.'] = true;
L['Choose which color you want your statusbars to use.'] = true;
L["Debuffs Threshold"] = true;
L["Debuffs"] = true;
L['Enable Static Color'] = true;
L["Height of the statusbar frame (default: 5). Changing this requires you to reload UI."] = true;
L["If enabled, the timers on your buffs will switch to text when duration goes below set threshold."] = true;
L["If enabled, the timers on your debuffs will switch to text when duration goes below set threshold."] = true;
L["If enabled, the timers on your temporary enchant(s) will switch to text when duration goes below set threshold."] = true;
L['Left Side of Icons'] = true;
L["No Duration"] = true;
L['Right Side of Icons'] = true;
L["Show bars for auras without a duration."] = true;
L['Show text in addition to statusbars. (You might need to move the text by changing the offset in the Buffs and Debuffs section)'] = true;
L["Show timers as bars instead of text."] = true;
L['Statusbar Color'] = true;
L["Statusbar Height"] = true;
L['Statusbar Options'] = true;
L['Statusbar Position'] = true;
L['Statusbar Width'] = true;
L["Switch to text based timers when duration goes below threshold"] = true;
L["Temp. Threshold"] = true;
L["Temporary Enchants"] = true;
L['Text Options'] = true;
L["Text Threshold"] = true;
L["Threshold in seconds before status bar based timers turn to text."] = true;
L["Visual Timers"] = true;
L['Width of the statusbar frame (default: 6). Changing this requires you to reload UI.'] = true;

--We don't need the rest if we're on enUS or enGB locale, so stop here.
if GetLocale() == "enUS" then return end

--German Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "deDE")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Spanish (Spain) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "esES")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Spanish (Mexico) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "esMX")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--French Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "frFR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Italian Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "itIT")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Korean Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "koKR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Portuguese Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "ptBR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Russian Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "ruRU")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Chinese (China, simplified) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "zhCN")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Chinese (Taiwan, traditional) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "zhTW")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end