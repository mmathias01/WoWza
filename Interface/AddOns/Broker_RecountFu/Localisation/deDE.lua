local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("BrokerRecountFu", "deDE")
if not L then return end

L["addon-desc-00"] = "Ein erweitertes Broker plugin f\195\188r Recount benutzer."
L["addon-desc-01"] = "Alle Informationen direkt vor deiner Nase!"
L["addon-desc-02"] = "Gewinnst du?"

-- "WoW API" options. ====================================================

L["wow-api-lmb-click"] = "LeftButton"
L["wow-api-rmb-click"] = "RightButton"

-- ========================================================================
-- Localisation Data for Component: Broker_RecountFu. 
-- ========================================================================

-- "BrokerRecountFu" menu and its options. ===============================

L["ldb-menu-main-name"] = "Broker_RecountFu Menu"

L["ldb-menu-item-about-txt-name"] = "\195\156ber"
L["ldb-menu-item-about-tip-name"] = "\195\156ber"
L["ldb-menu-item-about-tip-desc"] = "\195\156ber das Broker_RecountFu Addon."

L["ldb-menu-item-closemenu-txt-name"] = "Men\195\188 Schlie\195\159en"
L["ldb-menu-item-closemenu-tip-name"] = "Men\195\188 Schlie\195\159en"
L["ldb-menu-item-closemenu-tip-desc"] = "Schlie\195\159t und versteckt die drop-down Men\195\188s."

-- "Recount" menu and its options. =======================================

L["ldb-menu-recount-name"] = "Recount Optionen"

L["ldb-menu-heading-recount-txt-name"] = "Recount Optionen"
L["ldb-menu-heading-recount-tip-name"] = "Recount Optionen"
L["ldb-menu-heading-recount-tip-desc"] = "Provides options provided by Recount."

L["ldb-menu-window-controls-name"] = "Fenster Einstellungen"

L["ldb-menu-item-toggle-window-visibility-txt-name"] = "Fenster Sichtbarkeit"
L["ldb-menu-item-toggle-window-visibility-tip-name"] = "Fenster Sichtbarkeit"
L["ldb-menu-item-toggle-window-visibility-tip-desc"] = "Toggles whether the main Recount window is shown or hidden."

L["ldb-menu-item-toggle-window-lock-txt-name"] = "Fenster Sperre"
L["ldb-menu-item-toggle-window-lock-tip-name"] = "Fenster Sperre"
L["ldb-menu-item-toggle-window-lock-tip-desc"] = "Umschalten zwischen gesperrtem und ungesperrten Recount Fenster."

L["ldb-menu-item-reset-window-position-txt-name"] = "Fenster Positionen zur\195\188cksetzen"
L["ldb-menu-item-reset-window-position-tip-name"] = "Fenster Positionen zur\195\188cksetzen"
L["ldb-menu-item-reset-window-position-tip-desc"] = "Setzt die Fenster Positionen von allen Recount Fenstern zur\195\188ck."

L["ldb-menu-item-recount-config-window-txt-name"] = "Recount Konfigurieren"
L["ldb-menu-item-recount-config-window-tip-name"] = "Recount Konfigurieren"
L["ldb-menu-item-recount-config-window-tip-desc"] = "\195\150ffnet das Recount Konfigurieren Fenster."

-- "View Report" menu and its options. ===================================

L["ldb-menu-view-report-name"] = "Zeige Report"

L["ldb-menu-heading-view-report-txt-name"] = "Zeige Report"
L["ldb-menu-heading-view-report-tip-name"] = "Zeige Report"
L["ldb-menu-heading-view-report-tip-desc"] = "Provides access to Recount’s report viewing modes."

L["ldb-menu-item-view-report-description"] = "Zeige gew\195\164hlten Report in Recount."

-- "Send Report" menu and its options. ===================================

L["ldb-menu-send-report-name"] = "Sende Report"

L["ldb-menu-heading-send-report-txt-name"] = "Sende Report"
L["ldb-menu-heading-send-report-tip-name"] = "Sende Report"
L["ldb-menu-heading-send-report-tip-desc"] = "Provides access to Recount’s report sending modes."

