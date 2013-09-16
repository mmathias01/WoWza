-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AuctionDB                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_auctiondb           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- load the parent file (TSM) into a local variable and register this file as a module
local TSM = select(2, ...)
local Scan = TSM:NewModule("Scan", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_AuctionDB") -- loads the localization table


local function ScanCallback(event, ...)
	if event == "SCAN_PAGE_UPDATE" then
		local page, total = ...
		TSM.GUI:UpdateStatus(format(L["Scanning page %s/%s"], page, total), page*100/total)
	elseif event == "SCAN_COMPLETE" then
		local data = ...
		Scan:ProcessScanData(data)
		Scan:DoneScanning()
	elseif event == "INTERRUPTED" then
		Scan:DoneScanning()
	end
end

function Scan.ProcessGetAllScan(self)
	local temp = 0
	while true do
		temp = min(temp + 1, 100)
		self:Sleep(0.2)
		if not Scan.isScanning then return end
		if Scan.getAllLoaded then
			break
		end
		TSM.GUI:UpdateStatus(L["Running query..."], nil, temp)
	end

	local test = 0
	local data = {}
	for i=1, Scan.getAllLoaded do
		TSM.GUI:UpdateStatus(format(L["Scanning page %s/%s"], 1, 1), i*100/Scan.getAllLoaded)
		if i % 100 == 0 then
			self:Yield()
			if GetNumAuctionItems("list") ~= Scan.getAllLoaded then
				TSM:Print(L["GetAll scan did not run successfully due to issues on Blizzard's end. Using the TSM application for your scans is recommended."])
				Scan:DoneScanning()
				return
			end
		end
		
		local itemID = TSMAPI:GetItemID(GetAuctionItemLink("list", i))
		local _, _, count, _, _, _, _, _, _, buyout = GetAuctionItemInfo("list", i)
		if itemID and buyout and buyout > 0 then
			data[itemID] = data[itemID] or {records={}, minBuyout=1/0, quantity=0}
			data[itemID].minBuyout = min(data[itemID].minBuyout, buyout)
			data[itemID].quantity = data[itemID].quantity + count
			for j=1, count do
				tinsert(data[itemID].records, floor(buyout/count))
			end
			test = test + 1
		end
	end
	
	TSM.db.factionrealm.lastCompleteScan = time()
	TSM.Data:ProcessData(data)
	
	TSM.GUI:UpdateStatus(L["Processing data..."])
	while TSM.processingData do
		self:Sleep(0.2)
	end
	
	TSM:Print(L["It is strongly recommended that you reload your ui (type '/reload') after running a GetAll scan. Otherwise, any other scans (Post/Cancel/Search/etc) will be much slower than normal."])
end

function Scan:AUCTION_ITEM_LIST_UPDATE()
	Scan:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE")
	local num, total = GetNumAuctionItems("list")
	if num ~= total or num == 0 then
		TSM:Print(L["GetAll scan did not run successfully due to issues on Blizzard's end. Using the TSM application for your scans is recommended."])
		Scan:DoneScanning()
		return
	end
	Scan.getAllLoaded = num
end

function Scan:GetAllScanQuery()
	local canScan, canGetAll = CanSendAuctionQuery()
	if not canGetAll then return TSM:Print(L["Can't run a GetAll scan right now."]) end
	if not canScan then return TSMAPI:CreateTimeDelay("auctiondbGetAllStart", 0.5, Scan.GetAllScanQuery) end
	QueryAuctionItems("", nil, nil, 0, 0, 0, 0, 0, 0, true)
	Scan:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
	TSMAPI.Threading:Start(Scan.ProcessGetAllScan, 1, function() Scan:DoneScanning() end)
end

function Scan:StartFullScan()
	Scan.isScanning = "Full"
	
	TSM.GUI:UpdateStatus(L["Running query..."])
	Scan.isBuggedGetAll = nil
	TSMAPI.AuctionScan:RunQuery({name=""}, ScanCallback)
end

function Scan:StartGetAllScan()
	TSM.db.profile.lastGetAll = time()
	Scan.isScanning = "GetAll"
	Scan.isBuggedGetAll = nil
	TSMAPI.AuctionScan:StopScan()
	Scan:GetAllScanQuery()
end

function Scan:IsScanning()
	return Scan.isScanning
end

function Scan:DoneScanning()
	TSM.GUI:UpdateStatus(L["Done Scanning"], 100)
	Scan.isScanning = nil
	Scan.getAllLoaded = nil
end

function Scan:ProcessScanData(scanData)
	local data = {}
	
	for itemString, obj in pairs(scanData) do
		if TSMAPI:GetBaseItemString(itemString) == itemString then
			local itemID = obj:GetItemID()
			local quantity, minBuyout, records = 0, 0
			local records = {}
			for _, record in ipairs(obj.records) do
				local itemBuyout = record:GetItemBuyout()
				if itemBuyout and (itemBuyout < minBuyout or minBuyout == 0) then
					minBuyout = itemBuyout
				end
				quantity = quantity + record.count
				for i=1, record.count do
					tinsert(records, itemBuyout)
				end
			end
			data[itemID] = {records=records, minBuyout=minBuyout, quantity=quantity}
		end
	end
	
	TSM.db.factionrealm.lastCompleteScan = time()
	TSM.Data:ProcessData(data)
end

function Scan:ProcessImportedData(auctionData)
	local data = {}
	for itemID, auctions in pairs(auctionData) do
		local quantity, minBuyout, records = 0, 0, {}
		for _, auction in ipairs(auctions) do
			local itemBuyout, count = unpack(auction)
			if itemBuyout and (itemBuyout < minBuyout or minBuyout == 0) then
				minBuyout = itemBuyout
			end
			quantity = quantity + count
			for i=1, count do
				tinsert(records, itemBuyout)
			end
		end
		data[itemID] = {records=records, minBuyout=minBuyout, quantity=quantity}
	end
	TSM.db.factionrealm.lastCompleteScan = time()
	TSM.Data:ProcessData(data)
end