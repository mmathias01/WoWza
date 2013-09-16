-- initialize the HelpTab class
AskMrRobot.HelpTab = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

function AskMrRobot.HelpTab:new(parent)

	local tab = AskMrRobot.Frame:new(nil, parent)
	setmetatable(tab, { __index = AskMrRobot.HelpTab })
	tab:SetPoint("TOPLEFT")
	tab:SetPoint("BOTTOMRIGHT")
	tab:Hide()

	local text = tab:CreateFontString("AmrHelpText1", "ARTWORK", "GameFontNormalLarge")
	text:SetPoint("TOPLEFT", 0, -5)
	text:SetText("Help")
	return tab
end