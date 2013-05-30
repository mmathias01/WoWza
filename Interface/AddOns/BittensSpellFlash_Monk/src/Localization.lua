-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-monk/localization/

local addonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""

elseif GetLocale() == "frFR" then -- French
L["Flash Brewmaster"] = "Clignotements pour Maître brasseur" -- Needs review
L["Flash Melee Abilities Above % Mana:"] = "Clignotement des techniques de mêlée si au dessus de % de mana" -- Needs review
L["Flash Mistweaver"] = "Clignotements pour Tisse-brume" -- Needs review
L["Flash Windwalker"] = "Clignotements pour Marche-vent" -- Needs review

elseif GetLocale() == "deDE" then -- German
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
L["Flash Brewmaster"] = "酿酒闪光" -- Needs review
L["Flash Melee Abilities Above % Mana:"] = "近战技能在能量高于 % 时闪光:" -- Needs review
L["Flash Mistweaver"] = "织雾闪光" -- Needs review
L["Flash Windwalker"] = "风行闪光" -- Needs review

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
L["Flash Brewmaster"] = "釀酒閃光" -- Needs review
L["Flash Melee Abilities Above % Mana:"] = "近戰技能在能量值高過 % 時閃光:" -- Needs review
L["Flash Mistweaver"] = "織霧閃光" -- Needs review
L["Flash Windwalker"] = "御風閃光" -- Needs review

end