L["ldb-menu-item-send-main-data-txt-name"] = "Vom Hauptfenster"
L["ldb-menu-item-send-main-data-tip-name"] = "Vom Hauptfenster"
L["ldb-menu-item-send-main-data-tip-desc"] = "Opens the Recount dialog allowing you to send a report containing data from the main window."

L["ldb-menu-item-send-main-title"] = "Hauptfenster"

L["ldb-menu-item-send-detail-data-txt-name"] = "Vom Detail Fenster"
L["ldb-menu-item-send-detail-data-tip-name"] = "Vom Detail Fenster"
L["ldb-menu-item-send-detail-data-tip-desc"] = "Opens the Recount dialog allowing you to send a report containing data from the detail window."

L["ldb-menu-item-send-detail-title"] = "Detail"

-- "View Realtime Stats" menu and its options. ===========================

L["ldb-menu-view-realtime-stats-name"] = "Zeige Echtzeit Stats"

L["ldb-menu-heading-view-realtime-stats-txt-name"] = "Zeige Echtzeit Stats"
L["ldb-menu-heading-view-realtime-stats-tip-name"] = "Zeige Echtzeit Stats"
L["ldb-menu-heading-view-realtime-stats-tip-desc"] = "Provides access to Recount’s realtime stats viewing modes."

L["ldb-menu-item-view-realtime-stats-description"] = "View the realtime-stats windows of Recount."

L["ldb-menu-item-realtime-fps-txt-name"] = "FPS"
L["ldb-menu-item-realtime-fps-tip-name"] = "FPS"
L["ldb-menu-item-realtime-fps-tip-desc"] = "Opens the realtime-stats window, displaying FPS data."

L["ldb-menu-item-realtime-lag-txt-name"] = "Lag"
L["ldb-menu-item-realtime-lag-tip-name"] = "Lag"
L["ldb-menu-item-realtime-lag-tip-desc"] = "Opens the realtime-stats window, displaying Lag data."

L["ldb-menu-item-realtime-upstream-txt-name"] = "Upstream Traffic"
L["ldb-menu-item-realtime-upstream-tip-name"] = "Upstream Traffic"
L["ldb-menu-item-realtime-upstream-tip-desc"] = "Opens the realtime-stats window, displaying Upstream Traffic data."

L["ldb-menu-item-realtime-downstream-txt-name"] = "Downstream Traffic"
L["ldb-menu-item-realtime-downstream-tip-name"] = "Downstream Traffic"
L["ldb-menu-item-realtime-downstream-tip-desc"] = "Opens the realtime-stats window, displaying Downstream Traffic data."

L["ldb-menu-item-realtime-bandwidth-txt-name"] = "Available Bandwidth"
L["ldb-menu-item-realtime-bandwidth-tip-name"] = "Available Bandwidth"
L["ldb-menu-item-realtime-bandwidth-tip-desc"] = "Opens the realtime-stats window, displaying Available Bandwidth data."

L["ldb-menu-item-realtime-raid-dps-txt-name"] = "Raid DPS"
L["ldb-menu-item-realtime-raid-dps-tip-name"] = "Raid DPS"
L["ldb-menu-item-realtime-raid-dps-tip-desc"] = "Opens the realtime-stats window, displaying Raid DPS data. (Damage-done Per Second)"

L["ldb-menu-item-realtime-raid-dtps-txt-name"] = "Raid DTPS"
L["ldb-menu-item-realtime-raid-dtps-tip-name"] = "Raid DTPS"
L["ldb-menu-item-realtime-raid-dtps-tip-desc"] = "Opens the realtime-stats window, displaying Raid DTPS data. (Damage Taken Per Second)"

L["ldb-menu-item-realtime-raid-hps-txt-name"] = "Raid HPS"
L["ldb-menu-item-realtime-raid-hps-tip-name"] = "Raid HPS"
L["ldb-menu-item-realtime-raid-hps-tip-desc"] = "Opens the realtime-stats window, displaying Raid HPS data. (Healing-done Per Second)"

L["ldb-menu-item-realtime-raid-htps-txt-name"] = "Raid HTPS"
L["ldb-menu-item-realtime-raid-htps-tip-name"] = "Raid HTPS"
L["ldb-menu-item-realtime-raid-htps-tip-desc"] = "Opens the realtime-stats window, displaying Raid HTPS data. (Healing Taken Per Second)"

