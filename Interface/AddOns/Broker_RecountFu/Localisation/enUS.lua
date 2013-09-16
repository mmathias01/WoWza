-- ============================================================================
-- == AceLocale Localisation File - enUS (US English Locale).                ==
-- ==                                                                        ==
-- == This file provides "key=value" references to messages used by the      ==
-- == addon. Other versions of this file may exist for alternative languages ==
-- == as appropriate.                                                        ==
-- ============================================================================

local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L         = AceLocale:NewLocale("BrokerRecountFu", "enUS", true)

if not L then return end

-- ============================================================================
-- == Localisation Data.                                                     ==
-- ==                                                                        ==
-- == Each entry is provided in the following form:                          ==
-- ==                                                                        ==
-- == L["{keyname}"] = "{value}"                                             ==
-- ==                                                                        ==
-- == These keys are then referenced within the main LUA code-files whenever ==
-- == one of the values needs to be retrieved, assuming the reference "L"    ==
-- == has first been configured using the standard declaration format.       ==
-- ==                                                                        ==
-- == local L = LibStub("AceLocale-3.0"):GetLocale("HalonaTools")            ==
-- ==                                                                        ==
-- ============================================================================

-- ============================================================================
-- == Localisation Data for Component: ALL (ie: used by multiple components.)==
-- ============================================================================

L["addon-name"]                 = "Broker_RecountFu"
L["addon-version-name"]         = "Winning on Threat"
L["addon-version-number"]       = "1.19"

L["addon-desc-00"]              = "An enhanced Broker plugin for Recount users."
L["addon-desc-01"]              = "The power of information at your fingertips."
L["addon-desc-02"]              = "Are you winning on threat?"

L["addon-www-address"]          = "http://www.wowace.com/addons/Broker_RecountFu"
L["addon-svn-address"]          = "svn://svn.wowace.com/wow/broker_recountfu/mainline/trunk"
L["addon-dld-address"]          = "http://wow.curse.com/addons/wow/Broker_RecountFu"
L["addon-author-01-name"]       = "Broliant"
L["addon-author-01-email"]      = "broliant@broliant.com"

-- == "WoW API" options. ======================================================

L["wow-api-lmb-click"]          = "LeftButton"
L["wow-api-rmb-click"]          = "RightButton"

-- == "Data Value" options. ===================================================

L["all-data-unset"]             = "<unset>"

-- ============================================================================
-- == Localisation Data for Component: Broker_RecountFu.                     ==
-- ============================================================================

-- == "About" text. ===========================================================

L["brf-about-label-www"]                    = "Web: "
L["brf-about-label-svn"]                    = "SVN: "
L["brf-about-label-dld"]                    = "D/L: "
L["brf-about-label-author"]                 = "Author: "

-- == "BrokerRecountFu" menu and its options. =================================

L["ldb-menu-main-name"]                     = "Broker_RecountFu Menu"

L["ldb-menu-item-about-txt-name"]           = "About"
L["ldb-menu-item-about-tip-name"]           = "About"
L["ldb-menu-item-about-tip-desc"]           = "About the Broker_RecountFu addon."

L["ldb-menu-item-closemenu-txt-name"]       = "Close Menu"
L["ldb-menu-item-closemenu-tip-name"]       = "Close Menu"
L["ldb-menu-item-closemenu-tip-desc"]       = "Closes and hides the drop-down menus."

-- == "Recount" menu and its options. =========================================

L["ldb-menu-recount-name"]                           = "Recount Options"

L["ldb-menu-heading-recount-txt-name"]               = "Recount Options"
L["ldb-menu-heading-recount-tip-name"]               = "Recount Options"
L["ldb-menu-heading-recount-tip-desc"]               = "Provides options provided by Recount."

L["ldb-menu-window-controls-name"]                   = "Window Controls"

L["ldb-menu-item-toggle-window-visibility-txt-name"] = "Window Visibility"
L["ldb-menu-item-toggle-window-visibility-tip-name"] = "Window Visibility"
L["ldb-menu-item-toggle-window-visibility-tip-desc"] = "Toggles whether the main Recount window is shown or hidden."

L["ldb-menu-item-toggle-window-lock-txt-name"]       = "Window Lock"
L["ldb-menu-item-toggle-window-lock-tip-name"]       = "Window Lock"
L["ldb-menu-item-toggle-window-lock-tip-desc"]       = "Toggles whether the main Recount window is locked or unlocked."

L["ldb-menu-item-reset-window-position-txt-name"]    = "Reset Window Positions"
L["ldb-menu-item-reset-window-position-tip-name"]    = "Reset Window Positions"
L["ldb-menu-item-reset-window-position-tip-desc"]    = "Resets the position of Recount's windows."

