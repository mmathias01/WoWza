local _, AskMrRobot = ...

local showImportDetailsError = nil
local showImportErrorTab = nil

AskMrRobot.AmrUI = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

function AskMrRobot.AmrUI:displayImportItems()
	if not self.importedItems then 
		return false
	end
	for slotNum = 1, #AskMrRobot.slotIds do
		if AskMrRobot.OptimizationSlots[slotNum] then
			local slotId = AskMrRobot.slotIds[slotNum]
			local itemLink = GetInventoryItemLink("player", slotId)
			AskMrRobot.populateItemDiffs(self.importedItems[slotNum], itemLink, slotNum)
		end
	end

	self.summaryTab:showBadItems()

	-- if there are incorrect items equiped, display errors on other tabs
	if AskMrRobot.itemDiffs and AskMrRobot.itemDiffs.items then
		for k,v in pairs(AskMrRobot.itemDiffs.items) do
			if not v.needsUpgrade then
				self.hasImportError = true
			end
		end		
	end

	if self.hasImportError then
		showImportDetailsError()
	else
		self.gemTab:Update()
		self.enchantTab:showBadEnchants()
		self.reforgeTab:Render()
		self.shoppingTab:Update()
	end
end

function AskMrRobot.AmrUI:showImportError(text, ...)
	self.summaryTab:showImportError(text, ...)
	if text then
		self.hasImportError = true		
		showImportDetailsError()
	else
		self.hasImportError = false
	end
end

function AskMrRobot.AmrUI:showImportWarning(text, ...)
	self.summaryTab:showImportWarning(text, ...)
	self.hasImportError = false
	if text then
		showImportDetailsError()
	end
end

function AskMrRobot.AmrUI:validateInput(input)

	self.importedItems = nil
	self.mostlySuccess = false

	local parsed = AskMrRobot.parseAmr(input)

	if not parsed.realm then
		self:showImportError("Oops, you didn't have proper import text", "Please go back to AskMrRobot.com and grab optimizations for this character")
	elseif not AskMrRobot.validateCharacterName(parsed.name) then
		self:showImportError("Oops, you've imported optimizations for " .. parsed.name, "Please go back to AskMrRobot.com and grab optimizations for this character, who is much better looking anyway!")
	elseif not AskMrRobot.validateRace(parsed.race) then
		self:showImportError("It looks like your race may have changed, which affects the optimizations.", "Right now, Mr. Robot thinks you are a " .. parsed.race)
	elseif not AskMrRobot.validateFaction(parsed.faction) then
		self:showImportError("It looks like your faction may have changed.", "Right now, Mr. Robot thinks you belong to the " .. parsed.faction)
	elseif not AskMrRobot.validateProfessions(parsed.professions) then
		self:showImportError("Your professions have changed, which affects the optimizations.", "You will need to make sure your in-game professions match the professions on AskMrRobot.com when importing.")
	elseif not AskMrRobot.validateSpec(parsed.spec) then
		if parsed.spec and parsed.spec ~= 'nil' then			
			local _, specName = GetSpecializationInfoByID(parsed.spec)
			self:showImportError("WARNING! Please check your character before proceeding:", "Change your spec to " .. specName .. ".")
		else
			self:showImportError("WARNING! Please check your character before proceeding:", "AskMrRobot.com did not expect to see a specialization.")
		end
		self.mostlySuccess = true
		self.summaryTab.badRealm = nil
		self.summaryTab.badTalents = nil
		self.summaryTab.badGlyphs = nil
		AmrImportString = input
	else
		self.summaryTab.badRealm = not AskMrRobot.validateRealm(parsed.realm) and parsed.realm
		self.summaryTab.badTalents = not AskMrRobot.validateTalents(parsed.talents)
		self.summaryTab.badGlyphs = not AskMrRobot.validateGlyphs(parsed.glyphs)
		self.mostlySuccess = true
		self:showImportError(nil)
		AmrImportString = input
		self.importedItems = parsed.items
		return self:displayImportItems()
	end
	return false
end

local function createImportDetailsErrorTab(reforgeFrame)
	local tab = CreateFrame("Frame", nil, reforgeFrame)
	tab:SetPoint("TOPLEFT")
	tab:SetPoint("BOTTOMRIGHT")
	tab:Hide()

	local text = tab:CreateFontString("AmrImportDetailsText1", "ARTWORK", "GameFontNormalLarge")
	text:SetPoint("TOPLEFT", 0, -5)
	text:SetText("Help")

	local errorText1 = tab:CreateFontString("AmrImportDetailsText2", "ARTWORK", "GameFontRed")
	errorText1:SetPoint("TOPLEFT", "AmrImportDetailsText1", "BOTTOMLEFT", 0, -20)
	errorText1:SetText('You have no optimizations imported. Click the "Import" tab to get started.')
	errorText1:SetPoint("RIGHT", -10, 0)
	errorText1:SetWidth(errorText1:GetWidth())
	errorText1:SetJustifyH("LEFT")

	showImportDetailsError = function()
		errorText1:SetText("I can't optimize yet. Please go to the summary tab for more information.")
	end

	showImportErrorTab = function(tabName)
		if not tabName then
			tab:Hide()
		else
			text:SetText(tabName)
			tab:Show()
		end		
	end

	return tab