-- "Text" menu and its options. =======================================

L["ldb-menu-text-opts-name"] = "Text Optionen"

L["ldb-menu-heading-text-opts-txt-name"] = "Text Optionen"
L["ldb-menu-heading-text-opts-tip-name"] = "Text Optionen"
L["ldb-menu-heading-text-opts-tip-desc"] = "Provides configuration for the text display."

L["ldb-menu-text-last-fight-name"] = "Momentaner/Letzter-Kampf Daten (M/L)"

L["ldb-menu-item-text-dmg-rank-last-fight-txt-name"] = "Zeige Schaden gemacht Rang (D)"
L["ldb-menu-item-text-dmg-rank-last-fight-tip-name"] = "Zeige Schaden gemacht Rang (D)"
L["ldb-menu-item-text-dmg-rank-last-fight-tip-desc"] = "Enables the icon-text display of the damage done rank by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-dmg-last-fight-txt-name"] = "Zeige Schaden gemacht (D)"
L["ldb-menu-item-text-dmg-last-fight-tip-name"] = "Zeige Schaden gemacht (D)"
L["ldb-menu-item-text-dmg-last-fight-tip-desc"] = "Enables the icon-text display of the damage done by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-dps-rank-last-fight-txt-name"] = "Zeige DPS Rang (DPS)"
L["ldb-menu-item-text-dps-rank-last-fight-tip-name"] = "Zeige DPS Rang (DPS)"
L["ldb-menu-item-text-dps-rank-last-fight-tip-desc"] = "Enables the icon-text display of the DPS rank of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-dps-last-fight-txt-name"] = "Zeige DPS (DPS)"
L["ldb-menu-item-text-dps-last-fight-tip-name"] = "Zeige DPS (DPS)"
L["ldb-menu-item-text-dps-last-fight-tip-desc"] = "Enables the icon-text display of the DPS of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-heal-rank-last-fight-txt-name"]= "Zeige Heilungs Rang (H)"
L["ldb-menu-item-text-heal-rank-last-fight-tip-name"]= "Zeige Heilungs Rang (H)"
L["ldb-menu-item-text-heal-rank-last-fight-tip-desc"]= "Enables the icon-text display of the healing done rank by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-heal-last-fight-txt-name"] = "Zeige gewirkte Heilung (H)"
L["ldb-menu-item-text-heal-last-fight-tip-name"] = "Zeige gewirkte Heilung (H)"
L["ldb-menu-item-text-heal-last-fight-tip-desc"] = "Enables the icon-text display of the healing done by the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-hps-rank-last-fight-txt-name"] = "Zeige HPS Rang (HPS)"
L["ldb-menu-item-text-hps-rank-last-fight-tip-name"] = "Zeige HPS Rang (HPS)"
L["ldb-menu-item-text-hps-rank-last-fight-tip-desc"] = "Enables the icon-text display of the HPS rank of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-hps-last-fight-txt-name"] = "Zeige HPS (HPS)"
L["ldb-menu-item-text-hps-last-fight-tip-name"] = "Zeige HPS (HPS)"
L["ldb-menu-item-text-hps-last-fight-tip-desc"] = "Enables the icon-text display of the HPS of the player in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-time-last-fight-txt-name"] = "Kampf Zeit (Z)"
L["ldb-menu-item-text-time-last-fight-tip-name"] = "Kampf Zeit (Z)"
L["ldb-menu-item-text-time-last-fight-tip-desc"] = "Enables the icon-text display of the duration of the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-item-text-name-last-fight-txt-name"] = "Gegner Name (N)"
L["ldb-menu-item-text-name-last-fight-tip-name"] = "Gegner Name (N)"
L["ldb-menu-item-text-name-last-fight-tip-desc"] = "Enables the icon-text display of the opponent’s name in the last fight when out of combat or in the current fight when in combat."

L["ldb-menu-text-overall-name"] = "Gesamt Daten (O)"