L["ldb-menu-item-recount-config-window-txt-name"]    = "Config Recount"
L["ldb-menu-item-recount-config-window-tip-name"]    = "Config Recount"
L["ldb-menu-item-recount-config-window-tip-desc"]    = "Opens the Recount configuration window."

-- == "View Report" menu and its options. =====================================

L["ldb-menu-view-report-name"]                       = "View Report"

L["ldb-menu-heading-view-report-txt-name"]           = "View Report"
L["ldb-menu-heading-view-report-tip-name"]           = "View Report"
L["ldb-menu-heading-view-report-tip-desc"]           = "Provides access to Recount's report viewing modes."

L["ldb-menu-item-view-report-description"]           = "View the selected report in Recount."

-- == "Send Report" menu and its options. =====================================

L["ldb-menu-send-report-name"]                       = "Send Report"

L["ldb-menu-heading-send-report-txt-name"]           = "Send Report"
L["ldb-menu-heading-send-report-tip-name"]           = "Send Report"
L["ldb-menu-heading-send-report-tip-desc"]           = "Provides access to Recount's report sending modes."

L["ldb-menu-item-send-main-data-txt-name"]           = "From Main Window"
L["ldb-menu-item-send-main-data-tip-name"]           = "From Main Window"
L["ldb-menu-item-send-main-data-tip-desc"]           = "Opens the Recount dialog allowing you to send a report containing data from the main window."

L["ldb-menu-item-send-main-title"]                   = "Main"

L["ldb-menu-item-send-detail-data-txt-name"]         = "From Detail Window"
L["ldb-menu-item-send-detail-data-tip-name"]         = "From Detail Window"
L["ldb-menu-item-send-detail-data-tip-desc"]         = "Opens the Recount dialog allowing you to send a report containing data from the detail window."

L["ldb-menu-item-send-detail-title"]                 = "Detail"

-- == "View Realtime Stats" menu and its options. =============================

L["ldb-menu-view-realtime-stats-name"]               = "View Realtime Stats"

L["ldb-menu-heading-view-realtime-stats-txt-name"]   = "View Realtime Stats"
L["ldb-menu-heading-view-realtime-stats-tip-name"]   = "View Realtime Stats"
L["ldb-menu-heading-view-realtime-stats-tip-desc"]   = "Provides access to Recount's realtime stats viewing modes."

L["ldb-menu-item-view-realtime-stats-description"]   = "View the realtime-stats windows of Recount."

L["ldb-menu-item-realtime-fps-txt-name"]             = "FPS"
L["ldb-menu-item-realtime-fps-tip-name"]             = "FPS"
L["ldb-menu-item-realtime-fps-tip-desc"]             = "Opens the realtime-stats window, displaying FPS data."

L["ldb-menu-item-realtime-lag-txt-name"]             = "Lag"
L["ldb-menu-item-realtime-lag-tip-name"]             = "Lag"
L["ldb-menu-item-realtime-lag-tip-desc"]             = "Opens the realtime-stats window, displaying Lag data."

L["ldb-menu-item-realtime-upstream-txt-name"]        = "Upstream Traffic"
L["ldb-menu-item-realtime-upstream-tip-name"]        = "Upstream Traffic"
L["ldb-menu-item-realtime-upstream-tip-desc"]        = "Opens the realtime-stats window, displaying Upstream Traffic data."

L["ldb-menu-item-realtime-downstream-txt-name"]      = "Downstream Traffic"
L["ldb-menu-item-realtime-downstream-tip-name"]      = "Downstream Traffic"
L["ldb-menu-item-realtime-downstream-tip-desc"]      = "Opens the realtime-stats window, displaying Downstream Traffic data."

L["ldb-menu-item-realtime-bandwidth-txt-name"]       = "Available Bandwidth"
L["ldb-menu-item-realtime-bandwidth-tip-name"]       = "Available Bandwidth"
L["ldb-menu-item-realtime-bandwidth-tip-desc"]       = "Opens the realtime-stats window, displaying Available Bandwidth data."

L["ldb-menu-item-realtime-raid-dps-txt-name"]        = "Raid DPS"
L["ldb-menu-item-realtime-raid-dps-tip-name"]        = "Raid DPS"
L["ldb-menu-item-realtime-raid-dps-tip-desc"]        = "Opens the realtime-stats window, displaying Raid DPS data. (Damage-done Per Second)"

L["ldb-menu-item-realtime-raid-dtps-txt-name"]       = "Raid DTPS"
L["ldb-menu-item-realtime-raid-dtps-tip-name"]       = "Raid DTPS"
L["ldb-menu-item-realtime-raid-dtps-tip-desc"]       = "Opens the realtime-stats window, displaying Raid DTPS data. (Damage Taken Per Second)"

L["ldb-menu-item-realtime-raid-hps-txt-name"]        = "Raid HPS"
L["ldb-menu-item-realtime-raid-hps-tip-name"]        = "Raid HPS"
L["ldb-menu-item-realtime-raid-hps-tip-desc"]        = "Opens the realtime-stats window, displaying Raid HPS data. (Healing-done Per Second)"

