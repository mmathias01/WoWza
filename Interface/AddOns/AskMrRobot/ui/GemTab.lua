local _, AskMrRobot = ...

StaticPopupDialogs["AUTOGEM_FINISHED"] = {
	text = "Mr. Robot finished auto-gemming. \rIf some items aren't gemmed, you may need to acquire more gems. \rIf your belt isn't gemmed, you may still need to buy a belt buckle.",
	button1 = "Ok",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

StaticPopupDialogs["AUTOGEM_ONCE"] = {
	text = "Autogemming already in progress.",
	button1 = "Ok",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

-- initialize the GemTab class
AskMrRobot.GemTab = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

local MAX_SLOTS = 4

-- GemTab contructor
function AskMrRobot.GemTab:new(name, parent)
	-- create a new frame (if one isn't supplied)
	local tab = AskMrRobot.Frame:new(name, parent)
	tab:SetPoint("TOPLEFT")
	tab:SetPoint("BOTTOMRIGHT")
	-- use the GemTab class
	setmetatable(tab, { __index = AskMrRobot.GemTab })
	tab:Hide()

	local text = tab:CreateFontString("AmrGemsText1", "ARTWORK", "GameFontNormalLarge")
	text:SetPoint("TOPLEFT", 0, -5)
	text:SetText("Gems")

	tab.stamp = AskMrRobot.RobotStamp:new(nil, tab)
	tab.stamp:Hide()
	tab.stamp.smallText:SetText("Your gems are 100% optimal! You are truly, truly outrageous.")
	tab.stamp:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 2, -15)
	tab.stamp:SetPoint("RIGHT", tab, "RIGHT", -20, 0)

	text = tab:CreateFontString("AmrGemsText2", "ARTWORK", "GameFontWhite")
	text:SetText("You have X gems to optimize")
	text:SetPoint("TOPLEFT", "AmrGemsText1", "BOTTOMLEFT", 0, -20)
	text:SetWidth(200)
	text:SetJustifyH("LEFT")
	tab.gemsTextToOptimize = text

	-- autogem button
	tab.button = CreateFrame("Button", "AmrAutoGemButton", tab, "UIPanelButtonTemplate")	
	tab.button:SetPoint("TOP", "AmrGemsText1", "BOTTOM", 0, -16)
	tab.button:SetPoint("RIGHT", -40, 0)
	tab.button:SetText("Auto Gem! (BETA)")
	tab.button:SetWidth(150)
	tab.button:SetHeight(20)
	tab.button:SetScript("OnClick", function() tab:startAutoGem() end)
	tab.button:Hide()

	-- autogem checkbox button
	tab.usePerfectButton = CreateFrame("CheckButton", "AmrUsePerfectButton", tab, "ChatConfigCheckButtonTemplate")	
	tab.preferPerfects = true
	tab.usePerfectButton:SetChecked(tab.preferPerfects)
	tab.usePerfectButton:SetPoint("TOPLEFT", "AmrAutoGemButton", "BOTTOMLEFT", 0, -4)
	tab.usePerfectButton:SetScript("OnClick", function () tab.preferPerfects = tab.usePerfectButton:GetChecked() end)
	local text3 = getglobal(tab.usePerfectButton:GetName() .. 'Text')
	text3:SetText("Prefer Perfect")
	text3:SetWidth(150)
	text3:SetPoint("TOPLEFT", tab.usePerfectButton, "TOPRIGHT", 2, -4)
	tab.usePerfectButton:Hide()

	tab.gemSlotHeader = tab:CreateFontString("AmrBadGemSlot0", "ARTWORK", "GameFontNormal")
	tab.gemSlotHeader:SetPoint("TOPLEFT", "AmrGemsText2", "BOTTOMLEFT", 0, -20)
	tab.gemSlotHeader:SetText("Slot")
	tab.gemSlotHeader:SetWidth(90)
	tab.gemSlotHeader:SetJustifyH("LEFT")
	tab.gemSlotHeader:Hide()
	tab.gemCurrentHeader = tab:CreateFontString("AmrBadGemCurrent0_1", "ARTWORK", "GameFontNormal")
	tab.gemCurrentHeader:SetPoint("TOPLEFT", "AmrBadGemSlot0", "TOPLEFT", 88, 0)
	tab.gemCurrentHeader:SetWidth(110)
	tab.gemCurrentHeader:SetText("Current")
	tab.gemCurrentHeader:SetJustifyH("LEFT")
	tab.gemCurrentHeader:Hide()
	tab.gemOptimizedHeader = tab:CreateFontString("AmrBadGemOptimized0_1", "ARTWORK", "GameFontNormal")
	tab.gemOptimizedHeader:SetPoint("TOPLEFT", "AmrBadGemCurrent0_1", "TOPLEFT", 70, 0)
	tab.gemOptimizedHeader:SetPoint("RIGHT", -30, 0)
	tab.gemOptimizedHeader:SetText("Optimized")
	tab.gemOptimizedHeader:SetJustifyH("LEFT")
	tab.gemOptimizedHeader:Hide()

	tab.fauxScroll = CreateFrame("ScrollFrame", "testme", tab, "FauxScrollFrameTemplate")
	tab.fauxScroll:SetPoint("BOTTOMRIGHT", -40, 15)
	tab.fauxScroll:SetPoint("TOPLEFT", "AmrBadGemSlot0", "BOTTOMLEFT", -12, -5)
	tab.fauxScroll.parent = tab
	tab.fauxScroll:SetScript("OnVerticalScroll", AskMrRobot.GemTab.OnVerticalScroll)

	tab.jewelPanels = {}
	for i = 1, MAX_SLOTS do

		tab.jewelPanels[i] = AskMrRobot.JewelPanel:new("AmrBadGemSlot" .. i, tab)
		if i == 1 then
			tab.jewelPanels[i]:SetPoint("TOPLEFT", "AmrBadGemSlot" .. (i-1), "BOTTOMLEFT", -12, -5)
			--tab.jewelPanels[i]:SetPoint("TOPLEFT")
		else
			tab.jewelPanels[i]:SetPoint("TOPLEFT", "AmrBadGemSlot" .. (i-1), "BOTTOMLEFT", 0, -5)
		end
		tab.jewelPanels[i]:SetPoint("RIGHT", -40, 0)
	end

	return tab
end

function AskMrRobot.GemTab:startAutoGem()
	if AskMrRobot.AutoGem(self.preferPerfects) == false then 
		StaticPopup_Show("AUTOGEM_ONCE")
	end
end

function AskMrRobot.GemTab:Update()
	self.count = 0

	local i = 1
	local badGemTotal = 0

	if AskMrRobot.itemDiffs.gems then
		for slotNum, badGems in AskMrRobot.sortSlots(AskMrRobot.itemDiffs.gems) do
			self.count = self.count + 1
			if i <= MAX_SLOTS then
				self.jewelPanels[i]:Show()
			end
			for k, v in pairs(badGems.badGems) do
				badGemTotal = badGemTotal + 1
			end
			i = i + 1
		end
	end

	self.gemsTextToOptimize:SetFormattedText("You have %d \1244gem:gems; to optimize", badGemTotal)

	--hide/show the headers, depending on if we have any bad gems
	if self.count == 0 then
		self.gemSlotHeader:Hide()
		self.gemCurrentHeader:Hide()
		self.gemOptimizedHeader:Hide()
		self.gemsTextToOptimize:Hide()
		self.button:Hide()
		self.usePerfectButton:Hide()
		self.stamp:Show()
	else
		self.gemSlotHeader:Show()
		self.gemCurrentHeader:Show()
		self.gemOptimizedHeader:Show()
		self.gemsTextToOptimize:Show()
		self.button:Show()
		self.usePerfectButton:Show()
		self.stamp:Hide()
	end	

	for i = self.count + 1, MAX_SLOTS do
		self.jewelPanels[i]:Hide()
		i = i + 1
	end

	AskMrRobot.GemTab.OnUpdate(self.fauxScroll, self.count, #self.jewelPanels, self.jewelPanels[1]:GetHeight())
end

function AskMrRobot.GemTab.OnVerticalScroll(scrollframe, offset)
	local self = scrollframe.parent
	FauxScrollFrame_OnVerticalScroll(self.fauxScroll, offset, self.jewelPanels[1]:GetHeight(), AskMrRobot.GemTab.OnUpdate)
end

function AskMrRobot.GemTab.OnUpdate(scrollframe)	
	local self = scrollframe.parent
	FauxScrollFrame_Update(self.fauxScroll, self.count, #self.jewelPanels, self.jewelPanels[1]:GetHeight())
	local offset = FauxScrollFrame_GetOffset(scrollframe)

	local i = 1
	for slotNum, badGems in AskMrRobot.sortSlots(AskMrRobot.itemDiffs.gems) do
		if offset > 0 then
			offset = offset - 1
		else

			if i > MAX_SLOTS then
				break
			end

			self.jewelPanels[i]:SetItemLink(_G[strupper(AskMrRobot.slotNames[slotNum])], badGems.current.link )
			self.jewelPanels[i]:SetOptimizedGems(badGems.optimized, badGems.badGems)
			i = i + 1
		end
	end
end