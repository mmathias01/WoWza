-- ============================================================================
-- == Broker_RecountFu - This addon is a Broker/LDB display addon for users  ==
-- ==                    of the Recount damage meter. Although Recount does  ==
-- ==                    ship with native support for Broker/LDB compatible  ==
-- ==                    displays, it only offers the ability to show/hide   ==
-- ==                    the main Recount window via its display object.     ==
-- ==                                                                        ==
-- == By comparison, this Broker/LDB display object provides additional      ==
-- == features in addition to those available in the standard Recount        ==
-- == provided object. Additional features include, but are not limited to:  ==
-- ==                                                                        ==
-- == 1: Configurable Icon Text. (Addon-name, DPS, HPS, etc.)                ==
-- == 2: Configurable Tooltip Information. (DPS, HPS, etc.)                  ==
-- == 3: Right-click menu offering direct access to Recount views/displays.  ==
-- ==                                                                        ==
-- == Broker_RecountFu is the successor to the earlier FuBar_RecountFu. The  ==
-- == latter is a FuBar plugin for Recount users, based on the earlier Ace2, ==
-- == FuBar and Dewdrop libraries. Broker_RecountFu is an update that bases  ==
-- == itself on the Ace3 and LibDataBroker (LDB) libraries. Although other   ==
-- == Broker-compatible displays for Recount are available, few or none of   ==
-- == these alternatives offer the level of features that FuBar_RecountFu    ==
-- == does. User feedback indicated that many players were postponing a full ==
-- == migration away from FuBar (no longer being actively developed) to a    ==
-- == Broker/LDB compatible display (eg: ChocolateBar, TitanPanel) in order  ==
-- == to retain access to these features.                                    ==
-- ==                                                                        ==
-- == It is hoped that this addon offers a suitable upgrade path for those   ==
-- == users wishing to migrate away from FuBar whilst retaining all the      ==
-- == functionality of FuBar_RecountFu. It should be noted however that      ==
-- == this addon should continue to be useable by FuBar users via the        ==
-- == Broker2FuBar addon.                                                    ==
-- ==                                                                        ==
-- == Home-Page: http://www.wowace.com/addons/Broker_RecountFu               ==
-- == SVN......: svn://svn.wowace.com/wow/broker_recountfu/mainline/trunk    ==
-- == Download.: http://wow.curse.com/addons/wow/Broker_RecountFu            ==
-- == Author...: broliant@broliant.com                                       ==
-- ============================================================================

