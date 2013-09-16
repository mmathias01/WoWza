-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AuctionDB                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_auctiondb           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- load the parent file (TSM) into a local variable and register this file as a module
local TSM = select(2, ...)
local GUI = TSM:NewModule("GUI")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_AuctionDB") -- loads the localization table
	
local private = {}

function GUI:Show(frame)
	private.statusBar = private.statusBar or private:CreateStatusBar(frame.content)
	private.statusBar:Show()
	GUI:UpdateStatus("", 0, 0)
	
	private.startScanContent = private.startScanContent or private:CreateStartScanContent(frame.content)
	private.startScanContent:Show()
end

function GUI:Hide()
	private.statusBar:Hide()
	private.startScanContent:Hide()
	
	TSMAPI.AuctionScan:StopScan()
end

function GUI:UpdateStatus(text, major, minor)
	if text then
		private.statusBar:SetStatusText(text)
	end
	if major or minor then
		private.statusBar:UpdateStatus(major, minor)
	end
end

function private:CreateStatusBar(parent)
	local frame = TSMAPI.GUI:CreateStatusBar(parent, "TSMAuctionDBStatusBar")
	TSMAPI.GUI:CreateHorizontalLine(frame, -30, parent)
	
	return frame
end

function private:CreateStartScanContent(parent)
	local frame = CreateFrame("Frame", nil, parent)
	TSMAPI.Design:SetFrameBackdropColor(frame)
	frame:SetAllPoints(parent)
	frame:Hide()

	local function UpdateGetAllButton()
		if TSM.Scan:IsScanning() then
			frame:Disable()
		elseif not select(2, CanSendAuctionQuery()) then
			local previous = TSM.db.profile.lastGetAll or time()
			if previous > (time() - 15*60) then
				local diff = previous + 15*60 - time()
				local diffMin = math.floor(diff/60)
				local diffSec = diff - diffMin*60
				frame.getAllStatusText:SetText("|cff990000"..format(L["Ready in %s min and %s sec"], diffMin, diffSec))
			else
				frame.getAllStatusText:SetText("|cff990000"..L["Not Ready"])
			end
			frame:Enable()
			frame.startGetAllButton:Disable()
		else
			frame:Enable()
			frame.getAllStatusText:SetText("|cff009900"..L["Ready"])
			frame.startGetAllButton:Enable()
		end
	end
	
	frame:SetScript("OnShow", function(self)
			TSMAPI:CreateTimeDelay("auctionDBGetAllStatus", 0, UpdateGetAllButton, 0.2)
		end)
	
	frame:SetScript("OnHide", function(self)
			TSMAPI:CancelFrame("auctionDBGetAllStatus")
		end)
		
	frame.Enable = function(self)
		self.startGetAllButton:Enable()
		self.startFullScanButton:Enable()
	end

	frame.Disable = function(self)
		self.startGetAllButton:Disable()
		self.startFullScanButton:Disable()
	end
	
	-- 4th row (auto updater)
	local text = TSMAPI.GUI:CreateLabel(frame)
	text:SetFont(TSMAPI.Design:GetContentFont(), 20)
	text:SetPoint("CENTER", frame, "TOP", 0, -45)
	text:SetHeight(20)
	text:SetJustifyH("CENTER")
	text:SetJustifyV("CENTER")
	text:SetText(TSMAPI.Design:GetInlineColor("link")..L["Scanning the auction house in game is no longer necessary!"].."|r")
	local ag = text:CreateAnimationGroup()
	local a1 = ag:CreateAnimation("Alpha")
	a1:SetChange(-.4)
	a1:SetDuration(.5)
	ag:SetLooping("BOUNCE")
	ag:Play()
	
	local text = TSMAPI.GUI:CreateLabel(frame)
	text:SetPoint("TOPLEFT", 10, -60)
	text:SetPoint("TOPRIGHT", -10, -60)
	text:SetHeight(55)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("CENTER")
	text:SetText(format(L["Download the FREE TSM desktop application which will automatically update your TSM_AuctionDB prices using Blizzard's online APIs (and does MUCH more). Visit %s for more info and never scan the AH again! This is the best way to update your AuctionDB prices."], TSMAPI.Design:GetInlineColor("link").."http://tradeskillmaster.com/tsm_app".."|r"))

	TSMAPI.GUI:CreateHorizontalLine(frame, -125)
	
	local bar = TSMAPI.GUI:CreateVerticalLine(frame, 0)
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", 585, -125)
	bar:SetHeight(190)
	
	-- first row (getall scan)
	local text = TSMAPI.GUI:CreateLabel(frame)
	text:SetPoint("TOPLEFT", 10, -150)
	text:SetHeight(50)
	text:SetWidth(570)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("CENTER")
	text:SetText(L["A GetAll scan is the fastest in-game method for scanning every item on the auction house. However, there are many possible bugs on Blizzard's end with it including the chance for it to disconnect you from the game. Also, it has a 15 minute cooldown."])
	
	local btn = TSMAPI.GUI:CreateButton(frame, 18)
	btn:SetPoint("TOPLEFT", 595, -160)
	btn:SetHeight(22)
	btn:SetWidth(205)
	btn:SetScript("OnClick", TSM.Scan.StartGetAllScan)
	btn:SetText(L["Run GetAll Scan"])
	frame.startGetAllButton = btn
	
	local text = TSMAPI.GUI:CreateLabel(frame)
	text:SetPoint("TOPLEFT", 595, -185)
	text:SetHeight(16)
	text:SetWidth(205)
	text:SetJustifyH("CENTER")
	text:SetJustifyV("CENTER")
	frame.getAllStatusText = text
	
	TSMAPI.GUI:CreateHorizontalLine(frame, -215)
	
	
	-- second row (full scan)
	local text = TSMAPI.GUI:CreateLabel(frame)
	text:SetPoint("TOPLEFT", 10, -240)
	text:SetHeight(50)
	text:SetWidth(570)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("CENTER")
	text:SetText(L["A full auction house scan will scan every item on the auction house but is far slower than a GetAll scan. Expect this scan to take several minutes or longer."])
	
	local btn = TSMAPI.GUI:CreateButton(frame, 18)
	btn:SetPoint("TOPLEFT", 595, -260)
	btn:SetHeight(22)
	btn:SetWidth(205)
	btn:SetScript("OnClick", TSM.Scan.StartFullScan)
	btn:SetText(L["Run Full Scan"])
	frame.startFullScanButton = btn
	
	return frame
end