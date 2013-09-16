-- initialize the ExportTab class
AskMrRobot.ExportTab = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

function AskMrRobot.ExportTab:new(parent)

	local tab = AskMrRobot.Frame:new(nil, parent)	
	setmetatable(tab, { __index = AskMrRobot.ExportTab })
	tab:SetPoint("TOPLEFT")
	tab:SetPoint("BOTTOMRIGHT")
	tab:Hide()

	local text = tab:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	text:SetPoint("TOPLEFT", 0, -5)
	text:SetText("Export Gear for Best in Bags")

	local text2 = tab:CreateFontString(nil, "ARTWORK", "GameFontWhite")
	text2:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -20)
	text2:SetPoint("RIGHT", tab, "RIGHT", -25, 0)
	text2:SetWidth(text2:GetWidth())
	text2:SetText("Mr. Robot can find the best set of gear from items you own. So all of those extra rings or belts you're carrying around, might be put to good use. Offspec sets are also calculated!\r\r\r1. Open your bank.\r\r2. Click the export button (this updates the askmrrobot.lua file)")
	text2:SetHeight(100)
	text2:SetJustifyH("LEFT")

	local btn = CreateFrame("Button", "AmrImportButton", tab, "UIPanelButtonTemplate")
	btn:SetPoint("TOPLEFT", text2, "BOTTOMLEFT", 12, -20)
	btn:SetText("Export Bag & Bank Items")
	btn:SetWidth(180)
	btn:SetHeight(20)
	tab.button = btn

	local text3 = tab:CreateFontString(nil, "ARTWORK", "GameFontWhite")
	text3:SetPoint("TOP", btn, "BOTTOM", 0, -20)
	text3:SetPoint("LEFT", text2, "LEFT", 0, -20)
	text3:SetPoint("RIGHT", tab, "RIGHT", -25, 0)
	text3:SetWidth(text2:GetWidth())
	text3:SetText("3. Update the data on Ask Mr. Robot's website:")
	text3:SetJustifyH("LEFT")

	local text4 = tab:CreateFontString(nil, "ARTWORK", "GameFontWhite")
	text4:SetTextColor(.5,.5,.5)
	text4:SetPoint("TOPLEFT", text3, "BOTTOMLEFT", 12, -20)
	text4:SetPoint("RIGHT", tab, "RIGHT", -25, 0)
	text4:SetWidth(text2:GetWidth())
	text4:SetText("Look for the Add-On section on AskMrRobot.com, to the right of your character name.  If you have the desktop application installed, click the 'refresh' button.  Otherwise, click 'Import' to upload your askmrrobot.lua file.")
	text4:SetJustifyH("LEFT")


	local image = tab:CreateTexture(nil, "BACKGROUND")
	image:SetPoint("TOPLEFT", text4, "BOTTOMLEFT", 0, -20)
	image:SetTexture("Interface\\AddOns\\AskMrRobot\\Media\\BiBScreen")

	return tab
end