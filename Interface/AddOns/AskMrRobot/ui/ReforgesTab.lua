StaticPopupDialogs["REFORGE_TAB_PLEASE_OPEN"] = {
	text = "You need to open the reforge window for this to work",
	button1 = "Ok",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

-- initialize the ReforgesTab class
AskMrRobot.ReforgesTab = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

--from LibReforge
local SPI = 1
local DODGE = 2
local PARRY = 3
local HIT = 4
local CRIT = 5
local HASTE = 6
local EXP = 7
local MASTERY = 8

--from LibReforge
local StatNames = {
	ITEM_MOD_SPIRIT_SHORT,
	ITEM_MOD_DODGE_RATING_SHORT,
	ITEM_MOD_PARRY_RATING_SHORT,
	ITEM_MOD_HIT_RATING_SHORT,
	ITEM_MOD_CRIT_RATING_SHORT,
	ITEM_MOD_HASTE_RATING_SHORT,
	ITEM_MOD_EXPERTISE_RATING_SHORT,
	ITEM_MOD_MASTERY_RATING_SHORT
}
StatNames[0] = NONE
local StatToString = {
	"ITEM_MOD_SPIRIT_SHORT",
	"ITEM_MOD_DODGE_RATING_SHORT",
	"ITEM_MOD_PARRY_RATING_SHORT",
	"ITEM_MOD_HIT_RATING_SHORT",
	"ITEM_MOD_CRIT_RATING_SHORT",
	"ITEM_MOD_HASTE_RATING_SHORT",
	"ITEM_MOD_EXPERTISE_RATING_SHORT",
	"ITEM_MOD_MASTERY_RATING_SHORT"
}


local REFORGE_TABLE_BASE = 112
local REFORGE_TABLE = {
  {1, 2}, {1, 3}, {1, 4}, {1, 5}, {1, 6}, {1, 7}, {1, 8},
  {2, 1}, {2, 3}, {2, 4}, {2, 5}, {2, 6}, {2, 7}, {2, 8},
  {3, 1}, {3, 2}, {3, 4}, {3, 5}, {3, 6}, {3, 7}, {3, 8},
  {4, 1}, {4, 2}, {4, 3}, {4, 5}, {4, 6}, {4, 7}, {4, 8},
  {5, 1}, {5, 2}, {5, 3}, {5, 4}, {5, 6}, {5, 7}, {5, 8},
  {6, 1}, {6, 2}, {6, 3}, {6, 4}, {6, 5}, {6, 7}, {6, 8},
  {7, 1}, {7, 2}, {7, 3}, {7, 4}, {7, 5}, {7, 6}, {7, 8},
  {8, 1}, {8, 2}, {8, 3}, {8, 4}, {8, 5}, {8, 6}, {8, 7},
}

--------------- returns the index into the REFORGE_TABLE or nil
-- returns the reforge id or 0
local function GetReforgeIdForItem(item)
  local id = tonumber (item:match ("item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+:%d+:(%d+)"))
  return (id and id ~= 0 and id or 0)
end

local function GetReforgeIdFromStats(fromStat, toStat)
	if (toStat > fromStat) then
		return REFORGE_TABLE_BASE + 7 * (fromStat - 1) + toStat - 1;
	else
		return REFORGE_TABLE_BASE + 7 * (fromStat - 1) + toStat;
	end
end

local function GetReforgeString(fromId, toId)
	if toId == 0 then
		return "Restore"
	end
	local pair = REFORGE_TABLE[toId - REFORGE_TABLE_BASE]

	local text = _G[StatToString[pair[1]]] .. ' -> ' .. _G[StatToString[pair[2]]]
	--print('from ' .. fromId)
	if fromId == 0 then
		return text
	end
	return 'Restore, then ' .. text
end


function AskMrRobot.ReforgesTab:AddToReforgeQueue(itemSlot, reforgeId)
	local item = GetInventoryItemLink("player", AskMrRobot.slotIds[itemSlot])
	if item == nil then 
		--print ('no item')
		return 
	end
	local current = GetReforgeIdForItem(item)
	--print('current reforge is ' .. current)
	if current ~= reforgeId then
		if current ~= 0 and reforgeId ~= 0 then
			tinsert(self.reforgequeue, {itemSlot, 0})
			--print('inserting ' .. itemSlot .. ' 0')
		end

		tinsert(self.reforgequeue, {itemSlot, reforgeId})
		--print('inserting ' .. itemSlot .. ' ' .. reforgeId)
	end
end

function AskMrRobot.ReforgesTab:new(parent)

	local tab = AskMrRobot.Frame:new(nil, parent)
	setmetatable(tab, { __index = AskMrRobot.ReforgesTab })
	tab:SetPoint("TOPLEFT")
	tab:SetPoint("BOTTOMRIGHT")
	tab:Hide()

	local text = tab:CreateFontString("AmrReforgesHeader", "ARTWORK", "GameFontNormalLarge")
	text:SetPoint("TOPLEFT", 0, -5)
	text:SetText("Reforges")

	tab.stamp = AskMrRobot.RobotStamp:new(nil, tab)
	tab.stamp:Hide()
	tab.stamp.smallText:SetText("Your reforges are 100% optimal!")
	tab.stamp:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 2, -15)
	tab.stamp:SetPoint("RIGHT", tab, "RIGHT", -20, 0)

	tab.reforgeDetails = tab:CreateFontString("AmrReforgeDetails", "ARTWORK", "GameFontWhite")
	tab.reforgeDetails:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -15)
	tab.reforgeDetails:SetPoint("RIGHT", -30, 0)
	tab.reforgeDetails:SetWordWrap(true)
	tab.reforgeDetails:SetJustifyH("LEFT")
	tab.reforgeDetails:SetText('Open a reforge window, then click the "Reforge!" button to do it automatically.')
	tab.reforgeDetails:SetHeight(50)

	tab.reforgeButton = CreateFrame("Button", "AmrReforgeButton", tab, "UIPanelButtonTemplate")
	tab.reforgeButton:SetText("Reforge!")
	tab.reforgeButton:SetPoint("TOPLEFT", 0, -80)
	tab.reforgeButton:SetWidth(140)
	tab.reforgeButton:SetHeight(20)
	tab.reforgeButton:SetScript("OnClick", function()
		--print("ON CLICK")
		tab:OnReforge()
	end)

	tab.reforgeCost = tab:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	tab.reforgeCost:SetPoint("TOPLEFT", tab.reforgeButton, "TOPRIGHT", 25, 0)
	tab.reforgeCost:SetPoint("BOTTOM", tab.reforgeButton, "BOTTOM", 0, 0)
	tab.reforgeCost:SetPoint("RIGHT", tab, "RIGHT", -30, 0)
	tab.reforgeCost:SetText('')

	tab.slotHeader = tab:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	tab.slotHeader:SetText("Slot")
	tab.slotHeader:SetPoint("TOPLEFT", tab.reforgeButton, "BOTTOMLEFT", 0, -30)

	tab.reforgeHeader = tab:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	tab.reforgeHeader:SetText("Optimal Reforge")
	tab.reforgeHeader:SetPoint("TOPLEFT", tab.slotHeader, "TOPLEFT", 100, 0)

	tab.slots = {}
	tab.optimized = {}

	for i = 1, #AskMrRobot.slotNames do
		tab.slots[i] = tab:CreateFontString(nil, "ARTWORK", "GameFontWhite")
		tab.slots[i]:SetPoint("TOPLEFT", tab.slotHeader, "TOPLEFT", 0, -20 * i)
		tab.slots[i]:Hide()

		tab.optimized[i] = tab:CreateFontString(nil, "ARTWORK", "GameFontWhite")
		tab.optimized[i]:SetPoint("TOPLEFT", tab.reforgeHeader, "TOPLEFT", 0, -20 * i)
		tab.optimized[i]:Hide()
	end

	tab.inProgress = false

	tab:RegisterEvent("FORGE_MASTER_ITEM_CHANGED")
	tab:RegisterEvent("FORGE_MASTER_SET_ITEM")
	tab:RegisterEvent("FORGE_MASTER_OPENED")
	tab:RegisterEvent("FORGE_MASTER_CLOSED")

	tab:SetScript("OnEvent", function(...)
		tab:OnEvent(...)
	end)

	tab.pendingItemSlot = nil
	tab.pendingReforge = -1
	tab.currentItem = nil

	return tab
