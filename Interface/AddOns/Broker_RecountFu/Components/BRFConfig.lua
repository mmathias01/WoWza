-- ============================================================================
-- == BRFConfig - Provides functions for creating, reading, updating and     ==
-- ==             deleting the data used to configure the Broker_RecountFu   ==
-- ==             addon.                                                     ==
-- ============================================================================

BRFConfig      = LibStub("AceAddon-3.0"):NewAddon("BRFConfig", "AceConsole-3.0", "AceEvent-3.0")
local L        = LibStub("AceLocale-3.0"):GetLocale("BrokerRecountFu")

local db       = {} -- Reference variable used to persist data between sessions.
local defaults = {} -- Reference variable used to persist data between sessions.
local options  = {}                -- Used to provide Ace3/Blizzard GUI options.

-- ============================================================================
-- == OnInitialize()                                                         ==
-- ==                                                                        ==
-- == This function is called when the addon is initialised.                 ==
-- ============================================================================

function BRFConfig:OnInitialize()

  BRFConfig:BuildDBTable()
  BRFConfig:BuildOptionsTable()
  BRFConfig:RegisterOptionsTable()
  BRFConfig:SetDefaultPropertyValues()

end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is enabled.                     ==
-- ============================================================================

function BRFConfig:OnEnable()

  -- This is reset upon each OnEnable to correct occasional errors that occur
  -- when new versions are tested on the live servers with other players.
  self.db.profile.maxAddonVersionSeen = L["addon-version-number"]

end

-- ============================================================================
-- == OnDisable()                                                            ==
-- ==                                                                        ==
-- == This function is called when the addon is disabled.                    ==
-- ============================================================================

function BRFConfig:OnDisable()
end

-- ============================================================================
-- == BuildDBTable()                                                         ==
-- ==                                                                        ==
-- == This function builds the default db table. This table is persisted     ==
-- == between sessions by the AceDB library.                                 ==
-- ============================================================================

function BRFConfig:BuildDBTable()

  defaults = {
    profile =  {
      -- General status flags and data values.
      addonName                                   = L["addon-name"],
      isEnabledDebugMode                          = false,
      chatWindowTextMaxWidth                      = 45,
      pulseResting                                = 5,
      pulseCombat                                 = 1,

      favouriteReportIndexNumber1                 = 1,
      favouriteReportIndexNumber2                 = 2,
      favouriteReportIndexNumber3                 = 3,

      numericalSeparatorThousands                 = L["data-numerical-separator-comma"],
      numericalSeparatorDecimals                  = L["data-numerical-separator-period"],

      isEnabledCompactSystemNumbers               = true,
      isEnabledAlwaysShowOneDecimalPlace          = true,
      isEnabledCommaPeriodSeparation              = true,

      -- TextLabel Data Items.
      isEnabledTextLabelLastFightDamageDoneRank   = true,
      isEnabledTextLabelLastFightDamageDone       = true,
      isEnabledTextLabelLastFightDPSRank          = false,
      isEnabledTextLabelLastFightDPS              = false,
      isEnabledTextLabelLastFightHealingDoneRank  = false,
      isEnabledTextLabelLastFightHealingDone      = false,
      isEnabledTextLabelLastFightHPSRank          = false,
      isEnabledTextLabelLastFightHPS              = false,
      isEnabledTextLabelLastFightRaidDamage       = false,
      isEnabledTextLabelLastFightRaidDPS          = false,
      isEnabledTextLabelLastFightRaidHealing      = false,
      isEnabledTextLabelLastFightRaidHPS          = false,
      isEnabledTextLabelLastFightRaidTimeInCombat = false,

      isEnabledTextLabelLastFightOpponentName     = false,

      isEnabledTextLabelOverallDamageDoneRank     = false,
      isEnabledTextLabelOverallDamageDone         = false,
      isEnabledTextLabelOverallDPSRank            = false,
      isEnabledTextLabelOverallDPS                = false,
      isEnabledTextLabelOverallHealingDoneRank    = false,
      isEnabledTextLabelOverallHealingDone        = false,
      isEnabledTextLabelOverallHPSRank            = false,
      isEnabledTextLabelOverallHPS                = false,
      isEnabledTextLabelOverallRaidDamage         = false,
      isEnabledTextLabelOverallRaidDPS            = false,
      isEnabledTextLabelOverallRaidHealing        = false,
      isEnabledTextLabelOverallRaidHPS            = false,
      isEnabledTextLabelOverallRaidTimeInCombat   = false,

      isEnabledTextLabelRankLabel                 = true,
      isEnabledTextLabelAmountLabel               = false,
      isEnabledTextLabelRateLabel                 = false,
      isEnabledTextLabelTimeLabel                 = false,
      isEnabledTextLabelNameLabel                 = false,

      -- Tooltip Data Items.
      isEnabledTooltipDamageLastFight             = true,
      isEnabledTooltipDamageOverall               = true,
      isEnabledTooltipHealingLastFight            = true,
      isEnabledTooltipHealingOverall              = true,
      isEnabledTooltipGroupSummaryLastFight       = true,
      isEnabledTooltipGroupSummaryOverall         = true,
      isEnabledTooltipContentButtonActions        = true,

      tooltipTableSizeLimit                       = 5
    },
  }

  self.db = LibStub("AceDB-3.0"):New("BrokerRecountFuDB", defaults, "Default")