end

function AskMrRobot.AmrUI:createTabButtons()
	local importTabButton = CreateFrame("Button", "AmrImportTabButton", self, "OptionsListButtonTemplate")

	local buttons = {}
	self.hasImportError = true

	local function onTabButtonClick(clickedButton, event, ...)
		showImportErrorTab(nil)
		for i = 1, #buttons do
			local button = buttons[i]
			if clickedButton == button then
				button.highlight:SetVertexColor(1, 1, 0)
				button:LockHighlight()
				if self.hasImportError and button.isImportDetails then
					showImportErrorTab(button:GetText())
				elseif button.element then 
					button.element:Show()
				end
			else
				button.highlight:SetVertexColor(.196, .388, .8)
				button:UnlockHighlight()
				if button.element then
					button.element:Hide()
				end
			end
		end
	end

	local function createButton(text, spacing, isImportDetails)
		local lastButton = #buttons
		local i = lastButton + 1
		local tabButton = CreateFrame("Button", "AmrTabButton" .. i, self, "OptionsListButtonTemplate")
		tabButton.isImportDetails = isImportDetails
		tabButton:SetText(text)
		if i == 1 then
			tabButton:SetPoint("TOPLEFT", 20, spacing)
		else
			tabButton:SetPoint("TOPLEFT", "AmrTabButton" .. lastButton, "BOTTOMLEFT", 0, spacing)
		end
		tabButton:SetWidth(110)
		tabButton:SetHeight(20)
		tinsert(buttons, tabButton)
		tabButton:SetScript("OnClick", onTabButtonClick)
	end

	createButton("Import", -35, false)
	createButton("Summary", -20, false)
	createButton("Gems", 0, true)
	createButton("Enchants", 0, true)
	createButton("Reforges", 0, true)
	createButton("Shopping List", 0, true)
	createButton("Best in Bags", -20, false)
	createButton("Help", -20, false)

	return buttons
end

function AskMrRobot.AmrUI:new()
	local o = AskMrRobot.Frame:new("AskMrRobot_Dialog", nil, "UIPanelDialogTemplate")

	-- use the AmrUI class
	setmetatable(o, { __index = AskMrRobot.AmrUI })

	o:RegisterForDrag("LeftButton");
	o:SetWidth(600)
	o:SetHeight(530)
	o:SetBackdrop({bgFile="Interface/DialogFrame/UI-DialogBox-Background",
           edgeFile="Interface/DialogFrame/UI-DialogBox-Border", tile="true", edgeSize=32, tileSize=32, insets = { left = 11, right = 12, top = 12, bottom = 11 }})

	o:SetParent("UIParent")
	o:SetPoint("CENTER")
	o:Hide()
	o:EnableMouse(true)
	o:EnableKeyboard(true)
	o.hideOnEscape = 1
	o:SetMovable(true)
	o:SetToplevel(true)

	--o:SetScript("OnEscapePressed", function)
	o:SetScript("OnDragStart", AskMrRobot.AmrUI.OnDragStart)
	o:SetScript("OnDragStop", AskMrRobot.AmrUI.OnDragStop)
	o:SetScript("OnHide", AskMrRobot.AmrUI.OnHide)
	-- make the UI show the first tab when its opened
	o:SetScript("OnShow", AskMrRobot.AmrUI.OnShow)

	o:RegisterEvent("AUCTION_HOUSE_CLOSED")
	o:RegisterEvent("AUCTION_HOUSE_SHOW")
	o:RegisterEvent("FORGE_MASTER_OPENED")
	o:RegisterEvent("FORGE_MASTER_CLOSED")
	o:RegisterEvent("SOCKET_INFO_UPDATE")
	o:RegisterEvent("SOCKET_INFO_CLOSE")

	o:SetScript("OnEvent", function(...)
		o:OnEvent(...)
	end)

	tinsert(UISpecialFrames, o:GetName())

	-- title
	o.title:SetText("Ask Mr Robot " .. GetAddOnMetadata(AskMrRobot.AddonName, "Version"))

	-- create the tab buttons
	o.buttons = o:createTabButtons()

	local tabArea = AskMrRobot.Frame:new(nil, o)
	tabArea:SetPoint("TOPLEFT", 140, -30)
	tabArea:SetPoint("BOTTOMRIGHT")	

	createImportDetailsErrorTab(tabArea)

	-- create the import tab and associated it with the import tab button
	o.importTab = AskMrRobot.ImportTab:new(tabArea)
	o.buttons[1].element = o.importTab	
	o.importTab.scrollFrame.EditBox:SetScript("OnEscapePressed", function()
		o:Hide()
	end)	

	o.importTab.button:SetScript("OnClick", function(...)
		o.summaryTab.importDate = date()
		AmrImportDate = o.summaryTab.importDate
		o:OnUpdate()
		if o.mostlySuccess then
			-- save import between sessions
			AmrImportString = o.importTab.scrollFrame.EditBox:GetText()
			AmrImportDate = o.summaryTab.importDate
		end
		o:ShowTab("summary")
	end)

	o.summaryTab = AskMrRobot.SummaryTab:new(tabArea)
	o.buttons[2].element = o.summaryTab

	o.gemTab = AskMrRobot.GemTab:new(nil, tabArea)
	o.buttons[3].element = o.gemTab

	o.enchantTab = AskMrRobot.EnchantTab:new(tabArea)
	o.buttons[4].element = o.enchantTab

	o.reforgeTab = AskMrRobot.ReforgesTab:new(tabArea)
	o.buttons[5].element = o.reforgeTab

	o.shoppingTab = AskMrRobot.ShoppingListTab:new(tabArea)
	o.buttons[6].element = o.shoppingTab

	o.shoppingTab.sendTo:SetScript("OnEscapePressed", function()
 		o:Hide()
  	end)

	o.exportTab = AskMrRobot.ExportTab:new(tabArea)
	o.buttons[7].element = o.exportTab

	o.helpTab = AskMrRobot.HelpTab:new(tabArea)
	o.buttons[8].element = o.helpTab

	o.isSocketWindowVisible = false
	o.isReforgeVisible = false
	o.isAuctionHouseVisible = false

	--hide the UI	
	o:Hide()

	o:ShowTab("import")	

	return o