end


function AskMrRobot.ReforgesTab:showBadReforges()
	--print('show bad reforges')
	self.reforgequeue = {}

	local reforges = AskMrRobot.itemDiffs.reforges

	local i = 1

	local cost = 0

	-- for all the bad items
	for slotNum, badReforge in AskMrRobot.sortSlots(reforges) do
		--print('reforge on ' .. slotNum .. ' as ' .. badReforge.optimized)


		self.optimized[i]:SetText(GetReforgeString(badReforge.current, badReforge.optimized))
		self.optimized[i]:Show()

		--print(_G[strupper(AskMrRobot.slotNames[slotNum])])
		self.slots[i]:SetText(_G[strupper(AskMrRobot.slotNames[slotNum])])
		self.slots[i]:Show()

		-- Restore is free, so only add cost for non-restore reforges
		if badReforge.optimized > 0 then
			local slotId = AskMrRobot.slotIds[slotNum]
			local itemLink = GetInventoryItemLink("player", slotId)
			cost = cost + (itemLink and select (11, GetItemInfo(itemLink)) or 0)
		end

		--self.badEnchantOptimized[i]:SetEnchantId(badEnchant.optimized)
		--print("calling AddToReforgeQueue " .. slotNum .. ',' .. badReforge.optimized)
		self:AddToReforgeQueue(slotNum, badReforge.optimized);
		i = i + 1
	end

	self.reforgeCost:SetText("Total reforge cost: ~" .. math.ceil(cost / 10000) .. " Gold")

	-- hide / show the headers
	if i == 1 then
		self.reforgeHeader:Hide()
		self.slotHeader:Hide()
		self.reforgeButton:Hide()
		self.reforgeCost:Hide()
		self.reforgeDetails:Hide()
		self.stamp:Show()
	else
		self.stamp:Hide()
		self.reforgeButton:Show()
		self.reforgeCost:Show()
		self.reforgeHeader:Show()
		self.reforgeDetails:Show()
		self.slotHeader:Show()
	end

	-- hide the remaining slots
	while i <= #self.slots do
		self.optimized[i]:Hide()
		self.slots[i]:Hide()
		i = i + 1
	end		
