-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AuctionDB                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_auctiondb           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- register this file with Ace Libraries
local TSM = select(2, ...)
TSM = LibStub("AceAddon-3.0"):NewAddon(TSM, "TSM_AuctionDB", "AceEvent-3.0", "AceConsole-3.0")
local AceGUI = LibStub("AceGUI-3.0") -- load the AceGUI libraries

local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_AuctionDB") -- loads the localization table

local SECONDS_PER_DAY = 60 * 60 * 24

local savedDBDefaults = {
	factionrealm = {
		scanData = "",
		time = 0,
		lastCompleteScan = 0,
		appDataUpdate = 0,
	},
	profile = {
		tooltip = true,
		resultsPerPage = 50,
		resultsSortOrder = "ascending",
		resultsSortMethod = "name",
		hidePoorQualityItems = true,
		seenTooltip = true,
		totalSeenTooltip = true,
		marketValueTooltip = true,
		minBuyoutTooltip = true,
	},
}

-- Called once the player has loaded WOW.
function TSM:OnInitialize()
	-- load the savedDB into TSM.db
	TSM.db = LibStub:GetLibrary("AceDB-3.0"):New("TradeSkillMaster_AuctionDBDB", savedDBDefaults, true)

	-- make easier references to all the modules
	for moduleName, module in pairs(TSM.modules) do
		TSM[moduleName] = module
	end

	-- register this module with TSM
	TSM:RegisterModule()

	TSM.data = {}
	TSM:Deserialize(TSM.db.factionrealm.scanData, TSM.data)
	TSM:RegisterEvent("PLAYER_LOGOUT", TSM.OnDisable)
	TSM.db.factionrealm.time = 10 -- because AceDB won't save if we don't do this...
end

-- registers this module with TSM by first setting all fields and then calling TSMAPI:NewModule().
function TSM:RegisterModule()
	TSM.priceSources = {
		{ key = "DBMarket", label = L["AuctionDB - Market Value"], callback = "GetMarketValue" },
		{ key = "DBMinBuyout", label = L["AuctionDB - Minimum Buyout"], callback = "GetMinBuyout" },
	}
	TSM.icons = {
		{ side = "module", desc = "AuctionDB", slashCommand = "auctiondb", callback = "Config:Load", icon = "Interface\\Icons\\Inv_Misc_Platnumdisks" },
	}
	TSM.auctionTab = { callbackShow = "GUI:Show", callbackHide = "GUI:Hide" }
	TSM.slashCommands = {
		{ key = "adbreset", label = L["Resets AuctionDB's scan data"], callback = "Reset" },
	}
	TSM.moduleAPIs = {
		{ key = "seenCount", callback = TSM.GetSeenCount },
		{ key = "lastCompleteScan", callback = TSM.GetLastCompleteScan },
		{ key = "lastCompleteScanTime", callback = TSM.GetLastCompleteScanTime },
		{ key = "adbScans", callback = TSM.GetScans },
		{ key = "adbOppositeFaction", callback = TSM.GetOppositeFactionData },
	}
	TSM.tooltipOptions = {callback = "Config:LoadTooltipOptions"}
	TSMAPI:NewModule(TSM)
end

