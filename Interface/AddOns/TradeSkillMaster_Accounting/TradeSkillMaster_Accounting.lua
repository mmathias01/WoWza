-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_Accounting                          --
--           http://www.curse.com/addons/wow/tradeskillmaster_accounting          --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- register this file with Ace Libraries
local TSM = select(2, ...)
TSM = LibStub("AceAddon-3.0"):NewAddon(TSM, "TSM_Accounting", "AceEvent-3.0", "AceConsole-3.0")
TSM.SELL_KEYS = { "itemString", "itemName", "stackSize", "quantity", "price", "buyer", "player", "time", "source" }
TSM.BUY_KEYS = { "itemString", "itemName", "stackSize", "quantity", "price", "seller", "player", "time", "source" }
TSM.INCOME_KEYS = { "type", "amount", "source", "player", "time" }
TSM.EXPENSE_KEYS = { "type", "amount", "destination", "player", "time" }
TSM.EXPIRED_KEYS = { "itemString", "itemName", "stackSize", "quantity", "player", "time" }
TSM.CANCELLED_KEYS = { "itemString", "itemName", "stackSize", "quantity", "player", "time" }
TSM.GOLD_LOG_KEYS = { "startMinute", "endMinute", "copper" }
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_Accounting") -- loads the localization table
local LibParse = LibStub("LibParse")

local savedDBDefaults = {
	global = {
		itemStrings = {},
		infoID = 0,
	},
	factionrealm = {
		csvSales = "",
		csvBuys = "",
		csvIncome = "",
		csvExpense = "",
		csvExpired = "",
		csvCancelled = "",
		timeFormat = "ago",
		mvSource = "adbmarket",
		priceFormat = "avg",
		tooltip = { sale = false, purchase = false },
		smartBuyPrice = false,
		expiredAuctions = false,
		cancelledAuctions = false,
		saleRate = false,
		trackTrades = true,
		autoTrackTrades = false,
		displayGreys = true,
		goldLog = {},
		displayTransfers = true,
		saveTimeSales = "",
		saveTimeBuys = "",
	},
}

-- Called once the player has loaded WOW.
function TSM:OnInitialize()
	-- load the savedDB into TSM.db
	TSM.db = LibStub:GetLibrary("AceDB-3.0"):New("TradeSkillMaster_AccountingDB", savedDBDefaults, true)

	for module in pairs(TSM.modules) do
		TSM[module] = TSM.modules[module]
	end

	-- register with TSM
	TSM:RegisterModule()
	TSM:RegisterEvent("PLAYER_LOGOUT", TSM.OnDisable)

	-- convert 1.x data to 2.0 (CSV) format
	if TSM.db.factionrealm.itemData then
		TSM:ConvertOldData()
		wipe(TSM.db.factionrealm.itemData)
		TSM.db.factionrealm.itemData = nil
	end

	if TSM.db.factionrealm.data then
		TSM.db.factionrealm.csvSales = TSM.db.factionrealm.data.sales
		TSM.db.factionrealm.csvBuys = TSM.db.factionrealm.data.buys
		TSM.db.factionrealm.data = nil
	end

	TSM.Data:Load()

	-- fix issues in gold log
	for _, playerData in ipairs(TSM.db.factionrealm.goldLog) do
		for i=#playerData, 1, -1 do
			local data = playerData[i]
			data.startMinute = floor(data.startMinute)
			data.endMinute = floor(data.endMinute)
			if data.startMinute == data.endMinute and data.copper == 0 then
				tremove(playerData, i)
			else
				-- round to nearest 1k gold
				data.copper = TSM:Round(data.copper, COPPER_PER_GOLD*1000)
			end
		end
		if #playerData >= 2 then
			for i=2, #playerData do
				playerData[i].startMinute = playerData[i-1].endMinute + 1
			end
			for i=#playerData-1, 1, -1 do
				if playerData[i].copper == playerData[i+1].copper then
					playerData[i].endTime = playerData[i+1].endTime
					tremove(playerData, i+1)
				end
			end
		end
	end
end

