local addonName, AskMrRobot = ...

--if not addon.healthCheck then return end
local L = AskMrRobot.L

local wow_ver = select(4, GetBuildInfo())
local wow_500 = wow_ver >= 50000
local UIPanelButtonTemplate = wow_500 and "UIPanelButtonTemplate" or "UIPanelButtonTemplate2"

local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
frame.name = addonName
frame:Hide()

-- Credits to Ace3, Tekkub, cladhaire and Tuller for some of the widget stuff.

local function newCheckbox(label, tooltipTitle, description, onClick)
	local check = CreateFrame("CheckButton", "AmrCheck" .. label, frame, "InterfaceOptionsCheckButtonTemplate")
	check:SetScript("OnClick", function(self)
		PlaySound(self:GetChecked() and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		onClick(self, self:GetChecked() and true or false)
	end)
	check.label = _G[check:GetName() .. "Text"]
	check.label:SetText(label)
	check.tooltipText = tooltipTitle
	check.tooltipRequirement = description
	return check
end

frame:SetScript("OnShow", function(frame)
	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(addonName)

	local subTitleWrapper = CreateFrame("Frame", nil, frame)
	subTitleWrapper:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subTitleWrapper:SetPoint("RIGHT", -16, 0)
	local subtitle = subTitleWrapper:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetPoint("TOPLEFT", subTitleWrapper)
	subtitle:SetWidth(subTitleWrapper:GetRight() - subTitleWrapper:GetLeft())
	subtitle:SetJustifyH("LEFT")
	subtitle:SetNonSpaceWrap(false)
	subtitle:SetJustifyV("TOP")
	subtitle:SetText("Mr. Robot's addon can export your item information to his website, and import your optimizations into the game.")
	subTitleWrapper:SetHeight(subtitle:GetHeight())

	local autoPopup = newCheckbox(
		"Show minimap icon",
		"Minimap Icon",
		"Show the Ask Mr. Robot minimap icon.",
		function(self, value) 
			if AmrOptions.hideMapIcon then
				AmrOptions.hideMapIcon = false
			else
				AmrOptions.hideMapIcon = true
			end
			AskMrRobot.AmrUpdateMinimap();
		end
	)
	autoPopup:SetChecked(not AmrOptions.hideMapIcon)
	autoPopup:SetPoint("TOPLEFT", subTitleWrapper, "BOTTOMLEFT", -2, -16)

	local autoReforge = newCheckbox(
		"Automatically show Mr. Robot's reforge window at the reforger",
		"Auto-Show Reforges",
		"When you have suggested reforges left to complete, automatically show Mr. Robot's reforge window when you visit a reforger.",
		function(self, value) 
			if AmrOptions.manualShowReforge then
				AmrOptions.manualShowReforge = false
			else
				AmrOptions.manualShowReforge = true
			end
		end
	)
	autoReforge:SetChecked(not AmrOptions.manualShowReforge)
	autoReforge:SetPoint("TOPLEFT", subTitleWrapper, "BOTTOMLEFT", -2, -52)

	local autoAh = newCheckbox(
		"Automatically show Mr. Robot's shopping list at the auction house",
		"Auto-Show Shopping List",
		"When your shopping list still has things left to buy, automatically show Mr. Robot's shopping list when you visit the auction house.",
		function(self, value) 
			if AmrOptions.manualShowShop then
				AmrOptions.manualShowShop = false
			else
				AmrOptions.manualShowShop = true
			end
		end
	)
	autoAh:SetChecked(not AmrOptions.manualShowShop)
	autoAh:SetPoint("TOPLEFT", subTitleWrapper, "BOTTOMLEFT", -2, -88)
    

	frame:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame)

