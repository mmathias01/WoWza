
BugGrabberDB = {
	["session"] = 110,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "libs\\LibStatLogic-1.2\\LibStatLogic-1.2-74.lua:6524: attempt to call global \"GetPrimaryTalentTree\" (a nil value)",
			["time"] = "2012/12/23 14:13:57",
			["locals"] = "self = StatLogicItemSetFrame {\n 0 = <userdata>\n PLAYER_EQUIPMENT_CHANGED = <func> @RatingBuster\\libs\\..\\LibStatLogic-1.2.lua:6536\n PLAYER_LOGIN = <func> @RatingBuster\\libs\\..\\LibStatLogic-1.2.lua:6547\n PLAYER_TALENT_UPDATE = <func> @RatingBuster\\libs\\..\\LibStatLogic-1.2.lua:6539\n}\nelapsed = 1.8960001468658\nGetTime = <func> =[C]:-1\nUpdateArmorSpecActive = <func> @RatingBuster\\libs\\..\\LibStatLogic-1.2.lua:6516\n",
			["stack"] = "libs\\LibStatLogic-1.2\\LibStatLogic-1.2-74.lua:6524: in function <libs\\LibStatLogic-1.2\\LibStatLogic-1.2.lua:6516>\nlibs\\LibStatLogic-1.2\\LibStatLogic-1.2-74.lua:6530: in function <libs\\LibStatLogic-1.2\\LibStatLogic-1.2.lua:6527>",
			["session"] = 91,
			["counter"] = 4,
		}, -- [1]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarBottomLeft:Hide()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:41: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 6,
		}, -- [2]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarBottomRight:Hide()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:49: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 6,
		}, -- [3]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarRight:Hide()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:56: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 6,
		}, -- [4]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"MultiBarLeft:Hide()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\MultiActionBars.lua:63: in function \"MultiActionBar_Update\"\nFrameXML\\InterfaceOptionsPanels.lua:1074: in function \"setFunc\"\nFrameXML\\InterfaceOptionsPanels.lua:90: in function <FrameXML\\InterfaceOptionsPanels.lua:86>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 6,
		}, -- [5]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrameContainer:Hide()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:515: in function \"CompactRaidFrameManager_UpdateContainerVisibility\"\nBlizzard_CompactRaidFrameManager.lua:460: in function <Blizzard_CompactRaidFrameManager.lua:449>\nBlizzard_CompactRaidFrameManager.lua:499: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrameManagerContainerResizeFrame:Hide()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:559: in function \"CompactRaidFrameManager_LockContainer\"\nBlizzard_CompactRaidFrameManager.lua:552: in function \"CompactRaidFrameManager_UpdateContainerLockVisibility\"\nBlizzard_CompactRaidFrameManager.lua:394: in function <Blizzard_CompactRaidFrameManager.lua:389>\nBlizzard_CompactRaidFrameManager.lua:489: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrame1:SetSize()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:1001: in function \"func\"\nBlizzard_CompactRaidFrameContainer.lua:325: in function \"applyFunc\"\nBlizzard_CompactRaidFrameContainer.lua:121: in function \"CompactRaidFrameContainer_ApplyToFrames\"\nBlizzard_CompactUnitFrameProfiles.lua:554: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrame1:Show()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\CompactUnitFrame.lua:279: in function \"CompactUnitFrame_UpdateVisible\"\nFrameXML\\CompactUnitFrame.lua:237: in function \"func\"\nBlizzard_CompactRaidFrameContainer.lua:325: in function \"applyFunc\"\nBlizzard_CompactRaidFrameContainer.lua:121: in function \"CompactRaidFrameContainer_ApplyToFrames\"\nBlizzard_CompactUnitFrameProfiles.lua:555: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrameManagerContainerResizeFrame:ClearAllPoints()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:542: in function \"CompactRaidFrameManager_UpdateContainerBounds\"\nBlizzard_CompactRaidFrameManager.lua:685: in function \"CompactRaidFrameManager_ResizeFrame_LoadPosition\"\nBlizzard_CompactUnitFrameProfiles.lua:564: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrameManagerContainerResizeFrame:SetPoint()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:543: in function \"CompactRaidFrameManager_UpdateContainerBounds\"\nBlizzard_CompactRaidFrameManager.lua:685: in function \"CompactRaidFrameManager_ResizeFrame_LoadPosition\"\nBlizzard_CompactUnitFrameProfiles.lua:564: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrameManagerContainerResizeFrame:SetHeight()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:544: in function \"CompactRaidFrameManager_UpdateContainerBounds\"\nBlizzard_CompactRaidFrameManager.lua:685: in function \"CompactRaidFrameManager_ResizeFrame_LoadPosition\"\nBlizzard_CompactUnitFrameProfiles.lua:564: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [12]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrameContainer:SetHeight()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nBlizzard_CompactRaidFrameManager.lua:616: in function \"CompactRaidFrameManager_ResizeFrame_UpdateContainerSize\"\nBlizzard_CompactRaidFrameManager.lua:546: in function \"CompactRaidFrameManager_UpdateContainerBounds\"\nBlizzard_CompactRaidFrameManager.lua:685: in function \"CompactRaidFrameManager_ResizeFrame_LoadPosition\"\nBlizzard_CompactUnitFrameProfiles.lua:564: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrame1:ClearAllPoints()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:157: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:76: in function \"CompactRaidFrameContainer_SetGroupMode\"\nBlizzard_CompactRaidFrameManager.lua:425: in function <Blizzard_CompactRaidFrameManager.lua:416>\nBlizzard_CompactRaidFrameManager.lua:493: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 3,
		}, -- [14]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn \"SpellFlash\" tried to call the protected function \"CompactRaidFrame1:SetPoint()\".",
			["time"] = "2013/04/02 22:53:11",
			["stack"] = "!BugGrabber-r191-release\\BugGrabber.lua:587: in function <!BugGrabber\\BugGrabber.lua:587>\n<in C code>\nFrameXML\\FlowContainer.lua:161: in function \"FlowContainer_DoLayout\"\nFrameXML\\FlowContainer.lua:17: in function \"FlowContainer_ResumeUpdates\"\nBlizzard_CompactRaidFrameContainer.lua:185: in function \"CompactRaidFrameContainer_LayoutFrames\"\nBlizzard_CompactRaidFrameContainer.lua:130: in function \"CompactRaidFrameContainer_TryUpdate\"\nBlizzard_CompactRaidFrameContainer.lua:76: in function \"CompactRaidFrameContainer_SetGroupMode\"\nBlizzard_CompactRaidFrameManager.lua:425: in function <Blizzard_CompactRaidFrameManager.lua:416>\nBlizzard_CompactRaidFrameManager.lua:493: in function \"CompactRaidFrameManager_SetSetting\"\nBlizzard_CompactUnitFrameProfiles.lua:572: in function \"func\"\nBlizzard_CompactUnitFrameProfiles.lua:549: in function \"CompactUnitFrameProfiles_ApplyProfile\"\nBlizzard_CompactUnitFrameProfiles.lua:176: in function \"CompactUnitFrameProfiles_ApplyCurrentSettings\"\nBlizzard_CompactUnitFrameProfiles.lua:85: in function \"CompactUnitFrameProfiles_CancelChanges\"\nBlizzard_CompactUnitFrameProfiles.lua:78: in function <Blizzard_CompactUnitFrameProfiles.lua:76>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:217: in function <FrameXML\\InterfaceOptionsFrame.lua:216>\n<in C code>\nFrameXML\\InterfaceOptionsFrame.lua:252: in function <FrameXML\\InterfaceOptionsFrame.lua:248>",
			["session"] = 101,
			["counter"] = 3,
		}, -- [15]
		{
			["message"] = "ElvUI-5.88\\modules\\bags\\bags.lua:191: attempt to index field \"?\" (a nil value)",
			["time"] = "2013/04/03 00:37:53",
			["locals"] = "self = ElvUI_ContainerFrame {\n 0 = <userdata>\n ContainerHolder = ElvUI_ContainerFrameContainerHolder {}\n Bags = <table> {}\n UpdateCooldowns = <func> @ElvUI\\modules\\..\\bags.lua:187\n UpdateAllSlots = <func> @ElvUI\\modules\\..\\bags.lua:201\n totalSlots = 16\n UpdateBagSlots = <func> @ElvUI\\modules\\..\\bags.lua:177\n vendorButton = <unnamed> {}\n UpdateSlot = <func> @ElvUI\\modules\\..\\bags.lua:125\n bottomOffset = 28\n stackButton = <unnamed> {}\n template = \"Transparent\"\n sortButton = <unnamed> {}\n transferButton = <unnamed> {}\n currencyButton = <unnamed> {}\n editBox = ElvUI_ContainerFrameEditBox {}\n closeButton = ElvUI_ContainerFrameCloseButton {}\n bagsButton = <unnamed> {}\n detail = <unnamed> {}\n holderFrame = <unnamed> {}\n BagIDs = <table> {}\n goldText = <unnamed> {}\n topOffset = 50\n}\nevent = \"BAG_UPDATE_COOLDOWN\"\nB = <table> {\n DisableBlizzard = <func> @ElvUI\\modules\\..\\bags.lua:59\n SetDefaultModuleLibraries = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:383\n EnableModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:348\n modules = <table> {}\n CancelTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:161\n IterateEmbeds = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:458\n SecureHook = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:339\n ContructContainerFrame = <func> @ElvUI\\modules\\..\\bags.lua:566\n StartStacking = <func> @ElvUI\\modules\\..\\sort.lua:632\n RawHookScript = <func> @ArkInventory\\Externals\\Ace3-AceHook\\AceHook-3.0.lua:398\n CanItemGoInBag = <func> @ElvUI\\modules\\..\\sort.lua:431\n Compress = <func> @ElvUI\\modules\\..\\sort.lua:450\n ResetSlotAlphaForBags = <func> @ElvUI\\modules\\..\\bags.lua:226\n SetDefaultModulePrototype = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:425\n Encode_BagSlot = <func> @ElvUI\\modules\\..\\sort.lua:368\n defaultModuleState = true\n SetSlotAlphaForBag = <func> @ElvUI\\modules\\..\\bags.lua:209\n GetContainerFrame = <func> @ElvUI\\modules\\..\\bags.lua:18\n BagFrame = ElvUI_ContainerFrame {}\n ScheduleTimer = <func> @ArkInventory\\Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:108\n DisableModule = <func> @ArkInventory\\Externals\\Ace3-AceAddon\\AceAddon-3.0.lua:366\n LoadBagBar = <func> @ElvUI\\modules\\..\\bagbar.lua:84\n Tooltip_Hide = <func> @ElvUI\\modules\\..\\bags.lua:51\n BagFrames = <table> {}\n db = <table> {}\n RegisterMessage = <func> @ArkInventory\\Libs\\CallbackHandler\\CallbackHandler-1.0.lua:117\n UnregisterMessage = <func> @ArkInventory\\Libs\\CallbackHandler\\CallbackHandler-1.0.lua:180\n OpenBank = <func> =[C]:-1\n baseName = \"ElvUI\"\n hooks = <table> {}\n GetNumSlots = <func> @ElvUI\\modules\\..\\sort.lua:340\n CommandDecorator = <func> @ElvUI\\modules\\..\\sort.lua:806\n PositionBagFrames = <func> @ElvUI\\modules\\..\\bags.lua:837\n UpdateSearch = <func> @ElvUI\\modules\\..\\bags.lua:71\n Token_OnEnter = <func> @ElvUI\\modules\\..\\bags.lua:489\n UpdateSlot = <func> @ElvUI\\modules\\..\\bags.lua:125\n UpdateGoldText = <func> @ElvUI\\modules\\..\\bags.lua:500\n SetEnabledState = <func> @ArkInventory\\E",
			["stack"] = "ElvUI-5.88\\modules\\bags\\bags.lua:191: in function \"UpdateCooldowns\"\nElvUI-5.88\\modules\\bags\\bags.lua:429: in function <ElvUI\\modules\\bags\\bags.lua:415>",
			["session"] = 103,
			["counter"] = 8,
		}, -- [16]
		{
			["message"] = "ArkInventory-3.03.27\\ArkInventoryLDB.lua:770: attempt to index local \"mountEntry\" (a nil value)",
			["time"] = "2013/04/03 00:37:56",
			["stack"] = "ArkInventory-3.03.27\\ArkInventoryLDB.lua:770: in function \"GetAvailable\"\nArkInventory-3.03.27\\ArkInventoryLDB.lua:728: in function \"GetAvailable\"\nArkInventory-3.03.27\\ArkInventoryLDB.lua:914: in function \"GetUsable\"\nArkInventory-3.03.27\\ArkInventoryLDB.lua:389: in function \"Update\"\nArkInventory-3.03.27\\ArkInventoryStorage.lua:1118: in function <ArkInventory\\ArkInventoryStorage.lua:1116>\n(tail call): ?\n<in C code>\n<string>:\"safecall Dispatcher[2]\":9: in function <string>:\"safecall Dispatcher[2]\":5\n(tail call): ?\nExternals\\Ace3-AceBucket\\AceBucket-3.0-3.lua:116: in function \"func\"\nExternals\\Ace3-AceTimer\\AceTimer-3.0-16.lua:43: in function <Externals\\Ace3-AceTimer\\AceTimer-3.0.lua:36>",
			["session"] = 103,
			["counter"] = 1,
		}, -- [17]
	},
}
