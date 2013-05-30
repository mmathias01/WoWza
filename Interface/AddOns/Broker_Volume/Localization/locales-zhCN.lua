-- ********************************************************************************
-- Data Broker Volume Control (Broker_Volume)
-- A volume control for Data Broker.
-- By: Shenton
--
-- Locales-zhCN.lua
-- ********************************************************************************

local L = LibStub("AceLocale-3.0"):NewLocale("BrokerVolume", "zhCN");

if L then
L["Ambience volume"] = "环境音"
L["Ambience volume set to"] = "环境音设置为"
-- L["Blizlike mute"] = ""
-- L["Broker Volume"] = ""
L[ [=[|cffc79c6eLeft-Click: |cff33ff99Mute sound
|cffc79c6eRight-Click: |cff33ff99Display the volume sliders
|cffc79c6eShift+Right-Click: |cff33ff99Display the configuration menu]=] ] = [=[|cffc79c6e左键点击: |cff33ff99静音
|cffc79c6e右键点击: |cff33ff99显示音量滑动杆选项
|cffc79c6eShift+右键点击: |cff33ff99显示配置菜单]=]
L["    |cffc79c6elevels|r, display volume levels."] = "    |cffc79c6elevels|r, 显示音量等级."
L["    |cffc79c6e<master||effects||music||ambience> <0-100>|r, will set the volume for the given category."] = "    |cffc79c6e<master||effects||music||ambience> <0-100>|r, 设置音量为给出的范畴."
L["    |cffc79c6eshow|r, show the minimap icon."] = "    |cffc79c6eshow|r, 显示小地图图标"
L[ [=[|cffffffff%s|r
Use mouse wheel to change value.]=] ] = [=[|cffffffff%s|r
使用鼠标滚轮改变数值.]=]
L["Close"] = "关闭"
L["Command usage: /bv, /brokervolume"] = "插件命令: /bv, /brokervolume" -- Needs review
-- L["Disable Sound"] = ""
L["Effects volume"] = "声音"
L["Effects volume set to"] = "声音设置为"
L["Master: |cffc79c6e%s|r%% - Effects: |cffc79c6e%s|r%% - Music: |cffc79c6e%s|r%% - Ambience: |cffc79c6e%s|r%%"] = "主音量: |cffc79c6e%s|r%% - 声音: |cffc79c6e%s|r%% - 音乐: |cffc79c6e%s|r%% - 环境音: |cffc79c6e%s|r%%"
L["Master volume"] = "主音量"
L["Master volume set to"] = "主音量设置为"
L["Minimap icon is hidden if you want to show it back use: /bv show or /brokervolume show"] = "小地图图标已隐藏，如要重新显示，输入命令/bv show 或者 /brokervolume show"
L["Music volume"] = "音乐"
L["Music volume set to"] = "音乐设置为"
L["Mute"] = "静音"
-- L["No tooltip mode"] = ""
L["Options"] = "选项"
-- L["Queued volume boost"] = ""
-- L["Queued volume is enabled but all sound is currently disabled."] = ""
L["Show/Hide minimap icon"] = "显示/隐藏小地图图标"
L["You must provide a number between 0 and 100."] = "你必须提供一个0到100的数字"

end
