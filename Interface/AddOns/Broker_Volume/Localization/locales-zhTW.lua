-- ********************************************************************************
-- Data Broker Volume Control (Broker_Volume)
-- A volume control for Data Broker.
-- By: Shenton
--
-- Locales-zhTW.lua
-- ********************************************************************************

local L = LibStub("AceLocale-3.0"):NewLocale("BrokerVolume", "zhTW");

if L then
L["Ambience volume"] = "環境"
L["Ambience volume set to"] = "環境設置為"
-- L["Blizlike mute"] = ""
-- L["Broker Volume"] = ""
L[ [=[|cffc79c6eLeft-Click: |cff33ff99Mute sound
|cffc79c6eRight-Click: |cff33ff99Display the volume sliders
|cffc79c6eShift+Right-Click: |cff33ff99Display the configuration menu]=] ] = [=[|cffc79c6e左鍵點擊: |cff33ff99靜音
|cffc79c6e右鍵點擊: |cff33ff99顯示音量滑動桿選項
|cffc79c6eShift+右鍵點擊: |cff33ff99顯示配置菜單]=]
L["    |cffc79c6elevels|r, display volume levels."] = "    |cffc79c6elevels|r, 顯示音量等級."
L["    |cffc79c6e<master||effects||music||ambience> <0-100>|r, will set the volume for the given category."] = "    |cffc79c6e<master||effects||music||ambience> <0-100>|r, 設置音量為給出的範疇."
L["    |cffc79c6eshow|r, show the minimap icon."] = "    |cffc79c6eshow|r, 顯示小地圖圖標"
L[ [=[|cffffffff%s|r
Use mouse wheel to change value.]=] ] = [=[|cffffffff%s|r
使用鼠標滾輪改變數值.]=]
L["Close"] = "關閉"
L["Command usage: /bv, /brokervolume"] = "插件命令: /bv, /brokervolume"
-- L["Disable Sound"] = ""
L["Effects volume"] = "音效"
L["Effects volume set to"] = "音效設置為"
L["Master: |cffc79c6e%s|r%% - Effects: |cffc79c6e%s|r%% - Music: |cffc79c6e%s|r%% - Ambience: |cffc79c6e%s|r%%"] = "主音量: |cffc79c6e%s|r%% - 音效: |cffc79c6e%s|r%% - 音樂: |cffc79c6e%s|r%% - 環境: |cffc79c6e%s|r%%"
L["Master volume"] = "主音量"
L["Master volume set to"] = "主音量設置為"
L["Minimap icon is hidden if you want to show it back use: /bv show or /brokervolume show"] = "小地圖圖標已隱藏，如要重新顯示，輸入命令/bv show 或者 /brokervolume show"
L["Music volume"] = "音樂"
L["Music volume set to"] = "音樂設置為"
L["Mute"] = "靜音"
-- L["No tooltip mode"] = ""
L["Options"] = "選項"
-- L["Queued volume boost"] = ""
-- L["Queued volume is enabled but all sound is currently disabled."] = ""
L["Show/Hide minimap icon"] = "顯示/隱藏小地圖圖標"
L["You must provide a number between 0 and 100."] = "你必須提供一個0到100的數字"

end