L["ldb-menu-item-realtime-raid-htps-txt-name"]       = "Raid HTPS"
L["ldb-menu-item-realtime-raid-htps-tip-name"]       = "Raid HTPS"
L["ldb-menu-item-realtime-raid-htps-tip-desc"]       = "Opens the realtime-stats window, displaying Raid HTPS data. (Healing Taken Per Second)"

-- == "Text" menu and its options. =========================================

L["ldb-menu-text-opts-name"]                         = "Text Options"

L["ldb-menu-heading-text-opts-txt-name"]             = "Text Options"
L["ldb-menu-heading-text-opts-tip-name"]             = "Text Options"
L["ldb-menu-heading-text-opts-tip-desc"]             = "Provides configuration for the text display."

L["ldb-menu-text-last-fight-name"]                   = "Current/Last-Fight Data (C/LF)"

L["ldb-menu-item-text-dmg-rank-last-fight-txt-name"] = "Show Damage Done Rank (D)"
L["ldb-menu-item-text-dmg-rank-last-fight-tip-name"] = "Show Damage Done Rank (D)"
L["ldb-menu-item-text-dmg-rank-last-fight-tip-desc"] = "Enables the icon-text display of the damage done rank by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-dmg-last-fight-txt-name"]      = "Show Damage Done (D)"
L["ldb-menu-item-text-dmg-last-fight-tip-name"]      = "Show Damage Done (D)"
L["ldb-menu-item-text-dmg-last-fight-tip-desc"]      = "Enables the icon-text display of the damage done by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-dps-rank-last-fight-txt-name"] = "Show DPS Rank (DPS)"
L["ldb-menu-item-text-dps-rank-last-fight-tip-name"] = "Show DPS Rank (DPS)"
L["ldb-menu-item-text-dps-rank-last-fight-tip-desc"] = "Enables the icon-text display of the DPS rank of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-dps-last-fight-txt-name"]      = "Show DPS (DPS)"
L["ldb-menu-item-text-dps-last-fight-tip-name"]      = "Show DPS (DPS)"
L["ldb-menu-item-text-dps-last-fight-tip-desc"]      = "Enables the icon-text display of the DPS of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-heal-rank-last-fight-txt-name"]= "Show Healing Done Rank (H)"
L["ldb-menu-item-text-heal-rank-last-fight-tip-name"]= "Show Healing Done Rank (H)"
L["ldb-menu-item-text-heal-rank-last-fight-tip-desc"]= "Enables the icon-text display of the healing done rank by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-heal-last-fight-txt-name"]     = "Show Healing Done (H)"
L["ldb-menu-item-text-heal-last-fight-tip-name"]     = "Show Healing Done (H)"
L["ldb-menu-item-text-heal-last-fight-tip-desc"]     = "Enables the icon-text display of the healing done by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-hps-rank-last-fight-txt-name"] = "Show HPS Rank (HPS)"
L["ldb-menu-item-text-hps-rank-last-fight-tip-name"] = "Show HPS Rank (HPS)"
L["ldb-menu-item-text-hps-rank-last-fight-tip-desc"] = "Enables the icon-text display of the HPS rank of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-hps-last-fight-txt-name"]      = "Show HPS (HPS)"
L["ldb-menu-item-text-hps-last-fight-tip-name"]      = "Show HPS (HPS)"
L["ldb-menu-item-text-hps-last-fight-tip-desc"]      = "Enables the icon-text display of the HPS of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-time-last-fight-txt-name"]     = "Combat Time (T)"
L["ldb-menu-item-text-time-last-fight-tip-name"]     = "Combat Time (T)"
L["ldb-menu-item-text-time-last-fight-tip-desc"]     = "Enables the icon-text display of the duration of the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-name-last-fight-txt-name"]     = "Opponent Name (N)"
L["ldb-menu-item-text-name-last-fight-tip-name"]     = "Opponent Name (N)"
L["ldb-menu-item-text-name-last-fight-tip-desc"]     = "Enables the icon-text display of the opponent's name in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-text-overall-name"]                      = "Overall Data (O)"

L["ldb-menu-item-text-dmg-rank-overall-txt-name"]    = "Show Damage Done Rank (D)"
L["ldb-menu-item-text-dmg-rank-overall-tip-name"]    = "Show Damage Done Rank (D)"
L["ldb-menu-item-text-dmg-rank-overall-tip-desc"]    = "Enables the icon-text display of the damage done rank by the player overall across all recorded fights."

L["ldb-menu-item-text-dmg-overall-txt-name"]         = "Show Damage Done (D)"
L["ldb-menu-item-text-dmg-overall-tip-name"]         = "Show Damage Done (D)"
L["ldb-menu-item-text-dmg-overall-tip-desc"]         = "Enables the icon-text display of the damage done by the player overall across all recorded fights."

