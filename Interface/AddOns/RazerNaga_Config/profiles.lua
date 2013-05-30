--[[
	A profile selector panel
--]]

local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config')
local _G = getfenv(0)

--profile options
local NUM_ITEMS = 19
local width, height, offset = 580, 22, 2


--[[ Profile Button ]]--

local function ProfileButton_OnClick(self)
	local parent = self:GetParent()
	if parent.selected then
		parent.selected:UnlockHighlight()
	end
	self:LockHighlight()
	parent.selected = self
end

local function ProfileButton_Create(name, parent)
	local button = CreateFrame('Button', name, parent)
	button:SetWidth(width)
	button:SetHeight(height)
	button:SetScript('OnClick', ProfileButton_OnClick)

	local text = button:CreateFontString(nil, nil, 'GameFontNormalLarge')
	text:SetJustifyH('LEFT')
	text:SetAllPoints(button)
	button:SetFontString(text)
	button:SetHighlightFontObject('GameFontHighlightLarge')

	local highlight = button:CreateTexture()
	highlight:SetAllPoints(button)
	highlight:SetTexture('Interface/QuestFrame/UI-QuestTitleHighlight')
	button:SetHighlightTexture(highlight)

	return button
end


--[[ Panel Functions ]]--

local function Panel_UpdateList(self)
	local list = RazerNaga.db:GetProfiles()
	local size = #list
	table.sort(list)

	local scrollFrame = self.scrollFrame
	local offset = scrollFrame.offset
	FauxScrollFrame_Update(scrollFrame, size, NUM_ITEMS, height + offset)

	for i = 1, NUM_ITEMS do
		local index = i + offset
		local button = self.buttons[i]

		if index <= size then
			button:SetText(list[index])
			button:Show()
		else
			button:Hide()
		end
	end
end

local function Panel_Highlight(self, profile)
	local profile = profile or RazerNaga.db:GetCurrentProfile()

	for _,button in pairs(self.buttons) do
		if(button:GetText() == profile) then
			button:SetNormalFontObject('GameFontGreenLarge')
			button:SetHighlightFontObject('GameFontGreenLarge')
		else
			button:SetNormalFontObject('GameFontNormalLarge')
			button:SetHighlightFontObject('GameFontHighlightLarge')
		end
	end
end

--[[ Make the Panel ]]--

local function Panel_CreatePopupDialog(panel)
	return {
		text = L.EnterName,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 24,
		OnAccept = function(self)
			local text = _G[self:GetName()..'EditBox']:GetText()
			if text ~= '' then
				RazerNaga:SaveProfile(text)
				panel:UpdateList()
				panel:Highlight(text)
			end
		end,
		EditBoxOnEnterPressed = function(self)
			local text = self:GetText()
			if text ~= '' then
				RazerNaga:SaveProfile(text)
				panel:UpdateList()
				panel:Highlight(text)
			end
			self:GetParent():Hide()
		end,
		OnShow = function(self)
			_G[self:GetName()..'EditBox']:SetFocus()
			_G[self:GetName()..'EditBox']:SetText(UnitName('player'))
			_G[self:GetName()..'EditBox']:HighlightText()
		end,
		OnHide = function(self)
			_G[self:GetName()..'EditBox']:SetText('')
		end,
		timeout = 0, exclusive = 1, hideOnEscape = 1
	}
end

do
	local panel = RazerNaga.Options:NewPanel(L.Profiles, L.ProfilesPanelDesc)
	panel.UpdateList = Panel_UpdateList
	panel.Highlight = Panel_Highlight

	local name = panel:GetName()

	panel:SetScript('OnShow', function(self)
		self:UpdateList()
		self:Highlight()
	end)

	local scroll = CreateFrame('ScrollFrame', name .. 'ScrollFrame', panel, 'FauxScrollFrameTemplate')
	scroll:SetScript('OnVerticalScroll', function(self, arg1) 
		FauxScrollFrame_OnVerticalScroll(self, arg1, height + offset, function() panel:UpdateList() panel:Highlight() end) 
	end)
	scroll:SetScript('OnShow', function(self) panel.buttons[1]:SetWidth(width) end)
	scroll:SetScript('OnHide', function() panel.buttons[1]:SetWidth(width + 20) end)
	scroll:SetPoint('TOPLEFT', 6, -70)
	scroll:SetPoint('BOTTOMRIGHT', -28, 34)
	panel.scrollFrame = scroll

	local set = panel:NewButton(L.Set, 64, 22)
	set:SetScript('OnClick', function()
		local selected = panel.selected
		if selected then
			RazerNaga:SetProfile(selected:GetText())
			panel:UpdateList()
			panel:Highlight(selected:GetText())
		end
	end)
	set:SetPoint('BOTTOMLEFT', 10, 10)

	local save = panel:NewButton(L.Save, 64, 22)
	save:SetScript('OnClick', function() StaticPopup_Show('RazerNaga_OPTIONS_SAVE_PROFILE') end)
	save:SetPoint('LEFT', set, 'RIGHT', 4, 0)

	local copy = panel:NewButton(L.Copy, 64, 22)
	copy:SetScript('OnClick', function()
		local selected = panel.selected
		if selected then
			RazerNaga:CopyProfile(selected:GetText())
		end
	end)
	copy:SetPoint('LEFT', save, 'RIGHT', 4, 0)

	local delete = panel:NewButton(L.Delete, 64, 22)
	delete:SetScript('OnClick', function()
		local selected = panel.selected
		if selected then
			RazerNaga:DeleteProfile(selected:GetText())
			panel:UpdateList()
			panel:Highlight()
		end
	end)
	delete:SetPoint('LEFT', copy, 'RIGHT', 4, 0)

	--add list buttons
	panel.buttons = {}
	for i = 1, NUM_ITEMS do
		local button = ProfileButton_Create(name .. i, panel)
		if i == 1 then
			button:SetPoint('TOPLEFT', 14, -72)
		else
			button:SetPoint('TOPLEFT', name .. i-1, 'BOTTOMLEFT', 0, -offset)
			button:SetPoint('TOPRIGHT', name .. i-1, 'BOTTOMRIGHT', 0, -offset)
		end
		panel.buttons[i] = button
	end

	StaticPopupDialogs['RazerNaga_OPTIONS_SAVE_PROFILE'] = Panel_CreatePopupDialog(panel)
end