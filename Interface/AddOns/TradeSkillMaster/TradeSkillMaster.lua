﻿-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- This is the main TSM file that holds the majority of the APIs that modules will use.

-- register this file with Ace libraries
local TSM = select(2, ...)
TSM = LibStub("AceAddon-3.0"):NewAddon(TSM, "TradeSkillMaster", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
TSM.moduleObjects = {}
TSM.moduleNames = {}

local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster") -- loads the localization table
TSM._version = GetAddOnMetadata("TradeSkillMaster", "X-Curse-Packaged-Version") or GetAddOnMetadata("TradeSkillMaster", "Version") -- current version of the addon


TSMAPI = {}
local lib = TSMAPI

TSM.designDefaults = {
	frameColors = {
		frameBG = { backdrop = { 24, 24, 24, .93 }, border = { 30, 30, 30, 1 } },
		frame = { backdrop = { 24, 24, 24, 1 }, border = { 255, 255, 255, 0.03 } },
		content = { backdrop = { 42, 42, 42, 1 }, border = { 0, 0, 0, 0 } },
	},
	textColors = {
		iconRegion = { enabled = { 249, 255, 247, 1 } },
		text = { enabled = { 255, 254, 250, 1 }, disabled = { 147, 151, 139, 1 } },
		label = { enabled = { 216, 225, 211, 1 }, disabled = { 150, 148, 140, 1 } },
		title = { enabled = { 132, 219, 9, 1 } },
		link = { enabled = { 49, 56, 133, 1 } },
	},
	inlineColors = {
		link = { 153, 255, 255, 1 },
		link2 = { 153, 255, 255, 1 },
		category = { 36, 106, 36, 1 },
		category2 = { 85, 180, 8, 1 },
		tooltip = { 130, 130, 250, 1 },
		advanced = {  255, 30, 0, 1 },
	},
	edgeSize = 1.5,
	fonts = {
		content = "Fonts\\ARIALN.TTF",
		bold = "Interface\\Addons\\TradeSkillMaster\\Media\\DroidSans-Bold.ttf",
	},
	fontSizes = {
		normal = 15,
		medium = 13,
		small = 12,
	},
}

local savedDBDefaults = {
	global = {
		vendorItems = {},
		ignoreRandomEnchants = nil,
		globalOperations = false,
		operations = {},
		customPriceSources = {},
		bankUITab = "Warehousing",
		chatFrame = "",
		infoMessage = 1000,
	},
	profile = {
		minimapIcon = {
			-- minimap icon position and visibility
			hide = false,
			minimapPos = 220,
			radius = 80,
		},
		auctionFrameMovable = true,
		auctionFrameScale = 1,
		showBids = false,
		openAllBags = true,
		auctionResultRows = 12,
		design = nil,

		-- new TSM 2.0 stuff
		groups = {},
		items = {},
		operations = {},
		groupTreeStatus = {},
		customPriceSourceTreeStatus = {},
		directSubgroupAdd = true,
		pricePerUnit = true,
		moneyCoinsTooltip = true,
		moneyTextTooltip = false,
		tooltip = true,
		postDuration = 3,
		deValueSource = "DBMarket",
		deTooltip = true,
		vendorBuyTooltip = true,
		vendorSellTooltip = true,
		isBankui = true,
		defaultAuctionTab = "Shopping",
		gotoNewGroup = true,
		gotoNewCustomPriceSource = true,
		defaultGroupTab = 1,
		moveImportedItems = false,
		importParentOnly = false,
		keepInParent = true,
		savedThemes = {},
		groupTreeCollapsedStatus = {},
		exportSubGroups = false,
	},
	factionrealm = {
		accountKey = nil,
		characters = {},
		syncAccounts = {},
		numPagesCache = {},
	},
}

-- Called once the player has loaded WOW.
function TSM:OnInitialize()
	TSM.moduleObjects = nil
	TSM.moduleNames = nil

	-- load the savedDB into TSM.db
	TSM.db = LibStub:GetLibrary("AceDB-3.0"):New("TradeSkillMasterDB", savedDBDefaults, true)
	TSM.db:RegisterCallback("OnProfileChanged", TSM.UpdateModuleProfiles)
	TSM.db:RegisterCallback("OnProfileCopied", TSM.UpdateModuleProfiles)
	TSM.db:RegisterCallback("OnProfileReset", TSM.UpdateModuleProfiles)
	TSM.db:RegisterCallback("OnDatabaseShutdown", TSM.ModuleOnDatabaseShutdown)
	if TSM.db.global.globalOperations then
		TSM.operations = TSM.db.global.operations
	else
		TSM.operations = TSM.db.profile.operations
	end

	-- TSM core must be registered as a module just like the modules
	TSM:RegisterModule()

	for name, module in pairs(TSM.modules) do
		TSM[name] = module
	end

	-- create account key for multi-account syncing if necessary
	TSM.db.factionrealm.accountKey = TSM.db.factionrealm.accountKey or (GetRealmName() .. random(time()))
	-- add this character to the list of characters on this realm
	TSM.db.factionrealm.characters[UnitName("player")] = true
	
	if not TSM.db.profile.design then
		TSM:LoadDefaultDesign()
	end
	TSM:SetDesignDefaults(TSM.designDefaults, TSM.db.profile.design)

	-- create / register the minimap button
	TSM.LDBIcon = LibStub("LibDataBroker-1.1", true) and LibStub("LibDBIcon-1.0", true)
	local TradeSkillMasterLauncher = LibStub("LibDataBroker-1.1", true):NewDataObject("TradeSkillMasterMinimapIcon", {
		icon = "Interface\\Addons\\TradeSkillMaster\\Media\\TSM_Icon",
		OnClick = function(_, button) -- fires when a user clicks on the minimap icon
			if button == "LeftButton" then
				-- does the same thing as typing '/tsm'
				TSM.Modules:ChatCommand("")
			end
		end,
		OnTooltipShow = function(tt) -- tooltip that shows when you hover over the minimap icon
			local cs = "|cffffffcc"
			local ce = "|r"
			tt:AddLine("TradeSkillMaster " .. TSM._version)
			tt:AddLine(format(L["%sLeft-Click%s to open the main window"], cs, ce))
			tt:AddLine(format(L["%sDrag%s to move this button"], cs, ce))
		end,
	})
	TSM.LDBIcon:Register("TradeSkillMaster", TradeSkillMasterLauncher, TSM.db.profile.minimapIcon)
	local TradeSkillMasterLauncher2 = LibStub("LibDataBroker-1.1", true):NewDataObject("TradeSkillMaster", {
		type = "launcher",
		icon = "Interface\\Addons\\TradeSkillMaster\\Media\\TSM_Icon2",
		OnClick = function(_, button) -- fires when a user clicks on the minimap icon
			if button == "LeftButton" then
				-- does the same thing as typing '/tsm'
				TSM.Modules:ChatCommand("")
			end
		end,
		OnTooltipShow = function(tt) -- tooltip that shows when you hover over the minimap icon
			local cs = "|cffffffcc"
			local ce = "|r"
			tt:AddLine("TradeSkillMaster " .. TSM._version)
			tt:AddLine(format(L["%sLeft-Click%s to open the main window"], cs, ce))
			tt:AddLine(format(L["%sDrag%s to move this button"], cs, ce))
		end,
	})

	-- create the main TSM frame
	TSM:CreateMainFrame()
	
	-- fix any items with spaces in them
	for itemString, groupPath in pairs(TSM.db.profile.items) do
		if strfind(itemString, " ") then
			local newItemString = gsub(itemString, " ", "")
			TSM.db.profile.items[newItemString] = groupPath
			TSM.db.profile.items[itemString] = nil
		end
	end
end

function TSM:RegisterModule()
	TSM.icons = {
		{ side = "options", desc = L["TSM Status / Options"], callback = "LoadOptions", icon = "Interface\\Icons\\Achievement_Quests_Completed_04" },
		{ side = "options", desc = L["Groups"], callback = "LoadGroupOptions", slashCommand = "groups", icon = "Interface\\Icons\\INV_DataCrystal08" },
		{ side = "options", desc = L["Module Operations / Options"], slashCommand = "operations", callback = "LoadOperationOptions", icon = "Interface\\Icons\\INV_Misc_Enggizmos_33" },
		{ side = "options", desc = L["Tooltip Options"], slashCommand = "tooltips", callback = "LoadTooltipOptions", icon = "Interface\\Icons\\PET_Type_Mechanical" },
	}

	TSM.priceSources = {}
	-- Auctioneer
	if select(4, GetAddOnInfo("Auc-Advanced")) == 1 and AucAdvanced then
		if AucAdvanced.Modules.Util.Appraiser and AucAdvanced.Modules.Util.Appraiser.GetPrice then
			tinsert(TSM.priceSources, { key = "AucAppraiser", label = L["Auctioneer - Appraiser"], callback = AucAdvanced.Modules.Util.Appraiser.GetPrice })
		end
		if AucAdvanced.Modules.Util.SimpleAuction and AucAdvanced.Modules.Util.SimpleAuction.Private.GetItems then
			tinsert(TSM.priceSources, { key = "AucMinBuyout", label = L["Auctioneer - Minimum Buyout"], callback = function(itemLink) return select(6, AucAdvanced.Modules.Util.SimpleAuction.Private.GetItems(itemLink)) end })
		end
		if AucAdvanced.API.GetMarketValue then
			tinsert(TSM.priceSources, { key = "AucMarket", label = L["Auctioneer - Market Value"], callback = AucAdvanced.API.GetMarketValue })
		end
	end
	-- Auctionator
	if select(4, GetAddOnInfo("Auctionator")) == 1 and Atr_GetAuctionBuyout then
		tinsert(TSM.priceSources, { key = "AtrValue", label = L["Auctionator - Auction Value"], callback = Atr_GetAuctionBuyout })
	end
	-- TheUndermineJournal
	if select(4, GetAddOnInfo("TheUndermineJournal")) == 1 and TUJMarketInfo then
		tinsert(TSM.priceSources, { key = "TUJMarket", label = L["TUJ RE - Market Price"], callback = function(itemLink) return (TUJMarketInfo(TSMAPI:GetItemID(itemLink)) or {}).market end })
		tinsert(TSM.priceSources, { key = "TUJMean", label = L["TUJ RE - Mean"], callback = function(itemLink) return (TUJMarketInfo(TSMAPI:GetItemID(itemLink)) or {}).marketaverage end })
		tinsert(TSM.priceSources, { key = "TUJGEMarket", label = L["TUJ GE - Market Average"], callback = function(itemLink) return (TUJMarketInfo(TSMAPI:GetItemID(itemLink)) or {}).gemarketaverage end })
		tinsert(TSM.priceSources, { key = "TUJGEMedian", label = L["TUJ GE - Market Median"], callback = function(itemLink) return (TUJMarketInfo(TSMAPI:GetItemID(itemLink)) or {}).gemarketmedian end })
	end
	-- TheUndermineJournalGE
	if select(4, GetAddOnInfo("TheUndermineJournalGE")) == 1 and TUJMarketInfo then
		tinsert(TSM.priceSources, { key = "TUJGEMarket", label = L["TUJ GE - Market Average"], callback = function(itemLink) return (TUJMarketInfo(TSMAPI:GetItemID(itemLink)) or {}).marketaverage end })
		tinsert(TSM.priceSources, { key = "TUJGEMedian", label = L["TUJ GE - Market Median"], callback = function(itemLink) return (TUJMarketInfo(TSMAPI:GetItemID(itemLink)) or {}).marketmedian end })
	end
	-- Vendor Buy Price
	tinsert(TSM.priceSources, { key = "VendorBuy", label = L["Buy from Vendor"], callback = function(itemLink) return TSMAPI:GetVendorCost(TSMAPI:GetItemString(itemLink)) end })

	-- Vendor Buy Price
	tinsert(TSM.priceSources, { key = "VendorSell", label = L["Sell to Vendor"], callback = function(itemLink) local sell = select(11, GetItemInfo(itemLink)) return (sell or 0) > 0 and sell or nil end })

	-- Disenchant Value
	tinsert(TSM.priceSources, { key = "Disenchant", label = L["Disenchant Value"], callback = "GetDisenchantValue" })


	TSM.slashCommands = {
		{ key = "version", label = L["Prints out the version numbers of all installed modules"], callback = function() TSM:Print(L["TSM Version Info:"]) for _, module in ipairs(TSM.Modules:GetInfo()) do print(module.name, "|cff99ffff" .. module.version .. "|r") end end },
		{ key = "freset", label = L["Resets the position of the main TSM frame to the center of the screen"], callback = function() TSM.Frame.frame:ClearAllPoints() TSM.Frame.frame:SetPoint("CENTER", UIParent, "CENTER") TSM.Frame:SetWidth(823) TSM.Frame:SetHeight(686) TSM.Frame.frame:SetWidth(823) TSM.Frame.frame:SetHeight(686) end },
		{ key = "bankui", label = L["Toggles the bankui"], callback = "toggleBankUI" },
		{ key = "sources", label = L["Prints out the available price sources for use in custom price boxes."], callback = "PrintPriceSources" },
		{ key = "price", label = L["Allows for testing of custom prices."], callback = "TestPriceSource" },
	}

	TSM.moduleAPIs = {
		{ key = "deValue", callback = "GetDisenchantValue" },
	}

	TSM.sync = { callback = "SyncCallback" }

	TSMAPI:NewModule(TSM)
end


function TSMAPI:GetTSMProfileIterator()
	local originalProfile = TSM.db:GetCurrentProfile()
	local profiles = CopyTable(TSM.db:GetProfiles())

	return function()
		local profile = tremove(profiles)
		if profile then
			TSM.db:SetProfile(profile)
			return profile
		end
		TSM.db:SetProfile(originalProfile)
	end
end

function TSMAPI:AddPriceSource(key, label, callback)
	assert(type(key) == "string", "Invalid type of key: " .. type(key))
	assert(type(label) == "string", "Invalid type of label: " .. type(label))
	assert(type(callback) == "function", "Invalid type of callback: " .. type(callback))

	tinsert(TSM.priceSources, { key = key, label = label, callback = callback })
end

function TSM:GetTooltip(itemString, quantity)
	local text = {}
	quantity = max(quantity or 0, 1)
	if TSM.db.profile.tooltip then
		local base
		local path = TSM.db.profile.items[itemString]
		if not path then
			path = TSM.db.profile.items[TSMAPI:GetBaseItemString(itemString)]
			base = true
		end
		if path then
			if not base then
				tinsert(text, { left = "  " .. L["Group:"], right = "|cffffffff" .. TSMAPI:FormatGroupPath(path) })
			else
				tinsert(text, { left = "  " .. L["Group(Base Item):"], right = "|cffffffff" .. TSMAPI:FormatGroupPath(path) })
			end
			local modules = {}
			for module, operations in pairs(TSM.db.profile.groups[path]) do
				if operations[1] and operations[1] ~= "" then
					tinsert(modules, { module = module, operations = table.concat(operations, ", ") })
				end
			end
			sort(modules, function(a, b) return a.module < b.module end)
			for _, info in ipairs(modules) do
				tinsert(text, { left = "  " .. format(L["%s operation(s):"], info.module), right = "|cffffffff" .. info.operations .. "|r" })
			end
		end
	end

	local moneyCoinsTooltip = TSMAPI:GetMoneyCoinsTooltip()

	-- add disenchant value info
	if TSM.db.profile.deTooltip then
		local deValue = TSM:GetDisenchantValue(itemString)
		if deValue > 0 then
			if quantity then
				if moneyCoinsTooltip then
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Disenchant Value x%s:"], quantity), right = TSMAPI:FormatTextMoneyIcon(deValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Disenchant Value:"], right = TSMAPI:FormatTextMoneyIcon(deValue, "|cffffffff", true) })
					end
				else
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Disenchant Value x%s:"], quantity), right = TSMAPI:FormatTextMoney(deValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Disenchant Value:"], right = TSMAPI:FormatTextMoney(deValue, "|cffffffff", true) })
					end
				end
			end
		end
	end

	-- add Vendor Buy Price
	if TSM.db.profile.vendorBuyTooltip then
		local vendorValue = TSMAPI:GetVendorCost(itemString) or 0
		if vendorValue and vendorValue > 0 then
			if quantity then
				if moneyCoinsTooltip then
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Vendor Buy Price x%s:"], quantity), right = TSMAPI:FormatTextMoneyIcon(vendorValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Vendor Buy Price:"], right = TSMAPI:FormatTextMoneyIcon(vendorValue, "|cffffffff", true) })
					end
				else
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Vendor Buy Price x%s:"], quantity), right = TSMAPI:FormatTextMoney(vendorValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Vendor Buy Price:"], right = TSMAPI:FormatTextMoney(vendorValue, "|cffffffff", true) })
					end
				end
			end
		end
	end

	-- add Vendor sell Price
	if TSM.db.profile.vendorSellTooltip then
		local vendorValue = select(11, TSMAPI:GetSafeItemInfo(itemString))
		if vendorValue and vendorValue > 0 then
			if quantity then
				if moneyCoinsTooltip then
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Vendor Sell Price x%s:"], quantity), right = TSMAPI:FormatTextMoneyIcon(vendorValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Vendor Sell Price:"], right = TSMAPI:FormatTextMoneyIcon(vendorValue, "|cffffffff", true) })
					end
				else
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Vendor Sell Price x%s:"], quantity), right = TSMAPI:FormatTextMoney(vendorValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Vendor Sell Price:"], right = TSMAPI:FormatTextMoney(vendorValue, "|cffffffff", true) })
					end
				end
			end
		end
	end

	-- add heading
	if #text > 0 then
		tinsert(text, 1, "|cffffff00" .. L["TradeSkillMaster Info:"])
		return text
	end
