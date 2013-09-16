-- ============================================================================
-- == BRFRecount - Provides functions for interacting with the Recount       ==
-- ==              damage-meter addon.                                       ==
-- ============================================================================

BRFRecount = LibStub("AceAddon-3.0"):NewAddon("BRFRecount", "AceConsole-3.0", "AceEvent-3.0")
local L    = LibStub("AceLocale-3.0"):GetLocale("BrokerRecountFu")

-- ============================================================================
-- == OnInitialize()                                                         ==
-- ==                                                                        ==
-- == This function is called when the addon is initialised.                 ==
-- ============================================================================

function BRFRecount:OnInitialize()
end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is enabled.                     ==
-- ============================================================================

function BRFRecount:OnEnable()
end

-- ============================================================================
-- == OnDisable()                                                            ==
-- ==                                                                        ==
-- == This function is called when the addon is disabled.                    ==
-- ============================================================================

function BRFRecount:OnDisable()
end

-- ============================================================================
-- == IsRecountAvailable()                                                   ==
-- ==                                                                        ==
-- == This function returns true when Recount is available, false otherwise. ==
-- ============================================================================

function BRFRecount:IsRecountAvailable()

  if IsAddOnLoaded("Recount") then
    return true
  else
    return false
  end

end

-- ============================================================================
-- == DataTableCurrentOrLast()                                               ==
-- ==                                                                        ==
-- == This function returns the correct datatable type depending upon        ==
-- == whether the player is currently in combat or not. When in combat, it   ==
-- == returns "CurrentFightData", at all other times it returns              ==
-- == "LastFightData".                                                       ==
-- ============================================================================

function BRFRecount:DataTableCurrentOrLast()

  if Recount.InCombat then
    return L["rct-datatable-currentfight"]
  else
    return L["rct-datatable-lastfight"]
  end

end

-- ============================================================================
-- == DataTableLabelCurrentOrLast()                                          ==
-- ==                                                                        ==
-- == This function returns the correct datatable label depending upon       ==
-- == whether the player is currently in combat or not. When in combat, it   ==
-- == returns "CurrentFightData", at all other times it returns              ==
-- == "LastFightData".                                                       ==
-- ============================================================================

function BRFRecount:DataTableLabelCurrentOrLast()

  if Recount.InCombat then
    return L["ldb-text-datatable-currentfight"]
  else
    return L["ldb-text-datatable-lastfight"]
  end

end

-- ============================================================================
-- == ToggleMainWindowVisibility()                                           ==
-- ==                                                                        ==
-- == This function toggles whether the main Recount window is shown or      ==
-- == hidden.                                                                ==
-- ============================================================================

function BRFRecount:ToggleMainWindowVisibility()

  if Recount.MainWindow:IsShown() then
    Recount.MainWindow:Hide()
  else
    Recount.MainWindow:Show()
    Recount:RefreshMainWindow()
  end

end

-- ============================================================================
-- == ToggleMainWindowLock()                                                 ==
-- ==                                                                        ==
-- == This function toggles whether the main Recount window is locked or     ==
-- == unlocked.                                                              ==
-- ============================================================================

function BRFRecount:ToggleMainWindowLock()

  if Recount.db.profile.Locked == true then
    Recount.db.profile.Locked = false
  else
    Recount.db.profile.Locked = true
  end

  Recount:LockWindows(Recount.db.profile.Locked)

end

-- ============================================================================
-- == ShowMainWindow()                                                       ==
-- ==                                                                        ==
-- == This function shows the main Recount window.                           ==
-- ============================================================================

function BRFRecount:ShowMainWindow()

  Recount.MainWindow:Show()
  Recount:RefreshMainWindow()

end

-- ============================================================================
-- == GetValue(tableToUse,valueToUse)                                        ==
-- ==                                                                        ==
-- == This function returns the total value of the metric specified by the   ==
-- == valueToUse parameter, retrieved from the tableToUse data-table.        ==
-- ==                                                                        ==
-- == tableToUse Options               valueToUse Options                    ==
-- ==                                                                        ==
-- == "OverallData"                    "Damage"                              ==
-- == "LastFightData"                  "Healing"                             ==
-- == "CurrentFightData"               "DamageTaken"                         ==
-- ==                                  "HealingTaken"                        ==
-- ==                                                                        ==
-- == Credit: This function is based largely on similar code provided to the ==
-- == FuBar_RecountFu addon project by Elsia, a developer on the Recount     ==
-- == addon project.                                                         ==
-- ============================================================================

function BRFRecount:GetValue(tableToUse,valueToUse)
  playerName = UnitName("player")
  if valueToUse == "Damage" then
    local damage,_ = Recount:MergedPetDamageDPS(Recount.db2.combatants[playerName],tableToUse) -- Elsia: Proper merged pet handling
    return damage
  else
    combatData = Recount.db2.combatants[playerName] and Recount.db2.combatants[playerName].Fights and Recount.db2.combatants[playerName].Fights[tableToUse]
    return combatData and combatData[valueToUse] or 0
  end