end

function AskMrRobot.ReforgesTab:HasPendingOperation()
	if self.pendingItemSlot then
		--print('pending item slot')
		return true
	end

	if self.pendingReforge > 0 then
		--print('pending reforge')
		return true
	end

	return false
end

function AskMrRobot.ReforgesTab:CheckReforge()

	--print('Checking reforge')

	if self.reforgequeue == nil or #self.reforgequeue == 0 or self.reforgequeue == {} then
		return
	end

	for k, v in pairs(self.reforgequeue) do
	--Pick up the item and place it in the reforge window
		if self.pendingReforge then
			--print('pendingreforge1, checking whats in the reforge window')
			local currentReforge, icon, name, quality, bound, cost = GetReforgeItemInfo();
			-- if currentReforge then
			-- 	print('currentReforge = ' .. currentReforge)
			-- else
			-- 	print('currentReforge = ' .. nil)
			-- end
			if currentReforge == self.pendingReforge then
				--print('Done with ' .. self.currentItem)
				tremove(self.reforgequeue, 1)

			 	self.pendingReforge = 0
			 	self.currentSlot = -1
			 	self.currentItem = nil

			 	ClearCursor()
			 	SetReforgeFromCursorItem() -- pick up the old item
			 	ClearCursor() --get rid of it	

				AskMrRobot_ReforgeFrame:OnUpdate()
				self:OnReforge()
			else
				--try again
				ReforgeItem(self.pendingReforge)
				AskMrRobot.wait(0.250, AskMrRobot.ReforgesTab.CheckReforge, self)
			end
			return
		end

		local itemSlot = v[1]
		itemSlot = AskMrRobot.slotIds[itemSlot]

		local item = GetInventoryItemLink("player", AskMrRobot.slotIds[itemSlot])

		local reforgeId = GetReforgeIdForItem(item)

		if reforgeId == v[2] then
			--print('Done with ' .. self.currentItem)
			tremove(self.reforgequeue, 1)

			AskMrRobot_ReforgeFrame:validateInput(AskMrRobot_ReforgeFrame.importTab.scrollFrame.EditBox:GetText())
			self:showBadReforges()
			self:OnReforge()
 			return
 		end
 	end

end