function TSM:OnEnable()
	local function DecodeJSON(data)
		data = gsub(data, ":", "=")
		data = gsub(data, "\"horde\"", "horde")
		data = gsub(data, "\"alliance\"", "alliance")
		data = gsub(data, "\"m\"", "m")
		data = gsub(data, "\"b\"", "b")
		data = gsub(data, "\"n\"", "n")
		data = gsub(data, "\"([0-9]+)\"", "[%1]")
		loadstring("TSM_APP_DATA_TMP = " .. data .. "")()
		local val = TSM_APP_DATA_TMP
		TSM_APP_DATA_TMP = nil
		return val
	end

	if TSM.AppData then
		local realm = strlower(GetRealmName() or "")
		local faction = strlower(UnitFactionGroup("player") or "")
		if faction == "" or faction == "Neutral" then return end
		local newData = {}
		local numNewScans = 0
		for realmInfo, data in pairs(TSM.AppData) do
			local r, f, t, extra = ("-"):split(realmInfo)
			if extra then
				r = r .. "-" .. f
				f = t
				t = extra
			end
			r = strlower(r)
			f = strlower(f)
			if realm == r and (faction == f or f == "both") and tonumber(t) > TSM.db.factionrealm.appDataUpdate then
				newData[tonumber(t)] = DecodeJSON(data)
				numNewScans = numNewScans + 1
			end
		end

		local newItems = {}
		for epochTime, realmData in pairs(newData) do
			TSM.db.factionrealm.appDataUpdate = max(TSM.db.factionrealm.appDataUpdate, epochTime)
			local day = TSM.Data:GetDay(epochTime)
			for itemID, data in pairs(realmData[faction]) do
				itemID = tonumber(itemID)
				TSM.data[itemID] = TSM.data[itemID] or { scans = {}, seen = 0, lastScan = 0 }
				local marketValue, minBuyout, num = tonumber(data.m), tonumber(data.b), tonumber(data.n)

				if type(TSM.data[itemID].scans[day]) == "number" then
					TSM.data[itemID].scans[day] = { TSM.data[itemID].scans[day] }
				end
				TSM.data[itemID].scans[day] = TSM.data[itemID].scans[day] or {}
				tinsert(TSM.data[itemID].scans[day], marketValue)

				TSM.data[itemID].seen = ((TSM.data[itemID].seen or 0) + num)

				if not TSM.data[itemID].lastScan or TSM.data[itemID].lastScan < epochTime then
					TSM.data[itemID].currentQuantity = num
					TSM.data[itemID].lastScan = epochTime
					TSM.data[itemID].minBuyout = minBuyout > 0 and minBuyout or nil
				end
				newItems[itemID] = true
			end
		end

		for itemID in pairs(newItems) do
			TSM.Data:UpdateMarketValue(TSM.data[itemID])
		end

		if numNewScans > 0 then
			TSM.db.factionrealm.lastCompleteScan = TSM.db.factionrealm.appDataUpdate
			TSM:Printf(L["Imported %s scans worth of new auction data!"], numNewScans)
		end

		wipe(TSM.AppData)
		TSM.AppData = nil
		collectgarbage()
	end
end

function TSM:OnDisable()
	TSM:Serialize(TSM.data)
end

function TSM:GetTooltip(itemString, quantity)
	if not TSM.db.profile.tooltip then return end
	if not strfind(itemString, "item:") then return end
	local itemID = TSMAPI:GetItemID(itemString)
	if not itemID or not TSM.data[itemID] then return end
	local text = {}
	local moneyCoinsTooltip = TSMAPI:GetMoneyCoinsTooltip()


	-- add total seen count info
	if TSM.db.profile.totalSeenTooltip then
		local totalSeen = TSM:GetSeenCount(itemID)
		if totalSeen then
			tinsert(text, { left = "  " .. L["Total Seen Count:"], right = "|cffffffff" .. totalSeen })
		end
	end

	-- add current quantity info
	if TSM.db.profile.seenTooltip then
		local currQuantity = TSM:GetCurrentQuantity(itemID)
		if currQuantity and currQuantity > 0 then
			tinsert(text, { left = "  " .. L["Seen Last Scan:"], right = "|cffffffff" .. currQuantity })
		end
	end

	if not quantity then
		quantity = 1
	end

	-- add market value info
	if TSM.db.profile.marketValueTooltip then
		local marketValue = TSM:GetMarketValue(itemID)
		if marketValue then
				if moneyCoinsTooltip then
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Market Value x%s:"], quantity), right = TSMAPI:FormatTextMoneyIcon(marketValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Market Value:"], right = TSMAPI:FormatTextMoneyIcon(marketValue, "|cffffffff", true) })
					end
				else
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Market Value x%s:"], quantity), right = TSMAPI:FormatTextMoney(marketValue * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Market Value:"], right = TSMAPI:FormatTextMoney(marketValue, "|cffffffff", true) })
					end
				end
			end
	end

	-- add min buyout info
	if TSM.db.profile.minBuyoutTooltip then
		local minBuyout = TSM:GetMinBuyout(itemID)
		if minBuyout then
			if quantity then
				if moneyCoinsTooltip then
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Min Buyout x%s:"], quantity), right = TSMAPI:FormatTextMoneyIcon(minBuyout * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Min Buyout:"], right = TSMAPI:FormatTextMoneyIcon(minBuyout, "|cffffffff", true) })
					end
				else
					if IsShiftKeyDown() then
						tinsert(text, { left = "  " .. format(L["Min Buyout x%s:"], quantity), right = TSMAPI:FormatTextMoney(minBuyout * quantity, "|cffffffff", true) })
					else
						tinsert(text, { left = "  " .. L["Min Buyout:"], right = TSMAPI:FormatTextMoney(minBuyout, "|cffffffff", true) })
					end
				end
			end
		end
	end

	-- add heading and last scan time info
	if #text > 0 then
		local lastScan = TSM:GetLastScanTime(itemID)
		if lastScan then
			local timeDiff = SecondsToTime(time() - lastScan)
			tinsert(text, 1, { left = "|cffffff00" .. "TSM AuctionDB:", right = "|cffffffff" .. format(L["%s ago"], timeDiff) })
		else
			tinsert(text, 1, { left = "|cffffff00" .. "TSM AuctionDB:", right = "|cffffffff" .. L["Not Scanned"] })
		end
		return text
	end
