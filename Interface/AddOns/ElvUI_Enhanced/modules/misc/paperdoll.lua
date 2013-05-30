local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local PD = E:NewModule('PaperDoll', 'AceTimer-3.0', 'AceEvent-3.0');

local slots = {
	["HeadSlot"] = { true, true },
	["NeckSlot"] = { true, false },
	["ShoulderSlot"] = { true, true },
	["BackSlot"] = { true, false },
	["ChestSlot"] = { true, true },
	["WristSlot"] = { true, true },
	["MainHandSlot"] = { true, true },
	["SecondaryHandSlot"] = { true, true },
	["HandsSlot"] = { true, true },
	["WaistSlot"] = { true, true },
	["LegsSlot"] = { true, true },
	["FeetSlot"] = { true, true },
	["Finger0Slot"] = { true, false },
	["Finger1Slot"] = { true, false },
	["Trinket0Slot"] = { true, false },
	["Trinket1Slot"] = { true, false },
}

local levelAdjust = {
	["0"]=0,["1"]=8,["373"]=4,["374"]=8,["375"]=4,["376"]=4,
	["377"]=4,["379"]=4,["380"]=4,["445"]=0,["446"]=4,["447"]=8,
	["451"]=0,["452"]=8,["453"]=0,["454"]=4,["455"]=8,["456"]=0,
	["457"]=8,["458"]=0,["459"]=4,["460"]=8,["461"]=12,["462"]=16,
	["465"]=0,["466"]=4,["467"]=8 
}

local levelColors = {
	[0] = "|cffff0000",
	[1] = "|cff00ff00",
	[2] = "|cffffff88",
}

function PD:UpdatePaperDoll()
	if InCombatLockdown() then
		PD:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdatePaperDoll")	
		return
	else
		PD:UnregisterEvent("PLAYER_REGEN_ENABLED")
 	end

	local frame, slot, current, maximum, r, g, b
	local itemLink, rarity, itemLevel, linkLevel, upgrade
	local	avgItemLevel, avgEquipItemLevel = GetAverageItemLevel()
	
	for k, info in pairs(slots) do
		frame = _G[("Character%s"):format(k)]

		slot = GetInventorySlotInfo(k)	
		if info[1] then
			frame.ItemLevel:SetText()
			if E.private.equipment.itemlevel.enable and info[1] then
				itemLink = GetInventoryItemLink("player", slot)
				
        if itemLink then
            rarity, itemLevel = select(3, GetItemInfo(itemLink))    
            linkLevel, upgrade = itemLink:match(":(%d+):%d+:(%d+)\124h%[")
            if linkLevel and rarity == 7 then -- heirloom adjust
                itemLevel = (tonumber(linkLevel) == UnitLevel("player")) and avgEquipItemLevel or linkLevel
            end
            if itemLevel and upgrade and levelAdjust[upgrade] then
                itemLevel = itemLevel + levelAdjust[upgrade]
            end
            if itemLevel and avgEquipItemLevel then
                frame.ItemLevel:SetFormattedText("%s%d|r", levelColors[(itemLevel < avgEquipItemLevel-10 and 0 or (itemLevel > avgEquipItemLevel + 10 and 1 or (2)))], itemLevel)
            end
        end
			end
		end

		if info[2] then
			frame.DurabilityInfo:SetText()
			if  E.private.equipment.durability.enable then
				current, maximum = GetInventoryItemDurability(slot)
				if current and maximum and (not E.private.equipment.durability.onlydamaged or current < maximum) then
					r, g, b = E:ColorGradient((current / maximum), 1, 0, 0, 1, 1, 0, 0, 1, 0)
					frame.DurabilityInfo:SetFormattedText("%s%.0f%%|r", E:RGBToHex(r, g, b), (current / maximum) * 100)
				end
			end
		end
	end
end

function PD:InitialUpdatePaperDoll()
	PD:UnregisterEvent("PLAYER_ENTERING_WORLD")
	PD:ScheduleTimer("UpdatePaperDoll", 10)
end

function PD:Initialize()
	local frame
	for k, info in pairs(slots) do
		frame = _G[("Character%s"):format(k)]

		if info[1] then
			frame.ItemLevel = frame:CreateFontString(nil, "OVERLAY")
			frame.ItemLevel:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 1, 1)
			frame.ItemLevel:FontTemplate(E.media.font, 12, "THINOUTLINE")
		end
		
		if info[2] then
			frame.DurabilityInfo = frame:CreateFontString(nil, "OVERLAY")
			frame.DurabilityInfo:SetPoint("TOP", frame, "TOP", 0, -4)
			frame.DurabilityInfo:FontTemplate(E.media.font, 12, "THINOUTLINE")
		end
	end	
	
	PD:RegisterEvent("UPDATE_INVENTORY_DURABILITY", "UpdatePaperDoll")	
	PD:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "UpdatePaperDoll")
	PD:RegisterEvent("SOCKET_INFO_UPDATE", "UpdatePaperDoll")
	PD:RegisterEvent("COMBAT_RATING_UPDATE", "UpdatePaperDoll")
	PD:RegisterEvent("MASTERY_UPDATE", "UpdatePaperDoll")
	
	PD:RegisterEvent("PLAYER_ENTERING_WORLD", "InitialUpdatePaperDoll")
end

E:RegisterModule(PD:GetName())