function AskMrRobot.ReforgesTab:PutNextItemInForge()
	if (self.reforgequeue == nil or #self.reforgequeue == 0 or self.reforgequeue == {}) then
		return
	end

	if self:HasPendingOperation() then
		return
	end
	
	for k, v in pairs(self.reforgequeue) do
		--Pick up the item and place it in the reforge window
		local itemSlot = v[1]
		itemSlot = AskMrRobot.slotIds[itemSlot]
		--print("slot " .. itemSlot)

		local item = GetInventoryItemLink("player", itemSlot)
		self.currentItem = item
		if self.currentSlot ~= itemSlot then
			ClearCursor()
			SetReforgeFromCursorItem() -- pick up the old item
			ClearCursor() --get rid of it
			PickupInventoryItem(itemSlot)

 			--print("Placing " .. item .. " in the reforge window.")
 			self.pendingItemSlot = itemSlot
 			--print("setting pendingItemSlot = " .. self.pendingItemSlot)

			SetReforgeFromCursorItem()
 			return
 		end
 		return
 	end
end

function AskMrRobot.ReforgesTab:ReforgeItem()
	if self.reforgequeue == nil or #self.reforgequeue == 0 or self.reforgequeue == {} then
		return
	end

	if self:HasPendingOperation() then
		return
	end

	--local currentReforge, icon, name, quality, bound, cost = GetReforgeItemInfo();
	--print('... currentReforge ' .. currentReforge)

	for k, v in pairs(self.reforgequeue) do
		local reforgeID = 0;
		if v[2] ~= 0 then
			local targetFrom = REFORGE_TABLE[v[2] - REFORGE_TABLE_BASE][1];
			local targetTo = REFORGE_TABLE[v[2] - REFORGE_TABLE_BASE][2];
			--print ('num reforge options: ' .. GetNumReforgeOptions())
			for i=1, GetNumReforgeOptions() do
				local from, _, _, to, _, _ = GetReforgeOptionInfo(i)
	 			--print(i .. ': ' .. from .. " -> " .. to)
				if StatNames[targetFrom] == from and StatNames[targetTo] == to then
					reforgeID = i
					break
				end
			end
			if reforgeID == 0 then
				print('Could not find reforge')
			end
		end

		local currentReforgeID = GetReforgeIdForItem(self.currentItem);
		--print("Reforging " .. self.currentItem .. ' current: ' .. currentReforgeID)
		if currentReforgeID ~= 0 then
			--print('reforging to: ' .. reforgeID .. ': ' .. targetFrom .. ' -> ' .. targetTo);
		end
		if currentReforgeID == v[2] then
			--print('Done with ' .. self.currentItem)
			tremove(self.reforgequeue, 1)
			ClearCursor()
			SetReforgeFromCursorItem() -- pick up the old item
			ClearCursor() --get rid of it
			self.currentSlot = -1
			--AmrUpdateQueueText();
			--self:showBadReforges()
			AskMrRobot_ReforgeFrame:validateInput(AskMrRobot_ReforgeFrame.importTab.scrollFrame.EditBox:GetText())
		else
			if reforgeID == 0 then
				--print('restoring reforge')
			else
				local targetFrom = REFORGE_TABLE[v[2] - REFORGE_TABLE_BASE][1];
				local targetTo = REFORGE_TABLE[v[2] - REFORGE_TABLE_BASE][2];
				--print('reforging to: ' .. reforgeID .. ': ' .. StatNames[targetFrom] .. ' -> ' .. StatNames[targetTo]);
			end
			self.pendingReforge = reforgeID
			ReforgeItem(reforgeID)
			AskMrRobot.wait(0.250, AskMrRobot.ReforgesTab.CheckReforge, self)
		end
		--self:RetryReforge()
		return
	end
end

function AskMrRobot.ReforgesTab:OnReforge(event)
	if not self.isReforgeOpen then
		StaticPopup_Show("REFORGE_TAB_PLEASE_OPEN")
		return
	end

	self.currentSlot = -1
	--print("resetting pendingItemSlot")
	self.pendingItemSlot = nil
	self:PutNextItemInForge()
end

function AskMrRobot.ReforgesTab:On_FORGE_MASTER_SET_ITEM()
	if self.pendingItemSlot then
		--print('self.pendingItemSlot = ' .. self.pendingItemSlot)
		--printtable(self)
		-- indicate that the pending item is now the item in the UI
		self.currentSlot = self.pendingItemSlot
		-- indicate that we are no longer waiting for an item
		self.pendingItemSlot = nil
		--self:ReforgeIt()
		self:ReforgeItem()
	end 
end

function AskMrRobot.ReforgesTab:On_FORGE_MASTER_ITEM_CHANGED()
	if self.pendingReforge then
	 	--print('processing pending reforge')
	-- 	-- indicate the item is done
	-- 	self.pendingReforge = false
	-- 	self.currentSlot = -1
	-- 	self.currentItem = nil

	-- 	ClearCursor()
	-- 	SetReforgeFromCursorItem() -- pick up the old item
	-- 	ClearCursor() --get rid of it		

	 	self:CheckReforge()
	-- 	--self:ReforgeItem();
	-- 	--self:ReforgeIt()
	-- 	--self:showBadReforges()
	-- 	--self:OnReforge()
	-- 	--if #self.reforgequeue > 1
	-- 	--end
	end
end

function AskMrRobot.ReforgesTab:On_FORGE_MASTER_OPENED()
	self.isReforgeOpen = true
end

function AskMrRobot.ReforgesTab:On_FORGE_MASTER_CLOSED()
	self.isReforgeOpen = false
end

function AskMrRobot.ReforgesTab:OnEvent(frame, event, ...)
	--print("EVENT " .. event)
	local handler = self["On_" .. event]
	if handler then
		handler(self, ...)
	end
end