local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local frame = MissingLootFrame
	local close = MissingLootFramePassButton

	frame:StripTextures()
	frame:SetTemplate("Default")
	frame:CreateShadow()

	MissingLootFramePassButton:SkinCloseButton()
	
	local function SkinButton()
		local number = GetNumMissingLootItems()
		for i = 1, number do
			local slot = _G["MissingLootFrameItem"..i]
			local icon = slot.icon
			
			if not slot.isSkinned then
				slot:StripTextures()
				slot:SetTemplate("Default")
				slot:StyleButton()
				icon:SetTexCoord(.08, .92, .08, .92)
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)
				
				slot.isSkinned = true
			end
			
			local quality = select(4, GetMissingLootItemInfo(i))
			local color = (GetItemQualityColor(quality)) or (unpack(C.media.bordercolor))
			frame:SetBackdropBorderColor(color)
		end
	end
	hooksecurefunc("MissingLootFrame_Show", SkinButton)
	
	-- loot history frame
	LootHistoryFrame:StripTextures()
	LootHistoryFrame.CloseButton:SkinCloseButton()
	LootHistoryFrame:StripTextures()
	LootHistoryFrame:SetTemplate()
	LootHistoryFrame.ResizeButton:SkinCloseButton()
	LootHistoryFrame.ResizeButton.t:SetText("v v v v")
	LootHistoryFrame.ResizeButton:SetTemplate()
	LootHistoryFrame.ResizeButton:Width(LootHistoryFrame:GetWidth())
	LootHistoryFrame.ResizeButton:Height(19)
	LootHistoryFrame.ResizeButton:ClearAllPoints()
	LootHistoryFrame.ResizeButton:Point("TOP", LootHistoryFrame, "BOTTOM", 0, -2)
	LootHistoryFrameScrollFrameScrollBar:SkinScrollBar()
	
	local function UpdateLoots(self)
		local numItems = C_LootHistory.GetNumItems()
		for i=1, numItems do
			local frame = self.itemFrames[i]
			
			if not frame.isSkinned then
				frame.NameBorderLeft:Hide()
				frame.NameBorderRight:Hide()
				frame.NameBorderMid:Hide()
				frame.IconBorder:Hide()
				frame.Divider:Hide()
				frame.ActiveHighlight:Hide()
				frame.Icon:SetTexCoord(.08,.88,.08,.88)
				frame.Icon:SetDrawLayer("ARTWORK")
				
				-- create a backdrop around the icon
				frame:CreateBackdrop("Default")
				frame.backdrop:Point("TOPLEFT", frame.Icon, -2, 2)
				frame.backdrop:Point("BOTTOMRIGHT", frame.Icon, 2, -2)
				frame.backdrop:SetBackdropColor(0,0,0,0)
				frame.isSkinned = true
			end
		end
	end
	hooksecurefunc("LootHistoryFrame_FullUpdate", UpdateLoots)
	
	-- master loot frame
	MasterLooterFrame:StripTextures()
	MasterLooterFrame:SetTemplate()
	
	hooksecurefunc("MasterLooterFrame_Show", function()
		local b = MasterLooterFrame.Item
		if b then
			local i = b.Icon
			local icon = i:GetTexture()
			local c = ITEM_QUALITY_COLORS[LootFrame.selectedQuality]
			
			b:StripTextures()
			i:SetTexture(icon)
			i:SetTexCoord(.1,.9,.1,.9)
			b:CreateBackdrop()
			b.backdrop:SetOutside(i)
			b.backdrop:SetBackdropBorderColor(c.r, c.g, c.b)
		end
		
		for i=1, MasterLooterFrame:GetNumChildren() do
			local child = select(i, MasterLooterFrame:GetChildren())
			if child and not child.isSkinned and not child:GetName() then
				if child:GetObjectType() == "Button" then
					if child:GetPushedTexture() then
						child:SkinCloseButton()
					else
						child:SetTemplate()
						child:StyleButton()		
					end
					child.isSkinned = true
				end
			end
		end
	end)
	
	-- bonus
	BonusRollFrame:StripTextures()
	BonusRollFrame:CreateBackdrop()
	BonusRollFrame.backdrop:SetFrameLevel(0)
	BonusRollFrame.PromptFrame.Icon:SetTexCoord(.1,.9,.1,.9)
	BonusRollFrame.PromptFrame.IconBackdrop = CreateFrame("Frame", nil, BonusRollFrame.PromptFrame)
	BonusRollFrame.PromptFrame.IconBackdrop:SetFrameLevel(BonusRollFrame.PromptFrame.IconBackdrop:GetFrameLevel() - 1)
	BonusRollFrame.PromptFrame.IconBackdrop:SetOutside(BonusRollFrame.PromptFrame.Icon)
	BonusRollFrame.PromptFrame.IconBackdrop:SetTemplate()
	BonusRollFrame.PromptFrame.Timer.Bar:SetTexture(75/255,  175/255, 76/255)
	BonusRollFrame.PromptFrame.Timer.Bar:SetVertexColor(75/255,  175/255, 76/255)
	BonusRollFrame.BlackBackgroundHoist:StripTextures()
	BonusRollFrame.PromptFrame.Timer:CreateBackdrop()
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)