L["ldb-menu-item-text-dps-rank-overall-txt-name"]    = "Show DPS Rank (DPS)"
L["ldb-menu-item-text-dps-rank-overall-tip-name"]    = "Show DPS Rank (DPS)"
L["ldb-menu-item-text-dps-rank-overall-tip-desc"]    = "Enables the icon-text display of the DPS rank of the player overall across all recorded fights."

L["ldb-menu-item-text-dps-overall-txt-name"]         = "Show DPS (DPS)"
L["ldb-menu-item-text-dps-overall-tip-name"]         = "Show DPS (DPS)"
L["ldb-menu-item-text-dps-overall-tip-desc"]         = "Enables the icon-text display of the DPS of the player overall across all recorded fights."

L["ldb-menu-item-text-heal-rank-overall-txt-name"]   = "Show Healing Done Rank (H)"
L["ldb-menu-item-text-heal-rank-overall-tip-name"]   = "Show Healing Done Rank (H)"
L["ldb-menu-item-text-heal-rank-overall-tip-desc"]   = "Enables the icon-text display of the healing done rank by the player overall across all recorded fights."

L["ldb-menu-item-text-heal-overall-txt-name"]        = "Show Healing Done (H)"
L["ldb-menu-item-text-heal-overall-tip-name"]        = "Show Healing Done (H)"
L["ldb-menu-item-text-heal-overall-tip-desc"]        = "Enables the icon-text display of the healing done by the player overall across all recorded fights."

L["ldb-menu-item-text-hps-rank-overall-txt-name"]    = "Show HPS Rank (HPS)"
L["ldb-menu-item-text-hps-rank-overall-tip-name"]    = "Show HPS Rank (HPS)"
L["ldb-menu-item-text-hps-rank-overall-tip-desc"]    = "Enables the icon-text display of the HPS rank of the player overall across all recorded fights."

L["ldb-menu-item-text-hps-overall-txt-name"]         = "Show HPS (HPS)"
L["ldb-menu-item-text-hps-overall-tip-name"]         = "Show HPS (HPS)"
L["ldb-menu-item-text-hps-overall-tip-desc"]         = "Enables the icon-text display of the HPS of the player overall across all recorded fights."

L["ldb-menu-text-raid-data-name"]                    = "Raid Data"

L["ldb-menu-item-text-time-overall-txt-name"]        = "Combat Time (T)"
L["ldb-menu-item-text-time-overall-tip-name"]        = "Combat Time (T)"
L["ldb-menu-item-text-time-overall-tip-desc"]        = "Enables the icon-text display of the duration of all recorded fights."

L["ldb-menu-text-labels-name"]                       = "Text Labels"

L["ldb-menu-item-text-show-rank-label-txt-name"]     = "Show Rank Labels"
L["ldb-menu-item-text-show-rank-label-tip-name"]     = "Show Rank Labels"
L["ldb-menu-item-text-show-rank-label-tip-desc"]     = "Enables the display of rank labels within the icon-text."

L["ldb-menu-item-text-show-amount-label-txt-name"]   = "Show Amount Done Labels"
L["ldb-menu-item-text-show-amount-label-tip-name"]   = "Show Amount Done Labels"
L["ldb-menu-item-text-show-amount-label-tip-desc"]   = "Enables the display of amount done (eg: 'damage done', 'healing done') labels within the icon-text."

L["ldb-menu-item-text-show-rate-label-txt-name"]     = "Show Rate Labels"
L["ldb-menu-item-text-show-rate-label-tip-name"]     = "Show Rate Labels"
L["ldb-menu-item-text-show-rate-label-tip-desc"]     = "Enables the display of rate labels (eg: 'dps', 'hps') within the icon-text."

L["ldb-menu-item-text-show-time-label-txt-name"]     = "Show Time Labels"
L["ldb-menu-item-text-show-time-label-tip-name"]     = "Show Time Labels"
L["ldb-menu-item-text-show-time-label-tip-desc"]     = "Enables the display of time labels (eg: 'T:') within the icon-text."

L["ldb-menu-item-text-show-name-label-txt-name"]     = "Show Name Labels"
L["ldb-menu-item-text-show-name-label-tip-name"]     = "Show Name Labels"
L["ldb-menu-item-text-show-name-label-tip-desc"]     = "Enables the display of name labels (eg: 'N:') within the icon-text."

-- == "Tooltip" menu and its options. =========================================

L["ldb-menu-tip-opts-name"]                          = "Tooltip Options"

L["ldb-menu-heading-tip-opts-txt-name"]              = "Tooltip Options"
L["ldb-menu-heading-tip-opts-tip-name"]              = "Tooltip Options"
L["ldb-menu-heading-tip-opts-tip-desc"]              = "Provides configuration for the tooltip display."