L["ldb-menu-item-text-dmg-rank-overall-txt-name"] = "Zeige Schaden gemacht Rang (D)"
L["ldb-menu-item-text-dmg-rank-overall-tip-name"] = "Zeige Schaden gemacht Rang (D)"
L["ldb-menu-item-text-dmg-rank-overall-tip-desc"] = "Enables the icon-text display of the damage done rank by the player overall across all recorded fights."

L["ldb-menu-item-text-dmg-overall-txt-name"] = "Zeige Schaden gemacht (D)"
L["ldb-menu-item-text-dmg-overall-tip-name"] = "Zeige Schaden gemacht (D)"
L["ldb-menu-item-text-dmg-overall-tip-desc"] = "Enables the icon-text display of the damage done by the player overall across all recorded fights."

L["ldb-menu-item-text-dps-rank-overall-txt-name"] = "Zeige DPS Rang (DPS)"
L["ldb-menu-item-text-dps-rank-overall-tip-name"] = "Zeige DPS Rang (DPS)"
L["ldb-menu-item-text-dps-rank-overall-tip-desc"] = "Enables the icon-text display of the DPS rank of the player overall across all recorded fights."

L["ldb-menu-item-text-dps-overall-txt-name"] = "Zeige DPS (DPS)"
L["ldb-menu-item-text-dps-overall-tip-name"] = "Zeige DPS (DPS)"
L["ldb-menu-item-text-dps-overall-tip-desc"] = "Enables the icon-text display of the DPS of the player overall across all recorded fights."

L["ldb-menu-item-text-heal-rank-overall-txt-name"] = "Zeige Geheilt Rang (H)"
L["ldb-menu-item-text-heal-rank-overall-tip-name"] = "Zeige Geheilt Rang (H)"
L["ldb-menu-item-text-heal-rank-overall-tip-desc"] = "Enables the icon-text display of the healing done rank by the player overall across all recorded fights."

L["ldb-menu-item-text-heal-overall-txt-name"] = "Zeige Geheilt (H)"
L["ldb-menu-item-text-heal-overall-tip-name"] = "Zeige Geheilt (H)"
L["ldb-menu-item-text-heal-overall-tip-desc"] = "Enables the icon-text display of the healing done by the player overall across all recorded fights."

L["ldb-menu-item-text-hps-rank-overall-txt-name"] = "Zeige HPS Rang (HPS)"
L["ldb-menu-item-text-hps-rank-overall-tip-name"] = "Zeige HPS Rang (HPS)"
L["ldb-menu-item-text-hps-rank-overall-tip-desc"] = "Enables the icon-text display of the HPS rank of the player overall across all recorded fights."

L["ldb-menu-item-text-hps-overall-txt-name"] = "Zeige HPS (HPS)"
L["ldb-menu-item-text-hps-overall-tip-name"] = "Zeige HPS (HPS)"
L["ldb-menu-item-text-hps-overall-tip-desc"] = "Enables the icon-text display of the HPS of the player overall across all recorded fights."

L["ldb-menu-text-raid-data-name"] = "Raid Daten"

L["ldb-menu-item-text-time-overall-txt-name"] = "Kampf Zeit (Z)"
L["ldb-menu-item-text-time-overall-tip-name"] = "Kampf Zeit (Z)"
L["ldb-menu-item-text-time-overall-tip-desc"] = "Enables the icon-text display of the duration of all recorded fights."

L["ldb-menu-text-labels-name"] = "Text Label"

L["ldb-menu-item-text-show-rank-label-txt-name"] = "Zeige Rang Label"
L["ldb-menu-item-text-show-rank-label-tip-name"] = "Zeige Rang Label"
L["ldb-menu-item-text-show-rank-label-tip-desc"] = "Enables the display of rank labels within the icon-text."

L["ldb-menu-item-text-show-amount-label-txt-name"] = "Zeige Amount Done Label"
L["ldb-menu-item-text-show-amount-label-tip-name"] = "Zeige Amount Done Label"
L["ldb-menu-item-text-show-amount-label-tip-desc"] = "Enables the display of amount done (eg: 'damage done’, 'healing done’) labels within the icon-text."