BrokerRecountFu    = LibStub("AceAddon-3.0"):NewAddon("BrokerRecountFu", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L            = LibStub("AceLocale-3.0"):GetLocale("BrokerRecountFu")

local DropDownMenu = CreateFrame("Frame", "DropDownMenu")      -- Dropdown Menu
local info         = {}                                -- Dropdown Menu Options

local brokerObject = {}                        -- References the broker object.
local taskHandleHB = ""            -- Stores the handle for the heartbeat task.

-- ============================================================================
-- == OnInitialize()                                                         ==
-- ==                                                                        ==
-- == This function is called when the addon is initialised.                 ==
-- ============================================================================

function BrokerRecountFu:OnInitialize()

  self:CancelAllTimers()

end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is enabled.                     ==
-- ============================================================================

function BrokerRecountFu:OnEnable()

  -- Subscribe to the events which this component monitors.
  self:RegisterEvent("PLAYER_REGEN_ENABLED")
  self:RegisterEvent("PLAYER_REGEN_DISABLED")

  BrokerRecountFu:CreateDataObject()

  BrokerRecountFu:AdjustHeartRate()

end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is disabled.                    ==
-- ============================================================================

function BrokerRecountFu:OnDisable()

  self:CancelAllTimers()

end

-- ============================================================================
-- == PLAYER_REGEN_ENABLED()                                                 ==
-- ==                                                                        ==
-- == This function is triggered when the player leaves combat.              ==
-- ============================================================================

function BrokerRecountFu:PLAYER_REGEN_ENABLED()

  BrokerRecountFu:RestartHeart(BRFConfig:GetPulseResting(nil))

end

-- ============================================================================
-- == PLAYER_REGEN_DISABLED()                                                ==
-- ==                                                                        ==
-- == This function is triggered when the player enters combat.              ==
-- ============================================================================

function BrokerRecountFu:PLAYER_REGEN_DISABLED()

  BrokerRecountFu:RestartHeart(BRFConfig:GetPulseCombat(nil))

end

-- ============================================================================
-- == AdjustHeartRate()                                                      ==
-- ==                                                                        ==
-- == This function allows the rate at which the heartbeat occurs. Typically ==
-- == this function will be called after the player makes a configuration    ==
-- == change to either of the resting or combat interval pulse settings.     ==
-- ============================================================================

function BrokerRecountFu:AdjustHeartRate()

  if Recount.InCombat then
    BrokerRecountFu:RestartHeart(BRFConfig:GetPulseCombat(nil))
  else
    BrokerRecountFu:RestartHeart(BRFConfig:GetPulseResting(nil))
  end

end

-- ============================================================================
-- == RestartHeart(interval)                                                 ==
-- ==                                                                        ==
-- == This function starts/restarts the addon's heartbeat with the supplied  ==
-- == interval value. (interval = time-in-seconds.)                          ==
-- ============================================================================

function BrokerRecountFu:RestartHeart(interval)

  self:CancelAllTimers()

  taskHandleHB = self:ScheduleRepeatingTimer("DoHeartbeat", interval, interval)

end

-- ============================================================================
-- == DoHeartbeat()                                                          ==
-- ==                                                                        ==
-- == This function performs all tasks that are required to be repeated on a ==
-- == periodic basis.                                                        ==
-- ============================================================================

function BrokerRecountFu:DoHeartbeat(interval)

  BRFConsole:Debug("DoHeartbeat(" .. interval .. ") called.")

  BrokerRecountFu:BuildTextLabel()

end

-- ============================================================================
-- == CreateDataObject()                                                     ==
-- ==                                                                        ==
-- == This function creates the LDB data object.                             ==
-- ============================================================================

function BrokerRecountFu:CreateDataObject()

  brokerObject = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("BrokerRecountFu", {
    type    = "launcher",
    label   = L["addon-name"],
    icon    = "Interface\\AddOns\\Broker_RecountFu\\Images\\icon",
    OnClick = function(_, msg)
      BrokerRecountFu:OnButtonClick(msg)
    end,
    OnTooltipShow = function(tooltip)
      if not tooltip or not tooltip.AddLine then return end
      BrokerRecountFu:BuildTooltip(tooltip)
    end,
  })

end

-- ============================================================================
-- == OnButtonClick(buttonName)                                              ==
-- ==                                                                        ==
-- == This function processes clicks made by the user/player on the addon's  ==
-- == display object (typically the icon).                                   ==
-- ==                                                                        ==
-- == Options: "LeftButton", "RightButton".                                  ==
-- ============================================================================

function BrokerRecountFu:OnButtonClick(buttonName)

  if buttonName == L["wow-api-lmb-click"] then
    BrokerRecountFu:OnLeftButtonClick()
  elseif buttonName == L["wow-api-rmb-click"] then
    BrokerRecountFu:OnRightButtonClick()
  end

end

-- ============================================================================
-- == OnLeftButtonClick()                                                    ==
-- ==                                                                        ==
-- == This function processes left mouse-button clicks made by the player on ==
-- == the addon's display object (typically the icon).                       ==
-- ==                                                                        ==
-- == Left             = Show/Hide Main Recount Window.                      ==
-- == Left        +Alt = Favourite Report 1                                  ==
-- == Left+Control     = Favourite Report 2                                  ==
-- == Left+Control+Alt = Favourite Report 3                                  ==
-- ============================================================================

function BrokerRecountFu:OnLeftButtonClick()

  if IsAltKeyDown() and IsControlKeyDown() then
    BRFRecount:OpenReportByNumber(BRFConfig:GetFavouriteReportIndexNumber3(nil))
    return
  elseif IsAltKeyDown() then
    BRFRecount:OpenReportByNumber(BRFConfig:GetFavouriteReportIndexNumber1(nil))
    return
  elseif IsControlKeyDown() then
    BRFRecount:OpenReportByNumber(BRFConfig:GetFavouriteReportIndexNumber2(nil))
    return
  else
    BRFRecount:ToggleMainWindowVisibility()
    return
  end

end

-- ============================================================================
-- == OnRightButtonClick()                                                   ==
-- ==                                                                        ==
-- == This function processes right mouse-button clicks made by the player   ==
-- == on the addon's display object (typically the icon).                    ==
-- ==                                                                        ==
-- == Right             = Show BrokerRecountFu Menu.                         ==
-- == Right        +Alt = Reset Recount Data.                                ==
-- == Right+Control     = Reset Recount Window Positions.                    ==
-- == Right+Control+Alt = Show Recount Config. Window.                       ==
-- ============================================================================

function BrokerRecountFu:OnRightButtonClick()

  if IsAltKeyDown() and IsControlKeyDown() then
    Recount:ShowConfig()
    return
  elseif IsAltKeyDown() then
    Recount:ResetData()
    return
  elseif IsControlKeyDown() then
    Recount:ResetPositions()
    BRFRecount:ShowMainWindow()
    return
  else
    BrokerRecountFu:ShowMenu()
    return
  end

end

-- ============================================================================
-- == About()                                                                ==
-- ==                                                                        ==
-- == This function provides prints information about this addon in the      ==
-- == default chat window.                                                   ==
-- ============================================================================

function BrokerRecountFu:About()

  local textTitle = "|cff00c0ff " .. L["addon-name"] .. "|r - |cffffff00" .. L["addon-version-name"] .. ":" .. L["addon-version-number"] .. "|r"

  BRFConsole:SendTitleBar("CHAT")
  BRFConsole:SendChatMessage(textTitle, "CHAT", nil, nil)
  BRFConsole:SendTitleBar("CHAT")
  BRFConsole:SendChatMessage(L["addon-desc-00"], "CHAT", nil, nil)
  BRFConsole:SendChatMessage("|cffffff00" .. L["brf-about-label-www"]    .. "|r|cff00ff00" .. L["addon-www-address"] .. "|r", "CHAT", nil, nil)
  BRFConsole:SendChatMessage("|cffffff00" .. L["brf-about-label-svn"]    .. "|r|cff00ff00" .. L["addon-svn-address"] .. "|r", "CHAT", nil, nil)
  BRFConsole:SendChatMessage("|cffffff00" .. L["brf-about-label-dld"]    .. "|r|cff00ff00" .. L["addon-dld-address"] .. "|r", "CHAT", nil, nil)
  BRFConsole:SendChatMessage("|cffffff00" .. L["brf-about-label-author"] .. "|r|cff00ff00" .. L["addon-author-01-name"] .. " (" .. L["addon-author-01-email"] .. ")" .. "|r", "CHAT", nil, nil)
  BRFConsole:SendTitleBar("CHAT")

end

-- ============================================================================
-- == BuildTextLabel()                                                       ==
-- ==                                                                        ==
-- == This function builds the text label which display addons may display.  ==
-- ============================================================================

function BrokerRecountFu:BuildTextLabel()

  local textLabel = ""

  if BRFRecount:IsRecountAvailable() then
    -- Display data if ANY data items have been enabled/selected.
    if BRFConfig:GetIsEnabledTextLabelLastFightDamageDoneRank(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightDamageDone(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightDPSRank(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightDPS(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightHealingDoneRank(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightHealingDone(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightHPSRank(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightHPS(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightRaidDamage(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightRaidDPS(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightRaidHealing(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightRaidHPS(nil)
    or BRFConfig:GetIsEnabledTextLabelLastFightRaidTimeInCombat(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallDamageDoneRank(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallDamageDone(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallDPSRank(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallDPS(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallHealingDoneRank(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallHealingDone(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallHPSRank(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallHPS(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallRaidDamage(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallRaidDPS(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallRaidHealing(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallRaidHPS(nil)
    or BRFConfig:GetIsEnabledTextLabelOverallRaidTimeInCombat(nil) then
      textLabel = BrokerRecountFu:TextLabelAddContentDataSelected(textLabel)
    else
      textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentAddonName()
    end
  else
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentAddonName()
  end

  brokerObject.text = textLabel

end

-- ============================================================================
-- == BuildTextLabel()                                                       ==
-- ==                                                                        ==
-- == This function adds data-items to the supplied textLabel string.        ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentDataSelected(textLabel)

  textLabel = BrokerRecountFu:TextLabelAddContentLastFightDamage(textLabel)
  textLabel = BrokerRecountFu:TextLabelAddContentLastFightHealing(textLabel)
  textLabel = BrokerRecountFu:TextLabelAddContentLastFightTime(textLabel)
  textLabel = BrokerRecountFu:TextLabelAddContentLastFightName(textLabel)
  textLabel = BrokerRecountFu:TextLabelAddContentOverallDamage(textLabel)
  textLabel = BrokerRecountFu:TextLabelAddContentOverallHealing(textLabel)
  textLabel = BrokerRecountFu:TextLabelAddContentOverallTime(textLabel)

  return textLabel

end

-- ============================================================================
-- == TextLabelAddContentLastFightDamage(textLabel)                          ==
-- ==                                                                        ==
-- == This function adds damage done data from the last-fight data table to  ==
-- == the supplied textLabel string.                                         ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentLastFightDamage(textLabel)

  if BRFConfig:GetIsEnabledTextLabelLastFightDamageDoneRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-dps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-damage-done-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelLastFightDamageDone(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerAmount(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-dps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-damage-done"])
  end

  if BRFConfig:GetIsEnabledTextLabelLastFightDPSRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-dps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-damage-rate-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelLastFightDPS(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRate(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-dps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-damage-rate"])
  end

  return textLabel

end

-- ============================================================================
-- == TextLabelAddContentLastFightHealing(textLabel)                         ==
-- ==                                                                        ==
-- == This function adds healing done data from the last-fight data table to ==
-- == the supplied textLabel string.                                         ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentLastFightHealing(textLabel)

  if BRFConfig:GetIsEnabledTextLabelLastFightHealingDoneRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-hps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-healing-done-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelLastFightHealingDone(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerAmount(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-hps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-healing-done"])
  end

  if BRFConfig:GetIsEnabledTextLabelLastFightHPSRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-hps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-healing-rate-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelLastFightHPS(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRate(BRFRecount:DataTableCurrentOrLast(), L["rct-datatype-hps"], BRFRecount:DataTableLabelCurrentOrLast() .. "-" .. L["ldb-text-datatype-healing-rate"])
  end

  return textLabel

end

-- ============================================================================
-- == TextLabelAddContentLastFightTime(textLabel)                            ==
-- ==                                                                        ==
-- == This function adds time-in-combat from the last fight data to the      ==
-- == textLabel string.                                                      ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentLastFightTime(textLabel)

  if BRFConfig:GetIsEnabledTextLabelLastFightRaidTimeInCombat(nil) then
    if BRFConfig:GetIsEnabledTextLabelTimeLabel(info) then
      textLabel = textLabel .. "|cff00c0ff" .. L["ldb-text-datatype-combat-time"]  .. ": |r"
    end

    textLabel = textLabel .. "|cffff8080" .. BRFData:SecondsToMinutes(BRFRecount:GetTimeInCombat(BRFRecount:DataTableCurrentOrLast())) .. " |r"

    return textLabel
  else
    return textLabel
  end

end

-- ============================================================================
-- == TextLabelAddContentLastFightName(textLabel)                            ==
-- ==                                                                        ==
-- == This function returns the name of the last/current fight's opponent.   ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentLastFightName(textLabel)

  if BRFConfig:GetIsEnabledTextLabelLastFightOpponentName(nil) then

    if BRFConfig:GetIsEnabledTextLabelNameLabel(nil) then
      textLabel = textLabel .. "|cff00c0ff" .. L["ldb-text-datatype-opponent-name"] .. ": |r"
    end

    -- textLabel = textLabel .. "|cff00ff00" .. BRFData:GetFirstWord(BRFRecount:GetLastOpponentName()) .. " |r"
    textLabel = textLabel .. "|cff00ff00" .. BRFData:RemoveLastWord(BRFRecount:GetLastOpponentName()) .. " |r"
  end

  return textLabel

end

-- ============================================================================
-- == TextLabelAddContentOverallDamage(textLabel)                            ==
-- ==                                                                        ==
-- == This function adds damage done data from the overall data table to     ==
-- == the supplied textLabel string.                                         ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentOverallDamage(textLabel)

  if BRFConfig:GetIsEnabledTextLabelOverallDamageDoneRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(L["rct-datatable-overall"], L["rct-datatype-dps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-damage-done-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelOverallDamageDone(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerAmount(L["rct-datatable-overall"], L["rct-datatype-dps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-damage-done"])
  end

  if BRFConfig:GetIsEnabledTextLabelOverallDPSRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(L["rct-datatable-overall"], L["rct-datatype-dps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-damage-rate-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelOverallDPS(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRate(L["rct-datatable-overall"], L["rct-datatype-dps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-damage-rate"])
  end

  return textLabel

end

-- ============================================================================
-- == TextLabelAddContentOverallHealing(textLabel)                           ==
-- ==                                                                        ==
-- == This function adds healing done data from the overall data table to    ==
-- == the supplied textLabel string.                                         ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentOverallHealing(textLabel)

  if BRFConfig:GetIsEnabledTextLabelOverallHealingDoneRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(L["rct-datatable-overall"], L["rct-datatype-hps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-healing-done-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelOverallHealingDone(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerAmount(L["rct-datatable-overall"], L["rct-datatype-hps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-healing-done"])
  end

  if BRFConfig:GetIsEnabledTextLabelOverallHPSRank(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRank(L["rct-datatable-overall"], L["rct-datatype-hps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-healing-rate-rank"])
  end

  if BRFConfig:GetIsEnabledTextLabelOverallHPS(nil) then
    textLabel = textLabel .. BrokerRecountFu:GetTextLabelContentPlayerRate(L["rct-datatable-overall"], L["rct-datatype-hps"], L["ldb-text-datatable-overall"] .. "-" .. L["ldb-text-datatype-healing-rate"])
  end

  return textLabel

end

-- ============================================================================
-- == TextLabelAddContentOverallTime(textLabel)                              ==
-- ==                                                                        ==
-- == This function adds time-in-combat from the overall data to the         ==
-- == textLabel string.                                                      ==
-- ============================================================================

function BrokerRecountFu:TextLabelAddContentOverallTime(textLabel)

  if BRFConfig:GetIsEnabledTextLabelOverallRaidTimeInCombat(nil) then
    if BRFConfig:GetIsEnabledTextLabelTimeLabel(info) then
      textLabel = textLabel .. "|cff00c0ff" .. L["ldb-text-datatype-combat-time"]  .. ": |r"
    end

    textLabel = textLabel .. "|cffff8080" .. BRFData:SecondsToMinutes(BRFRecount:GetTimeInCombat(L["rct-datatable-overall"])) .. " |r"

    return textLabel
  else
    return textLabel
  end

end

-- ============================================================================
-- == GetTextLabelContentAddonName()                                         ==
-- ==                                                                        ==
-- == This function fetches the addon name, the simplest text label content. ==
-- == The addon name is only displayed if no other text label content is     ==
-- == currently selected.                                                    ==
-- ============================================================================

function BrokerRecountFu:GetTextLabelContentAddonName()

  return L["addon-name"]

end

-- ============================================================================
-- == GetTextLabelContentPlayerRank(dataTable, dataType, dataLabel)          ==
-- ==                                                                        ==
-- == This function returns the player's ranking in the respective           ==
-- == data-table for the specified data-type.                                ==
-- ==                                                                        ==
-- == dataTable -> "CurrentFightData", "LastFightData", "OverallData"        ==
-- == dataType  -> "DPS", "HPS"                                              ==
-- ============================================================================

function BrokerRecountFu:GetTextLabelContentPlayerRank(dataTable, dataType, dataLabel)

  local groupCombatData = BRFRecount:GetGroupCombatData(dataTable, dataType)
  local textLabel       = ""

  if BRFConfig:GetIsEnabledTextLabelRankLabel(nil) then
    textLabel = "|cff00c0ff" .. dataLabel .. ": |r"
  end

  for k,v in pairs(groupCombatData) do

    if v.name == UnitName("player") then
      textLabel = textLabel .. "|cffffff00" .. "#" .. k .. " |r"
    end
  end

  return textLabel

end

-- ============================================================================
-- == GetTextLabelContentPlayerAmount(dataTable, dataType, dataLabel)        ==
-- ==                                                                        ==
-- == This function returns the player's Damage-Done, Healing-Done in text   ==
-- == label format.                                                          ==
-- ==                                                                        ==
-- == dataTable -> "CurrentFightData", "LastFightData", "OverallData"        ==
-- == dataType  -> "DPS", "HPS"                                              ==
-- ============================================================================

function BrokerRecountFu:GetTextLabelContentPlayerAmount(dataTable, dataType, dataLabel)

  local groupCombatData = BRFRecount:GetGroupCombatData(dataTable, dataType)
  local textLabel       = ""

  if BRFConfig:GetIsEnabledTextLabelAmountLabel(nil) then
    textLabel = "|cff00c0ff" .. dataLabel .. ": |r"
  end

  for k,v in pairs(groupCombatData) do

    if v.name == UnitName("player") then
      textLabel = textLabel .. "|cff00ff00" .. BRFData:DecorateNumber(v.amount) .. " |r"
    end
  end

  return textLabel

end

-- ============================================================================
-- == GetTextLabelContentRaidAmount(dataTable, dataType, dataLabel)          ==
-- ==                                                                        ==
-- == This function returns the raid's Damage-Done, Healing-Done in text     ==
-- == label format.                                                          ==
-- ==                                                                        ==
-- == dataTable -> "CurrentFightData", "LastFightData", "OverallData"        ==
-- == dataType  -> "DPS", "HPS"                                              ==
-- ============================================================================

function BrokerRecountFu:GetTextLabelContentRaidAmount(dataTable, dataLabel)

  local groupCombatData = BRFRecount:GetGroupCombatData(dataTable, dataType)
  local textLabel       = ""

  if BRFConfig:GetIsEnabledTextLabelAmountLabel(nil) then
    textLabel = "|cff00c0ff" .. dataLabel .. ": |r"
  end

  textLabel = textLabel .. "|cff00ff00" .. BRFRecount:GetRaidValuePerSecond(dataTable) .. " |r"

  return textLabel

end

-- ============================================================================
-- == GetTextLabelContentPlayerRate(dataTable, dataType, dataLabel)          ==
-- ==                                                                        ==
-- == This function returns the player's DPS, HPS in text label format.      ==
-- ==                                                                        ==
-- == dataTable -> "CurrentFightData", "LastFightData", "OverallData"        ==
-- == dataType  -> "DPS", "HPS"                                              ==
-- ============================================================================

function BrokerRecountFu:GetTextLabelContentPlayerRate(dataTable, dataType, dataLabel)

  local groupCombatData = BRFRecount:GetGroupCombatData(dataTable, dataType)
  local textLabel       = ""

  if BRFConfig:GetIsEnabledTextLabelRateLabel(nil) then
    textLabel = "|cff00c0ff" .. dataLabel .. ": |r"
  end

  for k,v in pairs(groupCombatData) do

    if v.name == UnitName("player") then
      textLabel = textLabel .. "|cff00ffff" .. BRFData:DecorateNumber(v.rate) .. " |r"
    end
  end

  return textLabel

end

-- ============================================================================
-- == GetTextLabelContentRaidRate(dataTable, dataType, dataLabel)            ==
-- ==                                                                        ==
-- == This function returns the raid's output rate in text label format.     ==
-- ==                                                                        ==
-- == dataTable -> "CurrentFightData", "LastFightData", "OverallData"        ==
-- == dataType  -> "DPS", "HPS"                                              ==
-- ============================================================================

function BrokerRecountFu:GetTextLabelContentRaidRate(dataTable, dataLabel)

  local groupCombatData = BRFRecount:GetGroupCombatData(dataTable, dataType)
  local textLabel       = ""

  if BRFConfig:GetIsEnabledTextLabelAmountLabel(nil) then
    textLabel = "|cff00c0ff" .. dataLabel .. ": |r"
  end

  textLabel = textLabel .. "|cff00ff00" .. BRFRecount:GetRaidValuePerSecond(dataTable) .. " |r"

  return textLabel

end

-- ============================================================================
-- == BuildTooltip(tooltip)                                                  ==
-- ==                                                                        ==
-- == This function builds the tooltip object displayed by the data object.  ==
-- ============================================================================

function BrokerRecountFu:BuildTooltip(tooltip)

  BrokerRecountFu:AddTooltipAddonName(tooltip)
  BrokerRecountFu:AddTooltipAddonDescription(tooltip)
  BrokerRecountFu:AddTooltipContent(tooltip)
  BrokerRecountFu:AddTooltipContentButtonActions(tooltip)

end

-- ============================================================================
-- == AddTooltipAddonName(tooltip)                                           ==
-- ==                                                                        ==
-- == This function adds the addon-name to the tooltip.                      ==
-- ============================================================================

function BrokerRecountFu:AddTooltipAddonName(tooltip)

  tooltip:AddLine("|r" .. L["addon-name"] .. " (" .. L["addon-version-number"] .. ")|r")
  tooltip:AddLine(" ")

end

-- ============================================================================
-- == AddTooltipAddonDescription(tooltip)                                    ==
-- ==                                                                        ==
-- == This function adds the addon-description to the tooltip.               ==
-- ============================================================================

function BrokerRecountFu:AddTooltipAddonDescription(tooltip)

  tooltip:AddLine(L["addon-desc-01"])
  tooltip:AddLine(L["addon-desc-02"])
  tooltip:AddLine(" ")

end

-- ============================================================================
-- == AddTooltipContent(tooltip)                                             ==
-- ==                                                                        ==
-- == This function adds the main content to the tooltip.                    ==
-- ============================================================================

function BrokerRecountFu:AddTooltipContent(tooltip)

  local isNoContentEnabled = true

  if BRFRecount:IsRecountAvailable() then

    if BRFConfig:GetIsEnabledTooltipDamageLastFight(nil) then
      BrokerRecountFu:AddTooltipContentPlayerTable(L["ldb-tooltip-lastfight-players-damage"] .. " (" .. BRFData:RemoveLastWord(BRFRecount:GetLastOpponentName()) .. ")",  L["rct-datatable-lastfight"], L["rct-datatype-dps"], tooltip)
      isNoContentEnabled = false
    end

    if BRFConfig:GetIsEnabledTooltipDamageOverall(nil) then
      BrokerRecountFu:AddTooltipContentPlayerTable(L["ldb-tooltip-overall-players-damage"],    L["rct-datatable-overall"],   L["rct-datatype-dps"], tooltip)
      isNoContentEnabled = false
    end

    if BRFConfig:GetIsEnabledTooltipHealingLastFight(nil) then
      BrokerRecountFu:AddTooltipContentPlayerTable(L["ldb-tooltip-lastfight-players-healing"] .. " (" .. BRFData:RemoveLastWord(BRFRecount:GetLastOpponentName()) .. ")", L["rct-datatable-lastfight"], L["rct-datatype-hps"], tooltip)
      isNoContentEnabled = false
    end

    if BRFConfig:GetIsEnabledTooltipHealingOverall(nil) then
      BrokerRecountFu:AddTooltipContentPlayerTable(L["ldb-tooltip-overall-players-healing"],   L["rct-datatable-overall"],   L["rct-datatype-hps"], tooltip)
      isNoContentEnabled = false
    end

    if BRFConfig:GetIsEnabledTooltipGroupSummaryLastFight(nil) then
      BrokerRecountFu:AddTooltipContentSummary(L["ldb-tooltip-lastfight-team"], L["rct-datatable-lastfight"], tooltip)
      isNoContentEnabled = false
    end

    if BRFConfig:GetIsEnabledTooltipGroupSummaryOverall(nil) then
      BrokerRecountFu:AddTooltipContentSummary(L["ldb-tooltip-overall-team"],   L["rct-datatable-overall"],   tooltip)
      isNoContentEnabled = false
    end

    if isNoContentEnabled then
      BrokerRecountFu:AddTooltipContentNoContentEnabled(tooltip)
    end

  else

    BrokerRecountFu:AddTooltipContentNoRecount(tooltip)

  end

end

-- ============================================================================
-- == AddTooltipContentSummary(summaryLabel, dataTable, tooltip)             ==
-- ==                                                                        ==
-- == This function adds a content summary to the tooltip.                   ==
-- ============================================================================

function BrokerRecountFu:AddTooltipContentSummary(summaryLabel, dataTable, tooltip)

    tooltip:AddLine("|cff00c0ff" .. summaryLabel .. "|r")

    BrokerRecountFu:AddTooltipData(L["ldb-tooltip-damage-done"],   dataTable, L["rct-datatype-damage"],       L["rct-datatype-dps"], tooltip)
    BrokerRecountFu:AddTooltipData(L["ldb-tooltip-healing-done"],  dataTable, L["rct-datatype-healing"],      L["rct-datatype-hps"], tooltip)
    BrokerRecountFu:AddTooltipData(L["ldb-tooltip-damage-taken"],  dataTable, L["rct-datatype-damagetaken"],  L["rct-datatype-dps"], tooltip)
    BrokerRecountFu:AddTooltipData(L["ldb-tooltip-healing-taken"], dataTable, L["rct-datatype-healingtaken"], L["rct-datatype-hps"], tooltip)
    BrokerRecountFu:AddTooltipDataSummary(dataTable, tooltip)
    tooltip:AddLine(" ")

end

-- ============================================================================
-- == AddTooltipData(dataLabel, dataTable, dataType, rateType, tooltip)      ==
-- ==                                                                        ==
-- == This function adds a line of data to the tooltip.                      ==
-- ============================================================================

function BrokerRecountFu:AddTooltipData(dataLabel, dataTable, dataType, rateType, tooltip)

  local dataValue          = BRFRecount:GetValue(dataTable, dataType)
  local dataValuePerSecond = BRFRecount:GetValuePerSecond(dataTable, dataType)
  local labelText          = "|cffffffff" .. dataLabel .. "|r"
  local valueText          = "|cff00ff00" .. BRFData:DecorateNumber(dataValue) .. "|r |cff00ffff(" .. BRFData:DecorateNumber(dataValuePerSecond) .. " " .. rateType .. ")|r"

  tooltip:AddDoubleLine(labelText, valueText)

end

-- ============================================================================
-- == AddTooltipContentPlayerTable(tooltip)                                  ==
-- ==                                                                        ==
-- == This function adds a table of data to the tooltip.                     ==
-- ============================================================================

function BrokerRecountFu:AddTooltipContentPlayerTable(dataLabel, dataTable, dataType, tooltip)

  tooltip:AddLine("|cff00c0ff" .. dataLabel .. "|r")

  local maxTableRows = BRFData:SafeNumber(BRFConfig:GetTooltipSizeLimit(nil))
  local currentRow   = 1

  local groupCombatData = BRFRecount:GetGroupCombatData(dataTable, dataType)

  for k,v in pairs(groupCombatData) do

    local labelText = BRFCommon:ColourByClass(v.className) .. v.name .. "|r "
    local valueText = "|cff00ff00" .. BRFData:DecorateNumber(v.amount) .. "|r |cff00ffff(" .. BRFData:DecorateNumber(v.rate) .. " " .. v.rateUnits .. ") |r|cffffff00"

    tooltip:AddDoubleLine(labelText, valueText)

    -- Comply with player preference for table-limit-size.
    if maxTableRows > 0 and currentRow >= maxTableRows then
      break
    end

    currentRow = currentRow + 1

  end

  -- If there was no data to output, add a simple message explaining this.
  if currentRow < 2 then
    tooltip:AddLine("|cffffff00" .. "     " .. L["ldb-tooltip-no-data"] .. "|r")
  end

  tooltip:AddLine(" ")

end

-- ============================================================================
-- == AddTooltipDataSummary(dataTable, tooltip)                              ==
-- ==                                                                        ==
-- == This function adds a line of data-summary info to the tooltip.         ==
-- ============================================================================

function BrokerRecountFu:AddTooltipDataSummary(dataTable, tooltip)

  local sumDmgHeal = BRFRecount:GetValue(dataTable, L["rct-datatype-healingtaken"]) - BRFRecount:GetValue(dataTable, L["rct-datatype-damagetaken"])

  local labelText = "|cffffffff"
  local valueText = "|cff00ff00"

  if sumDmgHeal == 0 then
    labelText = labelText .. L["ldb-summary-nochange"] .. "|r"
    valueText = valueText .. "|r"
  elseif sumDmgHeal > 0 then
    labelText = labelText .. L["ldb-summary-healing"] .. "|r"
    valueText = valueText .. BRFData:DecorateNumber(sumDmgHeal) .. "|r"
  else
    labelText = labelText .. L["ldb-summary-damage"] .. "|r"
    valueText = valueText .. BRFData:DecorateNumber(sumDmgHeal * -1) .. "|r"
  end

  tooltip:AddDoubleLine(labelText, valueText)

end

-- ============================================================================
-- == AddTooltipContentNoContentEnabled(tooltip)                             ==
-- ==                                                                        ==
-- == This function adds the main content to the tooltip, indicating that    ==
-- == no content has been enabled in the configuration preferences.          ==
-- ============================================================================

function BrokerRecountFu:AddTooltipContentNoContentEnabled(tooltip)

  tooltip:AddLine("|cff00c0ff" .. L["ldb-tooltip-heading-nothing-enabled"] .. "|r")

  tooltip:AddLine("|cffff0000" .. L["ldb-tootip-content-nothing-enabled-01"] .. "|r")
  tooltip:AddLine("|cffff0000" .. L["ldb-tootip-content-nothing-enabled-02"] .. "|r")
  tooltip:AddLine("|cffff0000" .. L["ldb-tootip-content-nothing-enabled-03"] .. "|r")

end

-- ============================================================================
-- == AddTooltipContentNoRecount(tooltip)                                    ==
-- ==                                                                        ==
-- == This function adds the main content to the tooltip, indicating that    ==
-- == the main recount addon cannot be found at this time.                   ==
-- ============================================================================

function BrokerRecountFu:AddTooltipContentNoRecount(tooltip)

  tooltip:AddLine("|cff00c0ff" .. L["ldb-tooltip-heading-norecount"] .. "|r")

  tooltip:AddLine("|cffff0000" .. L["ldb-tootip-content-norecount-01"] .. "|r")
  tooltip:AddLine("|cffff0000" .. L["ldb-tootip-content-norecount-02"] .. "|r")
  tooltip:AddLine("|cffff0000" .. L["ldb-tootip-content-norecount-03"] .. "|r")

end

-- ============================================================================
-- == AddTooltipContentButtonActions(tooltip)                                ==
-- ==                                                                        ==
-- == This function adds the button-actions to the tooltip.                  ==
-- ============================================================================

function BrokerRecountFu:AddTooltipContentButtonActions(tooltip)

  -- Do not proceed if the configuration for this feature is not enabled.
  if not BRFConfig:GetIsEnabledTooltipContentButtonActions(nil) then return end

  -- Button Actions Heading.
  tooltip:AddLine(" ")
  tooltip:AddLine("|cff00c0ff" .. L["ldb-tooltip-heading-actions"] .. "|r")

  -- Left Click Button Actions.
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-left"], false, false, L["ldb-tooltip-item-value-left"],            tooltip)
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-left"], true,  false, BrokerRecountFu:GetFavouriteReportName(1),   tooltip) -- alt
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-left"], false, true,  BrokerRecountFu:GetFavouriteReportName(2),   tooltip) -- ctrl
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-left"], true,  true,  BrokerRecountFu:GetFavouriteReportName(3),   tooltip) -- ctrl+alt

  -- Right Click Button Actions.
  tooltip:AddLine(" ")
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-right"], false, false, L["ldb-tooltip-item-value-right"],          tooltip)
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-right"], true,  false, L["ldb-tooltip-item-value-right-alt"],      tooltip) -- alt
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-right"], false, true,  L["ldb-tooltip-item-value-right-ctrl"],     tooltip) -- ctrl
  BrokerRecountFu:AddTooltipContentButtonAction(L["ldb-tooltip-item-label-right"], true,  true,  L["ldb-tooltip-item-value-right-ctrl-alt"], tooltip) -- ctrl+alt

end

-- ============================================================================
-- == AddTooltipContentButtonAction(buttonLabel, isAltActive, isCtrlActive,  ==
-- ==                               buttonValue, tooltip)                    ==
-- ==                                                                        ==
-- == This function adds a single button-action to the tooltip.              ==
-- ==                                                                        ==
-- == Parameters:                                                            ==
-- ==                                                                        ==
-- == buttonLabel:  The name of the button clicked. (eg: 'Left' or 'Right')  ==
-- == isAltActive:  True if Alt key depressed, false otherwise.              ==
-- == isCtrlActive: True if Ctrl key depressed, false otherwise.             ==
-- == buttonValue:  The action this button-click triggers. (eg: 'Show Menu') ==
-- == tooltip:      The tooltip object to add this button action info to.    ==
-- ============================================================================

function BrokerRecountFu:AddTooltipContentButtonAction(buttonLabel, isAltActive, isCtrlActive, buttonValue, tooltip)

  local activeColour   = "|cffeda55f"
  local inactiveColour = "|cff333333"
  local valueColour    = "|cff00ff00"
  local resetColour    = "|r"

  local labelText = activeColour .. buttonLabel .. resetColour
  local valueText = activeColour .. buttonValue .. resetColour

  if isAltActive then
    labelText = labelText .. activeColour   .. L["ldb-tooltip-item-plus-alt"] .. resetColour
  else
    labelText = labelText .. inactiveColour .. L["ldb-tooltip-item-plus-alt"] .. resetColour
  end

  if isCtrlActive then
    labelText = labelText .. activeColour   .. L["ldb-tooltip-item-plus-ctl"] .. resetColour
  else
    labelText = labelText .. inactiveColour .. L["ldb-tooltip-item-plus-ctl"] .. resetColour
  end

  tooltip:AddDoubleLine(labelText, valueText)

end

-- ============================================================================
-- == GetFavouriteReportName(favouriteNumber)                                ==
-- ==                                                                        ==
-- == This function returns the name of the favourite report identified by   ==
-- == the supplied favouriteNumber parameter.                                ==
-- ============================================================================

function BrokerRecountFu:GetFavouriteReportName(favouriteNumber)

  local reportName = L["all-data-unset"]

  if favouriteNumber == 1 then
    reportName = BRFRecount:GetReportNameByNumber(BRFConfig:GetFavouriteReportIndexNumber1(nil))
  elseif favouriteNumber == 2 then
    reportName = BRFRecount:GetReportNameByNumber(BRFConfig:GetFavouriteReportIndexNumber2(nil))
  elseif favouriteNumber == 3 then
    reportName = BRFRecount:GetReportNameByNumber(BRFConfig:GetFavouriteReportIndexNumber3(nil))
  end

  return reportName

end

-- ============================================================================
-- == ShowMenu()                                                             ==
-- ==                                                                        ==
-- == This function displays the drop-down menu.                             ==
-- ============================================================================

function BrokerRecountFu:ShowMenu()

  BrokerRecountFu:BuildDropDownMenu()

  ToggleDropDownMenu(1, nil, DropDownMenu, "cursor", 0, 0)

end

-- ============================================================================
-- == BuildDropDownMenu()                                                    ==
-- ==                                                                        ==
-- == This function builds the drop-down menu. It is a dynamic function and  ==
-- == can be called either once only for menus that are not expected to      ==
-- == change during a session or every time before the menu is displayed for ==
-- == menus that change often.                                               ==
-- ============================================================================

function BrokerRecountFu:BuildDropDownMenu()

  DropDownMenu.displayMode = "MENU"
  DropDownMenu.initialize  = function(self, level)

    if not level then return end
    wipe(info)

    -- ========================================================================
    -- == Level 1 - Top level menu items.                                    ==
    -- ========================================================================
    if level == 1 then

      -- General Menu Defaults.
      BrokerRecountFu:AddMenuDefaultConfig()

      -- Create the title of the menu
      BrokerRecountFu:AddMenuTitle(L["ldb-menu-main-name"])
      UIDropDownMenu_AddButton(info, level)

      -- Empty Menu Item.
      BrokerRecountFu:AddMenuDummyButton()
      UIDropDownMenu_AddButton(info, level)

      -- Recount Submenu.
      BrokerRecountFu:AddMenuSubMenu("SubmenuRecount")
      BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-recount")
      UIDropDownMenu_AddButton(info, level)

      -- Tooltip Options Submenu.
      BrokerRecountFu:AddMenuSubMenu("SubmenuTextOptions")
      BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-text-opts")
      UIDropDownMenu_AddButton(info, level)

      -- Tooltip Options Submenu.
      BrokerRecountFu:AddMenuSubMenu("SubmenuTooltipOptions")
      BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-tip-opts")
      UIDropDownMenu_AddButton(info, level)

      -- System Submenu.
      BrokerRecountFu:AddMenuSubMenu("SubmenuSystem")
      BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-system")
      UIDropDownMenu_AddButton(info, level)

      -- Empty Menu Item.
      BrokerRecountFu:AddMenuDummyButton()
      UIDropDownMenu_AddButton(info, level)

      -- About Menu Item.
      BrokerRecountFu:AddMenuPushButton()
      BrokerRecountFu:AddMenuButtonText("ldb-menu-item-about")
      info.func = function() BrokerRecountFu:About() end
      UIDropDownMenu_AddButton(info, level)

      -- Close Menu Item.
      BrokerRecountFu:AddMenuPushButton()
      BrokerRecountFu:AddMenuButtonText("ldb-menu-item-closemenu")
      info.func = function() CloseDropDownMenus() end
      UIDropDownMenu_AddButton(info, level)

    -- ========================================================================
    -- == Level 2 - Submenus directly linked from the main menu.             ==
    -- ========================================================================
    elseif level == 2 then

      -- ======================================================================
      -- == Render the level 2 submenu for: Recount ===========================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuRecount" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-recount-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- View Report Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuViewReport")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-view-report")
        UIDropDownMenu_AddButton(info, level)

        -- Send Report Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuSendReport")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-send-report")
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime Stats Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuViewRealTimeStats")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-view-realtime-stats")
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-window-controls-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Toggle Window Visibility Menu Item.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-toggle-window-visibility")
        info.checked = Recount.MainWindow:IsShown()
        info.func    = function()
                         BRFRecount:ToggleMainWindowVisibility()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-toggle-window-visibility-txt-name"], BrokerRecountFu:IsEnabledText(Recount.MainWindow:IsShown()))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Toggle Window Lock Menu Item.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-toggle-window-lock")
        info.checked = Recount.db.profile.Locked
        info.func    = function()
                         BRFRecount:ToggleMainWindowLock()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-toggle-window-lock-txt-name"], BrokerRecountFu:IsEnabledText(Recount.db.profile.Locked))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Reset Window Position Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-reset-window-position")
        info.func = function() Recount:ResetPositions() end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-quick-config-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Recount Config Window Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-recount-config-window")
        info.func = function() Recount:ShowConfig() end
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 2 submenu for: Text Options ======================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuTextOptions" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-text-opts-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-text-last-fight-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Damage Done Rank Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dmg-rank-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightDamageDoneRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightDamageDoneRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dmg-rank-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightDamageDoneRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Damage Done Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dmg-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightDamageDone(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightDamageDone()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dmg-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightDamageDone(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- DPS Rank Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dps-rank-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightDPSRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightDPSRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dps-rank-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightDPSRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- DPS Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dps-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightDPS(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightDPS()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dps-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightDPS(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Healing Done Rank Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-heal-rank-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightHealingDoneRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightHealingDoneRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-heal-rank-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightHealingDoneRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Healing Done Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-heal-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightHealingDone(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightHealingDone()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-heal-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightHealingDone(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- HPS Rank Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-hps-rank-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightHPSRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightHPSRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-hps-rank-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightHPSRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- HPS Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-hps-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightHPS(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightHPS()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-hps-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightHPS(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Time In Combat Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-time-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightRaidTimeInCombat(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightRaidTimeInCombat()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-time-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightRaidTimeInCombat(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Opponent Name Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-name-last-fight")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelLastFightOpponentName(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelLastFightOpponentName()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-name-last-fight-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelLastFightOpponentName(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-text-overall-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Damage Done Rank Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dmg-rank-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallDamageDoneRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallDamageDoneRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dmg-rank-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallDamageDoneRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Damage Done Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dmg-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallDamageDone(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallDamageDone()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dmg-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallDamageDone(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- DPS Rank Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dps-rank-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallDPSRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallDPSRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dps-rank-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallDPSRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- DPS Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-dps-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallDPS(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallDPS()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-dps-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallDPS(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Healing Done Rank Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-heal-rank-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallHealingDoneRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallHealingDoneRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-heal-rank-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallHealingDoneRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Healing Done Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-heal-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallHealingDone(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallHealingDone()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-heal-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallHealingDone(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- HPS Rank Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-hps-rank-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallHPSRank(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallHPSRank()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-hps-rank-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallHPSRank(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- HPS Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-hps-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallHPS(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallHPS()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-hps-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallHPS(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Time In Combat Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-time-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelOverallRaidTimeInCombat(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelOverallRaidTimeInCombat()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-time-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelOverallRaidTimeInCombat(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-text-labels-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Show Rank Labels Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-show-rank-label")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelRankLabel(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelRankLabel()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-show-rank-label-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelRankLabel(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Show Amount Labels Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-show-amount-label")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelAmountLabel(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelAmountLabel()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-show-amount-label-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelAmountLabel(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Show Rate Labels Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-show-rate-label")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelRateLabel(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelRateLabel()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-show-rate-label-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelRateLabel(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Show Time Labels Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-show-time-label")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelTimeLabel(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelTimeLabel()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-show-time-label-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelTimeLabel(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Show Name Labels Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-text-show-name-label")
        info.checked = function() return BRFConfig:GetIsEnabledTextLabelNameLabel(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTextLabelNameLabel()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-text-show-name-label-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTextLabelNameLabel(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 2 submenu for: Tooltip Options ===================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuTooltipOptions" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-tip-opts-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-text-rank-tables-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Damage Done Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-tip-show-damage-last")
        info.checked = function() return BRFConfig:GetIsEnabledTooltipDamageLastFight(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTooltipDamageLastFight()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-tip-show-damage-last-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTooltipDamageLastFight(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Damage Done Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-tip-show-damage-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTooltipDamageOverall(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTooltipDamageOverall()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-tip-show-damage-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTooltipDamageOverall(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Healing Done Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-tip-show-healing-last")
        info.checked = function() return BRFConfig:GetIsEnabledTooltipHealingLastFight(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTooltipHealingLastFight()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-tip-show-healing-last-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTooltipHealingLastFight(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Healing Done Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-tip-show-healing-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTooltipHealingOverall(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTooltipHealingOverall()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-tip-show-healing-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTooltipHealingOverall(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-text-summary-tables-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Group Summary Last Fight Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-tip-show-group-last")
        info.checked = function() return BRFConfig:GetIsEnabledTooltipGroupSummaryLastFight(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTooltipGroupSummaryLastFight()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-tip-show-group-last-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTooltipGroupSummaryLastFight(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Group Summary Overall Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-tip-show-group-overall")
        info.checked = function() return BRFConfig:GetIsEnabledTooltipGroupSummaryOverall(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTooltipGroupSummaryOverall()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-tip-show-group-overall-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTooltipGroupSummaryOverall(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-text-other-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Button Actions Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-tip-show-button-actions")
        info.checked = function() return BRFConfig:GetIsEnabledTooltipContentButtonActions(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledTooltipContentButtonActions()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-tip-show-button-actions-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledTooltipContentButtonActions(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-quick-config-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Table Size Limit Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuTableSizeLimit")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-table-size-limit")
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 2 submenu for: System ============================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuSystem" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-system-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-update-pulses-config-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Update Pulse Resting Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuUpdatePulseResting")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-update-pulse-resting")
        UIDropDownMenu_AddButton(info, level)

        -- Update Pulse Combat Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuUpdatePulseCombat")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-update-pulse-combat")
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-fave-report-config-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Favourite Report 1 Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuFavouriteReport1")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-fave-report-1")
        UIDropDownMenu_AddButton(info, level)

        -- Favourite Report 2 Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuFavouriteReport2")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-fave-report-2")
        UIDropDownMenu_AddButton(info, level)

        -- Favourite Report 3 Submenu.
        BrokerRecountFu:AddMenuSubMenu("SubmenuFavouriteReport3")
        BrokerRecountFu:AddMenuButtonText("ldb-menu-heading-fave-report-3")
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Toggle Compact System Numbers.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-toggle-compact-numbers")
        info.checked = function() return BRFConfig:GetIsEnabledCompactSystemNumbers(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledCompactSystemNumbers()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-toggle-compact-numbers-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledCompactSystemNumbers(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Toggle Always Show One Decimal Place.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-toggle-always-show-1dp")
        info.checked = function() return BRFConfig:GetIsEnabledAlwaysShowOneDecimalPlace(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledAlwaysShowOneDecimalPlace()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-toggle-always-show-1dp-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledAlwaysShowOneDecimalPlace(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Toggle Comma Period Separation.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-toggle-comma-period-separation")
        info.checked = function() return BRFConfig:GetIsEnabledCommaPeriodSeparation(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledCommaPeriodSeparation()
                         BrokerRecountFu:BuildTextLabel()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-toggle-comma-period-separation-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledCommaPeriodSeparation(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-quick-config-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Debug Mode Toggle.
        BrokerRecountFu:AddMenuToggleButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-debugmode")
        info.checked = function() return BRFConfig:GetIsEnabledDebugMode(nil) end
        info.func    = function()
                         BRFConfig:ToggleIsEnabledDebugMode()
                         BrokerRecountFu:DisplayStatus(L["ldb-menu-item-debugmode-txt-name"], BrokerRecountFu:IsEnabledText(BRFConfig:GetIsEnabledDebugMode(nil)))
                       end
        UIDropDownMenu_AddButton(info, level)

      end

    -- ========================================================================
    -- == Level 3 - Submenus directly linked from the main menu.             ==
    -- ========================================================================
    elseif level == 3 then

      -- ======================================================================
      -- == Render the level 3 submenu for: View Report =======================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuViewReport" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-view-report-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Add buttons for each report; Recount supplies the list of reports.
        for k,v in pairs(Recount.MainWindowData) do
          local reportName = v[1]

          -- Recount View Report Menu Item.
          BrokerRecountFu:AddMenuPushButton()
          BrokerRecountFu:AddMenuButtonExplicitText(reportName, reportName, L["ldb-menu-item-view-report-description"])
          info.func = function() BRFRecount:OpenReportByNumber(k) end
          UIDropDownMenu_AddButton(info, level)
        end

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: Send Report =======================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuSendReport" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-send-report-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Send Main Window Data Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-send-main-data")
        info.func = function() Recount:ShowReport(L["ldb-menu-item-send-main-title"],Recount.ReportData) end
        UIDropDownMenu_AddButton(info, level)

        -- Send Detail Window Data Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-send-detail-data")
        info.func = function() Recount:ShowReport(L["ldb-menu-item-send-detail-title"],Recount.ReportData) end
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: View Realtime Stats ===============
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuViewRealTimeStats" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-view-realtime-stats-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime DPS Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-fps")
        info.func = function() Recount:CreateRealtimeWindow(L["ldb-menu-item-realtime-fps-txt-name"], "FPS", "") end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime Lag Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-lag")
        info.func = function() Recount:CreateRealtimeWindow(L["ldb-menu-item-realtime-lag-txt-name"], "LAG", "") end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime Upstream Traffic Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-upstream")
        info.func = function() Recount:CreateRealtimeWindow(L["ldb-menu-item-realtime-upstream-txt-name"], "UP_TRAFFIC", "") end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime Downstream Traffic Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-downstream")
        info.func = function() Recount:CreateRealtimeWindow(L["ldb-menu-item-realtime-downstream-txt-name"], "DOWN_TRAFFIC", "") end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime Bandwidth Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-bandwidth")
        info.func = function() Recount:CreateRealtimeWindow(L["ldb-menu-item-realtime-bandwidth-txt-name"], "AVAILABLE_BANDWIDTH", "") end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime DPS Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-raid-dps")
        info.func = function() Recount:CreateRealtimeWindow("!RAID", "DAMAGE", L["ldb-menu-item-realtime-raid-dps-txt-name"]) end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime DPS Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-raid-dtps")
        info.func = function() Recount:CreateRealtimeWindow("!RAID", "DAMAGETAKEN", L["ldb-menu-item-realtime-raid-dtps-txt-name"]) end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime DPS Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-raid-hps")
        info.func = function() Recount:CreateRealtimeWindow("!RAID", "HEALING", L["ldb-menu-item-realtime-raid-hps-txt-name"]) end
        UIDropDownMenu_AddButton(info, level)

        -- View Realtime DPS Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-realtime-raid-htps")
        info.func = function() Recount:CreateRealtimeWindow("!RAID", "HEALINGTAKEN", L["ldb-menu-item-realtime-raid-htps-txt-name"]) end
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: Table Size Limit ==================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuTableSizeLimit" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-table-size-limit-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- No Size Limit Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-00")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(0, 0)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-00-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 5 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-05")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(5, 5)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-05-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 10 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-10")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(10, 10)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-10-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 15 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-15")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(15, 15)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-15-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 20 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-20")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(20, 20)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-20-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 25 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-25")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(25, 25)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-25-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 30 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-30")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(30, 30)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-30-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 35 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-35")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(35, 35)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-35-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Size Limit Top 40 Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-table-size-limit-40")
        info.func = function()
                      BRFConfig:SetTooltipSizeLimit(40, 40)
                      BrokerRecountFu:DisplayValue(L["ldb-menu-item-table-size-limit-40-txt-name"], BRFConfig:GetTooltipSizeLimit(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: Update Pulse Resting ==============
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuUpdatePulseResting" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-update-pulse-resting-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Set Resting Pulse Interval to 1 Second Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-interval-secs-001")
        info.func = function()
                      BRFConfig:SetPulseResting(1, 1)
                      BrokerRecountFu:AdjustHeartRate()
                      BrokerRecountFu:DisplayValue(L["ldb-menu-update-pulse-resting-name"], BRFConfig:GetPulseResting(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Set Resting Pulse Interval to 5 Seconds Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-interval-secs-005")
        info.func = function()
                      BRFConfig:SetPulseResting(5, 5)
                      BrokerRecountFu:AdjustHeartRate()
                      BrokerRecountFu:DisplayValue(L["ldb-menu-update-pulse-resting-name"], BRFConfig:GetPulseResting(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Set Resting Pulse Interval to 10 Seconds Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-interval-secs-010")
        info.func = function()
                      BRFConfig:SetPulseResting(10, 10)
                      BrokerRecountFu:AdjustHeartRate()
                      BrokerRecountFu:DisplayValue(L["ldb-menu-update-pulse-resting-name"], BRFConfig:GetPulseResting(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: Update Pulse Combat ===============
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuUpdatePulseCombat" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-update-pulse-combat-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Set Resting Pulse Interval to 1 Second Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-interval-secs-001")
        info.func = function()
                      BRFConfig:SetPulseCombat(1, 1)
                      BrokerRecountFu:AdjustHeartRate()
                      BrokerRecountFu:DisplayValue(L["ldb-menu-update-pulse-combat-name"], BRFConfig:GetPulseCombat(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Set Resting Pulse Interval to 5 Seconds Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-interval-secs-005")
        info.func = function()
                      BRFConfig:SetPulseCombat(5, 5)
                      BrokerRecountFu:AdjustHeartRate()
                      BrokerRecountFu:DisplayValue(L["ldb-menu-update-pulse-combat-name"], BRFConfig:GetPulseCombat(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

        -- Set Resting Pulse Interval to 10 Seconds Menu Item.
        BrokerRecountFu:AddMenuPushButton()
        BrokerRecountFu:AddMenuButtonText("ldb-menu-item-interval-secs-010")
        info.func = function()
                      BRFConfig:SetPulseCombat(10, 10)
                      BrokerRecountFu:AdjustHeartRate()
                      BrokerRecountFu:DisplayValue(L["ldb-menu-update-pulse-combat-name"], BRFConfig:GetPulseCombat(nil))
                    end
        UIDropDownMenu_AddButton(info, level)

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: Favourite Report 1 ================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuFavouriteReport1" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-fave-report-1-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Add buttons for each report; Recount supplies the list of reports.
        for k,v in pairs(Recount.MainWindowData) do
          local reportName = v[1]

          -- Recount View Report Menu Item.
          BrokerRecountFu:AddMenuPushButton()
          BrokerRecountFu:AddMenuButtonExplicitText(reportName, reportName, L["ldb-menu-item-fave-report-1-tip-desc"])
          info.func = function()
                        BRFConfig:SetFavouriteReportIndexNumber1(k, k)
                        BrokerRecountFu:DisplayValue(L["ldb-menu-item-fave-report-1-txt-name"], reportName)
                      end
          UIDropDownMenu_AddButton(info, level)
        end

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: Favourite Report 2 ================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuFavouriteReport2" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-fave-report-2-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Add buttons for each report; Recount supplies the list of reports.
        for k,v in pairs(Recount.MainWindowData) do
          local reportName = v[1]

          -- Recount View Report Menu Item.
          BrokerRecountFu:AddMenuPushButton()
          BrokerRecountFu:AddMenuButtonExplicitText(reportName, reportName, L["ldb-menu-item-fave-report-2-tip-desc"])
          info.func = function()
                        BRFConfig:SetFavouriteReportIndexNumber2(k, k)
                        BrokerRecountFu:DisplayValue(L["ldb-menu-item-fave-report-2-txt-name"], reportName)
                      end
          UIDropDownMenu_AddButton(info, level)
        end

      end

      -- ======================================================================
      -- == Render the level 3 submenu for: Favourite Report 3 ================
      -- ======================================================================
      if UIDROPDOWNMENU_MENU_VALUE == "SubmenuFavouriteReport3" then

        -- General Menu Defaults.
        BrokerRecountFu:AddMenuDefaultConfig()

        -- Create the title of the menu
        BrokerRecountFu:AddMenuTitle(L["ldb-menu-fave-report-3-name"])
        UIDropDownMenu_AddButton(info, level)

        -- Empty Menu Item.
        BrokerRecountFu:AddMenuDummyButton()
        UIDropDownMenu_AddButton(info, level)

        -- Add buttons for each report; Recount supplies the list of reports.
        for k,v in pairs(Recount.MainWindowData) do
          local reportName = v[1]

          -- Recount View Report Menu Item.
          BrokerRecountFu:AddMenuPushButton()
          BrokerRecountFu:AddMenuButtonExplicitText(reportName, reportName, L["ldb-menu-item-fave-report-3-tip-desc"])
          info.func = function()
                        BRFConfig:SetFavouriteReportIndexNumber3(k, k)
                        BrokerRecountFu:DisplayValue(L["ldb-menu-item-fave-report-3-txt-name"], reportName)
                      end
          UIDropDownMenu_AddButton(info, level)
        end
      end

    end
  end
end

-- ============================================================================
-- == AddMenuDefaultConfig()                                                 ==
-- ==                                                                        ==
-- == This function adds the default meta-data required by all menu items.   ==
-- ============================================================================

function BrokerRecountFu:AddMenuDefaultConfig()

  info.keepShownOnClick = 1

end

-- ============================================================================
-- == AddMenuTitle(title)                                                    ==
-- ==                                                                        ==
-- == This function adds the meta-data required for a new menu title.        ==
-- ============================================================================

function BrokerRecountFu:AddMenuTitle(title)

  -- Create the title of the menu
  info.isTitle      = 1
  info.text         = title
  info.notCheckable = 1

end

-- ============================================================================
-- == AddMenuDummyButton()                                                   ==
-- ==                                                                        ==
-- == This function adds the meta-data required for a new dummy button.      ==
-- ============================================================================

function BrokerRecountFu:AddMenuDummyButton()

  -- Empty Menu Item.
  info.text         = " "
  info.checked      = nil
  info.notCheckable = 1
  info.hasArrow     = nil
  info.value        = nil
  info.disabled     = 1

end

-- ============================================================================
-- == AddMenuSubMenu()                                                       ==
-- ==                                                                        ==
-- == This function adds the meta-data required for a new sub-menu.          ==
-- ============================================================================

function BrokerRecountFu:AddMenuSubMenu(name)

  info.isTitle      = nil
  info.disabled     = nil
  info.func         = self.UncheckHack
  info.hasArrow     = 1
  info.value        = name
  info.notCheckable = 1

end

-- ============================================================================
-- == AddMenuPushButton()                                                    ==
-- ==                                                                        ==
-- == This function adds the meta-data required for a new push button.       ==
-- ============================================================================

function BrokerRecountFu:AddMenuPushButton()

  info.isTitle      = nil
  info.disabled     = nil
  info.hasArrow     = nil
  info.value        = nil
  info.notCheckable = 1

end

-- ============================================================================
-- == AddMenuToggleButton()                                                  ==
-- ==                                                                        ==
-- == This function adds the meta-data required for a new toggle button.     ==
-- ============================================================================

function BrokerRecountFu:AddMenuToggleButton()

  info.isTitle      = nil
  info.disabled     = nil
  info.hasArrow     = nil
  info.notCheckable = nil

end

-- ============================================================================
-- == AddMenuButtonText(referenceStub)                                       ==
-- ==                                                                        ==
-- == This function adds menu button text fields to the 'info' table for the ==
-- == supplied referenceStub value.                                          ==
-- ============================================================================

function BrokerRecountFu:AddMenuButtonText(referenceStub)

  local txtName = referenceStub .. "-txt-name"
  local tipName = referenceStub .. "-tip-name"
  local tipDesc = referenceStub .. "-tip-desc"

  info.text         = L[txtName]
  info.tooltipTitle = L[tipName]
  info.tooltipText  = L[tipDesc]

end

-- ============================================================================
-- == AddMenuButtonExplicitText(text, tipTitle, tipText)                     ==
-- ==                                                                        ==
-- == This function adds menu button text fields to the 'info' table for the ==
-- == supplied values.                                                       ==
-- ============================================================================

function BrokerRecountFu:AddMenuButtonExplicitText(text, tipTitle, tipText)

  info.text         = text
  info.tooltipTitle = tipTitle
  info.tooltipText  = tipText

end

-- ============================================================================
-- == IsEnabledText(value)                                                   ==
-- ==                                                                        ==
-- == This function determines whether the supplied value is recognised as   ==
-- == meaning "is enabled" and returns 'On' if enabled, 'Off' otherwise.     ==
-- ============================================================================

function BrokerRecountFu:IsEnabledText(value)

  if value == true then
    return "|cff00ff00On|r"
  else
    return "|cffff0000Off|r"
  end

end

-- ============================================================================
-- == DisplayStatus(featureName, isEnabledText)                              ==
-- ==                                                                        ==
-- == This function enables the status of a feature to be displayed via the  ==
-- == standard chat-window system with appropriate colourisation.            ==
-- ============================================================================

function BrokerRecountFu:DisplayStatus(featureName, isEnabledText)

  local message = L["cfg-display-data-title"] .. featureName .. ": " .. isEnabledText

  BRFConsole:SendChatMessage(message, "CHAT", nil, nil)

end

-- ============================================================================
-- == DisplayValue(featureName, value)                                       ==
-- ==                                                                        ==
-- == This function enables the value of a feature to be displayed via the   ==
-- == standard chat-window system.                                           ==
-- ============================================================================

function BrokerRecountFu:DisplayValue(featureName, value)

  local message = L["cfg-display-data-title"] .. featureName .. ": |cffffff00" .. value .. "|r"

  BRFConsole:SendChatMessage(message, "CHAT", nil, nil)

end
