-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AuctionDB                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_auctiondb           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- load the parent file (TSM) into a local variable and register this file as a module
local TSM = select(2, ...)
local Data = TSM:NewModule("Data")

-- weight for the market value from X days ago (where X is the index of the table)
local WEIGHTS = {[0] = 132, [1] = 125, [2] = 100, [3] = 75, [4] = 45, [5] = 34, [6] = 33,
	[7] = 38, [8] = 28, [9] = 21, [10] = 15, [11] = 10, [12] = 7, [13] = 5, [14] = 4}
local MIN_PERCENTILE = 0.15 -- consider at least the lowest 15% of auctions
local MAX_PERCENTILE = 0.30 -- consider at most the lowest 30% of auctions
local MAX_JUMP = 1.2 -- between the min and max percentiles, any increase in price over 120% will trigger a discard of remaining auctions

function Data:GetDay(t)
	t = t or time()
	return floor(t / (60*60*24))
end

-- Updates all the market values
function Data:UpdateMarketValue(itemData)
	local day = Data:GetDay()

	local scans = CopyTable(itemData.scans)
	itemData.scans = {}
	itemData.scans[day] = scans[day] and CopyTable(scans[day])
	for i=1, 14 do
		local dayScans = scans[day-i]
		if type(dayScans) == "table" then
			itemData.scans[day-i] = Data:GetAverage(dayScans)
		elseif dayScans then
			itemData.scans[day-i] = dayScans
		end
	end
	itemData.marketValue = Data:GetMarketValue(itemData.scans)
end

-- gets the average of a list of numbers
function Data:GetAverage(data)
	local total, num = 0, 0
	for _, marketValue in ipairs(data) do
		total = total + marketValue
		num = num + 1
	end
	
	return num > 0 and floor((total / num) + 0.5)
end

-- gets the market value given a set of scans
function Data:GetMarketValue(scans)
	local day = Data:GetDay()
	local totalAmount, totalWeight = 0, 0
	
	for i=0, 14 do
		local data = scans[day-i]
		if data then
			local dayMarketValue
			if type(data) == "table" then
				dayMarketValue = Data:GetAverage(data)
			else
				dayMarketValue = data
			end
			if dayMarketValue then
				totalAmount = totalAmount + (WEIGHTS[i] * dayMarketValue)
				totalWeight = totalWeight + WEIGHTS[i]
			end
		end
	end
	for i in ipairs(scans) do
		if i < day - 14 then
			scans[i] = nil
		end
	end
	
	return totalWeight > 0 and floor(totalAmount / totalWeight + 0.5) or 0
end

function Data:ProcessData(scanData)
	if TSM.processingData then return TSMAPI:CreateTimeDelay("adbAlreadyProcessing", 0.2, function() Data:ProcessData(scanData) end) end

	local day = Data:GetDay()
	-- wipe all the minBuyout data
	for itemID, data in pairs(TSM.data) do
		data.minBuyout = nil
		data.currentQuantity = 0
	end
	
	local scanDataList = {}
	for itemID, data in pairs(scanData) do
		tinsert(scanDataList, {itemID, data})
	end
	
	-- go through each item and figure out the market value / update the data table
	local index = 1
	local function DoDataProcessing()
		for i = 1, 500 do
			local itemID, data = unpack(scanDataList[index])
			TSM.data[itemID] = TSM.data[itemID] or {scans={}, seen=0}
			local marketValue = Data:CalculateMarketValue(data.records)
			
			if type(TSM.data[itemID].scans[day]) == "number" then
				TSM.data[itemID].scans[day] = {TSM.data[itemID].scans[day]}
			end
			TSM.data[itemID].scans[day] = TSM.data[itemID].scans[day] or {}
			tinsert(TSM.data[itemID].scans[day], marketValue)
			
			TSM.data[itemID].seen = ((TSM.data[itemID].seen or 0) + data.quantity)
			TSM.data[itemID].currentQuantity = data.quantity
			TSM.data[itemID].lastScan = TSM.db.factionrealm.lastCompleteScan
			TSM.data[itemID].minBuyout = data.minBuyout > 0 and data.minBuyout or nil
			Data:UpdateMarketValue(TSM.data[itemID])
			
			index = index + 1
			if index > #scanDataList then
				TSMAPI:CancelFrame("adbProcessDelay")
				TSM.processingData = nil
				break
			end
		end
	end
	
	TSM.processingData = true
	TSMAPI:CreateTimeDelay("adbProcessDelay", 0, DoDataProcessing, 0.1)
end

function Data:CalculateMarketValue(records)
	local totalNum, totalBuyout = 0, 0
	local numRecords = #records
	
	for i=1, numRecords do
		totalNum = i - 1
		if i ~= 1 and i > numRecords*MIN_PERCENTILE and (i > numRecords*MAX_PERCENTILE or records[i] >= MAX_JUMP*records[i-1]) then
			break
		end
		
		totalBuyout = totalBuyout + records[i]
		if i == numRecords then
			totalNum = i
		end
	end
	
	local uncorrectedMean = totalBuyout / totalNum
	local varience = 0
	
	for i=1, totalNum do
		varience = varience + (records[i]-uncorrectedMean)^2
	end
	
	local stdDev = sqrt(varience/totalNum)
	local correctedTotalNum, correctedTotalBuyout = 1, uncorrectedMean
	
	for i=1, totalNum do
		if abs(uncorrectedMean - records[i]) < 1.5*stdDev then
			correctedTotalNum = correctedTotalNum + 1
			correctedTotalBuyout = correctedTotalBuyout + records[i]
		end
	end
	
	local correctedMean = floor(correctedTotalBuyout / correctedTotalNum + 0.5)
	
	return correctedMean
end