-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- This file contains all the APIs regarding TSM's main frame (what shows when you type '/tsm').

local TSM = select(2, ...)
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster") -- loads the localization table
local AceGUI = LibStub("AceGUI-3.0") -- load the AceGUI libraries

local private = {icons={}, currentIcon=0}
local lib = TSMAPI


--- Opens the main TSM window.
function TSMAPI:OpenFrame()
	TSM.Frame:Show()
	if #TSM.Frame.children > 0 then
		TSM.Frame:ReleaseChildren()
	else
		TSMAPI:SelectIcon("TradeSkillMaster", L["TSM Status / Options"])
	end
	if TSM.db.global.infoMessage < 1001 then
		TSM.db.global.infoMessage = 1001
		StaticPopupDialogs["TSM_INFO_MESSAGE"] = StaticPopupDialogs["TSM_INFO_MESSAGE"] or {
			text = format(L["More advanced options are now designated by %sred text|r. Beginners are encourages to come back to these once they have a solid understanding of the basics."], TSMAPI.Design:GetInlineColor("advanced")),
			button1 = OKAY,
			OnAccept = function()
				TSM:Printf(L["More advanced options are now designated by %sred text|r. Beginners are encourages to come back to these once they have a solid understanding of the basics."], TSMAPI.Design:GetInlineColor("advanced"))
			end,
			timeout = 0,
			preferredIndex = 3,
		}
		TSMAPI:ShowStaticPopupDialog("TSM_INFO_MESSAGE")
	end
end

--- Closes the main TSM window.
function TSMAPI:CloseFrame()
	TSM.Frame:Hide()
end

function TSM:RegisterMainFrameIcon(displayName, icon, loadGUI, moduleName, side)
	if not (displayName and icon and loadGUI and moduleName) then
		return nil, "invalid args", displayName, icon, loadGUI, moduleName
	end
	
	if side and not (side == "module" or side == "crafting" or side == "options") then
		return nil, "invalid side", side
	end
	
	local icon = {name=displayName, moduleName=moduleName, icon=icon, loadGUI=loadGUI, side=(strlower(side or "module"))}
	if TSM.Frame then
		icon.texture = icon.icon
		if icon.side == "crafting" then
			icon.where = "bottom"
		elseif icon.side == "options" then
			icon.where = "topLeft"
		else
			icon.where = "topRight"
		end
		
		TSM.Frame:AddIcon(icon)
	end
	
	tinsert(private.icons, icon)
end

--- Selects an icon in the main TSM window once it's open.
-- @param moduleName Which module the icon belongs to (unlocalized).
-- @param iconName The text that shows in the tooltip of the icon to be clicked (localized).
-- @return Returns an error message as the second return value upon error.
function TSMAPI:SelectIcon(moduleName, iconName)
	if not moduleName then return nil, "no moduleName passed" end
	
	for _, data in ipairs(private.icons) do
		if data.moduleName == moduleName and data.name == iconName then
			data.frame:Click()
		end
	end
end

function TSMAPI:ShowOperationOptions(moduleName, operation, groupPath)
	TSMAPI:OpenFrame()
	TSM.loadModuleOptionsTab = {module=moduleName, operation=operation, group=groupPath}
	TSMAPI:SelectIcon("TradeSkillMaster", L["Module Operations / Options"])
	TSM.loadModuleOptionsTab = nil
end


function TSM:CreateMainFrame()
	local mainFrame = AceGUI:Create("TSMMainFrame")
	local version = TSM._version
	if strfind(version, "@") then version = "Dev" end
	mainFrame:SetIconText(version)
	mainFrame:SetIconLabels(L["Options"], L["Modules"])
	mainFrame:SetLayout("Fill")
	mainFrame:SetWidth(823)
	mainFrame:SetHeight(686)
	mainFrame.frame:SetFrameStrata("MEDIUM")
	mainFrame.frame:SetWidth(823)
	mainFrame.frame:SetHeight(686)
	
	for _, icon in ipairs(private.icons) do
		icon.texture = icon.icon
		if icon.side == "crafting" then
			icon.where = "bottom"
		elseif icon.side == "options" then
			icon.where = "topLeft"
		else
			icon.where = "topRight"
		end
		
		mainFrame:AddIcon(icon)
	end
	TSM.Frame = mainFrame
	
	TSMAPI:CreateTimeDelay("mainFrameSize", .5, function() mainFrame:SetWidth(823) mainFrame:SetHeight(686) end)
end