end

-- ============================================================================
-- == GetValuePerSecond(tableToUse,valueToUse)                               ==
-- ==                                                                        ==
-- == This function returns the rate value of the metric specified by the    ==
-- == valueToUse parameter, retrieved from the tableToUse data-table.        ==
-- ==                                                                        ==
-- == tableToUse Options               valueToUse Options                    ==
-- ==                                                                        ==
-- == "OverallData"                    "Damage"                              ==
-- == "LastFightData"                  "Healing"                             ==
-- == "CurrentFightData"               "DamageTaken"                         ==
-- ==                                  "HealingTaken"                        ==
-- ==                                                                        ==
-- == Credit: This function is based largely on similar code provided to the ==
-- == FuBar_RecountFu addon project by Elsia, a developer on the Recount     ==
-- == addon project.                                                         ==
-- ============================================================================

function BRFRecount:GetValuePerSecond(tableToUse,valueToUse)
  playerName = UnitName("player")
  Epsilon = 0.000000000000000001
  if valueToUse == "Damage" then
    local _,dps = Recount:MergedPetDamageDPS(Recount.db2.combatants[playerName],tableToUse) -- Elsia: Proper merged pet handling
    return math.floor(10*dps+0.5)/10
  else
    local _,dps = Recount:MergedPetHealingDPS(Recount.db2.combatants[playerName],tableToUse)
    return math.floor(10*dps+0.5)/10
  end
end

-- ============================================================================
-- == GetRaidValuePerSecond(tableToUse)                                      ==
-- ==                                                                        ==
-- == This function returns the rate value of the metric specified by the    ==
-- == valueToUse parameter, retrieved from the tableToUse data-table.        ==
-- ==                                                                        ==
-- == tableToUse Options               valueToUse Options                    ==
-- ==                                                                        ==
-- == "OverallData"                    "Damage"                              ==
-- == "LastFightData"                  "Healing"                             ==
-- == "CurrentFightData"               "DamageTaken"                         ==
-- ==                                  "HealingTaken"                        ==
-- ==                                                                        ==
-- == Credit: This function is based largely on similar code provided to the ==
-- == FuBar_RecountFu addon project by Elsia, a developer on the Recount     ==
-- == addon project.                                                         ==
-- ============================================================================

function BRFRecount:GetRaidValuePerSecond(tableToUse)
  Epsilon = 0.000000000000000001
  dps = 0
  for _,data in pairs(Recount.db2.combatants) do
    if data.Fights and data.Fights[tableToUse] and (data.type=="Self" or data.type=="Grouped" or data.type=="Pet") then
      local _,curdps = Recount:MergedPetDamageDPS(data,tableToUse)
      if data.type ~= "Pet" or (not Recount.db.profile.MergePets and data.Owner and (Recount.db2.combatants[data.Owner].type=="Self" or Recount.db2.combatants[data.Owner].type=="Grouped")) then -- Elsia: Only add to total if not merging pets.
        dps = dps + 10*curdps
      end
    end
  end
  return math.floor(dps+0.5)/10
end

-- ============================================================================
-- == GetTimeInCombat(tableToUse,valueToUse)                                 ==
-- ==                                                                        ==
-- == This function returns the total value of the specified value for the   ==
-- == specified data-table.                                                  ==
-- ==                                                                        ==
-- == tableToUse Options               valueToUse Options                    ==
-- ==                                                                        ==
-- == "OverallData"                    "Damage"                              ==
-- == "LastFightData"                  "Healing"                             ==
-- ==                                  "DamageTaken"                         ==
-- ==                                  "HealingTaken"                        ==
-- ==                                                                        ==
-- == Credit: This function is based largely on similar code provided to the ==
-- == FuBar_RecountFu addon project by Elsia, a developer on the Recount     ==
-- == addon project.                                                         ==
-- ============================================================================

function BRFRecount:GetTimeInCombat(tableToUse)
  Epsilon = 0.000000000000000001
  return math.floor(10*(BRFRecount:GetValue(tableToUse, L["rct-datatype-activetime"])+Epsilon))/10
end

-- ============================================================================
-- == GetGroupCombatData(dataTable, dataType)                                ==
-- ==                                                                        ==
-- == This function retrieves a group's combat data for a given dataTable    ==
-- == and dataType from the internal recount tables.                         ==
-- ==                                                                        ==
-- == dataTable options: "OverallData" or "LastFightData".                   ==
-- == dataType  options: "DPS" or "HPS".                                     ==
-- ==                                                                        ==
-- == Credit: This function is based largely on example code provided to     ==
-- == this project by J.N.Edwards but is believed to have originally been    ==
-- == derived from earlier code created for the Broker_RecountStats addon    ==
-- == project by 'Tristanian'.                                               ==
-- ============================================================================