end

function AskMrRobot.AmrUI:OnUpdate()
	local input = self.importTab.scrollFrame.EditBox:GetText()
	if input and input:len() > 0 then
		self:validateInput(input)
	end
end

function AskMrRobot.AmrUI:OnShow()
	self:OnUpdate()	
end

function AskMrRobot.AmrUI:OnDragStart()
	if not self.isLocked then
		self:StartMoving();
	end
end

function AskMrRobot.AmrUI:OnDragStop()
	self:StopMovingOrSizing()
end

function AskMrRobot.AmrUI:OnHide()
	self.visible = false
	self:StopMovingOrSizing()
end

function AskMrRobot.AmrUI:ShowReforgeFrame()
	self.visible = true
	self:Show()	
end

function AskMrRobot.AmrUI:Toggle()
	if self.visible then
		self:Hide()
	else
		self:ShowReforgeFrame()
	end
end

local nameToButtonNumber = {
	import = 1,
	summary = 2,
	gems = 3,
	enchants = 4,
	reforges = 5,
	shopping = 6,
	export = 7		
}

function AskMrRobot.AmrUI:ShowTab(tabName)
	local buttonNumber = nameToButtonNumber[tabName]
	if buttonNumber then
		self.buttons[buttonNumber]:Click()
	end
end

function AskMrRobot.AmrUI:OnEvent(frame, event, ...)
	local handler = self["On_" .. event]
	if handler then
		handler(self, ...)
	end
end

function AskMrRobot.AmrUI:On_AUCTION_HOUSE_SHOW()
	self.isAuctionHouseVisible = true
	if self.mostlySuccess then
		local showTab = self.visible
		if not AmrOptions.manualShowShop and not self.visible then

			-- show if there is anything to buy
			if self.shoppingTab:HasStuffToBuy() then
				self:Show()
				showTab = true
			end
		end

		if showTab then
			self:ShowTab("shopping")
		end
	end	
end

function AskMrRobot.AmrUI:On_AUCTION_HOUSE_CLOSED()
	self.isAuctionHouseVisible = false
	if self.isReforgeVisible then
		self:ShowTab("reforges")
	elseif self.isSocketWindowVisible then
		self:ShowTab("gems")
	end
end

function AskMrRobot.AmrUI:On_FORGE_MASTER_OPENED()
	self.isReforgeVisible = true
	if self.mostlySuccess then
		local showTab = self.visible
		if not AmrOptions.manualShowReforge and not self.visible then

			-- see if there are any reforges to do
			local reforgeCount = 0
			for slotNum, badReforge in pairs(AskMrRobot.itemDiffs.reforges) do
				reforgeCount = reforgeCount + 1
			end

			if reforgeCount > 0 then
				self:Show()
				showTab = true
			end
		end

		if showTab then
			self:ShowTab("reforges")
		end
	end
end

function AskMrRobot.AmrUI:On_FORGE_MASTER_CLOSED()
	self.isReforgeVisible = false
	if self.isAuctionHouseVisible then
		self:ShowTab("shopping")
	elseif self.isSocketWindowVisible then
		self:ShowTab("gems")
	end	
end

function AskMrRobot.AmrUI:On_SOCKET_INFO_UPDATE()
	self.isSocketWindowVisible = true
	if self.mostlySuccess then
		if not self.visible then
			self:Show()
		end
		self:ShowTab("gems")
	end
end

function AskMrRobot.AmrUI:On_SOCKET_INFO_CLOSE()
	self.isSocketWindowVisible = false
	if self.isAuctionHouseVisible then
		self:ShowTab("shopping")
	elseif self.isReforgeVisible then
		self:ShowTab("reforges")
	end
end