L["ldb-menu-item-text-show-rate-label-txt-name"] = "Zeige Rate Label"
L["ldb-menu-item-text-show-rate-label-tip-name"] = "Zeige Rate Label"
L["ldb-menu-item-text-show-rate-label-tip-desc"] = "Enables the display of rate labels (eg: 'dps’, 'hps’) within the icon-text."

L["ldb-menu-item-text-show-time-label-txt-name"] = "Zeige Zeit Label"
L["ldb-menu-item-text-show-time-label-tip-name"] = "Zeige Zeit Label"
L["ldb-menu-item-text-show-time-label-tip-desc"] = "Enables the display of time labels (eg: 'T:’) within the icon-text."

L["ldb-menu-item-text-show-name-label-txt-name"] = "Zeige Namens Label"
L["ldb-menu-item-text-show-name-label-tip-name"] = "Zeige Namens Label"
L["ldb-menu-item-text-show-name-label-tip-desc"] = "Enables the display of name labels (eg: 'N:’) within the icon-text."

-- "Tooltip" menu and its options. =======================================

L["ldb-menu-tip-opts-name"] = "Tooltip Optionen"

L["ldb-menu-heading-tip-opts-txt-name"] = "Tooltip Optionen"
L["ldb-menu-heading-tip-opts-tip-name"] = "Tooltip Optionen"
L["ldb-menu-heading-tip-opts-tip-desc"] = "Provides configuration for the tooltip display."

L["ldb-menu-text-rank-tables-name"] = "Rang Tabellen"

L["ldb-menu-item-tip-show-damage-last-txt-name"] = "Zeige Schaden - Letzter Kampf"
L["ldb-menu-item-tip-show-damage-last-tip-name"] = "Zeige Schaden - Letzter Kampf"
L["ldb-menu-item-tip-show-damage-last-tip-desc"] = "Enables the display of damage done in the last fight."

L["ldb-menu-item-tip-show-damage-overall-txt-name"] = "Zeige Schaden - Gesamt"
L["ldb-menu-item-tip-show-damage-overall-tip-name"] = "Zeige Schaden - Gesamt"
L["ldb-menu-item-tip-show-damage-overall-tip-desc"] = "Enables the display of damage done overall."

L["ldb-menu-item-tip-show-healing-last-txt-name"] = "Zeige Heilung - Letzter Kampf"
L["ldb-menu-item-tip-show-healing-last-tip-name"] = "Zeige Heilung - Letzter Kampf"
L["ldb-menu-item-tip-show-healing-last-tip-desc"] = "Enables the display of healing done in the last fight."

L["ldb-menu-item-tip-show-healing-overall-txt-name"] = "Zeige Heilung - Gesamt"
L["ldb-menu-item-tip-show-healing-overall-tip-name"] = "Zeige Heilung - Gesamt"
L["ldb-menu-item-tip-show-healing-overall-tip-desc"] = "Enables the display of healing done overall."

L["ldb-menu-text-summary-tables-name"] = "Zusammenfassungs Tabellen"

L["ldb-menu-item-tip-show-group-last-txt-name"] = "Zeige Gruppen Zusammenfassung - Letzter Kampf"
L["ldb-menu-item-tip-show-group-last-tip-name"] = "Zeige Gruppen Zusammenfassung - Letzter Kampf"
L["ldb-menu-item-tip-show-group-last-tip-desc"] = "Enables the display of the group summary for the last fight."

L["ldb-menu-item-tip-show-group-overall-txt-name"] = "Zeige Gruppen Zusammenfassung - Gesamt"
L["ldb-menu-item-tip-show-group-overall-tip-name"] = "Zeige Gruppen Zusammenfassung - Gesamt"
L["ldb-menu-item-tip-show-group-overall-tip-desc"] = "Enables the display of the group summary overall."

L["ldb-menu-text-other-name"] = "Andere Sachen"

L["ldb-menu-item-tip-show-button-actions-txt-name"] = "Zeige Tastaturbelegug"
L["ldb-menu-item-tip-show-button-actions-tip-name"] = "Zeige Tastaturbelegug"
L["ldb-menu-item-tip-show-button-actions-tip-desc"] = "Enables the display of the advisory footer, describing the available button actions."

-- "Table Size Limit" menu and its options. ==============================