-- registers this module with TSM by first setting all fields and then calling TSMAPI:NewModule().
function TSM:RegisterModule()
	TSM.icons = {
		{ side = "module", desc = "Accounting", slashCommand = "accounting", callback = "GUI:Load", icon = "Interface\\Icons\\Inv_Misc_Coin_02" },
	}
	TSM.moduleAPIs = {
		{ key = "avgsellprice", callback = "GetAverageSellPrice" },
		{ key = "avgbuyprice", callback = "GetAverageBuyPrice" },
	}
	TSM.priceSources = {
		{ key = "avgSell", label = L["Avg Sell Price"], callback = "GetAvgSellPrice" },
		{ key = "avgBuy", label = L["Avg Buy Price"], callback = "GetAvgBuyPrice" },
		{ key = "maxSell", label = L["Max Sell Price"], callback = "GetMaxSellPrice" },
		{ key = "maxBuy", label = L["Max Buy Price"], callback = "GetMaxBuyPrice" },
	}
	TSM.tooltipOptions = { callback = "GUI:LoadTooltipOptions" }

	TSMAPI:NewModule(TSM)
end

function TSM:GetTooltip(itemString)
	if not (TSM.db.factionrealm.tooltip.sale or TSM.db.factionrealm.tooltip.purchase) then return end
	if not (TSM.items[itemString]) then return end

	local itemCount, totalSaleNum, totalFailed, failedNum, expiredNum, cancelledNum = 0, 0, 0, 0, 0, 0
	local lastSold, lastPurchased
	if TSM.db.factionrealm.smartBuyPrice then
		local player, alts = TSMAPI:ModuleAPI("ItemTracker", "playertotal", itemString)
		if not player then
			alts = nil
		end
		player = player or 0
		alts = alts or 0
		local guild = TSMAPI:ModuleAPI("ItemTracker", "guildtotal", itemString) or 0
		local auctions = TSMAPI:ModuleAPI("ItemTracker", "auctionstotal", itemString) or 0
		itemCount = player + alts + guild + auctions
	end

	local text = {}
	local moneyCoinsTooltip = TSMAPI:GetMoneyCoinsTooltip()
	if TSM.db.factionrealm.tooltip.sale and TSM.items[itemString] and #TSM.items[itemString].sales > 0 then
		local totalPrice = 0
		for _, record in ipairs(TSM.items[itemString].sales) do
			if not record.copper then TSMAPI.Debug:DumpTable(record) end
			totalSaleNum = totalSaleNum + record.quantity
			totalPrice = totalPrice + record.copper * record.quantity
			if (record.time and record.time > (lastSold or 0)) then
				lastSold = record.time
			end
		end

		if IsShiftKeyDown() then
			if moneyCoinsTooltip then
				tinsert(text, { left = "  " .. L["Sold (Total Price):"], right = format("%s (%s)", "|cffffffff" .. totalSaleNum .. "|r", (TSMAPI:FormatTextMoneyIcon(totalPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			else
				tinsert(text, { left = "  " .. L["Sold (Total Price):"], right = format("%s (%s)", "|cffffffff" .. totalSaleNum .. "|r", (TSMAPI:FormatTextMoney(totalPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			end
		else
			local maxPrice = TSM:GetMaxSellPrice(itemString)
			if moneyCoinsTooltip then
				tinsert(text, { left = "  " .. L["Sold (Avg/Max Price):"], right = format("%s (%s / %s)", "|cffffffff" .. totalSaleNum .. "|r", (TSMAPI:FormatTextMoneyIcon(totalPrice / totalSaleNum, "|cffffffff", true) or "|cffffffff" .. "?"), (TSMAPI:FormatTextMoneyIcon(maxPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			else
				tinsert(text, { left = "  " .. L["Sold (Avg/Max Price):"], right = format("%s (%s / %s)", "|cffffffff" .. totalSaleNum .. "|r", (TSMAPI:FormatTextMoney(totalPrice / totalSaleNum, "|cffffffff", true) or "|cffffffff" .. "?"), (TSMAPI:FormatTextMoney(maxPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			end
		end
		if lastSold then
			local timeDiff = SecondsToTime(time() - lastSold)
			tinsert(text, { left = "  " .. L["Last Sold:"], right = "|cffffffff" .. format(L["%s ago"], timeDiff) })
		end
	end


	for _, record in ipairs(TSM.items[itemString].auctions) do
		if record.key == "Cancel" and TSM.db.factionrealm.cancelledAuctions then
			if lastSold then
				if record.time > lastSold then
					cancelledNum = cancelledNum + record.quantity
				end
			else
				cancelledNum = cancelledNum + record.quantity
			end
		elseif record.key == "Expire" and TSM.db.factionrealm.expiredAuctions then
			if lastSold then
				if record.time > lastSold then
					expiredNum = expiredNum + record.quantity
				end
			else
				expiredNum = expiredNum + record.quantity
			end
		end
		totalFailed = totalFailed + record.quantity
	end

	if expiredNum ~= 0 and cancelledNum ~= 0 then
		tinsert(text, { left = "  " .. L["Failed Since Last Sale (Expired/Cancelled):"], right = format("%s (%s/%s)", "|cffffffff" .. (expiredNum + cancelledNum) .. "|r", "|cffffffff" .. expiredNum .. "|r", "|cffffffff" .. cancelledNum .. "|r") })
	elseif expiredNum ~= 0 then
		tinsert(text, { left = "  " .. L["Expired Since Last Sale:"], right = "|cffffffff" .. expiredNum })
	elseif cancelledNum ~= 0 then
		tinsert(text, { left = "  " .. L["Cancelled Since Last Sale:"], right = "|cffffffff" .. cancelledNum })
	end

	if (totalSaleNum ~= 0 or totalFailed ~= 0) then
		local saleRate = (totalSaleNum / (totalSaleNum + totalFailed or 0))
		local shift = 10 ^ 2
		local result = floor(saleRate * shift + 0.5) / shift -- round to 2 decimal places
		tinsert(text, { left = "  " .. L["Sale Rate:"], right = "|cffffffff" .. result })
	end

	if TSM.db.factionrealm.tooltip.purchase and TSM.items[itemString] and #TSM.items[itemString].buys > 0 then
		local totalPrice, totalNum = 0, 0
		for i = #TSM.items[itemString].buys, 1, -1 do
			local record = TSM.items[itemString].buys[i]
			totalNum = totalNum + record.quantity
			totalPrice = totalPrice + record.copper * record.quantity
			if (record.time and record.time > (lastPurchased or 0)) then
				lastPurchased = record.time
			end
		end

		if IsShiftKeyDown() then
			if moneyCoinsTooltip then
				tinsert(text, { left = "  " .. L["Purchased (Total Price):"], right = format("%s (%s)", "|cffffffff" .. totalNum .. "|r", (TSMAPI:FormatTextMoneyIcon(totalPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			else
				tinsert(text, { left = "  " .. L["Purchased (Total Price):"], right = format("%s (%s)", "|cffffffff" .. totalNum .. "|r", (TSMAPI:FormatTextMoney(totalPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			end
		else
			local avgPrice = TSM:GetAvgBuyPrice(itemString)
			local maxPrice = TSM:GetMaxBuyPrice(itemString)
			if moneyCoinsTooltip then
				tinsert(text, { left = "  " .. L["Purchased (Avg/Max Price):"], right = format("%s (%s / %s)", "|cffffffff" .. totalNum .. "|r", (TSMAPI:FormatTextMoneyIcon(avgPrice, "|cffffffff", true) or "|cffffffff" .. "?"), (TSMAPI:FormatTextMoneyIcon(maxPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			else
				tinsert(text, { left = "  " .. L["Purchased (Avg/Max Price):"], right = format("%s (%s / %s)", "|cffffffff" .. totalNum .. "|r", (TSMAPI:FormatTextMoney(avgPrice, "|cffffffff", true) or "|cffffffff" .. "?"), (TSMAPI:FormatTextMoney(maxPrice, "|cffffffff", true) or "|cffffffff" .. "?")) })
			end
		end
		if lastPurchased then
			local timeDiff = SecondsToTime(time() - lastPurchased)
			tinsert(text, { left = "  " .. L["Last Purchased:"], right = "|cffffffff" .. format(L["%s ago"], timeDiff) })
		end
	end

	-- add heading
	if #text > 0 then
		tinsert(text, 1, "|cffffff00TSM Accounting:")
		return text
	end
end

function TSM:OnDisable()
	-- process items
	local exportData = {}
	local sales, buys, cancels, expires = {}, {}, {}, {}
	local saveTimeSales, saveTimeBuys = {}, {}
	for itemString, data in pairs(TSM.items) do
		local name = data.itemName or TSMAPI:GetSafeItemInfo(itemString) or TSM:GetItemName(itemString) or "?"
		name = gsub(name, ",", "") -- can't have commas in the itemNames in the CSV
		local itemExportData = {}
		
		-- process sales
		for _, record in ipairs(data.sales) do
			record.itemString = itemString
			record.itemName = name
			record.buyer = record.otherPlayer
			record.source = record.key
			record.price = record.copper
			if record.key == "Auction" then
				record.saveTime = record.saveTime or time()
				tinsert(saveTimeSales, record.saveTime)
				tinsert(itemExportData, strjoin("/", record.copper, record.quantity, record.time, record.saveTime))
			end
			tinsert(sales, record)
		end
		
		-- process buys
		for _, record in ipairs(data.buys) do
			record.itemString = itemString
			record.itemName = name
			record.seller = record.otherPlayer
			record.source = record.key
			record.price = record.copper
			if record.key == "Auction" then
				record.saveTime = record.saveTime or time()
				tinsert(saveTimeBuys, record.saveTime)
				tinsert(itemExportData, strjoin("/", record.copper, record.quantity, record.time, record.saveTime))
			end
			tinsert(buys, record)
		end
		if #itemExportData > 0 and strfind(itemString, "item:") then
			local item = gsub(itemString, "item:", "")
			item = gsub(item, ":0:0:0:0:0:", ":")
			tinsert(exportData, item..":"..table.concat(itemExportData, ","))
		end
		
		-- process auctions
		for _, record in ipairs(data.auctions) do
			record.itemString = itemString
			record.itemName = name
			if record.key == "Cancel" then
				tinsert(cancels, record)
			elseif record.key == "Expire" then
				tinsert(expires, record)
			end
		end
	end
	TSM.db.factionrealm.saveTimeSales = table.concat(saveTimeSales, ",")
	TSM.db.factionrealm.saveTimeBuys = table.concat(saveTimeBuys, ",")
	TSM.db.factionrealm.csvSales = LibParse:CSVEncode(TSM.SELL_KEYS, sales)
	TSM.db.factionrealm.csvBuys = LibParse:CSVEncode(TSM.BUY_KEYS, buys)
	TSM.db.factionrealm.csvCancelled = LibParse:CSVEncode(TSM.CANCELLED_KEYS, cancels)
	TSM.db.factionrealm.csvExpired = LibParse:CSVEncode(TSM.EXPIRED_KEYS, expires)
	TSM.db.factionrealm.appData = table.concat(exportData, ";")
	
	-- process income
	local income = {}
	for _, record in ipairs(TSM.money.income) do
		if record.key == "Transfer" then
			record.type = "Money Transfer"
			record.source = record.otherPlayer
			record.amount = record.copper
			tinsert(income, record)
		end
	end
	TSM.db.factionrealm.csvIncome = LibParse:CSVEncode(TSM.INCOME_KEYS, income)
	
	-- process expense
	local expense = {}
	for _, record in ipairs(TSM.money.expense) do
		record.amount = record.copper
		record.destination = record.otherPlayer
		if record.key == "Transfer" then
			record.type = "Money Transfer"
			tinsert(expense, record)
		elseif record.key == "Postage" then
			record.type = "Postage"
			tinsert(expense, record)
		elseif record.key == "Repair" then
			record.type = "Repair Bill"
			tinsert(expense, record)
		end
	end
	TSM.db.factionrealm.csvExpense = LibParse:CSVEncode(TSM.EXPENSE_KEYS, expense)
	
	-- process gold log
	TSM.Data:LogGold()
	for player, data in pairs(TSM.db.factionrealm.goldLog) do
		if type(data) == "table" then
			TSM.db.factionrealm.goldLog[player] = LibParse:CSVEncode(TSM.GOLD_LOG_KEYS, data)
		end
	end
end

function TSM:GetItemName(item)
	for itemName, itemString in pairs(TSM.db.global.itemStrings) do
		if itemString == item then
			return itemName
		end
	end
end

local baseItemLookup = { update = 0 }
function TSM:UpdateBaseItemLookup()
	if time() - baseItemLookup.update < 30 then return end
	baseItemLookup = { update = time() }
	for itemString in pairs(TSM.items) do
		local baseItemString = TSMAPI:GetBaseItemString(itemString)
		if baseItemString ~= itemString then
			baseItemLookup[baseItemString] = baseItemLookup[baseItemString] or {}
			tinsert(baseItemLookup[baseItemString], itemString)
		end
	end
end

function TSM:GetAverageSellPrice(itemString, maxTimeDiff)
	itemString = TSMAPI:GetItemString(itemString) or itemString
	if not TSM.items[itemString] or #TSM.items[itemString].sales == 0 then return end
	maxTimeDiff = maxTimeDiff or time()

	local totalNum, totalPrice = 0, 0
	for _, record in ipairs(TSM.items[itemString].sales) do
		local timeDiff = time() - record.time
		if timeDiff <= maxTimeDiff then
			totalNum = totalNum + record.quantity
			totalPrice = totalPrice + record.copper * record.quantity
		end
	end

	return floor(totalPrice / totalNum + 0.5), totalNum
end

function TSM:GetAverageBuyPrice(itemString, maxTimeDiff)
	itemString = TSMAPI:GetItemString(itemString) or itemString
	if not TSM.items[itemString] or #TSM.items[itemString].buys == 0 then return end
	maxTimeDiff = maxTimeDiff or time()

	local totalNum, totalPrice = 0, 0
	for _, record in ipairs(TSM.items[itemString].buys) do
		local timeDiff = time() - record.time
		if timeDiff <= maxTimeDiff then
			totalNum = totalNum + record.quantity
			totalPrice = totalPrice + record.copper * record.quantity
		end
	end

	return floor(totalPrice / totalNum + 0.5)
end

-- converts how data was stored in 1.x to the new 2.0 format (CSV)
function TSM:ConvertOldData()
	local itemNames = {}
	for name, itemString in pairs(TSM.db.global.itemStrings) do
		itemNames[itemString] = name
	end

	do
		local entries = {}
		for itemString in pairs(TSM.db.factionrealm.itemData.sell) do
			TSM.Util:UpdateLink("sold", itemString)
			local records = select(2, TSM.Util:DecodeItemData("sold", itemString))
			local name = TSMAPI:GetSafeItemInfo(itemString) or itemNames[itemString]
			if name then
				for _, record in ipairs(records or {}) do
					record.itemString = itemString
					record.itemName = gsub(name, ',', "")
					record.source = "Auction"
					tinsert(entries, record)
				end
			end
		end
		sort(entries, function(a, b) return (a.time or 0) < (b.time or 0) end)
		TSM.db.factionrealm.csvSales = LibParse:CSVEncode(TSM.SELL_KEYS, entries)
	end
	do
		local entries = {}
		for itemString in pairs(TSM.db.factionrealm.itemData.buy) do
			TSM.Util:UpdateLink("buy", itemString)
			local records = select(2, TSM.Util:DecodeItemData("buy", itemString))
			local name = TSMAPI:GetSafeItemInfo(itemString) or itemNames[itemString]
			if name then
				for _, record in ipairs(records or {}) do
					record.itemString = itemString
					record.itemName = gsub(name, ',', "")
					record.source = "Auction"
					tinsert(entries, record)
				end
			end
		end
		sort(entries, function(a, b) return (a.time or 0) < (b.time or 0) end)
		TSM.db.factionrealm.csvBuys = LibParse:CSVEncode(TSM.BUY_KEYS, entries)
	end
end


local noBaseItem
function TSM:GetAvgSellPrice(itemString)
	itemString = TSMAPI:GetItemString(select(2, TSMAPI:GetSafeItemInfo(itemString)))
	TSM:UpdateBaseItemLookup()
	if not noBaseItem and itemString and baseItemLookup[itemString] then
		noBaseItem = true
		local totalPrice, totalNum = 0, 0
		for _, item in ipairs(baseItemLookup[itemString]) do
			local price, num = TSM:GetAvgSellPrice(item)
			if price and num and num > 0 then
				totalPrice = totalPrice + price
				totalNum = totalNum + num
			end
		end
		noBaseItem = nil
		if totalNum > 0 then
			return floor(totalPrice / totalNum + 0.5)
		end
	end
	if not (itemString and TSM.items[itemString] and #TSM.items[itemString].sales > 0) then return end

	local totalPrice, totalSaleNum = 0, 0
	for _, record in ipairs(TSM.items[itemString].sales) do
		totalSaleNum = totalSaleNum + record.quantity
		totalPrice = totalPrice + record.copper * record.quantity
	end

	return floor(totalPrice / totalSaleNum + 0.5), totalNum
end

local noBaseItem
function TSM:GetAvgBuyPrice(itemString)
	itemString = TSMAPI:GetItemString(select(2, TSMAPI:GetSafeItemInfo(itemString)))
	TSM:UpdateBaseItemLookup()
	if not noBaseItem and itemString and baseItemLookup[itemString] then
		noBaseItem = true
		local totalPrice, totalNum = 0, 0
		for _, item in ipairs(baseItemLookup[itemString]) do
			if not baseItemLookup[item] then
				local price, num = TSM:GetAvgBuyPrice(item)
				if price and num and num > 0 then
					totalPrice = totalPrice + price
					totalNum = totalNum + num
				end
			end
		end
		noBaseItem = nil
		if totalNum > 0 then
			return floor(totalPrice / totalNum + 0.5)
		end
	end
	if not (TSM.items[itemString] and #TSM.items[itemString].buys > 0) then return end

	local itemCount = 0
	local lastSold
	if TSM.db.factionrealm.smartBuyPrice then
		local player, alts = TSMAPI:ModuleAPI("ItemTracker", "playertotal", itemString)
		if not player then
			alts = nil
		end
		player = player or 0
		alts = alts or 0
		local guild = TSMAPI:ModuleAPI("ItemTracker", "guildtotal", itemString) or 0
		local auctions = TSMAPI:ModuleAPI("ItemTracker", "auctionstotal", itemString) or 0
		itemCount = player + alts + guild + auctions
	end

	local prices = {}
	for i = #TSM.items[itemString].buys, 1, -1 do
		local record = TSM.items[itemString].buys[i]
		for j = 1, record.quantity do
			tinsert(prices, { price = record.copper, withinTime = (time() - 30 * 24 * 60 * 60 < floor(record.time)) })
		end
	end

	local totalNum, totalPrice = 0, 0
	for _, data in ipairs(prices) do
		totalNum = totalNum + 1
		totalPrice = totalPrice + data.price
		if (itemCount == 0 and totalNum >= 10 and not data.withinTime) or totalNum == itemCount then
			break
		end
	end
	return floor(totalPrice / totalNum + 0.5), totalNum
end

function TSM:Round(value, sig)
	sig = sig or 1
	local gold = value / sig
	gold = floor(gold + 0.5)
	return gold * sig
end

function TSM:GetMaxSellPrice(itemString)
	itemString = TSMAPI:GetItemString(select(2, TSMAPI:GetSafeItemInfo(itemString)))
	if not (itemString and TSM.items[itemString] and #TSM.items[itemString].sales > 0) then return end

	local prices = {}
	for i = #TSM.items[itemString].sales, 1, -1 do
		local record = TSM.items[itemString].sales[i]
		for j = 1, record.quantity do
			tinsert(prices, { price = record.copper })
		end
	end

	local maxPrice = 0
	for _, data in ipairs(prices) do
		if data.price > maxPrice then
			maxPrice = data.price
		end
	end

	return maxPrice
end

function TSM:GetMaxBuyPrice(itemString)
	itemString = TSMAPI:GetItemString(select(2, TSMAPI:GetSafeItemInfo(itemString)))
	if not (itemString and TSM.items[itemString] and #TSM.items[itemString].buys > 0) then return end

	local prices = {}
	for i = #TSM.items[itemString].buys, 1, -1 do
		local record = TSM.items[itemString].buys[i]
		for j = 1, record.quantity do
			tinsert(prices, { price = record.copper })
		end
	end

	local maxPrice = 0
	for _, data in ipairs(prices) do
		if data.price > maxPrice then
			maxPrice = data.price
		end
	end

	return maxPrice
end

function TSM:SafeStrSplit(str, sep)
	local parts = {}
	local s = 1
	while true do
		local e = strfind(str, sep, s)
		if not e then
			tinsert(parts, strsub(str, s))
			break
		end
		tinsert(parts, strsub(str, s, e-1))
		s = e + 1
	end
	return parts
end