L["ldb-menu-text-rank-tables-name"]                  = "Rank Tables"

L["ldb-menu-item-tip-show-damage-last-txt-name"]     = "Show Damage - Last Fight"
L["ldb-menu-item-tip-show-damage-last-tip-name"]     = "Show Damage - Last Fight"
L["ldb-menu-item-tip-show-damage-last-tip-desc"]     = "Enables the display of damage done in the last fight."

L["ldb-menu-item-tip-show-damage-overall-txt-name"]  = "Show Damage - Overall"
L["ldb-menu-item-tip-show-damage-overall-tip-name"]  = "Show Damage - Overall"
L["ldb-menu-item-tip-show-damage-overall-tip-desc"]  = "Enables the display of damage done overall."

L["ldb-menu-item-tip-show-healing-last-txt-name"]    = "Show Healing - Last Fight"
L["ldb-menu-item-tip-show-healing-last-tip-name"]    = "Show Healing - Last Fight"
L["ldb-menu-item-tip-show-healing-last-tip-desc"]    = "Enables the display of healing done in the last fight."

L["ldb-menu-item-tip-show-healing-overall-txt-name"] = "Show Healing - Overall"
L["ldb-menu-item-tip-show-healing-overall-tip-name"] = "Show Healing - Overall"
L["ldb-menu-item-tip-show-healing-overall-tip-desc"] = "Enables the display of healing done overall."

L["ldb-menu-text-summary-tables-name"]               = "Summary Tables"

L["ldb-menu-item-tip-show-group-last-txt-name"]      = "Show Group Summary - Last Fight"
L["ldb-menu-item-tip-show-group-last-tip-name"]      = "Show Group Summary - Last Fight"
L["ldb-menu-item-tip-show-group-last-tip-desc"]      = "Enables the display of the group summary for the last fight."

L["ldb-menu-item-tip-show-group-overall-txt-name"]   = "Show Group Summary - Overall"
L["ldb-menu-item-tip-show-group-overall-tip-name"]   = "Show Group Summary - Overall"
L["ldb-menu-item-tip-show-group-overall-tip-desc"]   = "Enables the display of the group summary overall."

L["ldb-menu-text-other-name"]                        = "Other Items"

L["ldb-menu-item-tip-show-button-actions-txt-name"]  = "Show Button Actions"
L["ldb-menu-item-tip-show-button-actions-tip-name"]  = "Show Button Actions"
L["ldb-menu-item-tip-show-button-actions-tip-desc"]  = "Enables the display of the advisory footer, describing the available button actions."

-- == "Table Size Limit" menu and its options. ================================

L["ldb-menu-table-size-limit-name"]                  = "Table Size Limit"

L["ldb-menu-heading-table-size-limit-txt-name"]      = "Table Size Limit"
L["ldb-menu-heading-table-size-limit-tip-name"]      = "Table Size Limit"
L["ldb-menu-heading-table-size-limit-tip-desc"]      = "Provides table-size limit options."

L["ldb-menu-item-table-size-limit-00-txt-name"]      = "No Limit"
L["ldb-menu-item-table-size-limit-00-tip-name"]      = "No Limit"
L["ldb-menu-item-table-size-limit-00-tip-desc"]      = "Show as many results as are available."

L["ldb-menu-item-table-size-limit-05-txt-name"]      = "Top 5"
L["ldb-menu-item-table-size-limit-05-tip-name"]      = "Top 5"
L["ldb-menu-item-table-size-limit-05-tip-desc"]      = "Limit table-size to show only the top 5 results."

L["ldb-menu-item-table-size-limit-10-txt-name"]      = "Top 10"
L["ldb-menu-item-table-size-limit-10-tip-name"]      = "Top 10"
L["ldb-menu-item-table-size-limit-10-tip-desc"]      = "Limit table-size to show only the top 10 results."

L["ldb-menu-item-table-size-limit-15-txt-name"]      = "Top 15"
L["ldb-menu-item-table-size-limit-15-tip-name"]      = "Top 15"
L["ldb-menu-item-table-size-limit-15-tip-desc"]      = "Limit table-size to show only the top 15 results."

L["ldb-menu-item-table-size-limit-20-txt-name"]      = "Top 20"
L["ldb-menu-item-table-size-limit-20-tip-name"]      = "Top 20"
L["ldb-menu-item-table-size-limit-20-tip-desc"]      = "Limit table-size to show only the top 20 results."

L["ldb-menu-item-table-size-limit-25-txt-name"]      = "Top 25"
L["ldb-menu-item-table-size-limit-25-tip-name"]      = "Top 25"
L["ldb-menu-item-table-size-limit-25-tip-desc"]      = "Limit table-size to show only the top 25 results."