end

-- ============================================================================
-- == BuildOptionsTable()                                                    ==
-- ==                                                                        ==
-- == This function builds the default options table. This table is          ==
-- == used to generate both the command-line options and the configuration   ==
-- == options available through the Blizzard Addons UI by the AceConfig lib. ==
-- ============================================================================

function BRFConfig:BuildOptionsTable()

  options = {
    name = L["addon-name"],
    handler = BRFConfig,
    type = 'group',
    args = {
      isEnabledDebugMode = {
        type = "toggle",
        name = L["cfg-feature-name-debugmode"],
        desc = L["cfg-feature-desc-debugmode"],
        get = "GetIsEnabledDebugMode",
        set = "SetIsEnabledDebugMode",
      },
    },
  }

end

-- ============================================================================
-- == RegisterOptionsTable()                                                 ==
-- ==                                                                        ==
-- == This function registers the default options table.                     ==
-- ============================================================================

function BRFConfig:RegisterOptionsTable()

    LibStub("AceConfig-3.0"):RegisterOptionsTable("Broker_RecountFu", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["addon-name"], L["addon-name"])
    self:RegisterChatCommand(L["cfg-console-command-long"],  "ChatCommand")
    self:RegisterChatCommand(L["cfg-console-command-short"], "ChatCommand")

end

-- ============================================================================
-- == SetDefaultPropertyValues()                                             ==
-- ==                                                                        ==
-- == This function sets internal properties to default values.              ==
-- ============================================================================

function BRFConfig:SetDefaultPropertyValues()

  BRFConfig:SetIsEnabledDebugMode(false, false)

end

-- ============================================================================
-- == ChatCommand(input)                                                     ==
-- ==                                                                        ==
-- == This function responds to calls to the addon via chat commands.        ==
-- ============================================================================

function BRFConfig:ChatCommand(input)

  if not input or input:trim() == "" then
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
  else
    LibStub("AceConfigCmd-3.0").HandleCommand(BrokerRecountFu, L["cfg-console-command-short"], L["addon-name"], input)
  end

end

-- ============================================================================
-- == ToggleValue(value)                                                     ==
-- ==                                                                        ==
-- == Toggles the supplied value.                                            ==
-- ============================================================================

function BRFConfig:ToggleValue(value)

    if value == true then
      return false
    else
      return true
    end

end

-- ============================================================================
-- == ACCESSORS/MUTATORS* only beyond this point.                            ==
-- ==                                                                        ==
-- == The remainder of this file contains the accessors and mutators for the ==
-- == various different variables/data-items managed as part of the          ==
-- == BRFConfig model.                                                       ==
-- ==                                                                        ==
-- == * Also known less formally as 'getters and setters'.                   ==
-- ============================================================================

-- ============================================================================
-- == GetIsEnabledDebugMode(info)                                            ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledDebugMode(info)
    return self.db.profile.isEnabledDebugMode
end

-- ============================================================================
-- == SetIsEnabledDebugMode(info, newValue)                                  ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledDebugMode(info, newValue)
    self.db.profile.isEnabledDebugMode = newValue
