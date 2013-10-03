
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 469,
	["errors"] = {
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"Volumizer\" tried to call the protected function \"CompactRaidFrame1:Show()\".",
			["time"] = "2013/01/03 01:16:57",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:276: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:234: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:46: in function <FrameXML\\CompactUnitFrame.lua:43>",
			["session"] = 144,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"AtlasLoot\" tried to call the protected function \"SpellFlyout:SetFrameLevel()\".",
			["time"] = "2013/01/10 00:03:32",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\n...\\AtlasLoot\\Libs\\LibStrataFix\\LibStrataFix-10003.lua:52: in function <...\\AtlasLoot\\Libs\\LibStrataFix\\LibStrataFix.lua:37>\n...\\AtlasLoot\\Libs\\LibStrataFix\\LibStrataFix-10003.lua:60: in function <...\\AtlasLoot\\Libs\\LibStrataFix\\LibStrataFix.lua:55>\n...\\AtlasLoot\\Libs\\LibStrataFix\\LibStrataFix-10003.lua:109: in function <...\\AtlasLoot\\Libs\\LibStrataFix\\LibStrataFix.lua:104>\n(tail call): ?\n<in C code>\nFrameXML\\SpellFlyout.lua:174: in function \"Toggle\"\nFrameXML\\SecureTemplates.lua:272: in function \"handler\"\nFrameXML\\SecureTemplates.lua:560: in function <FrameXML\\SecureTemplates.lua:508>",
			["session"] = 156,
			["counter"] = 3,
		}, -- [2]
		{
			["message"] = "<string>:\"*:OnShow\":15: attempt to call method \"ResetTalents\" (a nil value)",
			["time"] = "2013/01/11 00:41:20",
			["locals"] = "(*temporary) = <func> =[C]:-1\n = <func> @..\\Blizzard_TalentUI.lua:416\n = <func> *:OnShow:13\n",
			["stack"] = "<string>:\"*:OnShow\":15: in function <string>:\"*:OnShow\":13\n<in C code>\n<in C code>\nFrameXML\\UIParent.lua:1750: in function \"SetUIPanel\"\nFrameXML\\UIParent.lua:1594: in function \"ShowUIPanel\"\nFrameXML\\UIParent.lua:1481: in function <FrameXML\\UIParent.lua:1477>\n<in C code>\nFrameXML\\UIParent.lua:2193: in function \"ShowUIPanel\"\nBlizzard_TalentUI\\Blizzard_TalentUI.lua:226: in function \"PlayerTalentFrame_Toggle\"\nFrameXML\\UIParent.lua:479: in function \"ToggleTalentFrame\"\n<string>:\"TOGGLETALENTS\":1: in function <string>:\"TOGGLETALENTS\":1",
			["session"] = 157,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] AddOn \"Tukui\" tried to call the protected function \"RemoveTalent()\".",
			["time"] = "2013/01/14 22:20:31",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_TalentUI\\Blizzard_TalentUI.lua:10: in function \"OnAccept\"\nFrameXML\\StaticPopup.lua:3897: in function \"StaticPopup_OnClick\"\n<string>:\"*:OnClick\":1: in function <string>:\"*:OnClick\":1",
			["session"] = 174,
			["counter"] = 3,
		}, -- [4]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame1:ClearAllPoints()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:157: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [5]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame1:SetPoint()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:161: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [6]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame2:ClearAllPoints()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:157: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [7]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame2:SetPoint()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:161: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [8]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame3:ClearAllPoints()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:157: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [9]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame3:SetPoint()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:161: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [10]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame4:ClearAllPoints()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:157: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [11]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame4:SetPoint()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:161: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [12]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame5:ClearAllPoints()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:157: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [13]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame5:SetPoint()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:161: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:57: in function \"CompactRaidFrameContainer_OnEvent\"\n<string>:\"*:OnEvent\":1: in function <string>:\"*:OnEvent\":1",
			["session"] = 176,
			["counter"] = 2,
		}, -- [14]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrameManagerContainerResizeFrame:Hide()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:559: in function \"CompactRaidFrameManager_LockContainer\"\nBlizzard_CompactRaidFrameManager.lua:552: in function \"CompactRaidFrameManager_UpdateContainerLockVisibility\"\nBlizzard_CompactRaidFrameManager.lua:46: in function <Blizzard_CompactRaidFrameManager.lua:39>",
			["session"] = 176,
			["counter"] = 2,
		}, -- [15]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame1:Show()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:276: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:234: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:46: in function <FrameXML\\CompactUnitFrame.lua:43>",
			["session"] = 176,
			["counter"] = 2,
		}, -- [16]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame2:Show()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:276: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:234: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:46: in function <FrameXML\\CompactUnitFrame.lua:43>",
			["session"] = 176,
			["counter"] = 6,
		}, -- [17]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame3:Show()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:276: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:234: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:46: in function <FrameXML\\CompactUnitFrame.lua:43>",
			["session"] = 176,
			["counter"] = 2,
		}, -- [18]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame4:Show()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:276: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:234: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:46: in function <FrameXML\\CompactUnitFrame.lua:43>",
			["session"] = 176,
			["counter"] = 11,
		}, -- [19]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"CompactRaidFrame5:Show()\".",
			["time"] = "2013/01/14 00:03:52",
			["stack"] = "!BugGrabber-r188\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:276: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:234: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:46: in function <FrameXML\\CompactUnitFrame.lua:43>",
			["session"] = 176,
			["counter"] = 2,
		}, -- [20]
		{
			["message"] = "ElvUI-5.22\\modules\\actionbars\\actionbars.lua:73: attempt to index local \"bar\" (a nil value)",
			["time"] = "2013/01/15 00:17:15",
			["stack"] = "ElvUI-5.22\\modules\\actionbars\\actionbars.lua:73: in function \"PositionAndSizeBar\"\nElvUI-5.22\\modules\\actionbars\\actionbars.lua:347: in function \"UpdateButtonSettings\"\nElvUI-5.22\\core\\core.lua:474: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.25\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nLibs\\LibDualSpec-1.0\\LibDualSpec-1.0-11.lua:193: in function \"CheckDualSpecState\"\nLibs\\LibDualSpec-1.0\\LibDualSpec-1.0-11.lua:218: in function \"_EnhanceDatabase\"\nLibs\\LibDualSpec-1.0\\LibDualSpec-1.0-11.lua:240: in function \"EnhanceDatabase\"\nElvUI-5.22\\init.lua:145: in function \"LoadConfig\"\nElvUI-5.22\\core\\core.lua:639: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 178,
			["counter"] = 1,
		}, -- [21]
		{
			["message"] = "ElvUI-5.22\\init.lua:146: Usage: LibDualSpec:EnhanceOptions(optionTable, target): optionTable is not an 104AceDBOptions-3.0-14 table.",
			["time"] = "2013/01/15 00:17:15",
			["stack"] = "<in C code>\nLibs\\LibDualSpec-1.0\\LibDualSpec-1.0-11.lua:293: in function \"EnhanceOptions\"\nElvUI-5.22\\init.lua:146: in function \"LoadConfig\"\nElvUI-5.22\\core\\core.lua:639: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 178,
			["counter"] = 1,
		}, -- [22]
		{
			["message"] = "ElvUI-5.22\\modules\\datatexts\\datatexts.lua:64: attempt to call field \"OnClick\" (a nil value)",
			["time"] = "2013/01/15 12:37:22",
			["locals"] = "",
			["stack"] = "ElvUI-5.22\\modules\\datatexts\\datatexts.lua:64: in function <ElvUI\\modules\\datatexts\\datatexts.lua:63>",
			["session"] = 198,
			["counter"] = 3,
		}, -- [23]
		{
			["message"] = "Lorewalkers\\Lorewalkers-4.47.lua:631: attempt to perform arithmetic on field \"x\" (a nil value)",
			["time"] = "2013/01/15 22:16:14",
			["stack"] = "Lorewalkers\\Lorewalkers-4.47.lua:631: in function \"GetClosestWaypoint\"\nLorewalkers\\Lorewalkers-4.47.lua:654: in function \"AddClosestWaypoint\"\nLorewalkers\\Lorewalkers-4.47.lua:750: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 203,
			["counter"] = 1,
		}, -- [24]
		{
			["message"] = "ElvUI-5.24\\modules\\datatexts\\datatexts.lua:64: attempt to call field \"OnClick\" (a nil value)",
			["time"] = "2013/01/17 00:55:05",
			["locals"] = "",
			["stack"] = "ElvUI-5.24\\modules\\datatexts\\datatexts.lua:64: in function <ElvUI\\modules\\datatexts\\datatexts.lua:63>",
			["session"] = 205,
			["counter"] = 1,
		}, -- [25]
		{
			["message"] = "Lorewalkers\\Lorewalkers-4.47.lua:701: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/01/12 22:36:11",
			["stack"] = "Lorewalkers\\Lorewalkers-4.47.lua:701: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 207,
			["counter"] = 12,
		}, -- [26]
		{
			["message"] = "VuhDo-3.25\\VuhDoToolbox.lua:758: attempt to index global \"VUHDO_BOUQUETS\" (a nil value)",
			["time"] = "2013/01/19 10:52:12",
			["locals"] = "_ = VuhDo {\n 0 = <userdata>\n}\nanEvent = \"PLAYER_LOGOUT\"\nanArg1 = nil\nanArg2 = nil\nanArg3 = nil\nanArg4 = nil\nanArg5 = nil\nanArg6 = nil\nanArg7 = nil\nanArg8 = nil\nanArg9 = nil\nanArg10 = nil\nanArg11 = nil\nanArg12 = nil\nanArg13 = nil\nanArg14 = nil\nanArg15 = nil\nanArg16 = nil\nanArg17 = nil\nVUHDO_VARIABLES_LOADED = true\nVUHDO_parseCombatLogEvent = <func> @..\\VuhDoCombatLogParser.lua:106\nsShowShieldAbsorb = false\nVUHDO_RAID = <table> {\n raid14 = <table> {}\n raid18 = <table> {}\n raid4 = <table> {}\n raid9 = <table> {}\n raid3 = <table> {}\n raidpet37 = <table> {}\n raid22 = <table> {}\n raid13 = <table> {}\n raid23 = <table> {}\n raid6 = <table> {}\n raid7 = <table> {}\n raid35 = <table> {}\n raid12 = <table> {}\n raid16 = <table> {}\n raid39 = <table> {}\n raidpet8 = <table> {}\n raid38 = <table> {}\n raid26 = <table> {}\n raid27 = <table> {}\n raid25 = <table> {}\n raidpet23 = <table> {}\n raidpet17 = <table> {}\n raid37 = <table> {}\n raidpet21 = <table> {}\n raid28 = <table> {}\n raid36 = <table> {}\n raid8 = <table> {}\n raid40 = <table> {}\n raid21 = <table> {}\n raid10 = <table> {}\n raid34 = <table> {}\n raid20 = <table> {}\n raid33 = <table> {}\n raidpet35 = <table> {}\n raid31 = <table> {}\n raid24 = <table> {}\n raid5 = <table> {}\n raid2 = <table> {}\n raid17 = <table> {}\n raidpet5 = <table> {}\n raidpet31 = <table> {}\n raid32 = <table> {}\n raid1 = <table> {}\n raid29 = <table> {}\n raid11 = <table> {}\n player = <table> {}\n raid30 = <table> {}\n raid15 = <table> {}\n}\ntEmptyRaid = <table> {}\nVUHDO_updateHealth = <func> @..\\VuhDo.lua:436\nVUHDO_updateBouquetsForEvent = <func> @..\\VuhDoBouquets.lua:619\nVUHDO_updateManaBars = <func> @..\\VuhDoBarCustomizerMana.lua:40\nVUHDO_spellcastSucceeded = <func> @..\\VuhDoSpellEventHandler.lua:80\nVUHDO_spellcastSent = <func> @..\\VuhDoSpellEventHandler.lua:110\nVUHDO_updateThreat = <func> @..\\VuhDoEventHandler.lua:200\npairs = <func> =[C]:-1\nVUHDO_updateTargetBars = <func> @..\\VuhDoBarCustomizerTarget.lua:229\nVUHDO_INTERNAL_TOGGLES = <table> {\n 7 = false\n 14 = false\n 15 = true\n 16 = true\n 17 = false\n 18 = false\n 20 = false\n 22 = false\n 32 = true\n}\nInCombatLockdown = <func> =[C]:-1\nVUHDO_TIMERS = <table> {\n REFRESH_TOOLTIP = 1.8509999655187\n REFRESH_DRAG = 0.05\n BUFF_WATCH = 0.43999995663762\n UPDATE_AGGRO = -1\n REFRESH_CUDE_TOOLTIP = 0.43999995663762\n UPDATE_HOTS = 0.0825\n RELOAD_PANEL = 0\n RELOAD_UI = -0.0040000144392252\n UPDATE_CLUSTERS = 0.063999992161989\n MIRROR_TO_MACRO = 8\n UPDATE_RANGE = 0.03399998344481\n RELOAD_ZONES = 3.45\n RELOAD_ROSTER = -0.05800004824996\n RELOAD_RAID = 1.3989999324083\n UPDATE_AOE = 0.46199997439981\n CUSTOMIZE = -9.4850007176399\n CHECK_PROFILES = 3.1\n REFRESH_TARGETS = -1\n REFRESH_INSPECT = 2.1\n}\nVUHDO_FIRST_RELOAD_UI = true\nVUHDO_init = <func> @..\\VuhDoEventHandler.lua:301\nVUHDO_parseAddonMessage = <func> @..\\VuhDoAddonAdapter.lua:67\nVUHDO_updateHealthBarsFor = <func> @..\\VuhDoBarCustomizerHealth.lua:653\n",
			["stack"] = "VuhDo-3.25\\VuhDoToolbox.lua:758: in function \"VUHDO_compressAllBouquets\"\nVuhDo-3.25\\VuhDoEventHandler.lua:556: in function <VuhDo\\VuhDoEventHandler.lua:353>",
			["session"] = 213,
			["counter"] = 1,
		}, -- [27]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ArkInventory\" tried to call the protected function \"PickupContainerItem()\".",
			["time"] = "2013/01/22 22:39:01",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\ContainerFrame.lua:758: in function \"ContainerFrameItemButton_OnClick\"\nArkInventory\\ArkInventory-3.03.25.lua:6803: in function \"Frame_Item_OnDrag\"\n<string>:\"*:OnReceiveDrag\":1: in function <string>:\"*:OnReceiveDrag\":1",
			["session"] = 220,
			["counter"] = 1,
		}, -- [28]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"GearScore\" tried to call the protected function \"WorldMapBlobFrame:Show()\".",
			["time"] = "2013/01/22 23:04:55",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\WorldMapFrame.lua:1963: in function \"WorldMapFrame_DisplayQuests\"\nFrameXML\\WorldMapFrame.lua:2037: in function \"WorldMapFrame_UpdateMap\"\nFrameXML\\WorldMapFrame.lua:306: in function <FrameXML\\WorldMapFrame.lua:292>\n<in C code>\nFrameXML\\WorldMapFrame.lua:252: in function <FrameXML\\WorldMapFrame.lua:233>\n(tail call): ?\n<in C code>\n<in C code>\nFrameXML\\UIParent.lua:1750: in function \"SetUIPanel\"\nFrameXML\\UIParent.lua:1555: in function \"ShowUIPanel\"\nFrameXML\\UIParent.lua:1481: in function <FrameXML\\UIParent.lua:1477>\n<in C code>\nFrameXML\\UIParent.lua:2193: in function \"ShowUIPanel\"\nFrameXML\\UIParent.lua:2177: in function \"ToggleFrame\"\n<string>:\"TOGGLEWORLDMAP\":1: in function <string>:\"TOGGLEWORLDMAP\":1",
			["session"] = 221,
			["counter"] = 3,
		}, -- [29]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ArkInventory\" tried to call the protected function \"WorldMapBlobFrame:SetScale()\".",
			["time"] = "2013/01/24 00:57:24",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\WorldMapFrame.lua:321: in function <FrameXML\\WorldMapFrame.lua:292>",
			["session"] = 223,
			["counter"] = 1,
		}, -- [30]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ArkInventory\" tried to call the protected function \"ScenarioPOIFrame:SetScale()\".",
			["time"] = "2013/01/24 00:57:24",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\WorldMapFrame.lua:322: in function <FrameXML\\WorldMapFrame.lua:292>",
			["session"] = 223,
			["counter"] = 1,
		}, -- [31]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ACP\" tried to call the protected function \"CompactRaidFrame1:SetAttribute()\".",
			["time"] = "2013/01/24 00:57:24",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:194: in function \"CompactUnitFrame_SetUpClicks\"\nFrameXML\\CompactUnitFrame.lua:38: in function <FrameXML\\CompactUnitFrame.lua:6>\n<in C code>\n<in C code>\nBlizzard_CompactRaidFrameContainer.lua:345: in function \"CompactRaidFrameContainer_GetUnitFrame\"\nBlizzard_CompactRaidFrameContainer.lua:317: in function \"CompactRaidFrameContainer_AddUnitFrame\"\nBlizzard_CompactRaidFrameContainer.lua:254: in function \"CompactRaidFrameContainer_AddPlayers\"\nBlizzard_CompactRaidFrameContainer.lua:176: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:95: in function \"CompactRaidFrameContainer_SetFlowSortFunction\"\nBlizzard_CompactRaidFrameManager.lua:405: in function <Blizzard_CompactRaidFrameManager.lua:402>\nBlizzard_CompactRaidFrameManager.lua:491: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:172: in function \"CompactUnitFrameProfiles_ActivateRaidProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:45: in function \"CompactUnitFrameProfiles_ValidateProfilesLoaded\"\nBlizzard_CompactUnitFrameProfiles.lua:25: in function <Blizzard_CompactUnitFrameProfiles.lua:18>",
			["session"] = 223,
			["counter"] = 2,
		}, -- [32]
		{
			["message"] = "VuhDo-3.25\\VuhDoPanel.lua:51: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/01/24 00:58:02",
			["locals"] = "anIdentifier = 1\naPanelNum = nil\naModelIndex = nil\ntDynModel = nil\nVUHDO_getDynamicModelArray = <func> @VuhDo\\VuhDoPanel.lua:50\ntOccurrence = nil\ntMaxRows = nil\nVUHDO_PANEL_SETUP = <table> {\n 1 = <table> {}\n 2 = <table> {}\n 3 = <table> {}\n 4 = <table> {}\n 5 = <table> {}\n 6 = <table> {}\n 7 = <table> {}\n 8 = <table> {}\n 9 = <table> {}\n 10 = <table> {}\n RAID_ICON_FILTER = <table> {}\n PANEL_COLOR = <table> {}\n HOTS = <table> {}\n BAR_COLORS = <table> {}\n}\nVUHDO_getSubTable = <func> @VuhDo\\VuhDoPanel.lua:99\nVUHDO_GROUPS = <table> {}\nsEmpty = <table> {}\n",
			["stack"] = "VuhDo-3.25\\VuhDoPanel.lua:51: in function <VuhDo\\VuhDoPanel.lua:50>\nVuhDo-3.25\\VuhDoPanel.lua:120: in function <VuhDo\\VuhDoPanel.lua:119>\nVuhDo-3.25\\VuhDoPanel.lua:142: in function <VuhDo\\VuhDoPanel.lua:138>\nVuhDo-3.25\\VuhDoModelTools.lua:92: in function \"VUHDO_initDynamicPanelModels\"\nVuhDo-3.25\\VuhDoNewOptionsGeneralSkinsShared.lua:2481: in function \"VUHDO_loadProfile\"\nVuhDo-3.25\\VuhDoDropdownFactory.lua:290: in function \"func\"\nFrameXML\\UIDropDownMenu.lua:710: in function \"UIDropDownMenuButton_OnClick\"\n<string>:\"*:OnClick\":1: in function <string>:\"*:OnClick\":1",
			["session"] = 223,
			["counter"] = 1,
		}, -- [33]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarBottomLeft:Show()\".",
			["time"] = "2013/01/24 00:58:54",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:37: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 223,
			["counter"] = 6,
		}, -- [34]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarBottomRight:Show()\".",
			["time"] = "2013/01/24 00:58:54",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:46: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 223,
			["counter"] = 6,
		}, -- [35]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarRight:Show()\".",
			["time"] = "2013/01/24 00:58:54",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:53: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 223,
			["counter"] = 6,
		}, -- [36]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarLeft:Show()\".",
			["time"] = "2013/01/24 00:58:54",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:60: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 223,
			["counter"] = 6,
		}, -- [37]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ArkInventory\" tried to call the protected function \"CompactRaidFrameContainer:Hide()\".",
			["time"] = "2013/01/24 00:58:54",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:515: in function \"CompactRaidFrameManager_UpdateContainerVisibility\"\nBlizzard_CompactRaidFrameManager.lua:460: in function <Blizzard_CompactRaidFrameManager.lua:449>\nBlizzard_CompactRaidFrameManager.lua:499: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 223,
			["counter"] = 1,
		}, -- [38]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ArkInventory\" tried to call the protected function \"CompactRaidFrameManagerContainerResizeFrame:Hide()\".",
			["time"] = "2013/01/24 00:58:54",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:559: in function \"CompactRaidFrameManager_LockContainer\"\nBlizzard_CompactRaidFrameManager.lua:552: in function \"CompactRaidFrameManager_UpdateContainerLockVisibility\"\nBlizzard_CompactRaidFrameManager.lua:394: in function <Blizzard_CompactRaidFrameManager.lua:389>\nBlizzard_CompactRaidFrameManager.lua:489: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 223,
			["counter"] = 1,
		}, -- [39]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ACP\" tried to call the protected function \"CompactRaidFrame2:SetAttribute()\".",
			["time"] = "2013/01/24 00:58:54",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:194: in function \"CompactUnitFrame_SetUpClicks\"\nFrameXML\\CompactUnitFrame.lua:38: in function <FrameXML\\CompactUnitFrame.lua:6>\n<in C code>\n<in C code>\nBlizzard_CompactRaidFrameContainer.lua:345: in function \"CompactRaidFrameContainer_GetUnitFrame\"\nBlizzard_CompactRaidFrameContainer.lua:317: in function \"CompactRaidFrameContainer_AddUnitFrame\"\nBlizzard_CompactRaidFrameContainer.lua:296: in function \"CompactRaidFrameContainer_AddFlaggedUnits\"\nBlizzard_CompactRaidFrameContainer.lua:169: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:76: in function \"CompactRaidFrameContainer_SetGroupMode\"\nBlizzard_CompactRaidFrameManager.lua:425: in function <Blizzard_CompactRaidFrameManager.lua:416>\nBlizzard_CompactRaidFrameManager.lua:493: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 223,
			["counter"] = 2,
		}, -- [40]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"VuhDo\" tried to call the protected function \"ClearOverrideBindings()\".",
			["time"] = "2013/01/20 00:01:19",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nVuhDo-3.25\\VuhDoMacroFactory.lua:483: in function \"VUHDO_initKeyboardMacros\"\nVuhDoOptions-3.25\\VuhDoNewOptionsTabbedFrame.lua:112: in function \"VUHDO_tabbedPanelCancelClicked\"\n<string>:\"*:OnClick\":1: in function <string>:\"*:OnClick\":1",
			["session"] = 228,
			["counter"] = 2,
		}, -- [41]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"VuhDo\" tried to call the protected function \"DeleteMacro()\".",
			["time"] = "2013/01/20 00:01:19",
			["stack"] = "!BugGrabber-r189\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nVuhDo-3.25\\VuhDoMacroFactory.lua:514: in function \"VUHDO_initKeyboardMacros\"\nVuhDoOptions-3.25\\VuhDoNewOptionsTabbedFrame.lua:112: in function \"VUHDO_tabbedPanelCancelClicked\"\n<string>:\"*:OnClick\":1: in function <string>:\"*:OnClick\":1",
			["session"] = 228,
			["counter"] = 32,
		}, -- [42]
		{
			["message"] = "GearScore-5.2.0\\scripts.lua:3274: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/03/19 20:40:30",
			["locals"] = "self = GameTooltip {\n 0 = <userdata>\n SetExistingSocketGem = <func> =[C]:-1\n SetCurrencyToken = <func> =[C]:-1\n SetGuildBankItem = <func> =[C]:-1\n SetVoidItem = <func> =[C]:-1\n SetVoidDepositItem = <func> =[C]:-1\n SetVoidWithdrawalItem = <func> =[C]:-1\n template = \"Transparent\"\n needRefresh = true\n ARK_Data = <table> {}\n SetSocketGem = <func> =[C]:-1\n SetMissingLootItem = <func> =[C]:-1\n SetUnitDebuff = <func> =[C]:-1\n SetItemByID = <func> =[C]:-1\n SetLootItem = <func> =[C]:-1\n SetQuestItem = <func> =[C]:-1\n pos = \"BOTTOM\"\n forceRefresh = true\n SetTrainerService = <func> =[C]:-1\n numMoneyFrames = 1\n hasMoney = 1\n shownMoneyFrames = 1\n SetInboxItem = <func> =[C]:-1\n SetBuybackItem = <func> =[C]:-1\n shoppingTooltips = <table> {}\n SetHyperlinkCompareItem = <func> =[C]:-1\n SetMerchantItem = <func> =[C]:-1\n SetQuestLogItem = <func> =[C]:-1\n SetBackpackToken = <func> =[C]:-1\n SetTradeTargetItem = <func> =[C]:-1\n itemcleared = true\n SetTradePlayerItem = <func> =[C]:-1\n comparing = false\n SetSendMailItem = <func> =[C]:-1\n updateTooltip = 0.10099999494851\n SetInventoryItem = <func> =[C]:-1\n Hide = <func> =[C]:-1\n SetLootRollItem = <func> =[C]:-1\n SetUnitAura = <func> =[C]:-1\n SetAuctionSellItem = <func> =[C]:-1\n SetBagItem = <func> =[C]:-1\n SetTradeSkillItem = <func> =[C]:-1\n SetUnitBuff = <func> =[C]:-1\n SetHyperlink = <func> =[C]:-1\n SetMerchantCostItem = <func> =[C]:-1\n SetAuctionItem = <func> =[C]:-1\n}\nf = TenTonHammer {\n 0 = <userdata>\n Active = true\n BuildRaidList = <func> @GearScore\\scripts.lua:2606\n INSPECT_READY = <func> @GearScore\\scripts.lua:957\n Help = <table> {}\n GetColor = <func> @GearScore\\scripts.lua:1244\n CheckGeneric = <func> @GearScore\\scripts.lua:758\n Realm = \"Terenas\"\n PlayerScoreDebug = <func> @GearScore\\scripts.lua:4823\n AddValue = <func> @GearScore\\scripts.lua:827\n PlayerName = \"Cellestia\"\n GetHexColor = <func> @GearScore\\scripts.lua:1261\n PLAYER_REGEN_DISABLED = <func> @GearScore\\scripts.lua:1114\n Vote = <func> @GearScore\\scripts.lua:2332\n setupBonusTab = <func> @GearScore\\scripts.lua:4422\n getDefaultDatabaseDisplay = <func> @GearScore\\scripts.lua:4449\n ADDON_LOADED = <func> @GearScore\\scripts.lua:960\n Transmit = <func> @GearScore\\scripts.lua:1221\n data = <table> {}\n GetPVEScore = <func> @GearScore\\scripts.lua:3942\n GetGemInfo = <func> @GearScore\\scripts.lua:1294\n INSPECT_TALENT_READY = <func> @GearScore\\scripts.lua:1107\n GetLiteSpec = <func> @GearScore\\scripts.lua:1365\n CalculateNewPvPScore = <func> @GearScore\\scripts.lua:4867\n GenericBonuses = <table> {}\n InInstance = false\n ContextMenu = <func> @GearScore\\scripts.lua:4684\n displayDatabaseRaid = <func> @GearScore\\scripts.lua:4604\n GenerateNews = <func> @GearScore\\scripts.lua:3325\n GetColor100 = <func> @GearScore\\scripts.lua:1230\n communicateData = <func> @GearScore\\scripts.lua:1178\n DatabaseStats = <table> {}\n PassiveBonuses = <table> {}\n databaseSort = <func> @GearScore\\scripts.lua:4459\n GetItemRole = <func> @GearScore\\scripts.lua:2494\n I",
			["stack"] = "GearScore-5.2.0\\scripts.lua:3274: in function \"GetPlayerInfo\"\nGearScore-5.2.0\\scripts.lua:3174: in function <GearScore\\scripts.lua:3042>\n<in C code>\n...\\ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0-6.lua:95: in function <...\\ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:87>\n<in C code>\n<in C code>\n<in C code>\nFrameXML\\BuffFrame.lua:520: in function \"TempEnchantButton_OnEnter\"\n<string>:\"*:OnEnter\":1: in function <string>:\"*:OnEnter\":1",
			["session"] = 231,
			["counter"] = 11,
		}, -- [43]
		{
			["message"] = "ElvUI_Enhanced-1.62\\modules\\maps\\minimapbuttons.lua:203: attempt to index upvalue \"minimapButtonBar\" (a nil value)",
			["time"] = "2013/03/19 20:45:13",
			["stack"] = "ElvUI_Enhanced-1.62\\modules\\maps\\minimapbuttons.lua:203: in function \"ChangeMouseOverSetting\"\nElvUI_Enhanced-1.62\\config\\options.lua:337: in function <ElvUI_Enhanced\\config\\options.lua:337>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[2]\":9: in function <string>:\"safecall Dispatcher[2]\":5\n(tail call): ?\nAceConfigDialog-3.0\\AceConfigDialog-3.0-57.lua:799: in function <AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:614>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nArkInventory-3.03.27\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\nAce3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:68: in function <Ace3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:57>",
			["session"] = 232,
			["counter"] = 1,
		}, -- [44]
		{
			["message"] = "WoWDBProfiler-r273\\Comments.lua:17: Cannot find a library instance of \"LibQTip-1.0\".",
			["time"] = "2013/03/25 22:40:05",
			["locals"] = "self = <table> {\n NewLibrary = <func> @ArkInventory\\Libs\\..\\LibStub.lua:11\n minors = <table> {}\n minor = 2\n IterateLibraries = <func> @ArkInventory\\Libs\\..\\LibStub.lua:28\n GetLibrary = <func> @ArkInventory\\Libs\\..\\LibStub.lua:21\n libs = <table> {}\n}\nmajor = \"LibQTip-1.0\"\nsilent = nil\n",
			["stack"] = "<in C code>\nArkInventory-3.03.27\\Libs\\LibStub\\LibStub.lua:23: in function \"LibStub\"\nWoWDBProfiler-r273\\Comments.lua:17: in main chunk",
			["session"] = 236,
			["counter"] = 2,
		}, -- [45]
		{
			["message"] = "ElvUI-5.84\\modules\\unitframes\\unitframes.lua:559: No unit provided to create or update.",
			["time"] = "2013/03/27 22:14:35",
			["stack"] = "<in C code>\n<in C code>\nFrameXML\\RestrictedFrames.lua:604: in function <FrameXML\\RestrictedFrames.lua:603>\nFrameXML\\RestrictedFrames.lua:742: in function \"CallMethod\"\n<string>:\"		local header = self:GetParent()RestrictedExecution.lua:441: in function <FrameXML\\RestrictedExecution.lua:412>\nFrameXML\\SecureGroupHeaders.lua:116: in function <FrameXML\\SecureGroupHeaders.lua:110>\nFrameXML\\SecureGroupHeaders.lua:166: in function <FrameXML\\SecureGroupHeaders.lua:123>\nFrameXML\\SecureGroupHeaders.lua:488: in function <FrameXML\\SecureGroupHeaders.lua:387>\n<in C code>\nElvUI-5.84\\modules\\unitframes\\unitframes.lua:454: in function \"Update_AllFrames\"\nElvUI-5.84\\core\\core.lua:507: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n[string \"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.84\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.84\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 237,
			["counter"] = 5,
		}, -- [46]
		{
			["message"] = "ElvUI-5.84\\modules\\unitframes\\groups\\party-Party.lua:513: attempt to index local \"GPS\" (a nil value)",
			["time"] = "2013/03/27 22:14:35",
			["stack"] = "ElvUI-5.84\\modules\\unitframes\\groups\\party-Party.lua:513: in function \"?\"\nElvUI-5.84\\modules\\unitframes\\unitframes.lua:534: in function \"Update\"\nElvUI-5.84\\modules\\unitframes\\unitframes.lua:631: in function \"UpdateAllHeaders\"\nElvUI-5.84\\modules\\unitframes\\unitframes.lua:454: in function \"Update_AllFrames\"\nElvUI-5.84\\core\\core.lua:507: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.84\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.84\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 237,
			["counter"] = 1,
		}, -- [47]
		{
			["message"] = "ElvUI-5.84\\modules\\actionbars\\actionbars.lua:778: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/03/27 22:14:35",
			["stack"] = "ElvUI-5.84\\modules\\actionbars\\actionbars.lua:778: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 237,
			["counter"] = 1,
		}, -- [48]
		{
			["message"] = "ElvUI-5.84\\core\\math.lua:260: attempt to compare nil with number",
			["time"] = "2013/03/27 22:15:19",
			["locals"] = "self = ElvUIPlayerBuffsAuraButton1 {\n 0 = <userdata>\n highlight = <unnamed> {}\n backdrop = <unnamed> {}\n nextupdate = 0\n time = <unnamed> {}\n expiration = 14.98399999924\n count = <unnamed> {}\n anim = Flash {}\n texture = <unnamed> {}\n}\nelapsed = 0.016000000759959\ntimervalue = nil\nformatid = nil\nE = <table> {\n GetTimeInfo = <func> @ElvUI\\..\\math.lua:258\n Grid = <func> @ElvUI\\..\\commands.lua:81\n modules = <table> {}\n role = \"Caster\"\n StaticPopup_EscapePressed = <func> @ElvUI\\..\\staticpopups.lua:241\n screenwidth = 1920\n MassGuildKick = <func> @ElvUI\\..\\commands.lua:130\n SetMoversPositions = <func> @ElvUI\\..\\movers.lua:371\n ScheduleTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:108\n PriestColors = <table> {}\n RegisterModule = <func> @ElvUI\\..\\core.lua:614\n SetupTheme = <func> @ElvUI\\..\\install.lua:228\n media = <table> {}\n SetUpAnimGroup = <func> @ElvUI\\..\\animation.lua:7\n data = <table> {}\n UIScale = <func> @ElvUI\\..\\pixelperfect.lua:8\n db = <table> {}\n ToggleConfigMode = <func> @ElvUI\\..\\config.lua:49\n SetEnabledState = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:440\n Hook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:277\n Options = <table> {}\n Layout = <table> {}\n tDeleteItem = <func> @ElvUI\\..\\animation.lua:266\n LoadCommands = <func> @ElvUI\\..\\commands.lua:167\n SendPluginVersionCheck = <func> @ElvUI\\libs\\..\\LibElvUIPlugin-1.0.lua:119\n HiddenFrame = <unnamed> {}\n DisableAddon = <func> @ElvUI\\..\\commands.lua:17\n UnregisterAllEvents = <func> @ArkInventory\\Libs\\CallbackHandler\\CallbackHandler-1.0.lua:201\n UIFrameFade = <func> @ElvUI\\..\\animation.lua:202\n MinimapWidth = 176\n StaticPopup_IsLastDisplayedFrame = <func> @ElvUI\\..\\staticpopups.lua:302\n Truncate = <func> @ElvUI\\..\\math.lua:56\n UpdateBackdropColors = <func> @ElvUI\\..\\core.lua:271\n StaticPopup_OnHide = <func> @ElvUI\\..\\staticpopups.lua:342\n name = \"ElvUI\"\n WorldMap = <table> {}\n StopMassiveShake = <func> @ElvUI\\..\\core.lua:661\n Disable = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:330\n TimeColors = <table> {}\n SlideOut = <func> @ElvUI\\..\\animation.lua:147\n Unhook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:421\n Print = <func> @ElvUI\\..\\core.lua:129\n Install = <func> @ElvUI\\..\\install.lua:914\n TimeFormats = <table> {}\n RGBToHex = <func> @ElvUI\\..\\math.lua:62\n SetupPixelPerfect = <func> @ElvUI\\..\\install.lua:178\n RequestBGInfo = <func> @ElvUI\\..\\core.lua:222\n HealingClasses = <table> {}\n BeginFoolsDayEvent = <func> @ElvUI\\..\\core.lua:698\n UpdateNudgeFrame = <func> @ElvUI\\..\\config.lua:189\n SetDefaultModuleLibraries = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:383\n SlideIn = <func> @ElvUI\\..\\animation.lua:136\n NudgeFrame = <func> @ElvUI\\..\\config.lua:159\n wowbuild = 16769\n RegisteredInitialModules = <table> {}\n EnableModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\",
			["stack"] = "ElvUI-5.84\\core\\math.lua:260: in function \"GetTimeInfo\"\nElvUI-5.84\\modules\\auras\\auras-Auras.lua:24: in function <ElvUI\\modules\\auras\\auras.lua:9>",
			["session"] = 237,
			["counter"] = 40,
		}, -- [49]
		{
			["message"] = "Blizzard_AchievementUI\\Blizzard_AchievementUI-1.0.lua:704: Usage: GetCategoryNumAchievements(categoryID, includeSuperceded)",
			["time"] = "2013/01/03 01:00:41",
			["locals"] = "id = \"summary\"\n",
			["stack"] = "<in C code>\nBlizzard_AchievementUI\\Blizzard_AchievementUI-1.0.lua:704: in function \"AchievementFrameComparison_UpdateStatusBars\"\nBlizzard_AchievementUI\\Blizzard_AchievementUI-1.0.lua:2782: in function <Blizzard_AchievementUI\\Blizzard_AchievementUI.lua:2779>",
			["session"] = 239,
			["counter"] = 114,
		}, -- [50]
		{
			["message"] = "<string>:\"TenTonHammer_QuickRateFrame:OnShow\":18: attempt to concatenate field \"Spec\" (a nil value)",
			["time"] = "2013/01/22 00:59:36",
			["locals"] = "(*temporary) = TenTonHammer_QuickRateFrame {\n 0 = <userdata>\n}\n(*temporary) = <func> =[C]:-1\n",
			["stack"] = "<string>:\"*:OnShow\":18: in function <string>:\"*:OnShow\":1\n<in C code>\nGearScore-5.00.04.00\\scripts.lua:919: in function \"?\"\nGearScore-5.00.04.00\\scripts.lua:827: in function <GearScore\\scripts.lua:826>",
			["session"] = 245,
			["counter"] = 2,
		}, -- [51]
		{
			["message"] = "ElvUI-5.86\\modules\\unitframes\\unitframes.lua:573: No unit provided to create or update.",
			["time"] = "2013/03/29 14:53:45",
			["stack"] = "<in C code>\n<in C code>\nFrameXML\\RestrictedFrames.lua:604: in function <FrameXML\\RestrictedFrames.lua:603>\nFrameXML\\RestrictedFrames.lua:742: in function \"CallMethod\"\n<string>:\"		local header = self:GetParent()RestrictedExecution.lua:441: in function <FrameXML\\RestrictedExecution.lua:412>\nFrameXML\\SecureGroupHeaders.lua:116: in function <FrameXML\\SecureGroupHeaders.lua:110>\nFrameXML\\SecureGroupHeaders.lua:166: in function <FrameXML\\SecureGroupHeaders.lua:123>\nFrameXML\\SecureGroupHeaders.lua:488: in function <FrameXML\\SecureGroupHeaders.lua:387>\n<in C code>\nElvUI-5.86\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.86\\core\\core.lua:507: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n[string \"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.86\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.86\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 252,
			["counter"] = 5,
		}, -- [52]
		{
			["message"] = "ElvUI-5.86\\modules\\unitframes\\groups\\party-Party.lua:513: attempt to index local \"GPS\" (a nil value)",
			["time"] = "2013/03/29 14:53:45",
			["stack"] = "ElvUI-5.86\\modules\\unitframes\\groups\\party-Party.lua:513: in function \"?\"\nElvUI-5.86\\modules\\unitframes\\unitframes.lua:548: in function \"Update\"\nElvUI-5.86\\modules\\unitframes\\unitframes.lua:645: in function \"UpdateAllHeaders\"\nElvUI-5.86\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.86\\core\\core.lua:507: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.86\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.86\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 252,
			["counter"] = 1,
		}, -- [53]
		{
			["message"] = "ElvUI-5.86\\modules\\actionbars\\actionbars.lua:778: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/03/29 14:53:45",
			["stack"] = "ElvUI-5.86\\modules\\actionbars\\actionbars.lua:778: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 252,
			["counter"] = 1,
		}, -- [54]
		{
			["message"] = "ElvUI-5.96\\modules\\unitframes\\unitframes.lua:573: No unit provided to create or update.",
			["time"] = "2013/04/12 22:04:45",
			["stack"] = "<in C code>\n<in C code>\nFrameXML\\RestrictedFrames.lua:604: in function <FrameXML\\RestrictedFrames.lua:603>\nFrameXML\\RestrictedFrames.lua:742: in function \"CallMethod\"\n<string>:\"		local header = self:GetParent()RestrictedExecution.lua:441: in function <FrameXML\\RestrictedExecution.lua:412>\nFrameXML\\SecureGroupHeaders.lua:116: in function <FrameXML\\SecureGroupHeaders.lua:110>\nFrameXML\\SecureGroupHeaders.lua:166: in function <FrameXML\\SecureGroupHeaders.lua:123>\nFrameXML\\SecureGroupHeaders.lua:488: in function <FrameXML\\SecureGroupHeaders.lua:387>\n<in C code>\nElvUI-5.96\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.96\\core\\core.lua:507: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n[string \"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.96\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.96\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 323,
			["counter"] = 5,
		}, -- [55]
		{
			["message"] = "ElvUI-5.96\\modules\\unitframes\\groups\\party-Party.lua:525: attempt to index local \"GPS\" (a nil value)",
			["time"] = "2013/04/12 22:04:45",
			["stack"] = "ElvUI-5.96\\modules\\unitframes\\groups\\party-Party.lua:525: in function \"?\"\nElvUI-5.96\\modules\\unitframes\\unitframes.lua:548: in function \"Update\"\nElvUI-5.96\\modules\\unitframes\\unitframes.lua:645: in function \"UpdateAllHeaders\"\nElvUI-5.96\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.96\\core\\core.lua:507: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.96\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.96\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 323,
			["counter"] = 1,
		}, -- [56]
		{
			["message"] = "ElvUI-5.96\\modules\\actionbars\\actionbars.lua:782: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/04/12 22:04:45",
			["stack"] = "ElvUI-5.96\\modules\\actionbars\\actionbars.lua:782: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 323,
			["counter"] = 1,
		}, -- [57]
		{
			["message"] = "ElvUI-5.96\\core\\math.lua:260: attempt to compare nil with number",
			["time"] = "2013/04/12 22:04:45",
			["locals"] = "self = ElvUIPlayerBuffsAuraButton1 {\n 0 = <userdata>\n highlight = <unnamed> {}\n backdrop = <unnamed> {}\n nextupdate = 0\n time = <unnamed> {}\n expiration = 14.420999999275\n count = <unnamed> {}\n anim = Flash {}\n texture = <unnamed> {}\n}\nelapsed = 0.016000000759959\ntimervalue = nil\nformatid = nil\nE = <table> {\n GetTimeInfo = <func> @ElvUI\\..\\math.lua:258\n privateVars = <table> {}\n modules = <table> {}\n CancelTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:161\n StaticPopup_EscapePressed = <func> @ElvUI\\..\\staticpopups.lua:241\n CopyTable = <func> @ElvUI\\..\\core.lua:417\n MassGuildKick = <func> @ElvUI\\..\\commands.lua:130\n SetMoversPositions = <func> @ElvUI\\..\\movers.lua:371\n ScheduleTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:108\n PriestColors = <table> {}\n RegisterModule = <func> @ElvUI\\..\\core.lua:618\n SetupTheme = <func> @ElvUI\\..\\install.lua:228\n media = <table> {}\n SetUpAnimGroup = <func> @ElvUI\\..\\animation.lua:7\n data = <table> {}\n UIScale = <func> @ElvUI\\..\\pixelperfect.lua:8\n db = <table> {}\n ToggleConfigMode = <func> @ElvUI\\..\\config.lua:49\n SetEnabledState = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:440\n Hook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:277\n Options = <table> {}\n Layout = <table> {}\n tDeleteItem = <func> @ElvUI\\..\\animation.lua:266\n LoadCommands = <func> @ElvUI\\..\\commands.lua:167\n HiddenFrame = <unnamed> {}\n DisableAddon = <func> @ElvUI\\..\\commands.lua:17\n UnregisterAllEvents = <func> @ArkInventory\\Libs\\CallbackHandler\\CallbackHandler-1.0.lua:201\n UIFrameFade = <func> @ElvUI\\..\\animation.lua:202\n MinimapWidth = 176\n StaticPopup_IsLastDisplayedFrame = <func> @ElvUI\\..\\staticpopups.lua:302\n Truncate = <func> @ElvUI\\..\\math.lua:56\n UpdateBackdropColors = <func> @ElvUI\\..\\core.lua:271\n StaticPopup_OnHide = <func> @ElvUI\\..\\staticpopups.lua:342\n name = \"ElvUI\"\n WorldMap = <table> {}\n StopMassiveShake = <func> @ElvUI\\..\\core.lua:665\n Disable = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:330\n TimeColors = <table> {}\n SlideOut = <func> @ElvUI\\..\\animation.lua:147\n Unhook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:421\n Print = <func> @ElvUI\\..\\core.lua:129\n Install = <func> @ElvUI\\..\\install.lua:914\n TimeFormats = <table> {}\n RGBToHex = <func> @ElvUI\\..\\math.lua:62\n SetupPixelPerfect = <func> @ElvUI\\..\\install.lua:178\n RequestBGInfo = <func> @ElvUI\\..\\core.lua:222\n HealingClasses = <table> {}\n BeginFoolsDayEvent = <func> @ElvUI\\..\\core.lua:702\n UpdateNudgeFrame = <func> @ElvUI\\..\\config.lua:189\n SetDefaultModuleLibraries = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:383\n SlideIn = <func> @ElvUI\\..\\animation.lua:136\n NudgeFrame = <func> @ElvUI\\..\\config.lua:159\n wowbuild = 16826\n RegisteredInitialModules = <table> {}\n EnableModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua",
			["stack"] = "ElvUI-5.96\\core\\math.lua:260: in function \"GetTimeInfo\"\nElvUI-5.96\\modules\\auras\\auras-Auras.lua:24: in function <ElvUI\\modules\\auras\\auras.lua:9>",
			["session"] = 323,
			["counter"] = 42,
		}, -- [58]
		{
			["message"] = "ElvUI-5.98\\modules\\unitframes\\unitframes.lua:573: No unit provided to create or update.",
			["time"] = "2013/04/13 17:32:32",
			["stack"] = "<in C code>\n<in C code>\nFrameXML\\RestrictedFrames.lua:604: in function <FrameXML\\RestrictedFrames.lua:603>\nFrameXML\\RestrictedFrames.lua:742: in function \"CallMethod\"\n<string>:\"		local header = self:GetParent()RestrictedExecution.lua:441: in function <FrameXML\\RestrictedExecution.lua:412>\nFrameXML\\SecureGroupHeaders.lua:116: in function <FrameXML\\SecureGroupHeaders.lua:110>\nFrameXML\\SecureGroupHeaders.lua:166: in function <FrameXML\\SecureGroupHeaders.lua:123>\nFrameXML\\SecureGroupHeaders.lua:488: in function <FrameXML\\SecureGroupHeaders.lua:387>\n<in C code>\nElvUI-5.98\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.98\\core\\core.lua:515: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n[string \"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.98\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.98\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 330,
			["counter"] = 5,
		}, -- [59]
		{
			["message"] = "ElvUI-5.98\\modules\\chat\\chat-Chat.lua:1434: attempt to compare number with nil",
			["time"] = "2013/04/13 17:32:55",
			["stack"] = "ElvUI-5.98\\modules\\chat\\chat-Chat.lua:1434: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[16]\":4: in function <string>:\"safecall Dispatcher[16]\":4\n<in C code>\n<string>:\"safecall Dispatcher[16]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 330,
			["counter"] = 1,
		}, -- [60]
		{
			["message"] = "ElvUI-5.98\\modules\\unitframes\\groups\\party-Party.lua:525: attempt to index local \"GPS\" (a nil value)",
			["time"] = "2013/04/13 17:32:32",
			["stack"] = "ElvUI-5.98\\modules\\unitframes\\groups\\party-Party.lua:525: in function \"?\"\nElvUI-5.98\\modules\\unitframes\\unitframes.lua:548: in function \"Update\"\nElvUI-5.98\\modules\\unitframes\\unitframes.lua:645: in function \"UpdateAllHeaders\"\nElvUI-5.98\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.98\\core\\core.lua:515: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.98\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.98\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 330,
			["counter"] = 2,
		}, -- [61]
		{
			["message"] = "ElvUI-5.98\\core\\pixelperfect.lua:114: attempt to perform arithmetic on local \"x\" (a nil value)",
			["time"] = "2013/04/13 17:33:33",
			["stack"] = "ElvUI-5.98\\core\\pixelperfect.lua:114: in function \"Scale\"\nElvUI-5.98\\modules\\actionbars\\actionbars.lua:63: in function <ElvUI\\modules\\actionbars\\actionbars.lua:62>\n<in C code>\nElvUI_Config-1.00\\actionbars.lua:23: in function <ElvUI_Config\\actionbars.lua:23>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[2]\":9: in function <string>:\"safecall Dispatcher[2]\":5\n(tail call): ?\nAceConfigDialog-3.0\\AceConfigDialog-3.0-57.lua:799: in function <AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:614>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nArkInventory-3.03.27\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\nAce3-AceGUI\\widgets\\AceGUIWidget-DropDown.lua:439: in function <Ace3-AceGUI\\widgets\\AceGUIWidget-DropDown.lua:430>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nArkInventory-3.03.27\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\n...\\Ace3-AceGUI\\widgets\\AceGUIWidget-DropDown-Items.lua:351: in function <...\\Ace3-AceGUI\\widgets\\AceGUIWidget-DropDown-Items.lua:341>",
			["session"] = 330,
			["counter"] = 4,
		}, -- [62]
		{
			["message"] = "ElvUI-5.98\\modules\\actionbars\\actionbars.lua:782: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/04/13 17:32:32",
			["stack"] = "ElvUI-5.98\\modules\\actionbars\\actionbars.lua:782: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 330,
			["counter"] = 7,
		}, -- [63]
		{
			["message"] = "ElvUI-5.98\\modules\\datatexts\\datatexts.lua:61: attempt to call field \"OnClick\" (a nil value)",
			["time"] = "2013/04/14 20:13:01",
			["locals"] = "self = DataText3 {\n 0 = <userdata>\n text = <unnamed> {}\n pointIndex = \"right\"\n}\nbutton = \"LeftButton\"\ndata = <table> {\n onEnter = <func> @ElvUI\\modules\\..\\datatexts.lua:38\n events = <table> {}\n origOnClick = <func> @ElvUI\\modules\\..\\datatexts.lua:60\n onClick = <func> @ElvUI_Enhanced\\modules\\..\\extratexts.lua:101\n eventFunc = <func> @ElvUI\\modules\\..\\datatexts.lua:72\n}\nmenuDatatext = DataText3 {\n 0 = <userdata>\n text = <unnamed> {}\n pointIndex = \"right\"\n}\nDT = <table> {\n UnregisterAllEvents = <func> @ArkInventory\\Libs\\CallbackHandler\\CallbackHandler-1.0.lua:201\n SetDefaultModuleLibraries = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:383\n PanelLayoutOptions = <func> @ElvUI_Config\\datatexts.lua:6\n Unhook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:421\n Enable = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:315\n NewModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:256\n baseName = \"ElvUI\"\n EnableModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:348\n modules = <table> {}\n GetModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:231\n IterateEmbeds = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:458\n HideBattlegroundTexts = <func> @ElvUI\\modules\\..\\battleground.lua:92\n SecureHook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:339\n defaultModuleLibraries = <table> {}\n TimeLeft = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:187\n PointLocation = <table> {}\n BattlegroundStats = <func> @ElvUI\\modules\\..\\battleground.lua:53\n RawHookScript = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:398\n ScheduleRepeatingTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:143\n CancelAllTimers = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:175\n UPDATE_BATTLEFIELD_SCORE = <func> @ElvUI\\modules\\..\\battleground.lua:41\n tooltip = DatatextTooltip {}\n SetDefaultModulePrototype = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:425\n LoadDataTexts = <func> =[C]:-1\n AssignPanelToDataText = <func> @ElvUI\\modules\\..\\datatexts.lua:155\n CancelTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:161\n name = \"ElvUI_DataTexts\"\n Initialize = <func> @ElvUI\\modules\\..\\datatexts.lua:8\n IsEnabled = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:467\n orderedModules = <table> {}\n ScheduleTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:108\n DisableModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:366\n SecureHookScript = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:413\n Data_OnLeave = <func> @ElvUI\\modules\\..\\datatexts.lua:115\n hooks = <table> {}\n SetupTooltip = <func> @ElvUI\\modules\\..\\datatexts.lua:119\n RegisterMessage = <func> @ArkInventory\\Libs\\CallbackHandler\\CallbackHandler-1.0.lua:117\n HookScript = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:369\n RegisterLDB = <func> @ElvUI",
			["stack"] = "ElvUI-5.98\\modules\\datatexts\\datatexts.lua:61: in function \"origOnClick\"\nElvUI_Enhanced-1.71\\modules\\datatexts\\extratexts.lua:115: in function <ElvUI_Enhanced\\modules\\datatexts\\extratexts.lua:101>",
			["session"] = 342,
			["counter"] = 1,
		}, -- [64]
		{
			["message"] = "ElvUI_ChatTweaks-5.94\\Modules\\InviteLinks.lua:72: attempt to perform arithmetic on a nil value",
			["time"] = "2013/04/15 00:03:40",
			["locals"] = "(*temporary) = \"GMChat\"\n(*temporary) = \"|HGMChat|h[A GM would like to chat with you. Click here to begin.]|h\"\n(*temporary) = \"LeftButton\"\n(*temporary) = <func> =[C]:-1\n",
			["stack"] = "ElvUI_ChatTweaks-5.94\\Modules\\InviteLinks.lua:72: in function <ElvUI_ChatTweaks\\Modules\\InviteLinks.lua:71>\n(tail call): ?\n(tail call): ?\n(tail call): ?\nBlizzard_CombatLog\\Blizzard_CombatLog.lua:3573: in function <Blizzard_CombatLog\\Blizzard_CombatLog.lua:3517>\n<in C code>\n<in C code>\nFrameXML\\ChatFrame.lua:3381: in function <FrameXML\\ChatFrame.lua:3380>\n<in C code>\nElvUI-5.98\\modules\\chat\\chat-Chat.lua:601: in function <ElvUI\\modules\\chat\\chat.lua:588>",
			["session"] = 348,
			["counter"] = 1,
		}, -- [65]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"MacroToolkit\" tried to call the protected function \"EditMacro()\".",
			["time"] = "2013/04/16 01:10:34",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_MacroUI\\Blizzard_MacroUI.lua:424: in function \"MacroFrame_SaveMacro\"\nBlizzard_MacroUI\\Blizzard_MacroUI.lua:153: in function <Blizzard_MacroUI\\Blizzard_MacroUI.lua:151>",
			["session"] = 351,
			["counter"] = 2,
		}, -- [66]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ACP\" tried to call the protected function \"CompactRaidFrame5:Show()\".",
			["time"] = "2013/04/16 20:41:52",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:279: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:237: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:139: in function <FrameXML\\CompactUnitFrame.lua:139>",
			["session"] = 354,
			["counter"] = 33,
		}, -- [67]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ACP\" tried to call the protected function \"CompactRaidFrame6:Show()\".",
			["time"] = "2013/04/16 20:41:52",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:279: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:237: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:139: in function <FrameXML\\CompactUnitFrame.lua:139>",
			["session"] = 354,
			["counter"] = 33,
		}, -- [68]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ACP\" tried to call the protected function \"CompactRaidFrame2:Show()\".",
			["time"] = "2013/04/16 20:41:52",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:279: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:237: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:139: in function <FrameXML\\CompactUnitFrame.lua:139>",
			["session"] = 356,
			["counter"] = 87,
		}, -- [69]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"ACP\" tried to call the protected function \"CompactRaidFrame3:Show()\".",
			["time"] = "2013/04/16 20:41:52",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:279: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:237: in function \"CompactUnitFrame_UpdateAll\"\nFrameXML\\CompactUnitFrame.lua:139: in function <FrameXML\\CompactUnitFrame.lua:139>",
			["session"] = 356,
			["counter"] = 87,
		}, -- [70]
		{
			["message"] = "ElvUI-5.99\\core\\math.lua:260: attempt to compare nil with number",
			["time"] = "2013/04/16 23:04:10",
			["locals"] = "self = ElvUIPlayerBuffsAuraButton1 {\n 0 = <userdata>\n highlight = <unnamed> {}\n backdrop = <unnamed> {}\n nextupdate = 0\n time = <unnamed> {}\n expiration = 14.982999999076\n count = <unnamed> {}\n anim = Flash {}\n texture = <unnamed> {}\n}\nelapsed = 0.017000000923872\ntimervalue = nil\nformatid = nil\nE = <table> {\n GetTimeInfo = <func> @ElvUI\\..\\math.lua:258\n privateVars = <table> {}\n modules = <table> {}\n CancelTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:161\n StaticPopup_EscapePressed = <func> @ElvUI\\..\\staticpopups.lua:241\n CopyTable = <func> @ElvUI\\..\\core.lua:421\n MassGuildKick = <func> @ElvUI\\..\\commands.lua:130\n SetMoversPositions = <func> @ElvUI\\..\\movers.lua:371\n ScheduleTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:108\n PriestColors = <table> {}\n RegisterModule = <func> @ElvUI\\..\\core.lua:622\n SetupTheme = <func> @ElvUI\\..\\install.lua:228\n media = <table> {}\n SetUpAnimGroup = <func> @ElvUI\\..\\animation.lua:7\n data = <table> {}\n UIScale = <func> @ElvUI\\..\\pixelperfect.lua:8\n db = <table> {}\n ToggleConfigMode = <func> @ElvUI\\..\\config.lua:49\n SetEnabledState = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:440\n Hook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:277\n Options = <table> {}\n Layout = <table> {}\n tDeleteItem = <func> @ElvUI\\..\\animation.lua:266\n LoadCommands = <func> @ElvUI\\..\\commands.lua:167\n SendPluginVersionCheck = <func> @ElvUI\\libs\\..\\LibElvUIPlugin-1.0.lua:119\n HiddenFrame = <unnamed> {}\n DisableAddon = <func> @ElvUI\\..\\commands.lua:17\n UnregisterAllEvents = <func> @ArkInventory\\Libs\\CallbackHandler\\CallbackHandler-1.0.lua:201\n UIFrameFade = <func> @ElvUI\\..\\animation.lua:202\n MinimapWidth = 176\n StaticPopup_IsLastDisplayedFrame = <func> @ElvUI\\..\\staticpopups.lua:302\n Truncate = <func> @ElvUI\\..\\math.lua:56\n UpdateBackdropColors = <func> @ElvUI\\..\\core.lua:271\n StaticPopup_OnHide = <func> @ElvUI\\..\\staticpopups.lua:342\n name = \"ElvUI\"\n WorldMap = <table> {}\n StopMassiveShake = <func> @ElvUI\\..\\core.lua:669\n Disable = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:330\n TimeColors = <table> {}\n SlideOut = <func> @ElvUI\\..\\animation.lua:147\n Unhook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:421\n Print = <func> @ElvUI\\..\\core.lua:129\n Install = <func> @ElvUI\\..\\install.lua:914\n TimeFormats = <table> {}\n RGBToHex = <func> @ElvUI\\..\\math.lua:62\n SetupPixelPerfect = <func> @ElvUI\\..\\install.lua:178\n RequestBGInfo = <func> @ElvUI\\..\\core.lua:222\n HealingClasses = <table> {}\n BeginFoolsDayEvent = <func> @ElvUI\\..\\core.lua:706\n UpdateNudgeFrame = <func> @ElvUI\\..\\config.lua:189\n SetDefaultModuleLibraries = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:383\n SlideIn = <func> @ElvUI\\..\\animation.lua:136\n NudgeFrame = <func> @ElvUI\\..\\config.lua:159\n wowbuild = 16826\n RegisteredInitialModules =",
			["stack"] = "ElvUI-5.99\\core\\math.lua:260: in function \"GetTimeInfo\"\nElvUI-5.99\\modules\\auras\\auras-Auras.lua:24: in function <ElvUI\\modules\\auras\\auras.lua:9>",
			["session"] = 373,
			["counter"] = 200,
		}, -- [71]
		{
			["message"] = "ElvUI-5.99\\modules\\actionbars\\actionbars.lua:782: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/04/16 23:04:01",
			["stack"] = "ElvUI-5.99\\modules\\actionbars\\actionbars.lua:782: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 380,
			["counter"] = 10,
		}, -- [72]
		{
			["message"] = "ElvUI-5.99\\modules\\chat\\chat-Chat.lua:1434: attempt to compare number with nil",
			["time"] = "2013/04/21 00:23:19",
			["stack"] = "ElvUI-5.99\\modules\\chat\\chat-Chat.lua:1434: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[16]\":4: in function <string>:\"safecall Dispatcher[16]\":4\n<in C code>\n<string>:\"safecall Dispatcher[16]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 380,
			["counter"] = 34,
		}, -- [73]
		{
			["message"] = "ElvUI-5.99\\modules\\actionbars\\actionbars.lua:63: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/04/21 00:23:17",
			["stack"] = "ElvUI-5.99\\modules\\actionbars\\actionbars.lua:63: in function <ElvUI\\modules\\actionbars\\actionbars.lua:62>\n<in C code>\nElvUI-5.99\\modules\\actionbars\\actionbars.lua:381: in function \"UpdateButtonSettings\"\nElvUI_Enhanced-1.71\\modules\\datatexts\\extratexts.lua:49: in function \"UpdateSettings\"\nElvUI_Enhanced-1.71\\config\\options.lua:39: in function <ElvUI_Enhanced\\config\\options.lua:37>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[2]\":9: in function <string>:\"safecall Dispatcher[2]\":5\n(tail call): ?\nAceConfigDialog-3.0\\AceConfigDialog-3.0-57.lua:799: in function <AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:614>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nArkInventory-3.03.27\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\nAce3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:68: in function <Ace3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:57>",
			["session"] = 380,
			["counter"] = 5,
		}, -- [74]
		{
			["message"] = "CreateFrame: Can\"t create protected \"Button\" now",
			["time"] = "2013/01/24 00:57:24",
			["locals"] = "(*temporary) = \"Button\"\n(*temporary) = \"CompactRaidFrame1\"\n(*temporary) = CompactRaidFrameContainer {\n unitFrameUnusedFunc = <func> @Blizzard_CompactRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:46\n flowSortFunc = <func> @Blizzard_CompactRaidFrames\\Blizzard_CompactRaidFrameManager.lua:732\n groupMode = \"flush\"\n raidUnits = <table> {}\n frameUpdateList = <table> {}\n flowOrientation = \"horizontal\"\n showBorder = true\n borderFrame = CompactRaidFrameContainerBorderFrame {}\n flowFilterFunc = <func> @Blizzard_CompactRaidFrames\\Blizzard_CompactRaidFrameManager.lua:830\n groupFilterFunc = <func> @Blizzard_CompactRaidFrames\\Blizzard_CompactRaidFrameManager.lua:860\n partyUnits = <table> {}\n flowMaxPrimaryUsed = 0\n flowMaxSecondaryUsed = 0\n units = <table> {}\n flowPauseUpdates = true\n enabled = false\n frameReservations = <table> {}\n flowFrames = <table> {}\n 0 = <userdata>\n displayFlaggedMembers = true\n}\n(*temporary) = \"CompactUnitFrameTemplate\"\n = <func> =[C]:-1\n = <func> @AtlasLoot\\Libs\\..\\LibStrataFix.lua:118\n",
			["stack"] = "<in C code>\n<in C code>\nBlizzard_CompactRaidFrameContainer.lua:345: in function \"CompactRaidFrameContainer_GetUnitFrame\"\nBlizzard_CompactRaidFrameContainer.lua:317: in function \"CompactRaidFrameContainer_AddUnitFrame\"\nBlizzard_CompactRaidFrameContainer.lua:254: in function \"CompactRaidFrameContainer_AddPlayers\"\nBlizzard_CompactRaidFrameContainer.lua:176: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:95: in function \"CompactRaidFrameContainer_SetFlowSortFunction\"\nBlizzard_CompactRaidFrameManager.lua:405: in function <Blizzard_CompactRaidFrameManager.lua:402>\nBlizzard_CompactRaidFrameManager.lua:491: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:172: in function \"CompactUnitFrameProfiles_ActivateRaidProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:45: in function \"CompactUnitFrameProfiles_ValidateProfilesLoaded\"\nBlizzard_CompactUnitFrameProfiles.lua:25: in function <Blizzard_CompactUnitFrameProfiles.lua:18>",
			["session"] = 384,
			["counter"] = 2,
		}, -- [75]
		{
			["message"] = "ElvUI-5.99\\core\\core.lua:177: attempt to index field \"general\" (a nil value)",
			["time"] = "2013/04/28 20:47:09",
			["stack"] = "ElvUI-5.99\\core\\core.lua:177: in function \"UpdateMedia\"\nElvUI-5.99\\core\\core.lua:507: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.99\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.99\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:204: in function \"_EnhanceDatabase\"\nElvUI-5.99\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:226: in function \"EnhanceDatabase\"\nElvUI-5.99\\core\\core.lua:765: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 392,
			["counter"] = 1,
		}, -- [76]
		{
			["message"] = "ElvUI-5.99\\modules\\unitframes\\unitframes.lua:573: No unit provided to create or update.",
			["time"] = "2013/04/16 23:04:01",
			["stack"] = "<in C code>\n<in C code>\nFrameXML\\RestrictedFrames.lua:604: in function <FrameXML\\RestrictedFrames.lua:603>\nFrameXML\\RestrictedFrames.lua:742: in function \"CallMethod\"\n<string>:\"		local header = self:GetParent()RestrictedExecution.lua:441: in function <FrameXML\\RestrictedExecution.lua:412>\nFrameXML\\SecureGroupHeaders.lua:116: in function <FrameXML\\SecureGroupHeaders.lua:110>\nFrameXML\\SecureGroupHeaders.lua:166: in function <FrameXML\\SecureGroupHeaders.lua:123>\nFrameXML\\SecureGroupHeaders.lua:488: in function <FrameXML\\SecureGroupHeaders.lua:387>\n<in C code>\nElvUI-5.99\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.99\\core\\core.lua:511: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n[string \"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.99\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.99\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 392,
			["counter"] = 40,
		}, -- [77]
		{
			["message"] = "ElvUI-5.99\\modules\\unitframes\\groups\\party-Party.lua:525: attempt to index local \"GPS\" (a nil value)",
			["time"] = "2013/04/16 23:04:01",
			["stack"] = "ElvUI-5.99\\modules\\unitframes\\groups\\party-Party.lua:525: in function \"?\"\nElvUI-5.99\\modules\\unitframes\\unitframes.lua:548: in function \"Update\"\nElvUI-5.99\\modules\\unitframes\\unitframes.lua:645: in function \"UpdateAllHeaders\"\nElvUI-5.99\\modules\\unitframes\\unitframes.lua:468: in function \"Update_AllFrames\"\nElvUI-5.99\\core\\core.lua:511: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.27\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nElvUI-5.99\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:178: in function \"CheckDualSpecState\"\nElvUI-5.99\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0-8.lua:325: in function <ElvUI\\libs\\LibDualSpec-1.0\\LibDualSpec-1.0.lua:319>",
			["session"] = 392,
			["counter"] = 14,
		}, -- [78]
		{
			["message"] = "Pawn\\Pawn-1.8.4.lua:4112: attempt to concatenate global \"PawnPlayerFullName\" (a nil value)",
			["time"] = "2013/03/29 11:37:10",
			["locals"] = "Item = <table> {}\nItemLevel = 90\nSocketBonus = <table> {}\nUnenchantedItem = <table> {}\nUnenchantedItemSocketBonus = <table> {}\nDebugMessages = true\nNoNormalization = nil\nItemValues = <table> {}\n(for generator) = <func> =[C]:-1\n(for state) = <table> {\n \"Wowhead\":ShamanEnhancement = <table> {}\n \"Wowhead\":DeathKnightUnholyDps = <table> {}\n \"Wowhead\":RogueAssassination = <table> {}\n \"Wowhead\":WarriorArms = <table> {}\n \"Wowhead\":WarlockDestruction = <table> {}\n \"Wowhead\":MonkMistweaver = <table> {}\n \"Wowhead\":PaladinTank = <table> {}\n \"Wowhead\":HunterBeastMastery = <table> {}\n \"Wowhead\":PaladinHoly = <table> {}\n \"Wowhead\":RogueCombat = <table> {}\n \"Wowhead\":PriestDiscipline = <table> {}\n \"Wowhead\":DeathKnightBloodTank = <table> {}\n \"Wowhead\":MageFrost = <table> {}\n \"Wowhead\":ShamanRestoration = <table> {}\n \"Wowhead\":MageFire = <table> {}\n Resto: Mr Robot = <table> {}\n \"Wowhead\":WarriorFury = <table> {}\n \"Wowhead\":WarlockDemonology = <table> {}\n \"Wowhead\":MonkBrewmaster = <table> {}\n \"Wowhead\":DruidRestoration = <table> {}\n \"Wowhead\":DruidFeralTank = <table> {}\n \"Wowhead\":HunterMarksman = <table> {}\n \"Wowhead\":RogueSubtlety = <table> {}\n \"Wowhead\":ShamanElemental = <table> {}\n \"Wowhead\":PaladinRetribution = <table> {}\n \"Wowhead\":MageArcane = <table> {}\n \"Wowhead\":DruidFeralDps = <table> {}\n \"Wowhead\":WarriorTank = <table> {}\n \"Wowhead\":DeathKnightFrostDps = <table> {}\n \"Wowhead\":DruidBalance = <table> {}\n \"Wowhead\":MonkWindwalker = <table> {}\n \"Wowhead\":HunterSurvival = <table> {}\n \"Wowhead\":WarlockAffliction = <table> {}\n \"Wowhead\":PriestHoly = <table> {}\n \"Wowhead\":PriestShadow = <table> {}\n}\n(for control) = \"\"Wowhead\":ShamanEnhancement\"\nScaleName = \"\"Wowhead\":ShamanEnhancement\"\nScale = <table> {\n PerCharacterOptions = <table> {}\n Color = \"ff2800\"\n LocalizedName = \"Shaman: enhancement\"\n DoNotShow1HUpgrades = false\n NormalizationFactor = 1\n DoNotShow2HUpgrades = true\n UpgradesFollowSpecialization = true\n Provider = \"Wowhead\"\n UnenchantedColor = \"bf1e00\"\n}\n",
			["stack"] = "Pawn\\Pawn-1.8.4.lua:4112: in function \"PawnIsScaleVisible\"\nPawn\\Pawn-1.8.4.lua:1300: in function \"PawnGetAllItemValues\"\nPawn\\Pawn-1.8.4.lua:1189: in function \"PawnRecalculateItemValuesIfNecessary\"\nPawn\\Pawn-1.8.4.lua:1067: in function \"PawnGetItemData\"\nPawn-1.8.4\\PawnUI.lua:2271: in function \"PawnUI_OnQuestInfo_ShowRewards\"\nPawn-1.8.4\\PawnUI.lua:2230: in function <Pawn\\PawnUI.lua:2226>\n<in C code>\nFrameXML\\WorldMapFrame.lua:2335: in function \"WorldMapFrame_SelectQuestFrame\"\nFrameXML\\WorldMapFrame.lua:2100: in function \"WorldMapFrame_SelectQuestById\"\nFrameXML\\WorldMapFrame.lua:2066: in function \"WorldMapFrame_DisplayQuests\"\nFrameXML\\WorldMapFrame.lua:2156: in function \"WorldMapFrame_UpdateMap\"\nFrameXML\\WorldMapFrame.lua:306: in function <FrameXML\\WorldMapFrame.lua:292>\nExternals\\Ace3-AceAddon\\AceAddon-3.0-11.lua:543: in function \"EnableAddon\"\nExternals\\Ace3-AceAddon\\AceAddon-3.0-11.lua:636: in function <Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:621>\n<in C code>\nFrameXML\\UIParent.lua:301: in function \"UIParentLoadAddOn\"\nFrameXML\\UIParent.lua:375: in function \"TimeManager_LoadUI\"\nFrameXML\\UIParent.lua:713: in function <FrameXML\\UIParent.lua:678>",
			["session"] = 396,
			["counter"] = 16,
		}, -- [79]
		{
			["message"] = "oRA3-r565-release\\modules\\Cooldowns.lua:1021: attempt to call method \"SendComm\" (a nil value)",
			["time"] = "2013/04/15 00:36:25",
			["stack"] = "oRA3-r565-release\\modules\\Cooldowns.lua:1021: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 415,
			["counter"] = 18,
		}, -- [80]
		{
			["message"] = "FrameXML\\FloatingChatFrame.lua:1046: bad argument #1 to \"max\" (number expected, got nil)",
			["time"] = "2013/01/15 01:32:08",
			["locals"] = "chatFrame = ChatFrame2 {\n 0 = <userdata>\n flashTimer = 0\n originalShow = <func> =[C]:-1\n tellTimer = 67.865\n button = CopyChatButton2 {}\n resizeButton = ChatFrame2ResizeButton {}\n buttonFrame = ChatFrame2ButtonFrame {}\n Hide = <func> @FrameXML\\FrameLocks.lua:119\n hasBeenFaded = true\n buttonSide = \"left\"\n channelList = <table> {}\n SetScript = <func> =[C]:-1\n clickAnywhereButton = ChatFrame2ClickAnywhereButton {}\n isDocked = 1\n styled = true\n editBox = ChatFrame2EditBox {}\n Show = <func> @FrameXML\\FrameLocks.lua:123\n isLocked = 1\n name = \"Combat Log\"\n isStaticDocked = true\n originalHide = <func> =[C]:-1\n zoneChannelList = <table> {}\n defaultLanguage = \"Common\"\n messageTypeList = <table> {}\n}\nframeName = \"ChatFrame2\"\n(for generator) = <func> =[C]:-1\n(for state) = <table> {\n 1 = \"Background\"\n 2 = \"TopLeftTexture\"\n 3 = \"BottomLeftTexture\"\n 4 = \"TopRightTexture\"\n 5 = \"BottomRightTexture\"\n 6 = \"LeftTexture\"\n 7 = \"RightTexture\"\n 8 = \"BottomTexture\"\n 9 = \"TopTexture\"\n 10 = \"ButtonFrameBackground\"\n 11 = \"ButtonFrameTopLeftTexture\"\n 12 = \"ButtonFrameBottomLeftTexture\"\n 13 = \"ButtonFrameTopRightTexture\"\n 14 = \"ButtonFrameBottomRightTexture\"\n 15 = \"ButtonFrameLeftTexture\"\n 16 = \"ButtonFrameRightTexture\"\n 17 = \"ButtonFrameBottomTexture\"\n 18 = \"ButtonFrameTopTexture\"\n}\n(for control) = 10\nindex = 10\nvalue = \"ButtonFrameBackground\"\nobject = ChatFrame2ButtonFrameBackground {\n 0 = <userdata>\n}\n(*temporary) = <func> @FrameXML\\UIParent.lua:2670\n(*temporary) = ChatFrame2ButtonFrameBackground {\n 0 = <userdata>\n}\n(*temporary) = 0\n(*temporary) = 1\n",
			["stack"] = "<in C code>\nFrameXML\\FloatingChatFrame.lua:1046: in function \"FCF_FadeInChatFrame\"\nFrameXML\\FloatingChatFrame.lua:1052: in function \"FCF_FadeInChatFrame\"\nFrameXML\\FloatingChatFrame.lua:1128: in function \"FCF_OnUpdate\"\n<string>:\"*:OnUpdate\":1: in function <string>:\"*:OnUpdate\":1",
			["session"] = 432,
			["counter"] = 7,
		}, -- [81]
		{
			["message"] = "FrameXML\\FloatingChatFrame.lua:1076: bad argument #2 to \"max\" (number expected, got nil)",
			["time"] = "2013/01/15 01:32:09",
			["locals"] = "chatFrame = ChatFrame2 {\n 0 = <userdata>\n flashTimer = 0\n originalShow = <func> =[C]:-1\n tellTimer = 67.865\n button = CopyChatButton2 {}\n resizeButton = ChatFrame2ResizeButton {}\n buttonFrame = ChatFrame2ButtonFrame {}\n Hide = <func> @FrameXML\\FrameLocks.lua:119\n buttonSide = \"left\"\n channelList = <table> {}\n SetScript = <func> =[C]:-1\n clickAnywhereButton = ChatFrame2ClickAnywhereButton {}\n isDocked = 1\n styled = true\n editBox = ChatFrame2EditBox {}\n Show = <func> @FrameXML\\FrameLocks.lua:123\n isLocked = 1\n name = \"Combat Log\"\n isStaticDocked = true\n originalHide = <func> =[C]:-1\n zoneChannelList = <table> {}\n defaultLanguage = \"Common\"\n messageTypeList = <table> {}\n}\nframeName = \"ChatFrame2\"\n(for generator) = <func> =[C]:-1\n(for state) = <table> {\n 1 = \"Background\"\n 2 = \"TopLeftTexture\"\n 3 = \"BottomLeftTexture\"\n 4 = \"TopRightTexture\"\n 5 = \"BottomRightTexture\"\n 6 = \"LeftTexture\"\n 7 = \"RightTexture\"\n 8 = \"BottomTexture\"\n 9 = \"TopTexture\"\n 10 = \"ButtonFrameBackground\"\n 11 = \"ButtonFrameTopLeftTexture\"\n 12 = \"ButtonFrameBottomLeftTexture\"\n 13 = \"ButtonFrameTopRightTexture\"\n 14 = \"ButtonFrameBottomRightTexture\"\n 15 = \"ButtonFrameLeftTexture\"\n 16 = \"ButtonFrameRightTexture\"\n 17 = \"ButtonFrameBottomTexture\"\n 18 = \"ButtonFrameTopTexture\"\n}\n(for control) = 10\nindex = 10\nvalue = \"ButtonFrameBackground\"\nobject = ChatFrame2ButtonFrameBackground {\n 0 = <userdata>\n}\n(*temporary) = <func> @FrameXML\\UIParent.lua:2680\n(*temporary) = ChatFrame2ButtonFrameBackground {\n 0 = <userdata>\n}\n(*temporary) = 2\n",
			["stack"] = "<in C code>\nFrameXML\\FloatingChatFrame.lua:1076: in function \"FCF_FadeOutChatFrame\"\nFrameXML\\FloatingChatFrame.lua:1082: in function \"FCF_FadeOutChatFrame\"\nFrameXML\\FloatingChatFrame.lua:1137: in function \"FCF_OnUpdate\"\n<string>:\"*:OnUpdate\":1: in function <string>:\"*:OnUpdate\":1",
			["session"] = 432,
			["counter"] = 7,
		}, -- [82]
		{
			["message"] = "FrameXML\\FloatingPetBattleTooltip.lua:107: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/04/28 21:03:59",
			["locals"] = "speciesID = 89\nlevel = nil\nbreedQuality = nil\nmaxHealth = nil\npower = nil\nspeed = nil\ncustomName = nil\nname = \"Worg Pup\"\nicon = \"INTERFACE\\ICONS\\INV_BOX_PETCARRIER_01.BLP\"\npetType = 8\nBATTLE_PET_TOOLTIP = <table> {\n speciesID = 89\n petType = 8\n name = \"Worg Pup\"\n}\n",
			["stack"] = "FrameXML\\FloatingPetBattleTooltip.lua:107: in function \"BattlePetTooltipTemplate_SetBattlePet\"\nFrameXML\\BattlePetTooltip.lua:20: in function <FrameXML\\BattlePetTooltip.lua:3>\n<in C code>\nFrameXML\\BankFrame.lua:40: in function \"BankFrameItemButton_OnEnter\"\nArkInventory\\ArkInventory-3.03.27.lua:6757: in function \"Frame_Item_OnEnter\"\n<string>:\"*:OnEnter\":1: in function <string>:\"*:OnEnter\":1",
			["session"] = 433,
			["counter"] = 6,
		}, -- [83]
		{
			["message"] = "ElvUI-6.34\\core\\core.lua:178: attempt to index field \"general\" (a nil value)",
			["time"] = "2013/09/04 21:29:25",
			["stack"] = "ElvUI-6.34\\core\\core.lua:178: in function \"UpdateMedia\"\nElvUI-6.34\\core\\core.lua:517: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:147: in function <Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:147>\n<string>:\"safecall Dispatcher[3]\":4: in function <string>:\"safecall Dispatcher[3]\":4\n<in C code>\n<string>:\"safecall Dispatcher[3]\":13: in function \"?\"\nLibs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:92: in function \"Fire\"\nArkInventory-3.03.30\\Externals\\Ace3-AceDB\\AceDB-3.0-22.lua:462: in function \"SetProfile\"\nlibs\\LibDualSpec-1.0\\LibDualSpec-1.0-12.lua:193: in function \"CheckDualSpecState\"\nlibs\\LibDualSpec-1.0\\LibDualSpec-1.0-12.lua:218: in function \"_EnhanceDatabase\"\nlibs\\LibDualSpec-1.0\\LibDualSpec-1.0-12.lua:240: in function \"EnhanceDatabase\"\nElvUI-6.34\\core\\core.lua:777: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 449,
			["counter"] = 1,
		}, -- [84]
		{
			["message"] = "ElvUI-6.36\\modules\\unitframes\\config_enviroment.lua:194: attempt to call a nil value",
			["time"] = "2013/09/10 00:41:26",
			["stack"] = "ElvUI-6.36\\modules\\unitframes\\config_enviroment.lua:194: in function \"HeaderConfig\"\nElvUI_Config-1.01\\unitframes.lua:2961: in function <ElvUI_Config\\unitframes.lua:2960>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nAceConfigDialog-3.0\\AceConfigDialog-3.0-57.lua:799: in function <AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:614>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[4]\":9: in function <string>:\"safecall Dispatcher[4]\":5\n(tail call): ?\nArkInventory-3.03.30\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\nAce3-AceGUI\\widgets\\AceGUIWidget-Button.lua:28: in function <Ace3-AceGUI\\widgets\\AceGUIWidget-Button.lua:25>",
			["session"] = 452,
			["counter"] = 1,
		}, -- [85]
		{
			["message"] = "ElvUI-6.36\\modules\\unitframes\\unitframes.lua:823: No unit provided to create or update.",
			["time"] = "2013/09/10 00:41:15",
			["stack"] = "<in C code>\n<in C code>\nFrameXML\\RestrictedFrames.lua:604: in function <FrameXML\\RestrictedFrames.lua:603>\nFrameXML\\RestrictedFrames.lua:742: in function \"CallMethod\"\n<string>:\"		local header = self:GetParent()RestrictedExecution.lua:441: in function <FrameXML\\RestrictedExecution.lua:412>\nFrameXML\\SecureGroupHeaders.lua:116: in function <FrameXML\\SecureGroupHeaders.lua:110>\nFrameXML\\SecureGroupHeaders.lua:166: in function <FrameXML\\SecureGroupHeaders.lua:123>\nFrameXML\\SecureGroupHeaders.lua:488: in function <FrameXML\\SecureGroupHeaders.lua:387>\n<in C code>\nAceConfigDialog-3.0\\AceConfigDialog-3.0-57.lua:799: in function <AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:614>\n(tail call): ?\n<in C code>\n[string \"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nArkInventory-3.03.30\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\nAce3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:68: in function <Ace3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:57>",
			["session"] = 455,
			["counter"] = 15,
		}, -- [86]
		{
			["message"] = "ElvUI-6.36\\modules\\unitframes\\groups\\party-Party.lua:532: attempt to index local \"GPS\" (a nil value)",
			["time"] = "2013/09/10 00:41:27",
			["stack"] = "ElvUI-6.36\\modules\\unitframes\\groups\\party-Party.lua:532: in function \"?\"\nElvUI-6.36\\modules\\unitframes\\unitframes.lua:608: in function \"Update\"\nElvUI-6.36\\modules\\unitframes\\config_enviroment.lua:213: in function \"HeaderConfig\"\nElvUI_Config-1.01\\unitframes.lua:2961: in function <ElvUI_Config\\unitframes.lua:2960>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nAceConfigDialog-3.0\\AceConfigDialog-3.0-57.lua:799: in function <AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:614>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[4]\":9: in function <string>:\"safecall Dispatcher[4]\":5\n(tail call): ?\nArkInventory-3.03.30\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\nAce3-AceGUI\\widgets\\AceGUIWidget-Button.lua:28: in function <Ace3-AceGUI\\widgets\\AceGUIWidget-Button.lua:25>",
			["session"] = 455,
			["counter"] = 11,
		}, -- [87]
		{
			["message"] = "ElvUI_ExtraActionBars-2.22\\core.lua:62: attempt to call method \"UpdateCooldownSettings\" (a nil value)",
			["time"] = "2013/09/12 20:57:42",
			["stack"] = "ElvUI_ExtraActionBars-2.22\\core.lua:62: in function \"CreateBars\"\nElvUI_ExtraActionBars-2.22\\core.lua:85: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:146: in function <Libs\\CallbackHandler\\CallbackHandler-1.0.lua:146>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 458,
			["counter"] = 1,
		}, -- [88]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"TradeSkillMaster_ItemTracker\" tried to call the protected function \"orig()\".",
			["time"] = "2013/09/10 21:08:59",
			["stack"] = "!BugGrabber-r193-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\n...\\ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0-6.lua:95: in function \"PlaceAuctionBid\"\nTradeSkillMaster-v2.1.3\\Auction\\AuctionResultsTable.lua:438: in function <TradeSkillMaster\\Auction\\AuctionResultsTable.lua:423>\n<in C code>\nTradeSkillMaster_Shopping-v2.1\\modules\\Util.lua:269: in function <TradeSkillMaster_Shopping\\modules\\Util.lua:262>\n(tail call): ?\nTradeSkillMaster_Shopping-v2.1\\modules\\Util.lua:234: in function \"callbackHandler\"\n...\\TradeSkillMaster\\Auction\\AuctionScanning.lua:27: in function <...\\TradeSkillMaster\\Auction\\AuctionScanning.lua:25>\n(tail call): ?\n...\\TradeSkillMaster\\Auction\\AuctionScanning.lua:43: in function <...\\TradeSkillMaster\\Auction\\AuctionScanning.lua:31>\n<string>:\"safecall Dispatcher[1]\":4: in function <string>:\"safecall Dispatcher[1]\":4\n<in C code>\n<string>:\"safecall Dispatcher[1]\":13: in function \"?\"\nLibs\\CallbackHandler\\CallbackHandler-1.0-6.lua:91: in function \"Fire\"\nExternals\\Ace3-AceEvent\\AceEvent-3.0-3.lua:120: in function <Externals\\Ace3-AceEvent\\AceEvent-3.0.lua:119>",
			["session"] = 458,
			["counter"] = 2,
		}, -- [89]
		{
			["message"] = "ElvUI-6.49\\modules\\unitframes\\unitframes.lua:823: No unit provided to create or update.",
			["time"] = "2013/09/14 18:00:06",
			["stack"] = "<in C code>\n<in C code>\nFrameXML\\RestrictedFrames.lua:604: in function <FrameXML\\RestrictedFrames.lua:603>\nFrameXML\\RestrictedFrames.lua:742: in function \"CallMethod\"\n<string>:\"		local header = self:GetParent()RestrictedExecution.lua:441: in function <FrameXML\\RestrictedExecution.lua:412>\nFrameXML\\SecureGroupHeaders.lua:116: in function <FrameXML\\SecureGroupHeaders.lua:110>\nFrameXML\\SecureGroupHeaders.lua:166: in function <FrameXML\\SecureGroupHeaders.lua:123>\nFrameXML\\SecureGroupHeaders.lua:488: in function <FrameXML\\SecureGroupHeaders.lua:387>\n<in C code>\nAceConfigDialog-3.0\\AceConfigDialog-3.0-58.lua:799: in function <AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:614>\n(tail call): ?\n<in C code>\n[string \"safecall Dispatcher[3]\":9: in function <string>:\"safecall Dispatcher[3]\":5\n(tail call): ?\nArkInventory-3.03.31\\Externals\\Ace3-AceGUI\\AceGUI-3.0-33.lua:314: in function \"Fire\"\nAce3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:68: in function <Ace3-AceGUI\\widgets\\AceGUIWidget-CheckBox.lua:57>",
			["session"] = 460,
			["counter"] = 15,
		}, -- [90]
		{
			["message"] = "_NPCScan\\_NPCScan-v5.1-1-g89a1c46.lua:602: attempt to index field \"Achievements\" (a nil value)",
			["time"] = "2013/10/02 01:31:21",
			["locals"] = "self = <unnamed> {\n ACHIEVEMENT_EARNED = <func> @..\\_NPCScan.lua:1002\n ZONE_CHANGED_NEW_AREA = <func> @..\\_NPCScan.lua:1008\n PLAYER_ENTERING_WORLD = <func> @..\\_NPCScan.lua:949\n OnEvent = <func> @..\\_NPCScan.lua:1015\n 0 = <userdata>\n CRITERIA_UPDATE = <func> @..\\_NPCScan.lua:732\n PLAYER_UPDATE_RESTING = <func> @..\\_NPCScan.lua:618\n PLAYER_LEAVING_WORLD = <func> @..\\_NPCScan.lua:988\n}\nEvent = \"PLAYER_LOGIN\"\nOptions = <table> {\n NPCs = <table> {}\n Version = 5.1\n NPCWorldIDs = <table> {}\n}\nOptionsCharacter = <table> {\n NPCs = <table> {}\n Version = \"5.0.0.5\"\n NPCWorldIDs = <table> {}\n}\nNS = <table> {\n Overlay = <table> {}\n RareMobData = <table> {}\n SetAchievementsAddFound = <func> @..\\_NPCScan.lua:501\n OptionsCharacterDefault = <table> {}\n Achievements = <table> {}\n TamableIDs = <table> {}\n SetCacheWarnings = <func> @..\\_NPCScan.lua:481\n OptionsCharacter = <table> {}\n Synchronize = <func> @..\\_NPCScan.lua:563\n NPCAdd = <func> @..\\_NPCScan.lua:367\n Config = <unnamed> {}\n TestID = <func> @..\\_NPCScan.lua:213\n Frame = <unnamed> {}\n NpcIDMax = 1048575\n Overlays = <table> {}\n SetAlertSoundUnmute = <func> @..\\_NPCScan.lua:516\n Print = <func> @..\\_NPCScan.lua:196\n NPCIsActive = <func> @..\\_NPCScan.lua:358\n Button = _NPCScanButton {}\n AchievementRemove = <func> @..\\_NPCScan.lua:463\n AchievementAdd = <func> @..\\_NPCScan.lua:446\n ContinentIDs = <table> {}\n Options = <table> {}\n TamableNames = <table> {}\n AchievementNPCIsActive = <func> @..\\_NPCScan.lua:440\n SetAlertSound = <func> @..\\_NPCScan.lua:526\n SlashCommand = <func> @..\\_NPCScan.lua:1025\n SetBlockFlightScan = <func> @..\\_NPCScan.lua:538\n CacheListPrint = <func> @..\\_NPCScan.lua:273\n L = <table> {}\n Version = 5.1\n OptionsDefault = <table> {}\n ContinentNames = <table> {}\n Updater = <unnamed> {}\n NPCRemove = <func> @..\\_NPCScan.lua:383\n SetPrintTime = <func> @..\\_NPCScan.lua:491\n}\n",
			["stack"] = "_NPCScan\\_NPCScan-v5.1-1-g89a1c46.lua:602: in function \"Synchronize\"\n_NPCScan\\_NPCScan-v5.1-1-g89a1c46.lua:944: in function <_NPCScan\\_NPCScan.lua:801>\n(tail call): ?",
			["session"] = 468,
			["counter"] = 1,
		}, -- [91]
	},
}