L["ldb-menu-item-table-size-limit-30-txt-name"]      = "Top 30"
L["ldb-menu-item-table-size-limit-30-tip-name"]      = "Top 30"
L["ldb-menu-item-table-size-limit-30-tip-desc"]      = "Limit table-size to show only the top 30 results."

L["ldb-menu-item-table-size-limit-35-txt-name"]      = "Top 35"
L["ldb-menu-item-table-size-limit-35-tip-name"]      = "Top 35"
L["ldb-menu-item-table-size-limit-35-tip-desc"]      = "Limit table-size to show only the top 35 results."

L["ldb-menu-item-table-size-limit-40-txt-name"]      = "Top 40"
L["ldb-menu-item-table-size-limit-40-tip-name"]      = "Top 40"
L["ldb-menu-item-table-size-limit-40-tip-desc"]      = "Limit table-size to show only the top 40 results."


-- == "System" menu and its options. ==========================================

L["ldb-menu-system-name"]                            = "System"

L["ldb-menu-heading-system-txt-name"]                = "System"
L["ldb-menu-heading-system-tip-name"]                = "System"
L["ldb-menu-heading-system-tip-desc"]                = "Provides system functions."

L["ldb-menu-update-pulses-config-name"]              = "Update Pulses"

L["ldb-menu-fave-report-config-name"]                = "Favourite Report Options"

L["ldb-menu-item-debugmode-txt-name"]                = "Debug Mode"
L["ldb-menu-item-debugmode-tip-name"]                = "Debug Mode"
L["ldb-menu-item-debugmode-tip-desc"]                = "Enables the Debug Mode feature to be switched on and off."

-- == "Update Pulse Resting" menu and its options. ============================

L["ldb-menu-update-pulse-resting-name"]              = "Pulse Interval (Resting)"

L["ldb-menu-heading-update-pulse-resting-txt-name"]  = "Pulse Interval (Resting)"
L["ldb-menu-heading-update-pulse-resting-tip-name"]  = "Pulse Interval (Resting)"
L["ldb-menu-heading-update-pulse-resting-tip-desc"]  = "Select the interval for the update pulse to occur when resting."

-- == "Update Pulse Combat" menu and its options. =============================

L["ldb-menu-update-pulse-combat-name"]               = "Pulse Interval (Combat)"

L["ldb-menu-heading-update-pulse-combat-txt-name"]   = "Pulse Interval (Combat)"
L["ldb-menu-heading-update-pulse-combat-tip-name"]   = "Pulse Interval (Combat)"
L["ldb-menu-heading-update-pulse-combat-tip-desc"]   = "Select the interval for the update pulse to occur when in combat."

-- == "Update Pulse <...>" menus and their options. ===========================

L["ldb-menu-item-interval-secs-001-txt-name"]        = " 1 Second"
L["ldb-menu-item-interval-secs-001-tip-name"]        = " 1 Second"
L["ldb-menu-item-interval-secs-001-tip-desc"]        = "Set the pause between pulses to 1 second. (Useful if display of combat-time is enabled.)"

L["ldb-menu-item-interval-secs-005-txt-name"]        = "5 Seconds"
L["ldb-menu-item-interval-secs-005-tip-name"]        = "5 Seconds"
L["ldb-menu-item-interval-secs-005-tip-desc"]        = "Set the pause between pulses to 5 seconds. (The default resting pulse interval.)"

L["ldb-menu-item-interval-secs-010-txt-name"]        = "10 Seconds"
L["ldb-menu-item-interval-secs-010-tip-name"]        = "10 Seconds"
L["ldb-menu-item-interval-secs-010-tip-desc"]        = "Set the pause between pulses to 10 seconds. (A good choice for less powerful systems.)"

-- == "Favourite Report 1" menu and its options. ==============================

L["ldb-menu-fave-report-1-name"]                     = "Select Favourite Report 1"

L["ldb-menu-heading-fave-report-1-txt-name"]         = "Favourite Report 1"
L["ldb-menu-heading-fave-report-1-tip-name"]         = "Favourite Report 1"
L["ldb-menu-heading-fave-report-1-tip-desc"]         = "Select favourite report 1 from the list of available reports."

L["ldb-menu-item-fave-report-1-txt-name"]            = "Favourite Report 1"
L["ldb-menu-item-fave-report-1-tip-name"]            = "Favourite Report 1"
L["ldb-menu-item-fave-report-1-tip-desc"]            = "Select this report to be favourite report 1, accessible via the display icon using LMB+<Alt>."

-- == "Favourite Report 2" menu and its options. ==============================

L["ldb-menu-fave-report-2-name"]                     = "Select Favourite Report 2"

L["ldb-menu-heading-fave-report-2-txt-name"]         = "Favourite Report 2"
L["ldb-menu-heading-fave-report-2-tip-name"]         = "Favourite Report 2"
L["ldb-menu-heading-fave-report-2-tip-desc"]         = "Select favourite report 2 from the list of available reports."

