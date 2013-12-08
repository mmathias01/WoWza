local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local VAT = E:GetModule('VisualAuraTimers')
local A = E:GetModule('Auras');
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, ns = ...

local inversePoints = {
	TOP = 'BOTTOM',
	BOTTOM = 'TOP',
	LEFT = 'RIGHT',
	RIGHT = 'LEFT',
}

function VAT:CreateBar(button)
	if not button.Holder then
		local width = button:GetWidth();
		local height = button:GetHeight();
		local pos = E.db.VAT.position;
		local isOnTop = pos == 'TOP' and true or false;
		local isOnBottom = pos == 'BOTTOM' and true or false;
		local isOnLeft = pos == 'LEFT' and true or false;
		local isOnRight = pos == 'RIGHT' and true or false;
		
		-- Border
		local BarHolder = CreateFrame('Frame', nil, button)
		BarHolder:Width((isOnTop or isOnBottom) and width or (E.db.VAT.barWidth + (E.PixelMode and 0 or 2)))
		BarHolder:Height((isOnLeft or isOnRight) and height or (E.db.VAT.barHeight + (E.PixelMode and 0 or 2)))
		BarHolder:Point(inversePoints[pos], button, pos, (isOnTop or isOnBottom) and 0 or ((isOnLeft and -(E.PixelMode and 1 or 3)) or (E.PixelMode and 1 or 3)), (isOnLeft or isOnRight) and 0 or ((isOnTop and (E.PixelMode and 1 or 3) or -(E.PixelMode and 1 or 3))))
		BarHolder:SetTemplate('Default')
		button.Holder = BarHolder

		-- Statusbar
		local Bar = CreateFrame('StatusBar', nil, BarHolder)
		Bar:SetInside(BarHolder)
		Bar:SetStatusBarTexture(E['media'].blankTex)
		if E.db.VAT.enableStaticColor then
			local r, g, b = unpack(E.db.VAT.staticColor)
			Bar:SetStatusBarColor(r, g, b)
		else
			Bar:SetStatusBarColor(0, 0.8, 0)
		end
		if isOnLeft or isOnRight then
			Bar:SetOrientation('VERTICAL')
		end
		button.Bar = Bar
	end
end

function VAT:UpdateAura(button, index)
	local enable = E.db.VAT.enable
	local enableThreshold = E.db.VAT.tenable
	local noduration = E.db.VAT.noduration
	local buffs = E.db.VAT.threshold.buffs
	local debuffs = E.db.VAT.threshold.debuffs
	local buffsvalue = E.db.VAT.threshold.buffsvalue
	local debuffsvalue = E.db.VAT.threshold.debuffsvalue
	local showText = E.db.VAT.showText
	local timeLeft = button.timeLeft
	local isDebuff
	
	local filter = button:GetParent():GetAttribute('filter')
	local unit = button:GetParent():GetAttribute("unit")
	local name, _, _, _, dtype, duration, expiration = UnitAura(unit, index, filter)
	if(name) then
		if UnitBuff('player',name) then
			isDebuff = false
		elseif UnitDebuff('player',name) then
			isDebuff = true
		end
	
		if filter == 'HARMFUL' then
			local color = DebuffTypeColor[dtype or ""]
			-- Match color of statusbar border to color of the border of the debuff aura
			button.Holder:SetBackdropBorderColor(color.r * 3/5, color.g * 3/5, color.b * 3/5)
		else
			button.Holder:SetBackdropBorderColor(unpack(E.media.bordercolor))
		end

		-- Set min / max values
		if (button.Bar and duration > 0 and expiration) then
			button.Bar:SetMinMaxValues(0, duration)
		else
			-- Make sure a full statusbar is shown if aura has no duration
			local min, max  = button.Bar:GetMinMaxValues()
			button.Bar:SetValue(max)
			if E.db.VAT.enableStaticColor then
				local color = E.db.VAT.staticColor
				button.Bar:SetStatusBarColor(color.r, color.g, color.b)
			else
				button.Bar:SetStatusBarColor(0, 0.8, 0)
			end
		end
	end

	-- Toggle Visual Timer and Text Timer
	-- For auras with no duration
	if not timeLeft then
		if enable then -- Toggle visual timer
			-- If 'No Duration' is disabled then hide statusbar on auras with no duration
			if not noduration then
				button.Holder:Hide()
			else
				button.Holder:Show()
			end
		else -- Disable visual timer
			button.Holder:Hide()
		end
	else -- For auras with a duration
		if enable then -- Toggle visual timer
			button.Holder:Show()
			if showText then
				button.time:Show()
			else
				button.time:Hide()
				-- If aura duration goes below threshold then toggle to text
				if enableThreshold then
					-- Buffs
					if buffs and timeLeft <= buffsvalue and duration > 0 and isDebuff == false then
						button.Holder:Hide()
						button.time:Show()
					-- Debuffs
					elseif debuffs and timeLeft <= debuffsvalue and duration > 0 and isDebuff == true then
						button.Holder:Hide()
						button.time:Show()
					else
						button.Holder:Show()
						button.time:Hide()
					end
				end
			end
		else -- Toggle to text only
			button.Holder:Hide()
			button.time:Show()
		end

		-- Set color and value of statusbar
		local r, g, b
		button.Bar:SetValue(timeLeft)
		if E.db.VAT.enableStaticColor then
			local color = E.db.VAT.staticColor
			r, g, b = color.r, color.g, color.b
		else
			r, g, b = ElvUF.ColorGradient(timeLeft, duration or 0, 0.8,0,0,0.8,0.8,0,0,0.8,0)
		end
		button.Bar:SetStatusBarColor(r, g, b)
	end
