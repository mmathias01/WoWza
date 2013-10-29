local _, AskMrRobot = ...

-- initialize the EnchantTab class
AskMrRobot.EnchantTab = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

function AskMrRobot.EnchantTab:new(parent)

	local tab = AskMrRobot.Frame:new(nil, parent)
	setmetatable(tab, { __index = AskMrRobot.EnchantTab })
	tab:SetPoint("TOPLEFT")
	tab:SetPoint("BOTTOMRIGHT")
	tab:Hide()


	local text = tab:CreateFontString("AmrEnchantsText1", "ARTWORK", "GameFontNormalLarge")
	text:SetPoint("TOPLEFT", 0, -5)
	text:SetText("Enchants")

	tab.stamp = AskMrRobot.RobotStamp:new(nil, tab)
	tab.stamp:Hide()
	tab.stamp.smallText:SetText("Your enchants are 100% optimal!")
	tab.stamp:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 2, -15)
	tab.stamp:SetPoint("RIGHT", tab, "RIGHT", -20, 0)

	tab.slotHeader = tab:CreateFontString("AmrBadEnchantSlotHeader", "ARTWORK", "GameFontNormal")
	tab.slotHeader:SetPoint("TOPLEFT", "AmrEnchantsText1", "BOTTOMLEFT", 0, -20)
	tab.slotHeader:SetText("Slot")
	tab.slotHeader:SetWidth(90)
	tab.slotHeader:SetJustifyH("LEFT")

	tab.currentHeader = tab:CreateFontString("AmrBadEnchantCurrentHeader", "ARTWORK", "GameFontNormal")
	tab.currentHeader:SetText("Current")
	tab.currentHeader:SetPoint("TOPLEFT", "AmrBadEnchantSlotHeader", "TOPLEFT", 100, 0)
	tab.currentHeader:SetWidth(120)
	tab.currentHeader:SetJustifyH("LEFT")

	tab.optimizedHeader = tab:CreateFontString("AmrBadEnchantOptimizedHeader", "ARTWORK", "GameFontNormal")
	tab.optimizedHeader:SetPoint("TOPLEFT", "AmrBadEnchantCurrentHeader", "TOPLEFT", 140, 0)
	tab.optimizedHeader:SetPoint("RIGHT", -30, 0)
	tab.optimizedHeader:SetText("Optimized")
	tab.optimizedHeader:SetJustifyH("LEFT")

	tab.badEnchantSlots = {}
	tab.badEnchantCurrent = {}
	tab.badEnchantOptimized = {}

	for i = 1, #AskMrRobot.slotNames do
		local itemText = tab:CreateFontString(nil, "ARTWORK", "GameFontWhite")
		itemText:SetPoint("TOPLEFT", "AmrBadEnchantSlotHeader", "TOPLEFT", 0, -26 * i)
		itemText:SetPoint("BOTTOMRIGHT", "AmrBadEnchantSlotHeader", "BOTTOMRIGHT", 0, -26 * i)
		itemText:SetJustifyH("LEFT")
		itemText:SetText("TestSlot")
		tinsert(tab.badEnchantSlots, itemText)

		itemText = AskMrRobot.EnchantLinkText:new(nil, tab)
		itemText:SetPoint("TOPLEFT", "AmrBadEnchantCurrentHeader", "TOPLEFT", 0, -26 * i)
		itemText:SetPoint("BOTTOMRIGHT", "AmrBadEnchantCurrentHeader", "BOTTOMRIGHT", 0,  -26 * i)
		tinsert(tab.badEnchantCurrent, itemText)

		itemText = AskMrRobot.EnchantLinkIconAndText:new(nil, tab)
		itemText:SetPoint("TOPLEFT", "AmrBadEnchantOptimizedHeader", "TOPLEFT", 0,  -26 * i)
		itemText:SetPoint("BOTTOMRIGHT", "AmrBadEnchantOptimizedHeader", "BOTTOMRIGHT", 0,  -26 * i)
		tinsert(tab.badEnchantOptimized, itemText)
	end

	return tab
end

function AskMrRobot.EnchantTab:showBadEnchants()

	local badEnchants = AskMrRobot.itemDiffs.enchants

	local i = 1

	-- for all the bad items
	for slotNum, badEnchant in AskMrRobot.sortSlots(badEnchants) do
		self.badEnchantSlots[i]:SetText(_G[strupper(AskMrRobot.slotNames[slotNum])])
		self.badEnchantSlots[i]:Show()

		self.badEnchantCurrent[i]:SetEnchantId(badEnchant.current)

		self.badEnchantOptimized[i]:SetEnchantId(badEnchant.optimized)
		i = i + 1
	end

	-- hide / show the headers
	if i == 1 then
		self.optimizedHeader:Hide()
		self.currentHeader:Hide()
		self.slotHeader:Hide()
		self.stamp:Show()
	else
		self.optimizedHeader:Show()
		self.currentHeader:Show()
		self.slotHeader:Show()
		self.stamp:Hide()
	end

	-- hide the remaining slots
	while i <= #self.badEnchantSlots do
		self.badEnchantSlots[i]:Hide()
		self.badEnchantCurrent[i]:SetEnchantId(nil)
		self.badEnchantOptimized[i]:SetEnchantId(nil)
		i = i + 1
	end		
end