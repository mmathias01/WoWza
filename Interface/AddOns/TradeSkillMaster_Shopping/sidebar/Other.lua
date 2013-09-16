local TSM = select(2, ...)
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_Shopping") -- loads the localization table

local private = {}

function private.Create(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetAllPoints()
	
	frame:SetScript("OnShow", function()
			local lastScan = TSMAPI:ModuleAPI("AuctionDB", "lastCompleteScan")
			for itemID, data in pairs(lastScan or {}) do
				GetItemInfo(itemID) -- request item info from the server ahead of time
			end
		end)
	
	local helpText = TSMAPI.GUI:CreateLabel(frame)
	helpText:SetPoint("TOPLEFT")
	helpText:SetPoint("TOPRIGHT")
	helpText:SetHeight(35)
	helpText:SetJustifyH("CENTER")
	helpText:SetJustifyV("CENTER")
	helpText:SetText(L["The vendor search looks for items on the AH below their vendor sell price."])
	frame.helpText = helpText
	
	local startBtn = TSMAPI.GUI:CreateButton(frame, 16)
	startBtn:SetPoint("TOPLEFT", helpText, "BOTTOMLEFT", 3, -3)
	startBtn:SetPoint("TOPRIGHT", helpText, "BOTTOMRIGHT", 3, -3)
	startBtn:SetHeight(20)
	startBtn:SetText(L["Start Vendor Search"])
	startBtn:SetScript("OnClick", private.StartVendorSearch)
	frame.startBtn = startBtn
	
	return frame
end

function private.VendorSearchCallback(event, ...)
	if event == "filter" then
		local filter = ...
		local maxPrice
		for _, itemString in ipairs(filter.items) do
			local vendor = select(11, GetItemInfo(itemString))
			maxPrice = maxPrice and max(maxPrice, vendor) or vendor
		end
		return maxPrice
	elseif event == "process" then
		local itemString, auctionItem = ...
		local vendor = select(11, GetItemInfo(itemString))
		if not vendor then return end
		auctionItem:FilterRecords(function(record)
				return (record:GetItemBuyout() or 0) >= vendor
			end)
		auctionItem:SetMarketValue(vendor)
		return auctionItem
	elseif event == "done" then
		local auctions = ...
		local profit = 0
		for itemString, data in pairs(auctions) do
			local link = select(2, GetItemInfo(itemString))
			local vendor = select(11, GetItemInfo(itemString))
			for _, record in ipairs(data.records) do
				profit = profit + vendor * record.count - record.buyout
			end
		end
		TSM:Printf(L["Vendor Search Profit: %s"], TSMAPI:FormatTextMoney(profit))
		TSM.Search:SetSearchBarDisabled(false)
		return
	end
end

function private:StartVendorSearch()
	local itemList = {}
	local lastScan = TSMAPI:ModuleAPI("AuctionDB", "lastCompleteScan")
	if not lastScan then
		TSM:Print(L["No recent AuctionDB scan data found."])
		return
	end
	
	for itemID, data in pairs(lastScan) do
		local link = select(2, GetItemInfo(itemID))
		local vendor = select(11, GetItemInfo(itemID))
		if link and data.minBuyout and data.minBuyout < vendor then
			tinsert(itemList, TSMAPI:GetItemString(link))
		end
	end

	TSM.Search:SetSearchBarDisabled(true)
	TSM.Util:ShowSearchFrame(nil, L["% Vendor Price"])
	TSM.Util:StartItemScan(itemList, private.VendorSearchCallback)
end

do
	TSM:AddSidebarFeature(L["Other"], private.Create)
end