L["ldb-menu-table-size-limit-name"] = "Tabellen gr\195\182\195\159en Limit"

L["ldb-menu-heading-table-size-limit-txt-name"] = "Tabellen gr\195\182\195\159en Limit"
L["ldb-menu-heading-table-size-limit-tip-name"] = "Tabellen gr\195\182\195\159en Limit"
L["ldb-menu-heading-table-size-limit-tip-desc"] = "Provides table-size limit options."

L["ldb-menu-item-table-size-limit-00-txt-name"] = "Kein Limit"
L["ldb-menu-item-table-size-limit-00-tip-name"] = "Kein Limit"
L["ldb-menu-item-table-size-limit-00-tip-desc"] = "Show as many results as are available."

L["ldb-menu-item-table-size-limit-05-txt-name"] = "Top 5"
L["ldb-menu-item-table-size-limit-05-tip-name"] = "Top 5"
L["ldb-menu-item-table-size-limit-05-tip-desc"] = "Limit table-size to show only the top 5 results."

L["ldb-menu-item-table-size-limit-10-txt-name"] = "Top 10"
L["ldb-menu-item-table-size-limit-10-tip-name"] = "Top 10"
L["ldb-menu-item-table-size-limit-10-tip-desc"] = "Limit table-size to show only the top 10 results."

L["ldb-menu-item-table-size-limit-15-txt-name"] = "Top 15"
L["ldb-menu-item-table-size-limit-15-tip-name"] = "Top 15"
L["ldb-menu-item-table-size-limit-15-tip-desc"] = "Limit table-size to show only the top 15 results."

L["ldb-menu-item-table-size-limit-20-txt-name"] = "Top 20"
L["ldb-menu-item-table-size-limit-20-tip-name"] = "Top 20"
L["ldb-menu-item-table-size-limit-20-tip-desc"] = "Limit table-size to show only the top 20 results."

L["ldb-menu-item-table-size-limit-25-txt-name"] = "Top 25"
L["ldb-menu-item-table-size-limit-25-tip-name"] = "Top 25"
L["ldb-menu-item-table-size-limit-25-tip-desc"] = "Limit table-size to show only the top 25 results."

L["ldb-menu-item-table-size-limit-30-txt-name"] = "Top 30"
L["ldb-menu-item-table-size-limit-30-tip-name"] = "Top 30"
L["ldb-menu-item-table-size-limit-30-tip-desc"] = "Limit table-size to show only the top 30 results."

L["ldb-menu-item-table-size-limit-35-txt-name"] = "Top 35"
L["ldb-menu-item-table-size-limit-35-tip-name"] = "Top 35"
L["ldb-menu-item-table-size-limit-35-tip-desc"] = "Limit table-size to show only the top 35 results."

L["ldb-menu-item-table-size-limit-40-txt-name"] = "Top 40"
L["ldb-menu-item-table-size-limit-40-tip-name"] = "Top 40"
L["ldb-menu-item-table-size-limit-40-tip-desc"] = "Limit table-size to show only the top 40 results."

-- "System" menu and its options. ========================================

L["ldb-menu-system-name"] = "System"

L["ldb-menu-heading-system-txt-name"] = "System"
L["ldb-menu-heading-system-tip-name"] = "System"
L["ldb-menu-heading-system-tip-desc"] = "Provides system functions."

L["ldb-menu-update-pulses-config-name"] = "Update Intervall"

L["ldb-menu-fave-report-config-name"] = "Lieblingsreport Options"

L["ldb-menu-item-debugmode-txt-name"] = "Debug Modus"
L["ldb-menu-item-debugmode-tip-name"] = "Debug Modus"
L["ldb-menu-item-debugmode-tip-desc"] = "Enables the Debug Mode feature to be switched on and off."

-- "Update Pulse Resting" menu and its options. ==========================

L["ldb-menu-update-pulse-resting-name"] = "Pulse Intervall (ruhend)"

L["ldb-menu-heading-update-pulse-resting-txt-name"] = "Pulse Intervall (ruhend)"
L["ldb-menu-heading-update-pulse-resting-tip-name"] = "Pulse Intervall (ruhend)"
L["ldb-menu-heading-update-pulse-resting-tip-desc"] = "Select the interval for the update pulse to occur when resting."