function BRFRecount:GetGroupCombatData(dataTable, dataType)

  -- Declare and initialise all local variables that will be needed.
  local recountData   = nil
  local characterName = ""
  local totalAmount   = 0
  local totalRate     = 0
  local currentAmount = 0
  local currentRate   = 0
  local characterData = {}
  local groupData     = {}

  -- Loop through the recount data, processing it as required.
  for _,recountData in pairs(Recount.db2.combatants) do

    if  recountData.Fights and recountData.Fights[dataTable]
    and (recountData.type=="Self" or recountData.type=="Grouped" or recountData.type=="Pet" or recountData.type=="Ungrouped") then

      if dataType == L["rct-datatype-dps"] then
        currentAmount,currentRate = Recount:MergedPetDamageDPS(recountData,dataTable)
      elseif dataType == L["rct-datatype-hps"] then
        currentAmount,currentRate = Recount:MergedPetHealingDPS(recountData,dataTable)
      end

      if recountData.type ~= "Pet"
      or (not Recount.db.profile.MergePets and recountData.Owner and (Recount.db2.combatants[recountData.Owner].type=="Self" or Recount.db2.combatants[recountData.Owner].type=="Grouped" or Recount.db2.combatants[recountData.Owner].type=="Ungrouped"))
      or (not Recount.db.profile.MergePets and recountData.Name and recountData.GUID and BRFRecount:MatchUnitGUID(recountData.Name, recountData.GUID)) then

        if currentAmount > 0 then
          totalAmount = totalAmount + currentAmount
          currentRate = math.floor(currentRate + 0.5)
          totalRate = totalRate + currentRate

          characterName = recountData.Name or _G["UNKNOWN"]

          if recountData.type == "Pet" then
            characterName = recountData.Name.." <"..recountData.Owner..">"
          end

          characterData = {name = characterName, amount = currentAmount, rate = currentRate, className = recountData.enClass, rateUnits = dataType}
          table.insert(groupData, characterData)
        end
      end
    end
  end

  -- Now sort the data according to the amount field. (Highest to lowest.)
  table.sort(groupData, function(a,b) return a.amount > b.amount end)

  -- Now return the group-data and totals.
  return groupData, totalAmount, totalRate
end

-- ============================================================================
-- == MatchUnitGUID(unitname, guid)                                          ==
-- ==                                                                        ==
-- == This function attempts to match a unit-name with a GUID.               ==
-- == Inherited code, source unknown. Required to resolve logic-clause in    ==
-- == BRFRecount:GetGroupCombatData(dataTable, dataType).                    ==
-- ============================================================================

function BRFRecount:MatchUnitGUID(unitname, guid)
    for _, data in pairs(Recount.db2.combatants) do
        if data.GuardianReverseGUIDs and data.GuardianReverseGUIDs[unitname] and data.GuardianReverseGUIDs[unitname].GUIDs then
            for _, v in pairs(data.GuardianReverseGUIDs[unitname].GUIDs) do
                if v == guid then
                    return true
                end
            end
        end
    end
    return false
end

-- ============================================================================
-- == GetLastOpponentName()                                                  ==
-- ==                                                                        ==
-- == This function retrieves the name of the last opponent engaged.         ==
-- ============================================================================

function BRFRecount:GetLastOpponentName()

  for k, v in pairs(Recount.db2.FoughtWho) do

    return v

  end

end

-- ============================================================================
-- == GetReportNameByNumber(reportNumber)                                    ==
-- ==                                                                        ==
-- == This function retrieves the name of the Recount report as indexed by   ==
-- == the supplied reportNumber parameter.                                   ==
-- ============================================================================

function BRFRecount:GetReportNameByNumber(reportNumber)

  local reportName = L["all-data-unset"]

  if BRFRecount:IsRecountAvailable() then
    for k,v in pairs(Recount.MainWindowData) do

      if k == reportNumber then
        reportName = v[1]
      end
    end
  end

  return reportName

end

-- ============================================================================
-- == OpenReportByNumber(reportNumber)                                       ==
-- ==                                                                        ==
-- == This function opens the Recount window with the report, as indexed by  ==
-- == the supplied reportNumber parameter, preselected, assuming that it     ==
-- == exists.                                                                ==
-- ============================================================================

function BRFRecount:OpenReportByNumber(reportNumber)

  if BRFRecount:IsRecountAvailable() then
    for k,v in pairs(Recount.MainWindowData) do

      if k == reportNumber then
        Recount:SetMainWindowMode(k)
        BRFRecount:ShowMainWindow()
      end
    end
  end

  return reportName

end
