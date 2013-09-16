-- ------------------------------------------------------------------------------ --
--                            TradeSkillMaster_Crafting                           --
--            http://www.curse.com/addons/wow/tradeskillmaster_crafting           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

--load the parent file (TSM) into a local variable and register this file as a module
local TSM = select(2, ...)
local Gather = TSM:NewModule("Gather", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_Crafting") -- loads the localization table

local next = next
local private = { shoppingItems = {} }

function Gather:BuyFromMerchant(neededMats)
	for i = 1, GetMerchantNumItems() do
		local itemString = TSMAPI:GetItemString(GetMerchantItemLink(i))
		if neededMats[itemString] then
			local maxStack = GetMerchantItemMaxStack(i)
			local toBuy = neededMats[itemString]
			while toBuy > 0 do
				BuyMerchantItem(i, math.min(toBuy, maxStack))
				toBuy = toBuy - maxStack
				TSM.db.factionrealm.gathering.gatheredMats = true
			end
		end
	end
end

function Gather:gatherItems(source, task)
	local items = TSM.db.factionrealm.gathering.availableMats

	if source == L["Vendor"] then
		Gather:BuyFromMerchant(items)
	elseif source == UnitName("player") and (task == L["Visit Bank"] or task == L["Visit Guild Bank"]) then
		Gather:GatherBank(items)
	elseif source == UnitName("player") and task == L["Mail Items"] then
		Gather:MailItems(items)
	elseif source == L["Auction House"] then
		if TSMAPI:AHTabIsVisible("Shopping") then
			private.shoppingItems = CopyTable(items)
			Gather:ShoppingSearch(next(private.shoppingItems))
		else
			TSM:Printf(L["Please switch to the Shopping Tab to perform the gathering search."])
		end
	end
end

function Gather:GatherBank(moveItems)
	local next = next
	if next(moveItems) == nil then
		TSM:Print(L["Nothing to Gather"])
	else
		TSM:Print(L["Gathering Crafting Mats"])
		TSMAPI:MoveItems(moveItems, Gather.PrintMsg)
		TSM.db.factionrealm.gathering.gatheredMats = true
	end
end

function Gather.PrintMsg(message)
	if message then
		TSM:Print(message)
	end
end

function Gather:MerchantSells(neededItem)
	for i = 1, GetMerchantNumItems() do
		local itemString = TSMAPI:GetItemString(GetMerchantItemLink(i))
		if neededItem == itemString then
			return true
		end
	end
	return false
end

function Gather:MailItems(neededItems)
	local next = next
	if next(neededItems) == nil then
		TSM:Print(L["Nothing to Mail"])
	else
		local crafter = TSM.db.factionrealm.gathering.crafter
		if crafter then
			TSM:Print(format(L["Mailing Craft Mats to %s"], crafter))
			TSMAPI:ModuleAPI("Mailing", "mailItems", neededItems, crafter, Gather.PrintMsg)
			TSM.db.factionrealm.gathering.gatheredMats = true
		end
	end
end

local function ShoppingNextSearch()
	local items = TSM.db.factionrealm.gathering.availableMats
	private.shoppingItems = CopyTable(items)

	if next(private.shoppingItems) then
		Gather:ShoppingSearch(next(private.shoppingItems))
	end
end

local function ShoppingCallback(remainingQty, boughtItem, stackSize)
	--TSM:Print(TSM.Inventory.gatherItem, remainingQty, "remaining")
	TSM.Inventory.gatherQuantity = remainingQty
	if TSM.Inventory.gatherItem and boughtItem ~= TSM.Inventory.gatherItem then
		for itemString, data in pairs(TSMAPI.Conversions[TSM.Inventory.gatherItem] or {}) do
			if itemString == boughtItem then
				TSM.db.factionrealm.gathering.destroyingMats[boughtItem] = (TSM.db.factionrealm.gathering.destroyingMats[boughtItem] or 0) + stackSize
			end
		end
	end

	if max(TSM.Inventory.gatherQuantity, 0) == 0 then
		TSMAPI:CreateTimeDelay("shoppingSearchThrottle", 0.5, ShoppingNextSearch)
	end
end

function Gather:ShoppingSearch(itemString, need)
	TSM.Inventory.gatherQuantity = nil
	local matPrice = TSMAPI:FormatTextMoney(TSM.Cost:GetMatCost(itemString))
	if TSMAPI.InkConversions[itemString] then
		TSM.Inventory.gatherItem = itemString
		TSMAPI:ModuleAPI("Shopping", "runDestroySearch", TSMAPI:GetSafeItemInfo(itemString) .. "/even/x" .. need, ShoppingCallback)
	elseif TSMAPI:GetDisenchantData(itemString) then
		TSM.Inventory.gatherItem = itemString
		TSMAPI:ModuleAPI("Shopping", "runDestroySearch", TSMAPI:GetSafeItemInfo(itemString) .. "/exact/x" .. need, ShoppingCallback)
	elseif TSMAPI.Conversions[itemString] then
		TSM.Inventory.gatherItem = itemString
		local convertSource
		for _, data in pairs(TSMAPI.Conversions[itemString]) do
			convertSource = data.source
			break
		end
		if convertSource == "mill" or convertSource == "prospect" then
			TSMAPI:ModuleAPI("Shopping", "runDestroySearch", TSMAPI:GetSafeItemInfo(itemString) .. "/even/x" .. need, ShoppingCallback)
		else
			TSMAPI:ModuleAPI("Shopping", "runSearch", TSMAPI:GetSafeItemInfo(itemString) .. "/exact/x" .. need, ShoppingCallback)
		end
	else
		TSM.Inventory.gatherItem = nil
		TSMAPI:ModuleAPI("Shopping", "runSearch", TSMAPI:GetSafeItemInfo(itemString) .. "/exact/x" .. need, ShoppingCallback)
	end
end