end

function TSM:Reset()
	-- Popup Confirmation Window used in this module
	StaticPopupDialogs["TSMAuctionDBClearDataConfirm"] = StaticPopupDialogs["TSMAuctionDBClearDataConfirm"] or {
		text = L["Are you sure you want to clear your AuctionDB data?"],
		button1 = YES,
		button2 = CANCEL,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		OnAccept = function()
			for i in pairs(TSM.data) do
				TSM.data[i] = nil
			end
			TSM:Print(L["Reset Data"])
		end,
		OnCancel = false,
	}

	StaticPopup_Show("TSMAuctionDBClearDataConfirm")
	for i = 1, 10 do
		local popup = _G["StaticPopup" .. i]
		if popup and popup.which == "TSMAuctionDBClearDataConfirm" then
			popup:SetFrameStrata("TOOLTIP")
			break
		end
	end
end

local alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_="
local base = #alpha
local alphaTable = {}
local alphaTableLookup = {}
for i = 1, base do
	local char = strsub(alpha, i, i)
	tinsert(alphaTable, char)
	alphaTableLookup[char] = i
end

local function decode(h)
	if strfind(h, "~") then return
	end
	local result = 0

	local i = #h - 1
	for w in string.gmatch(h, "([A-Za-z0-9_=])") do
		result = result + (alphaTableLookup[w] - 1) * (base ^ i)
		i = i - 1
	end

	return result
end

local function encode(d)
	d = tonumber(d)
	if not d or not (d < math.huge and d > 0) then -- this cannot be simplified since 0/0 is neither less than nor greater than any number
		return "~"
	end

	local r = d % base
	local diff = d - r
	if diff == 0 then
		return alphaTable[r + 1]
	else
		return encode((diff) / base) .. alphaTable[r + 1]
	end
end

local function encodeScans(scans)
	local result

	for day, data in pairs(scans) do
		if type(data) == "table" then
			if result then
				result = result .. "!"
			end
			result = (result or "") .. encode(day) .. ":"
			for i = 1, #data do
				result = result .. encode(data[i]) .. (data[i + 1] and ";" or "")
			end
		else
			if result then
				result = result .. "!"
			end
			result = (result or "") .. encode(day) .. ":" .. encode(data)
		end
	end

	return result
end

local function decodeScans(rope)
	if rope == "A" then return
	end
	local scans = {}
	local days = { ("!"):split(rope) }
	for _, data in ipairs(days) do
		local day, marketValueData = (":"):split(data)
		day = decode(day)
		scans[day] = {}
		for _, value in ipairs({ (";"):split(marketValueData) }) do
			local decodedValue = decode(value)
			if decodedValue ~= "~" then
				tinsert(scans[day], tonumber(decodedValue))
			end
		end
	end

	return scans