end

-- ============================================================================
-- == ToggleIsEnabledDebugMode()                                             ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledDebugMode()
    self.db.profile.isEnabledDebugMode = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledDebugMode(nil))
end

-- ============================================================================
-- == GetChatWindowTextMaxWidth(info)                                        ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetChatWindowTextMaxWidth(info)
    return self.db.profile.chatWindowTextMaxWidth
end

-- ============================================================================
-- == SetChatWindowTextMaxWidth(info, newValue)                              ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetChatWindowTextMaxWidth(info, newValue)
    self.db.profile.chatWindowTextMaxWidth = newValue
end

-- ============================================================================
-- == GetPulseResting(info)                                                  ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetPulseResting(info)
    return self.db.profile.pulseResting
end

-- ============================================================================
-- == SetPulseResting(info, newValue)                                        ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetPulseResting(info, newValue)
    self.db.profile.pulseResting = newValue
end

-- ============================================================================
-- == GetPulseCombat(info)                                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetPulseCombat(info)
    return self.db.profile.pulseCombat
end

-- ============================================================================
-- == SetPulseCombat(info, newValue)                                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetPulseCombat(info, newValue)
    self.db.profile.pulseCombat = newValue
end

-- ============================================================================
-- == GetFavouriteReportIndexNumber1(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetFavouriteReportIndexNumber1(info)
    return self.db.profile.favouriteReportIndexNumber1
end

-- ============================================================================
-- == SetFavouriteReportIndexNumber1(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetFavouriteReportIndexNumber1(info, newValue)
    self.db.profile.favouriteReportIndexNumber1 = newValue
end

-- ============================================================================
-- == GetFavouriteReportIndexNumber2(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetFavouriteReportIndexNumber2(info)
    return self.db.profile.favouriteReportIndexNumber2
end

-- ============================================================================
-- == SetFavouriteReportIndexNumber2(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetFavouriteReportIndexNumber2(info, newValue)
    self.db.profile.favouriteReportIndexNumber2 = newValue
end

-- ============================================================================
-- == GetFavouriteReportIndexNumber3(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetFavouriteReportIndexNumber3(info)
    return self.db.profile.favouriteReportIndexNumber3
end

-- ============================================================================
-- == SetFavouriteReportIndexNumber3(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetFavouriteReportIndexNumber3(info, newValue)
    self.db.profile.favouriteReportIndexNumber3 = newValue
end

-- ============================================================================
-- == GetNumericalSeparatorThousands(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetNumericalSeparatorThousands(info)
    return self.db.profile.numericalSeparatorThousands
end

-- ============================================================================
-- == SetNumericalSeparatorThousands(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetNumericalSeparatorThousands(info, newValue)
    self.db.profile.numericalSeparatorThousands = newValue
end

-- ============================================================================
-- == GetNumericalSeparatorDecimals(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetNumericalSeparatorDecimals(info)
    return self.db.profile.numericalSeparatorDecimals
end

-- ============================================================================
-- == SetNumericalSeparatorDecimals(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetNumericalSeparatorDecimals(info, newValue)
    self.db.profile.numericalSeparatorDecimals = newValue
end

-- ============================================================================
-- == GetIsEnabledCompactSystemNumbers(info)                                 ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledCompactSystemNumbers(info)
    return self.db.profile.isEnabledCompactSystemNumbers
end

-- ============================================================================
-- == SetIsEnabledCompactSystemNumbers(info, newValue)                       ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledCompactSystemNumbers(info, newValue)
    self.db.profile.isEnabledCompactSystemNumbers = newValue
end

-- ============================================================================
-- == ToggleIsEnabledCompactSystemNumbers()                                  ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledCompactSystemNumbers()
    self.db.profile.isEnabledCompactSystemNumbers = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledCompactSystemNumbers(nil))
end

-- ============================================================================
-- == GetIsEnabledAlwaysShowOneDecimalPlace(info)                            ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledAlwaysShowOneDecimalPlace(info)
    return self.db.profile.isEnabledAlwaysShowOneDecimalPlace
end

-- ============================================================================
-- == SetIsEnabledAlwaysShowOneDecimalPlace(info, newValue)                  ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledAlwaysShowOneDecimalPlace(info, newValue)
    self.db.profile.isEnabledAlwaysShowOneDecimalPlace = newValue
end

-- ============================================================================
-- == ToggleIsEnabledAlwaysShowOneDecimalPlace()                             ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledAlwaysShowOneDecimalPlace()
    self.db.profile.isEnabledAlwaysShowOneDecimalPlace = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledAlwaysShowOneDecimalPlace(nil))
end

-- ============================================================================
-- == GetIsEnabledCommaPeriodSeparation(info)                                ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledCommaPeriodSeparation(info)
    return self.db.profile.isEnabledCommaPeriodSeparation
end

-- ============================================================================
-- == SetIsEnabledCommaPeriodSeparation(info, newValue)                      ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledCommaPeriodSeparation(info, newValue)
    self.db.profile.isEnabledCommaPeriodSeparation = newValue
end

-- ============================================================================
-- == ToggleIsEnabledCommaPeriodSeparation()                                 ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledCommaPeriodSeparation()
    self.db.profile.isEnabledCommaPeriodSeparation = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledCommaPeriodSeparation(nil))

    if self.db.profile.isEnabledCommaPeriodSeparation == true then
      BRFConfig:SetNumericalSeparatorThousands(L["data-numerical-separator-comma"], L["data-numerical-separator-comma"])
      BRFConfig:SetNumericalSeparatorDecimals(L["data-numerical-separator-period"], L["data-numerical-separator-period"])
    else
      BRFConfig:SetNumericalSeparatorThousands(L["data-numerical-separator-period"], L["data-numerical-separator-period"])
      BRFConfig:SetNumericalSeparatorDecimals(L["data-numerical-separator-comma"], L["data-numerical-separator-comma"])
    end
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightDamageDoneRank(info)                     ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightDamageDoneRank(info)
    return self.db.profile.isEnabledTextLabelLastFightDamageDoneRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightDamageDoneRank(info, newValue)           ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightDamageDoneRank(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightDamageDoneRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightDamageDoneRank()                      ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightDamageDoneRank()
    self.db.profile.isEnabledTextLabelLastFightDamageDoneRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightDamageDoneRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightDamageDone(info)                         ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightDamageDone(info)
    return self.db.profile.isEnabledTextLabelLastFightDamageDone
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightDamageDone(info, newValue)               ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightDamageDone(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightDamageDone = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightDamageDone()                          ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightDamageDone()
    self.db.profile.isEnabledTextLabelLastFightDamageDone = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightDamageDone(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightDPSRank(info)                            ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightDPSRank(info)
    return self.db.profile.isEnabledTextLabelLastFightDPSRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightDPSRank(info, newValue)                  ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightDPSRank(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightDPSRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightDPSRank()                             ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightDPSRank()
    self.db.profile.isEnabledTextLabelLastFightDPSRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightDPSRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightDPS(info)                                ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightDPS(info)
    return self.db.profile.isEnabledTextLabelLastFightDPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightDPS(info, newValue)                      ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightDPS(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightDPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightDPS()                                 ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightDPS()
    self.db.profile.isEnabledTextLabelLastFightDPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightDPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightHealingDoneRank(info)                    ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightHealingDoneRank(info)
    return self.db.profile.isEnabledTextLabelLastFightHealingDoneRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightHealingDoneRank(info, newValue)          ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightHealingDoneRank(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightHealingDoneRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightHealingDoneRank()                     ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightHealingDoneRank()
    self.db.profile.isEnabledTextLabelLastFightHealingDoneRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightHealingDoneRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightHealingDone(info)                        ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightHealingDone(info)
    return self.db.profile.isEnabledTextLabelLastFightHealingDone
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightHealingDone(info, newValue)              ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightHealingDone(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightHealingDone = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightHealingDone()                         ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightHealingDone()
    self.db.profile.isEnabledTextLabelLastFightHealingDone = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightHealingDone(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightHPSRank(info)                            ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightHPSRank(info)
    return self.db.profile.isEnabledTextLabelLastFightHPSRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightHPSRank(info, newValue)                  ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightHPSRank(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightHPSRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightHPSRank()                             ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightHPSRank()
    self.db.profile.isEnabledTextLabelLastFightHPSRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightHPSRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightHPS(info)                                ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightHPS(info)
    return self.db.profile.isEnabledTextLabelLastFightHPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightHPS(info, newValue)                      ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightHPS(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightHPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightHPS()                                 ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightHPS()
    self.db.profile.isEnabledTextLabelLastFightHPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightHPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightRaidDamage(info)                         ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightRaidDamage(info)
    return self.db.profile.isEnabledTextLabelLastFightRaidDamage
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightRaidDamage(info, newValue)               ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightRaidDamage(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightRaidDamage = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightRaidDamage()                          ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightRaidDamage()
    self.db.profile.isEnabledTextLabelLastFightRaidDamage = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightRaidDamage(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightRaidDPS(info)                            ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightRaidDPS(info)
    return self.db.profile.isEnabledTextLabelLastFightRaidDPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightRaidDPS(info, newValue)                  ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightRaidDPS(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightRaidDPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightRaidDPS()                             ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightRaidDPS()
    self.db.profile.isEnabledTextLabelLastFightRaidDPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightRaidDPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightRaidHealing(info)                        ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightRaidHealing(info)
    return self.db.profile.isEnabledTextLabelLastFightRaidHealing
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightRaidHealing(info, newValue)              ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightRaidHealing(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightRaidHealing = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightRaidHealing()                         ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightRaidHealing()
    self.db.profile.isEnabledTextLabelLastFightRaidHealing = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightRaidHealing(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightRaidHPS(info)                            ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightRaidHPS(info)
    return self.db.profile.isEnabledTextLabelLastFightRaidHPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightRaidHPS(info, newValue)                  ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightRaidHPS(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightRaidHPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightRaidHPS()                             ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightRaidHPS()
    self.db.profile.isEnabledTextLabelLastFightRaidHPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightRaidHPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightRaidTimeInCombat(info)                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightRaidTimeInCombat(info)
    return self.db.profile.isEnabledTextLabelLastFightRaidTimeInCombat
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightRaidTimeInCombat(info, newValue)         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightRaidTimeInCombat(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightRaidTimeInCombat = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightRaidTimeInCombat()                    ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightRaidTimeInCombat()
    self.db.profile.isEnabledTextLabelLastFightRaidTimeInCombat = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightRaidTimeInCombat(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelLastFightOpponentName(info)                       ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelLastFightOpponentName(info)
    return self.db.profile.isEnabledTextLabelLastFightOpponentName
end

-- ============================================================================
-- == SetIsEnabledTextLabelLastFightOpponentName(info, newValue)             ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelLastFightOpponentName(info, newValue)
    self.db.profile.isEnabledTextLabelLastFightOpponentName = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelLastFightOpponentName()                        ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelLastFightOpponentName()
    self.db.profile.isEnabledTextLabelLastFightOpponentName = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelLastFightOpponentName(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallDamageDoneRank(info)                       ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallDamageDoneRank(info)
    return self.db.profile.isEnabledTextLabelOverallDamageDoneRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallDamageDoneRank(info, newValue)             ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallDamageDoneRank(info, newValue)
    self.db.profile.isEnabledTextLabelOverallDamageDoneRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallDamageDoneRank()                        ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallDamageDoneRank()
    self.db.profile.isEnabledTextLabelOverallDamageDoneRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallDamageDoneRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallDamageDone(info)                           ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallDamageDone(info)
    return self.db.profile.isEnabledTextLabelOverallDamageDone
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallDamageDone(info, newValue)                 ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallDamageDone(info, newValue)
    self.db.profile.isEnabledTextLabelOverallDamageDone = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallDamageDone()                            ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallDamageDone()
    self.db.profile.isEnabledTextLabelOverallDamageDone = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallDamageDone(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallDPSRank(info)                              ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallDPSRank(info)
    return self.db.profile.isEnabledTextLabelOverallDPSRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallDPSRank(info, newValue)                    ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallDPSRank(info, newValue)
    self.db.profile.isEnabledTextLabelOverallDPSRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallDPSRank()                               ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallDPSRank()
    self.db.profile.isEnabledTextLabelOverallDPSRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallDPSRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallDPS(info)                                  ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallDPS(info)
    return self.db.profile.isEnabledTextLabelOverallDPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallDPS(info, newValue)                        ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallDPS(info, newValue)
    self.db.profile.isEnabledTextLabelOverallDPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallDPS()                                   ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallDPS()
    self.db.profile.isEnabledTextLabelOverallDPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallDPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallHealingDoneRank(info)                      ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallHealingDoneRank(info)
    return self.db.profile.isEnabledTextLabelOverallHealingDoneRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallHealingDoneRank(info, newValue)            ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallHealingDoneRank(info, newValue)
    self.db.profile.isEnabledTextLabelOverallHealingDoneRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallHealingDoneRank()                       ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallHealingDoneRank()
    self.db.profile.isEnabledTextLabelOverallHealingDoneRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallHealingDoneRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallHealingDone(info)                          ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallHealingDone(info)
    return self.db.profile.isEnabledTextLabelOverallHealingDone
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallHealingDone(info, newValue)                ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallHealingDone(info, newValue)
    self.db.profile.isEnabledTextLabelOverallHealingDone = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallHealingDone()                           ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallHealingDone()
    self.db.profile.isEnabledTextLabelOverallHealingDone = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallHealingDone(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallHPSRank(info)                              ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallHPSRank(info)
    return self.db.profile.isEnabledTextLabelOverallHPSRank
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallHPSRank(info, newValue)                    ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallHPSRank(info, newValue)
    self.db.profile.isEnabledTextLabelOverallHPSRank = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallHPSRank()                               ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallHPSRank()
    self.db.profile.isEnabledTextLabelOverallHPSRank = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallHPSRank(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallHPS(info)                                  ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallHPS(info)
    return self.db.profile.isEnabledTextLabelOverallHPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallHPS(info, newValue)                        ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallHPS(info, newValue)
    self.db.profile.isEnabledTextLabelOverallHPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallHPS()                                   ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallHPS()
    self.db.profile.isEnabledTextLabelOverallHPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallHPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallRaidDamage(info)                           ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallRaidDamage(info)
    return self.db.profile.isEnabledTextLabelOverallRaidDamage
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallRaidDamage(info, newValue)                 ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallRaidDamage(info, newValue)
    self.db.profile.isEnabledTextLabelOverallRaidDamage = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallRaidDamage()                            ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallRaidDamage()
    self.db.profile.isEnabledTextLabelOverallRaidDamage = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallRaidDamage(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallRaidDPS(info)                              ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallRaidDPS(info)
    return self.db.profile.isEnabledTextLabelOverallRaidDPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallRaidDPS(info, newValue)                    ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallRaidDPS(info, newValue)
    self.db.profile.isEnabledTextLabelOverallRaidDPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallRaidDPS()                               ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallRaidDPS()
    self.db.profile.isEnabledTextLabelOverallRaidDPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallRaidDPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallRaidHealing(info)                          ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallRaidHealing(info)
    return self.db.profile.isEnabledTextLabelOverallRaidHealing
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallRaidHealing(info, newValue)                ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallRaidHealing(info, newValue)
    self.db.profile.isEnabledTextLabelOverallRaidHealing = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallRaidHealing()                           ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallRaidHealing()
    self.db.profile.isEnabledTextLabelOverallRaidHealing = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallRaidHealing(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallRaidHPS(info)                              ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallRaidHPS(info)
    return self.db.profile.isEnabledTextLabelOverallRaidHPS
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallRaidHPS(info, newValue)                    ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallRaidHPS(info, newValue)
    self.db.profile.isEnabledTextLabelOverallRaidHPS = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallRaidHPS()                               ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallRaidHPS()
    self.db.profile.isEnabledTextLabelOverallRaidHPS = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallRaidHPS(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelOverallRaidTimeInCombat(info)                                                  ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelOverallRaidTimeInCombat(info)
    return self.db.profile.isEnabledTextLabelOverallRaidTimeInCombat
end

-- ============================================================================
-- == SetIsEnabledTextLabelOverallRaidTimeInCombat(info, newValue)                                        ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelOverallRaidTimeInCombat(info, newValue)
    self.db.profile.isEnabledTextLabelOverallRaidTimeInCombat = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelOverallRaidTimeInCombat()                                                   ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelOverallRaidTimeInCombat()
    self.db.profile.isEnabledTextLabelOverallRaidTimeInCombat = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelOverallRaidTimeInCombat(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelRankLabel(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelRankLabel(info)
    return self.db.profile.isEnabledTextLabelRankLabel
end

-- ============================================================================
-- == SetIsEnabledTextLabelRankLabel(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelRankLabel(info, newValue)
    self.db.profile.isEnabledTextLabelRankLabel = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelRankLabel()                                    ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelRankLabel()
    self.db.profile.isEnabledTextLabelRankLabel = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelRankLabel(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelAmountLabel(info)                                 ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelAmountLabel(info)
    return self.db.profile.isEnabledTextLabelAmountLabel
end

-- ============================================================================
-- == SetIsEnabledTextLabelAmountLabel(info, newValue)                       ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelAmountLabel(info, newValue)
    self.db.profile.isEnabledTextLabelAmountLabel = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelAmountLabel()                                  ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelAmountLabel()
    self.db.profile.isEnabledTextLabelAmountLabel = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelAmountLabel(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelRateLabel(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelRateLabel(info)
    return self.db.profile.isEnabledTextLabelRateLabel
end

-- ============================================================================
-- == SetIsEnabledTextLabelRateLabel(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelRateLabel(info, newValue)
    self.db.profile.isEnabledTextLabelRateLabel = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelRateLabel()                                    ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelRateLabel()
    self.db.profile.isEnabledTextLabelRateLabel = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelRateLabel(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelTimeLabel(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelTimeLabel(info)
    return self.db.profile.isEnabledTextLabelTimeLabel
end

-- ============================================================================
-- == SetIsEnabledTextLabelTimeLabel(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelTimeLabel(info, newValue)
    self.db.profile.isEnabledTextLabelTimeLabel = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelTimeLabel()                                    ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelTimeLabel()
    self.db.profile.isEnabledTextLabelTimeLabel = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelTimeLabel(nil))
end

-- ============================================================================
-- == GetIsEnabledTextLabelNameLabel(info)                                   ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTextLabelNameLabel(info)
    return self.db.profile.isEnabledTextLabelNameLabel
end

-- ============================================================================
-- == SetIsEnabledTextLabelNameLabel(info, newValue)                         ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTextLabelNameLabel(info, newValue)
    self.db.profile.isEnabledTextLabelNameLabel = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTextLabelNameLabel()                                    ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTextLabelNameLabel()
    self.db.profile.isEnabledTextLabelNameLabel = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTextLabelNameLabel(nil))
end

-- ============================================================================
-- == GetIsEnabledTooltipDamageLastFight(info)                               ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTooltipDamageLastFight(info)
    return self.db.profile.isEnabledTooltipDamageLastFight
end

-- ============================================================================
-- == SetIsEnabledTooltipDamageLastFight(info, newValue)                     ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTooltipDamageLastFight(info, newValue)
    self.db.profile.isEnabledTooltipDamageLastFight = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTooltipDamageLastFight()                                ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTooltipDamageLastFight()
    self.db.profile.isEnabledTooltipDamageLastFight = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTooltipDamageLastFight(nil))
end

-- ============================================================================
-- == GetIsEnabledTooltipDamageOverall(info)                                 ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTooltipDamageOverall(info)
    return self.db.profile.isEnabledTooltipDamageOverall
end

-- ============================================================================
-- == SetIsEnabledTooltipDamageOverall(info, newValue)                       ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTooltipDamageOverall(info, newValue)
    self.db.profile.isEnabledTooltipDamageOverall = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTooltipDamageOverall()                                  ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTooltipDamageOverall()
    self.db.profile.isEnabledTooltipDamageOverall = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTooltipDamageOverall(nil))
end

-- ============================================================================
-- == GetIsEnabledTooltipHealingLastFight(info)                              ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTooltipHealingLastFight(info)
    return self.db.profile.isEnabledTooltipHealingLastFight
end

-- ============================================================================
-- == SetIsEnabledTooltipHealingLastFight(info, newValue)                    ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTooltipHealingLastFight(info, newValue)
    self.db.profile.isEnabledTooltipHealingLastFight = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTooltipHealingLastFight()                               ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTooltipHealingLastFight()
    self.db.profile.isEnabledTooltipHealingLastFight = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTooltipHealingLastFight(nil))
end

-- ============================================================================
-- == GetIsEnabledTooltipHealingOverall(info)                                ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTooltipHealingOverall(info)
    return self.db.profile.isEnabledTooltipHealingOverall
end

-- ============================================================================
-- == SetIsEnabledTooltipHealingOverall(info, newValue)                      ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTooltipHealingOverall(info, newValue)
    self.db.profile.isEnabledTooltipHealingOverall = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTooltipHealingOverall()                                 ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTooltipHealingOverall()
    self.db.profile.isEnabledTooltipHealingOverall = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTooltipHealingOverall(nil))
end

-- ============================================================================
-- == GetIsEnabledTooltipGroupSummaryLastFight(info)                         ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTooltipGroupSummaryLastFight(info)
    return self.db.profile.isEnabledTooltipGroupSummaryLastFight
end

-- ============================================================================
-- == SetIsEnabledTooltipGroupSummaryLastFight(info, newValue)               ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTooltipGroupSummaryLastFight(info, newValue)
    self.db.profile.isEnabledTooltipGroupSummaryLastFight = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTooltipGroupSummaryLastFight()                          ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTooltipGroupSummaryLastFight()
    self.db.profile.isEnabledTooltipGroupSummaryLastFight = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTooltipGroupSummaryLastFight(nil))
end

-- ============================================================================
-- == GetIsEnabledTooltipGroupSummaryOverall(info)                           ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTooltipGroupSummaryOverall(info)
    return self.db.profile.isEnabledTooltipGroupSummaryOverall
end

-- ============================================================================
-- == SetIsEnabledTooltipGroupSummaryOverall(info, newValue)                 ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTooltipGroupSummaryOverall(info, newValue)
    self.db.profile.isEnabledTooltipGroupSummaryOverall = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTooltipGroupSummaryOverall()                            ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTooltipGroupSummaryOverall()
    self.db.profile.isEnabledTooltipGroupSummaryOverall = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTooltipGroupSummaryOverall(nil))
end

-- ============================================================================
-- == GetIsEnabledTooltipContentButtonActions(info)                          ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledTooltipContentButtonActions(info)
    return self.db.profile.isEnabledTooltipContentButtonActions
end

-- ============================================================================
-- == SetIsEnabledTooltipContentButtonActions(info, newValue)                ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledTooltipContentButtonActions(info, newValue)
    self.db.profile.isEnabledTooltipContentButtonActions = newValue
end

-- ============================================================================
-- == ToggleIsEnabledTooltipContentButtonActions()                           ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledTooltipContentButtonActions()
    self.db.profile.isEnabledTooltipContentButtonActions = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledTooltipContentButtonActions(nil))
end

-- ============================================================================
-- == GetTooltipSizeLimit(info)                                              ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetTooltipSizeLimit(info)
    return self.db.profile.tooltipSizeLimit
end

-- ============================================================================
-- == SetTooltipSizeLimit(info, newValue)                                    ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetTooltipSizeLimit(info, newValue)
    self.db.profile.tooltipSizeLimit = newValue
end

-- ============================================================================
-- == GetIsEnabledXXX(info)                                                  ==
-- ==                                                                        ==
-- == Standard accessor function for the named property.                     ==
-- ============================================================================

function BRFConfig:GetIsEnabledXXX(info)
    return self.db.profile.isEnabledXXX
end

-- ============================================================================
-- == SetIsEnabledXXX(info, newValue)                                        ==
-- ==                                                                        ==
-- == Standard mutator function for the named property.                      ==
-- ============================================================================

function BRFConfig:SetIsEnabledXXX(info, newValue)
    self.db.profile.isEnabledXXX = newValue
end

-- ============================================================================
-- == ToggleIsEnabledXXX()                                                   ==
-- ==                                                                        ==
-- == Toggles the value of the named property.                               ==
-- ============================================================================

function BRFConfig:ToggleIsEnabledXXX()
    self.db.profile.isEnabledXXX = BRFConfig:ToggleValue(BRFConfig:GetIsEnabledXXX(nil))
end