-- "Update Pulse Combat" menu and its options. ===========================

L["ldb-menu-update-pulse-combat-name"] = "Pulse Intervall (im Kampf)"

L["ldb-menu-heading-update-pulse-combat-txt-name"] = "Pulse Intervall (im Kampf)"
L["ldb-menu-heading-update-pulse-combat-tip-name"] = "Pulse Intervall (im Kampf)"
L["ldb-menu-heading-update-pulse-combat-tip-desc"] = "Select the interval for the update pulse to occur when in combat."

-- "Update Pulse <...>" menus and their options. =========================

L["ldb-menu-item-interval-secs-001-txt-name"] = " 1 Sekunde"
L["ldb-menu-item-interval-secs-001-tip-name"] = " 1 Sekunde"
L["ldb-menu-item-interval-secs-001-tip-desc"] = "Set the pause between pulses to 1 second. (Useful if display of combat-time is enabled.)"

L["ldb-menu-item-interval-secs-005-txt-name"] = "5 Sekunden"
L["ldb-menu-item-interval-secs-005-tip-name"] = "5 Sekunden"
L["ldb-menu-item-interval-secs-005-tip-desc"] = "Set the pause between pulses to 5 seconds. (The default resting pulse interval.)"

L["ldb-menu-item-interval-secs-010-txt-name"] = "10 Sekunden"
L["ldb-menu-item-interval-secs-010-tip-name"] = "10 Sekunden"
L["ldb-menu-item-interval-secs-010-tip-desc"] = "Set the pause between pulses to 10 seconds. (A good choice for less powerful systems.)"

-- "Favourite Report 1" menu and its options. ============================

L["ldb-menu-fave-report-1-name"] = "W\195\164hle Favourite Report 1"

L["ldb-menu-heading-fave-report-1-txt-name"] = "Lieblingsreport 1"
L["ldb-menu-heading-fave-report-1-tip-name"] = "Lieblingsreport 1"
L["ldb-menu-heading-fave-report-1-tip-desc"] = "Select favourite report 1 from the list of available reports."

L["ldb-menu-item-fave-report-1-txt-name"] = "Lieblingsreport 1"
L["ldb-menu-item-fave-report-1-tip-name"] = "Lieblingsreport 1"
L["ldb-menu-item-fave-report-1-tip-desc"] = "Select this report to be favourite report 1, accessible via the display icon using LMB+."

-- "Favourite Report 2" menu and its options. ============================

L["ldb-menu-fave-report-2-name"] = "W\195\164hle Lieblingsreport 2"

L["ldb-menu-heading-fave-report-2-txt-name"] = "Lieblingsreport 2"
L["ldb-menu-heading-fave-report-2-tip-name"] = "Lieblingsreport 2"
L["ldb-menu-heading-fave-report-2-tip-desc"] = "Select favourite report 2 from the list of available reports."

L["ldb-menu-item-fave-report-2-txt-name"] = "Lieblingsreport 2"
L["ldb-menu-item-fave-report-2-tip-name"] = "Lieblingsreport 2"
L["ldb-menu-item-fave-report-2-tip-desc"] = "Select this report to be favourite report 2, accessible via the display icon using LMB+."

-- "Favourite Report 3" menu and its options. ============================

L["ldb-menu-fave-report-3-name"] = "W\195\164hle Lieblingsreport 3"

L["ldb-menu-heading-fave-report-3-txt-name"] = "Lieblingsreport 3"
L["ldb-menu-heading-fave-report-3-tip-name"] = "Lieblingsreport 3"
L["ldb-menu-heading-fave-report-3-tip-desc"] = "Select favourite report 3 from the list of available reports."

L["ldb-menu-item-fave-report-3-txt-name"] = "Lieblingsreport 3"
L["ldb-menu-item-fave-report-3-tip-name"] = "Lieblingsreport 3"
L["ldb-menu-item-fave-report-3-tip-desc"] = "Select this report to be favourite report 3, accessible via the display icon using LMB++."

-- Common-to-All menu/options. ===========================================

