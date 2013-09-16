-- ============================================================================
-- == BRFCommon - A collection of common functions used throughout the       ==
-- ==             BrokerRecountFu addon.                                     ==
-- ============================================================================

BRFCommon = LibStub("AceAddon-3.0"):NewAddon("BRFCommon", "AceConsole-3.0", "AceEvent-3.0")
local L   = LibStub("AceLocale-3.0"):GetLocale("BrokerRecountFu")

-- ============================================================================
-- == OnInitialize()                                                         ==
-- ==                                                                        ==
-- == This function is called when the addon is initialised.                 ==
-- ============================================================================

function BRFCommon:OnInitialize()
end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is enabled.                     ==
-- ============================================================================

function BRFCommon:OnEnable()
end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is disabled.                    ==
-- ============================================================================

function BRFCommon:OnDisable()
end

-- ============================================================================
-- ==  IsPlayerInParty()                                                     ==
-- ==                                                                        ==
-- == This function determines whether the player is currently in a party or ==
-- == not and returns true if the player is in a party, false otherwise.     ==
-- ============================================================================

function BRFCommon:IsPlayerInParty()

  local isInGroup = IsInGroup()

  if isInGroup == true then
    return true
  else
    return false
  end

end

-- ============================================================================
-- ==  IsPlayerInRaid()                                                      ==
-- ==                                                                        ==
-- == This function determines whether the player is currently in a raid or  ==
-- == not and returns true if the player is in a raid, false otherwise.      ==
-- ============================================================================

function BRFCommon:IsPlayerInRaid()

  local isInRaid  = IsInRaid()

  if isInRaid == true then
    return true
  else
    return false
  end

end

-- ============================================================================
-- == ColourByClass(className)                                               ==
-- ==                                                                        ==
-- == This function returns the colour-string suggested by the supplied      ==
-- == className parameter or returs the colour-string representing white.    ==
-- ============================================================================

function BRFCommon:ColourByClass(className)

  local colourText = "|cffffffff"

  if className == nil then return colourText end

  if string.lower(className) == string.lower(L["cmn-classname-functional-deathknight"]) then colourText = "|cffc41f3b" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-druid"])       then colourText = "|cffff7d0a" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-hunter"])      then colourText = "|cffabd473" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-mage"])        then colourText = "|cff69ccf0" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-monk"])        then colourText = "|cff00ff96" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-paladin"])     then colourText = "|cfff58cba" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-priest"])      then colourText = "|cffffffff" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-rogue"])       then colourText = "|cfffff569" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-shaman"])      then colourText = "|cff0070de" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-warrior"])     then colourText = "|cffc79c6e" end
  if string.lower(className) == string.lower(L["cmn-classname-functional-warlock"])     then colourText = "|cff9482c9" end

  return colourText

end