end


function TSM:GetDisenchantValue(link)
	local _, itemLink, quality, ilvl, _, iType = TSMAPI:GetSafeItemInfo(link)
	local itemString = TSMAPI:GetItemString(itemLink)
	local WEAPON, ARMOR = GetAuctionItemClasses()
	if not itemString or TSMAPI.DisenchantingData.notDisenchantable[itemString] or not (iType == ARMOR or iType == WEAPON) then return 0 end

	local value = 0
	for _, data in ipairs(TSMAPI.DisenchantingData.disenchant) do
		for item, itemData in pairs(data) do
			if item ~= "desc" and itemData.itemTypes[iType] and itemData.itemTypes[iType][quality] then
				for _, deData in ipairs(itemData.itemTypes[iType][quality]) do
					if ilvl >= deData.minItemLevel and ilvl <= deData.maxItemLevel then
						local matValue = TSM:GetCustomPrice(TSM.db.profile.deValueSource, item)
						value = value + (matValue or 0) * deData.amountOfMats
					end
				end
			end
		end
	end

	return value
end

function TSM:PrintPriceSources()
	TSM:Printf(L["Below are your currently available price sources. The %skey|r is what you would type into a custom price box."], TSMAPI.Design:GetInlineColor("link"))
	local lines = {}
	for key, label in pairs(TSMAPI:GetPriceSources()) do
		tinsert(lines, { key = key, label = label })
	end
	sort(lines, function(a, b) return strlower(a.key) < strlower(b.key) end)
	local chatFrame = TSMAPI:GetChatFrame()
	for _, info in ipairs(lines) do
		chatFrame:AddMessage(format("%s (%s)", TSMAPI.Design:GetInlineColor("link") .. info.key .. "|r", info.label))
	end