L["ldb-menu-quick-config-name"] = "Schnell Konfiguration"

-- "Addon Text" labels and data. =========================================
L["ldb-text-datatable-currentfight"] = "M"
L["ldb-text-datatable-lastfight"] = "L"
L["ldb-text-datatable-overall"] = "O"

L["ldb-text-datatype-damage-done-rank"] = "D"
L["ldb-text-datatype-damage-done"] = "D"

L["ldb-text-datatype-damage-rate-rank"] = "DPS"
L["ldb-text-datatype-damage-rate"] = "DPS"

L["ldb-text-datatype-healing-done-rank"] = "H"
L["ldb-text-datatype-healing-done"] = "H"

L["ldb-text-datatype-healing-rate-rank"] = "HPS"
L["ldb-text-datatype-healing-rate"] = "HPS"

L["ldb-text-datatype-combat-time"] = "Z"
L["ldb-text-datatype-opponent-name"] = "N"

-- "Addon Tooltip" labels and data. ======================================

L["ldb-tooltip-heading-norecount"] = "Important:"
L["ldb-tootip-content-norecount-01"] = "Recount cannot be found."
L["ldb-tootip-content-norecount-02"] = "Please download, install and enable"
L["ldb-tootip-content-norecount-03"] = "the Recount damage-meter addon."

L["ldb-tooltip-heading-nothing-enabled"] = "Important:"
L["ldb-tootip-content-nothing-enabled-01"] = "No tooltip content enabled."
L["ldb-tootip-content-nothing-enabled-02"] = "Please enable tooltip content via"
L["ldb-tootip-content-nothing-enabled-03"] = "the 'Tooltip Options’ menu."

L["ldb-tooltip-lastfight-players-damage"] = "Schaden gemacht (Letzter Kampf)"
L["ldb-tooltip-lastfight-players-healing"] = "Geheilt f\195\188r (Letzter Kampf)"
L["ldb-tooltip-overall-players-damage"] = "Schaden gemacht (gesamt)"
L["ldb-tooltip-overall-players-healing"] = "Geheilt f\195\188r (gesamt)"
L["ldb-tooltip-lastfight-team"] = "Zusammenfassung (Letzter Kampf)"
L["ldb-tooltip-overall-team"] = "Zusammenfassung (gesamt)"

L["ldb-tooltip-damage-done"] = "Schaden gemacht"
L["ldb-tooltip-healing-done"] = "Geheilt f\195\188r"
L["ldb-tooltip-damage-taken"] = "Schaden genommen"
L["ldb-tooltip-healing-taken"] = "Heilung bekommen"

L["ldb-summary-nochange"] = "Keine Schadens Ver\195\164nderung"
L["ldb-summary-damage"] = "Schadens Zusammenfassung"
L["ldb-summary-healing"] = "Heilungs Zusammenfassung"

L["ldb-tooltip-no-data"] = "Keine Daten vorhanden!"

L["ldb-tooltip-heading-actions"] = "Tastaturbelegung:"
L["ldb-tooltip-item-label-left"] = "Links Klick"
L["ldb-tooltip-item-label-right"] = "Rechts Klick"

L["ldb-tooltip-item-value-left"] = "Zeige/Verstecke Recount"
L["ldb-tooltip-item-value-left-alt"] = "N/A"
L["ldb-tooltip-item-value-left-ctrl"] = "N/A"
L["ldb-tooltip-item-value-left-ctrl-alt"] = "N/A"

L["ldb-tooltip-item-value-right"] = "Zeige Menu"
L["ldb-tooltip-item-value-right-alt"] = "Daten Zur\195\188cksetzen"
L["ldb-tooltip-item-value-right-ctrl"] = "Positionen Zur\195\188cksetzen"
L["ldb-tooltip-item-value-right-ctrl-alt"] = "Recount Konfigurieren"

L["ldb-tooltip-item-plus-alt"] = "+"
L["ldb-tooltip-item-plus-ctl"] = "+"

-- ========================================================================
-- Localisation Data for Component: BRFData. 
-- ========================================================================
L["data-conversion-boolean-as-text-yes"] = "Ja"
L["data-conversion-boolean-as-text-no"] = "Nein"