L["ldb-menu-item-fave-report-2-txt-name"]            = "Favourite Report 2"
L["ldb-menu-item-fave-report-2-tip-name"]            = "Favourite Report 2"
L["ldb-menu-item-fave-report-2-tip-desc"]            = "Select this report to be favourite report 2, accessible via the display icon using LMB+<Ctrl>."

-- == "Favourite Report 3" menu and its options. ==============================

L["ldb-menu-fave-report-3-name"]                     = "Select Favourite Report 3"

L["ldb-menu-heading-fave-report-3-txt-name"]         = "Favourite Report 3"
L["ldb-menu-heading-fave-report-3-tip-name"]         = "Favourite Report 3"
L["ldb-menu-heading-fave-report-3-tip-desc"]         = "Select favourite report 3 from the list of available reports."

L["ldb-menu-item-fave-report-3-txt-name"]            = "Favourite Report 3"
L["ldb-menu-item-fave-report-3-tip-name"]            = "Favourite Report 3"
L["ldb-menu-item-fave-report-3-tip-desc"]            = "Select this report to be favourite report 3, accessible via the display icon using LMB+<Alt>+<Ctrl>."

-- == Common-to-All menu/options. =============================================

L["ldb-menu-item-toggle-compact-numbers-txt-name"]   = "Compact Numbers (1M, 2K...)"
L["ldb-menu-item-toggle-compact-numbers-tip-name"]   = "Compact Numbers (1M, 2K...)"
L["ldb-menu-item-toggle-compact-numbers-tip-desc"]   = "Toggles whether numbers are displayed in full or in compacted form."

L["ldb-menu-item-toggle-always-show-1dp-txt-name"]   = "Always Show 1DP (1.0K, 22.3K...)"
L["ldb-menu-item-toggle-always-show-1dp-tip-name"]   = "Always Show 1DP (1.0K, 22.3K...)"
L["ldb-menu-item-toggle-always-show-1dp-tip-desc"]   = "Toggles whether compact displays always show one decimal place or not."

L["ldb-menu-item-toggle-comma-period-separation-txt-name"] = "Comma-Period Separation (123,456.789)"
L["ldb-menu-item-toggle-comma-period-separation-tip-name"] = "Comma-Period Separation (123,456.789)"
L["ldb-menu-item-toggle-comma-period-separation-tip-desc"] = "Toggles whether comma-period or period-comma separation is used."

L["ldb-menu-quick-config-name"]             = "Quick Config"

-- == "Addon Text" labels and data. ===========================================
L["ldb-text-datatable-currentfight"]        = "C"
L["ldb-text-datatable-lastfight"]           = "LF"
L["ldb-text-datatable-overall"]             = "O"

L["ldb-text-datatype-damage-done-rank"]     = "D"
L["ldb-text-datatype-damage-done"]          = "D"

L["ldb-text-datatype-damage-rate-rank"]     = "DPS"
L["ldb-text-datatype-damage-rate"]          = "DPS"

L["ldb-text-datatype-healing-done-rank"]    = "H"
L["ldb-text-datatype-healing-done"]         = "H"

L["ldb-text-datatype-healing-rate-rank"]    = "HPS"
L["ldb-text-datatype-healing-rate"]         = "HPS"

L["ldb-text-datatype-combat-time"]          = "T"
L["ldb-text-datatype-opponent-name"]        = "N"

-- == "Addon Tooltip" labels and data. ========================================

L["ldb-tooltip-heading-norecount"]          = "Important:"
L["ldb-tootip-content-norecount-01"]        = "Recount cannot be found."
L["ldb-tootip-content-norecount-02"]        = "Please download, install and enable"
L["ldb-tootip-content-norecount-03"]        = "the Recount damage-meter addon."

L["ldb-tooltip-heading-nothing-enabled"]    = "Important:"
L["ldb-tootip-content-nothing-enabled-01"]  = "No tooltip content enabled."
L["ldb-tootip-content-nothing-enabled-02"]  = "Please enable tooltip content via"
L["ldb-tootip-content-nothing-enabled-03"]  = "the 'Tooltip Options' menu."

L["ldb-tooltip-lastfight-players-damage"]   = "Damage Done (Last Fight)"
L["ldb-tooltip-lastfight-players-healing"]  = "Healing Done (Last Fight)"
L["ldb-tooltip-overall-players-damage"]     = "Damage Done (Overall)"
L["ldb-tooltip-overall-players-healing"]    = "Healing Done (Overall)"
L["ldb-tooltip-lastfight-team"]             = "Summaries (Last Fight)"
L["ldb-tooltip-overall-team"]               = "Summaries (Overall)"

