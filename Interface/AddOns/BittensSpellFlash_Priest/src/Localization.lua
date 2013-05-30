-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-priest/localization/

local addonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif GetLocale() == "deDE" then -- German
L["Flash Discipline"] = "Aufblitzen bei Disziplin" -- Needs review
L["Flash Holy"] = "Aufblitzen bei Heilig" -- Needs review
L["Flash Shadow"] = "Aufblitzen bei Schatten" -- Needs review
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
L["Flash Discipline"] = "戒律闪光" -- Needs review
L["Flash Holy"] = "神圣闪光" -- Needs review
L["Flash Shadow"] = "暗影闪光" -- Needs review
L["PW: Shield & Binding Heal on Mouseover"] = "真言术:盾&绑定治疗于鼠标指向" -- Needs review

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
L["Flash Discipline"] = "戒律閃光" -- Needs review
L["Flash Holy"] = "神聖閃光" -- Needs review
L["Flash Shadow"] = "暗影閃光" -- Needs review
L["PW: Shield & Binding Heal on Mouseover"] = "真言術:盾&綁定治療到滑鼠遊標" -- Needs review

end