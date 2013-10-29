local _, AskMrRobot = ...

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

	local text2 = tab:CreateFontString(nil, "ARTWORK", "GameFontWhite")
	text2:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -20)
	text2:SetPoint("RIGHT", tab, "RIGHT", -25, -20)
	text2:SetWidth(text2:GetWidth())
	text2:SetText("Visit |c003333ffhttp://blog.askmrrobot.com/addon/|r  for a full tutorial and to ask questions.\r\r" ..
                  "|c00999999Q:|r Do I have to get a new text-string every time I need to optimize?\r" ..
                  '|c0066dd66A:|r Yes. Go to the website and click the green "Update from Armory" button to the left of your character to make sure you have the most up-to-date gear. Optimize your gear and then click the "Export to Addon" button to get your new text-string.\r\r' ..
				  "|c00999999Q:|r The belt buckle didn't show up in my list.\r" ..
                  "|c0066dd66A:|r Correct, it's actually quite hard to detect it's status in-game, believe it or not. But we're working on a clever way to detect it!\r\r"..
                  "|c00999999Q:|r My cogwheels/tinkers didn't show up.\r"..
                  "|c0066dd66A:|r Correct, we're working on adding those into the list as well... the problem is Mr. Robot has been using them to build other robots...\r\r"..
                  "|c00999999Q:|r Can I send my shopping list to an alt?\r"..
                  '|c0066dd66A:|r Yes, go to the shopping list tab and select the "mail" option in the drop down. You can mail the list to your alt.\r\r'..
                  "|c00999999Q:|r I am in the middle of a raid and just won a piece of loot. Can I optimize really quick\r"..
                  "|c0066dd66A:|r Yes! You'll want to read the tutorial on that here: |c003333ffhttp://blog.askmrrobot.com/addon#raid|r")
	--text2:SetHeight(100)
	text2:SetJustifyH("LEFT")

	return tab
end