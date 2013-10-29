local _, AskMrRobot = ...

--------------------------------------------------------------------
-- Local Reforge Utility Code
--------------------------------------------------------------------

StaticPopupDialogs["REFORGE_TAB_PLEASE_OPEN"] = {
	text = "You need to open the reforge window for this to work",
	button1 = "Ok",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

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
  local id = tonumber(item:match("item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+:%d+:(%d+)"))
  return (id and id ~= 0 and id or 0)
end

local function GetReforgeIdFromStats(fromStat, toStat)
	if (toStat > fromStat) then
		return REFORGE_TABLE_BASE + 7 * (fromStat - 1) + toStat - 1;
	else
		return REFORGE_TABLE_BASE + 7 * (fromStat - 1) + toStat;
	end
end


--------------------------------------------------------------------
-- Initialization
--------------------------------------------------------------------
AskMrRobot.ReforgesTab = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

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

	-- pre-allocate a visual element for all possible slots; showBadReforges will set text and show the number that are needed, and hide the rest
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

	tab:RegisterEvent("FORGE_MASTER_ITEM_CHANGED")
	tab:RegisterEvent("FORGE_MASTER_SET_ITEM")
	tab:RegisterEvent("FORGE_MASTER_OPENED")
	tab:RegisterEvent("FORGE_MASTER_CLOSED")

	tab:SetScript("OnEvent", function(...)
		tab:OnEvent(...)
	end)


	-- initialize stat required for performing the reforges
	tab.state = {}
	tab:ResetState()


	return tab
end


--------------------------------------------------------------------
-- Rendering
--------------------------------------------------------------------

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

-- draw all of the reforges that still need to be performed
function AskMrRobot.ReforgesTab:Render()

	local reforges = AskMrRobot.itemDiffs.reforges
	local i = 1
	local cost = 0

	-- for all the bad items
	for slotNum, badReforge in AskMrRobot.sortSlots(reforges) do

		self.optimized[i]:SetText(GetReforgeString(badReforge.current, badReforge.optimized))
		self.optimized[i]:Show()

		self.slots[i]:SetText(_G[strupper(AskMrRobot.slotNames[slotNum])])
		self.slots[i]:Show()

		-- Restore is free, so only add cost for non-restore reforges
		if badReforge.optimized > 0 then
			local slotId = AskMrRobot.slotIds[slotNum]
			local itemLink = GetInventoryItemLink("player", slotId)
			cost = cost + (itemLink and select (11, GetItemInfo(itemLink)) or 0)
		end

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

--------------------------------------------------------------------
-- Reforge Logic
--------------------------------------------------------------------

-- reset state for a fresh pass at automatic reforging
function AskMrRobot.ReforgesTab:ResetState()

	self.state.queue = {}           -- list of all reforges actions that still need to be performed
	self.state.currentItem = nil    -- the current item we are trying to reforge
	self.state.pendingSlot = nil    -- the slot that we have requested to place into the reforger
	self.state.currentSlot = nil    -- the current slot in the reforger
	self.state.pendingReforge = -1  -- the reforge that we have requested to perform on the current item
end

-- refresh the queue of reforges that still need to be performed
function AskMrRobot.ReforgesTab:RefreshQueue()

	-- clear the queue
	self.state.queue = {}

	local reforges = AskMrRobot.itemDiffs.reforges

	-- add all reforges that need updating to the reforge queue
	for slotNum, badReforge in AskMrRobot.sortSlots(reforges) do
		self:AddToReforgeQueue(slotNum, badReforge.optimized);
	end
end

function AskMrRobot.ReforgesTab:AddToReforgeQueue(itemSlot, reforgeId)

	-- the game's slot id, not the same as the ids that we use on our servers
	local gameSlot = AskMrRobot.slotIds[itemSlot]
	
	local item = GetInventoryItemLink("player", gameSlot)
	if item == nil then 
		--print ('no item')
		return 
	end

	local current = GetReforgeIdForItem(item)

	if current ~= reforgeId then
		-- restore first
		if current ~= 0 and reforgeId ~= 0 then
			tinsert(self.state.queue, { ["slot"] = gameSlot, ["reforge"] = 0 })
		end

		-- then reforge to the specified reforge
		tinsert(self.state.queue, { ["slot"] = gameSlot, ["reforge"] = reforgeId })
	end
end

function AskMrRobot.ReforgesTab:IsQueueEmpty()
	return self.state.queue == nil or #self.state.queue == 0 or self.state.queue == {};
end

-- returns true if we are waiting on the game to finish a pending async reforge operation
function AskMrRobot.ReforgesTab:HasPendingOperation()

	-- waiting for an item to be placed into the reforger
	if self.state.pendingSlot then
		return true
	end

	-- waiting for a reforge to be completed
	if self.state.pendingReforge ~= -1 then
		return true
	end

	return false
end

-- put the next item in the reforge queue into the game's reforge UI
function AskMrRobot.ReforgesTab:PutNextItemInForge()

	if self:IsQueueEmpty() or self:HasPendingOperation() then
		return
	end
	
	-- get the first action in the queue
	local currentAction = self.state.queue[1]
	local itemSlot = currentAction.slot

	local item = GetInventoryItemLink("player", itemSlot)
		
	-- set current item that we are trying to reforge
	self.state.currentItem = item

	-- if this item isn't already in the reforger, put it in
	if self.state.currentSlot ~= itemSlot then
		ClearCursor()                 -- make sure no item is selected
		SetReforgeFromCursorItem()    -- pick up the old item (calling this with an item already in the reforger will put it back on the mouse cursor)
		ClearCursor()                 -- clear the cursor to finish removing any current item from the game reforge UI
		PickupInventoryItem(itemSlot) -- pick up the right equipped item

		-- pending, listen for an event from the game to complete setting this item into the reforger
		self.state.pendingSlot = itemSlot

		SetReforgeFromCursorItem()    -- put the item into the reforger, and wait for the FORGE_MASTER_SET_ITEM event, which calls DoReforge
 	end

end

-- an item is in the reforger, ready to be reforged, so do it
function AskMrRobot.ReforgesTab:DoReforge()

	if self:IsQueueEmpty() or self:HasPendingOperation() then
		return
	end

	local currentAction = self.state.queue[1]
	local desiredReforge = currentAction.reforge

	-- the index that needs to be provided to WoW's ReforgeItem method, corresponds to one of the options in the game reforge UI
	local reforgeIndex = -1

	if desiredReforge ~= 0 then
		local targetFrom = REFORGE_TABLE[desiredReforge - REFORGE_TABLE_BASE][1];
		local targetTo = REFORGE_TABLE[desiredReforge - REFORGE_TABLE_BASE][2];

		for i=1, GetNumReforgeOptions() do
			local from, _, _, to, _, _ = GetReforgeOptionInfo(i)
	 		--print(i .. ': ' .. from .. " -> " .. to)
			if StatNames[targetFrom] == from and StatNames[targetTo] == to then
				reforgeIndex = i
				break
			end
		end
	else
		reforgeIndex = 0
	end

	if reforgeIndex == -1 then
		-- we couldn't do this reforge... we either had a bad reforge (wrong stats on an item), or the game had no options in the UI for some reason

		-- remove the item from the reforge window
		ClearCursor()
		SetReforgeFromCursorItem()
		ClearCursor()

		-- reset state and quit reforging (clears the queue)
		self:ResetState()

	else

		local currentReforge = GetReforgeIdForItem(self.state.currentItem);
		if currentReforge == desiredReforge then
			-- we already have this reforge on the item... probably shouldn't ever happen, but if it does, recalculate and start over
			tremove(self.state.queue, 1)

			-- remove the item from the reforge window
			ClearCursor()
			SetReforgeFromCursorItem()
			ClearCursor()

			-- update the state of the entire UI, and start again with the next required reforge
			AskMrRobot_ReforgeFrame:OnUpdate()
			self:OnReforge()

		else
			-- we have a reforge (or restore) to do, kick it off and wait for CheckReforge to respond to completion
			self:TryReforge(reforgeIndex)
		end

	end

end

-- wraps WoW API call to ReforgeItem, fires a manual timeout in case the UI does not raise an event
function AskMrRobot.ReforgesTab:TryReforge(reforgeIndex)

	-- we have a reforge (or restore) to do, kick it off and wait for FORGE_MASTER_ITEM_CHANGED, which calls CheckReforge
	self.state.pendingReforge = reforgeIndex
	ReforgeItem(reforgeIndex)

	-- sometimes the game doesn't send the FORGE_MASTER_ITEM_CHANGED event, so also check after a delay also
	AskMrRobot.wait(0.250, AskMrRobot.ReforgesTab.CheckReforge, self)

end

-- check that a requested reforge has been completed
function AskMrRobot.ReforgesTab:CheckReforge()

	if self:IsQueueEmpty() or self.state.pendingReforge == -1 then

		-- responding to a reforge that the user has manually performed, update the UI and terminate any automatic process that is going on
		AskMrRobot_ReforgeFrame:OnUpdate()
		self:ResetState()

	else
		-- responding to a reforge that we have initiated

		local currentReforge, icon, name, quality, bound, cost = GetReforgeItemInfo();
		if currentReforge == self.state.pendingReforge then
			tremove(self.state.queue, 1)

			-- remove the item from the reforge window
			ClearCursor()
			SetReforgeFromCursorItem()
			ClearCursor()

			-- update the state of the entire UI, and start again with the next required reforge
			AskMrRobot_ReforgeFrame:OnUpdate()
			self:OnReforge()
		else
			-- try again
			self:TryReforge(self.state.pendingReforge)
		end
	end

end


--------------------------------------------------------------------
-- Event Handling
--------------------------------------------------------------------

-- event called when the Mr. Robot Reforge button is clicked, kicks off automatic reforge
function AskMrRobot.ReforgesTab:OnReforge()

	-- need to be at a reforger for this to work
	if not self.isReforgeOpen then
		StaticPopup_Show("REFORGE_TAB_PLEASE_OPEN")
		return
	end

	-- reset state and refresh the queue of reforges that still need to be done
	self:ResetState()
	self:RefreshQueue()

	-- get goin, put the first item in the reforger
	self:PutNextItemInForge()
end

function AskMrRobot.ReforgesTab:On_FORGE_MASTER_SET_ITEM()

	if self.state.pendingSlot then
		
		-- we have successfully finished placing an item into the reforger
		self.state.currentSlot = self.state.pendingSlot

		-- indicate that we are no longer waiting for an item
		self.state.pendingSlot = nil

		-- now reforge it
		self:DoReforge()
	end 

end

function AskMrRobot.ReforgesTab:On_FORGE_MASTER_ITEM_CHANGED()
	self:CheckReforge()
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