L["ldb-tooltip-damage-done"]                = "Damage Done"
L["ldb-tooltip-healing-done"]               = "Healing Done"
L["ldb-tooltip-damage-taken"]               = "Damage Taken"
L["ldb-tooltip-healing-taken"]              = "Healing Taken"

L["ldb-summary-nochange"]                   = "No Damage Change"
L["ldb-summary-damage"]                     = "Damage Summary"
L["ldb-summary-healing"]                    = "Healing Summary"

L["ldb-tooltip-no-data"]                    = "No data to display. Time to fight!"

L["ldb-tooltip-heading-actions"]            = "Button Actions:"
L["ldb-tooltip-item-label-left"]            = "Left Click"
L["ldb-tooltip-item-label-right"]           = "Right Click"

L["ldb-tooltip-item-value-left"]            = "Show/Hide Recount"
L["ldb-tooltip-item-value-left-alt"]        = "N/A"
L["ldb-tooltip-item-value-left-ctrl"]       = "N/A"
L["ldb-tooltip-item-value-left-ctrl-alt"]   = "N/A"

L["ldb-tooltip-item-value-right"]           = "Show Menu"
L["ldb-tooltip-item-value-right-alt"]       = "Reset Data"
L["ldb-tooltip-item-value-right-ctrl"]      = "Reset Positions"
L["ldb-tooltip-item-value-right-ctrl-alt"]  = "Config Recount"

L["ldb-tooltip-item-plus-alt"]              = "+<Alt>"
L["ldb-tooltip-item-plus-ctl"]              = "+<Ctrl>"

-- ============================================================================
-- == Localisation Data for Component: BRFCommon                             ==
-- ============================================================================
L["cmn-classname-functional-deathknight"]   = "DEATHKNIGHT"
L["cmn-classname-functional-druid"]         = "DRUID"
L["cmn-classname-functional-hunter"]        = "HUNTER"
L["cmn-classname-functional-mage"]          = "MAGE"
L["cmn-classname-functional-monk"]          = "MONK"
L["cmn-classname-functional-paladin"]       = "PALADIN"
L["cmn-classname-functional-priest"]        = "PRIEST"
L["cmn-classname-functional-rogue"]         = "ROGUE"
L["cmn-classname-functional-shaman"]        = "SHAMAN"
L["cmn-classname-functional-warrior"]       = "WARRIOR"
L["cmn-classname-functional-warlock"]       = "WARLOCK"

-- ============================================================================
-- == Localisation Data for Component: BRFConfig.                            ==
-- ============================================================================

L["cfg-display-data-title"]                 = "[BRF] - Config - "

L["cfg-console-command-long"]               = "BrokerRecountFu"
L["cfg-console-command-short"]              = "brf"

L["cfg-feature-name-autoinvitations"]       = "AutoInvitations"
L["cfg-feature-desc-autoinvitations"]       = "Determines whether auto-invitations is turned on or off."

L["cfg-feature-name-debugmode"]             = "DebugMode"
L["cfg-feature-desc-debugmode"]             = "Determines whether debug-mode is turned on or off."

-- ============================================================================
-- == Localisation Data for Component: BRFConsole.                           ==
-- ============================================================================
L["con-player-not-in-guild"]                 = "[BRF] - SafeChannel - Not in guild, redirecting output to CHAT."
L["con-player-not-in-raid"]                  = "[BRF] - SafeChannel - Not in raid, redirecting output to PARTY."
L["con-player-not-in-party"]                 = "[BRF] - SafeChannel - Not in party, redirecting output to CHAT."

-- ============================================================================
-- == Localisation Data for Component: BRFData.                              ==
-- ============================================================================
L["data-numerical-separator-comma"]          = ","
L["data-numerical-separator-period"]         = "."

L["data-conversion-boolean-as-text-yes"]     = "Yes"
L["data-conversion-boolean-as-text-no"]      = "No"

L["data-numerical-unit-thousands"]           = "K"
L["data-numerical-unit-millions"]            = "M"
L["data-numerical-unit-billions"]            = "B"
L["data-numerical-unit-trillions"]           = "T"

-- ============================================================================
-- == Localisation Data for Component: BRFRecount.                           ==
-- ============================================================================
L["rct-datatable-currentfight"]              = "CurrentFightData"
L["rct-datatable-overall"]                   = "OverallData"
L["rct-datatable-lastfight"]                 = "LastFightData"

L["rct-datatype-damage"]                     = "Damage"
L["rct-datatype-healing"]                    = "Healing"
L["rct-datatype-damagetaken"]                = "DamageTaken"
L["rct-datatype-healingtaken"]               = "HealingTaken"
L["rct-datatype-activetime"]                 = "ActiveTime"

L["rct-datatype-dps"]                        = "DPS"
L["rct-datatype-hps"]                        = "HPS"

-- ============================================================================
-- == End of Document.                                                       ==
-- ============================================================================
