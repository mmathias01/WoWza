local addonName, addon = ...
--if not addon.healthCheck then return end
local L = addon.L

local wow_ver = select(4, GetBuildInfo())
local wow_500 = wow_ver >= 50000
local UIPanelButtonTemplate = wow_500 and "UIPanelButtonTemplate" or "UIPanelButtonTemplate2"

local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
frame.name = addonName
frame:Hide()

-- Credits to Ace3, Tekkub, cladhaire and Tuller for some of the widget stuff.

local function newCheckbox(label, description, onClick)
	local check = CreateFrame("CheckButton", "AmrCheck" .. label, frame, "InterfaceOptionsCheckButtonTemplate")
	check:SetScript("OnClick", function(self)
		PlaySound(self:GetChecked() and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		onClick(self, self:GetChecked() and true or false)
	end)
	check.label = _G[check:GetName() .. "Text"]
	check.label:SetText(label)
	check.tooltipText = label
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
	subtitle:SetText("Ask Mr Robot collects your item information and sends it to AskMrRobot.com for optimization")
	subTitleWrapper:SetHeight(subtitle:GetHeight())

	local autoPopup = newCheckbox(
		"Minimap Icon",
		"Show Ask Mr Robot Minimap Icon",
		function(self, value) 
			AmrHideMapIcon = not AmrHideMapIcon;
			AmrUpdateMinimap();
		end
	)
	autoPopup:SetChecked(not AmrHideMapIcon)
	autoPopup:SetPoint("TOPLEFT", subTitleWrapper, "BOTTOMLEFT", -2, -16)

	frame:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame)