end

function VAT:UpdateTempEnchant(button, index)
	local quality = GetInventoryItemQuality("player", index)
	local enable = E.db.VAT.enable
	local enableThreshold = E.db.VAT.tenable
	local tempenchants = E.db.VAT.threshold.tempenchants
	local tempenchantsvalue = E.db.VAT.threshold.tempenchantsvalue
	local noduration = E.db.VAT.noduration
	local showText = E.db.VAT.showText
	local timeLeft = button.timeLeft
	local duration

	-- Here we try to figure out the maximum duration of the weapon enchant
	-- If less than 1 hour and higher than 30 minutes set max duration to 1 hour
	if timeLeft <= 3600.5 and timeLeft > 1800.5 then
		duration = 3600
	-- if less than 30 minutes and higher than 10 minutes set max duration to 30 minutes
	elseif timeLeft <= 1800.5 and timeLeft > 600.5 then
		duration = 1800
	--if less than 10 minutes and higher than 0 seconds set max duration to 10 minutes
	elseif timeLeft <= 600.5 and timeLeft > 0 then
		duration = 600
	end

	-- Set min / max values
	if (button.Bar and duration) then
		button.Bar:SetMinMaxValues(0, duration)
	else
		-- Make sure a full statusbar is shown if Temp. Enchant has no duration (none that I know of, but might be in the future)
		local min, max  = button.Bar:GetMinMaxValues()
		button.Bar:SetValue(max)
		if E.db.VAT.enableStaticColor then
			local color = E.db.VAT.staticColor
			button.Bar:SetStatusBarColor(color.r, color.g, color.b)
		else
			button.Bar:SetStatusBarColor(0, 0.8, 0)
		end
	end
	
	-- Apparently 'totems' are calling updates here, prevent errors by checking if holder is created
	if button.Holder then
		-- Toggle Visual Timer and Text Timer
		-- For auras with no duration
		if not timeLeft then
			if enable then -- Toggle visual timer
				-- If 'No Duration' is disabled then hide statusbar on auras with no duration
				if not noduration then
					button.Holder:Hide()
				else
					button.Holder:Show()
				end
			else -- Disable visual timer
				button.Holder:Hide()
			end
		else -- For auras with a duration
			if enable then -- Toggle visual timer
				button.Holder:Show()
				if showText then
					button.time:Show()
				else
					button.time:Hide()
					-- If aura duration goes below threshold then toggle to text
					if enableThreshold and tempenchants and timeLeft <= tempenchantsvalue then
						button.Holder:Hide()
						button.time:Show()
					else
						button.Holder:Show()
						button.time:Hide()
					end
				end
			else --Toggle to text only
				button.Holder:Hide()
				button.time:Show()
			end
			
			-- Set color and value of statusbar and match color of statusbar border to color of the aura border
			local r, g, b
			button.Bar:SetValue(timeLeft)
			if E.db.VAT.enableStaticColor then
				local color = E.db.VAT.staticColor
				r, g, b = color.r, color.g, color.b
			else
				r, g, b = ElvUF.ColorGradient(timeLeft, duration or 0, 0.8,0,0,0.8,0.8,0,0,0.8,0)
			end
			button.Bar:SetStatusBarColor(r, g, b)
			if (quality) then
				button.Holder:SetBackdropBorderColor(GetItemQualityColor(quality))
			end
		end
	end
end

function VAT:OnInitialize()
	-- Register callback with LibElvUIPlugin
	EP:RegisterPlugin(addon, VAT.InsertOptions)

	--ElvUI Auras are not enabled, stop right here!
	if E.private.auras.enable ~= true then return; end

	hooksecurefunc(A, 'CreateIcon', VAT.CreateBar)
	hooksecurefunc(A, 'UpdateAura', VAT.UpdateAura)
	hooksecurefunc(A, 'UpdateTempEnchant', VAT.UpdateTempEnchant)
end