end

function TSM:Serialize()
	local results, scans = {}, nil
	for id, v in pairs(TSM.data) do
		if v.marketValue then
			tinsert(results, "?" .. encode(id) .. "," .. encode(v.seen) .. "," .. encode(v.marketValue) .. "," .. encode(v.lastScan) .. "," .. encode(v.currentQuantity or 0) .. "," .. encode(v.minBuyout) .. "," .. encodeScans(v.scans))
		end
	end
	TSM.db.factionrealm.scanData = table.concat(results)
end

function TSM:Deserialize(data, resultTbl)
	if strsub(data, 1, 1) ~= "?" then return
	end

	for k, a, b, c, d, f, s in gmatch(data, "?([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^?]+)") do
		local itemID = decode(k)
		resultTbl[itemID] = { seen = decode(a), marketValue = decode(b), lastScan = decode(c), currentQuantity = (decode(d) or 0), minBuyout = decode(f), scans = decodeScans(s) }
	end
end

function TSM:GetLastCompleteScan()
	local lastScan = {}
	for itemID, data in pairs(TSM.data) do
		if data.lastScan == TSM.db.factionrealm.lastCompleteScan then
			lastScan[itemID] = { marketValue = data.marketValue, minBuyout = data.minBuyout }
		end
	end

	return lastScan
end

function TSM:GetLastCompleteScanTime()
	return TSM.db.factionrealm.lastCompleteScan
end

function TSM:GetScans(link)
	if not link then return
	end
	link = select(2, GetItemInfo(link))
	if not link then return
	end
	local itemID = TSMAPI:GetItemID(link)
	if not TSM.data[itemID] then return
	end

	return CopyTable(TSM.data[itemID].scans)
end

function TSM:GetOppositeFactionData()
	local realm = GetRealmName()
	local faction = UnitFactionGroup("player")
	if faction == "Horde" then
		faction = "Alliance"
	elseif faction == "Alliance" then
		faction = "Horde"
	else
		return
	end

	local data = TSM.db.sv.factionrealm[faction .. " - " .. realm]
	if not data or type(data.scanData) ~= "string" then return
	end

	local result = {}
	TSM:Deserialize(data.scanData, result)
	return result
end

function TSM:GetMarketValue(itemID)
	if itemID and not tonumber(itemID) then
		itemID = TSMAPI:GetItemID(itemID)
	end
	if not itemID or not TSM.data[itemID] then return end
	TSM.data[itemID].marketValue = TSM.Data:GetMarketValue(TSM.data[itemID].scans)
	return TSM.data[itemID].marketValue ~= 0 and TSM.data[itemID].marketValue or nil
end

function TSM:GetSeenCount(itemID)
	if itemID and not tonumber(itemID) then
		itemID = TSMAPI:GetItemID(itemID)
	end
	if not itemID or not TSM.data[itemID] then return end
	return TSM.data[itemID].seen
end

function TSM:GetLastScanTime(itemID)
	return itemID and TSM.data[itemID].lastScan
end

function TSM:GetCurrentQuantity(itemID)
	return itemID and TSM.data[itemID].currentQuantity
end

function TSM:GetMinBuyout(itemID)
	if itemID and not tonumber(itemID) then
		itemID = TSMAPI:GetItemID(itemID)
	end
	if not itemID or not TSM.data[itemID] then return end
	return TSM.data[itemID].minBuyout
end

-- not used anywhere yet, just a fun statistic
function TSM:GetRealmIndex()
	local day = TSM.Data:GetDay(TSM.db.factionrealm.lastCompleteScan)
	local total, num = 0, 0
	for itemID, data in pairs(TSM.data) do
		if data.lastScan == TSM.db.factionrealm.lastCompleteScan then
			total = total + data.currentQuantity * data.marketValue
			num = num + data.currentQuantity
		end
	end
	
	return TSMAPI:FormatTextMoney(floor(total / num + 0.5))
end