end

function TSM:TestPriceSource(price)
	local link = select(3, strfind(price, "(\124c.+\124r)"))
	if not link then return TSM:Print(L["Usage: /tsm price <ItemLink> <Price String>"]) end
	price = gsub(price, TSMAPI:StrEscape(link), ""):trim()
	if price == "" then return TSM:Print(L["Usage: /tsm price <ItemLink> <Price String>"]) end
	local func, err = TSMAPI:ParseCustomPrice(price)
	if err then
		TSM:Printf(L["%s is not a valid custom price and gave the following error: %s"], TSMAPI.Design:GetInlineColor("link") .. price .. "|r", err)
	else
		local itemString = TSMAPI:GetItemString(link)
		if not itemString then return TSM:Printf(L["%s is a valid custom price but %s is an invalid item."], TSMAPI.Design:GetInlineColor("link") .. price .. "|r", link) end
		local value = func(itemString)
		if not value then return TSM:Printf(L["%s is a valid custom price but did not give a value for %s."], TSMAPI.Design:GetInlineColor("link") .. price .. "|r", link) end
		TSM:Printf(L["A custom price of %s for %s evaluates to %s."], TSMAPI.Design:GetInlineColor("link") .. price .. "|r", link, TSMAPI:FormatTextMoney(value))
	end
end

function TSM:GetCustomPrice(priceMethod, itemString)
	local func = TSMAPI:ParseCustomPrice(priceMethod)
	return func and func(itemString)
end

function TSMAPI:GetChatFrame()
	local chatFrame = DEFAULT_CHAT_FRAME
	for i=1, NUM_CHAT_WINDOWS do
		local name = strlower(GetChatWindowInfo(i) or "")
		if name ~= "" and name == strlower(TSM.db.global.chatFrame) then
			chatFrame = _G["ChatFrame"..i]
			break
		end
	end
	return chatFrame
end