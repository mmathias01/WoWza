local T, C, L, G = unpack(select(2, ...)) 
if C.unitframes.enable ~= true or T.myclass ~= "SHAMAN" then return end
--[[
	Documentation:
	
		Element handled:
			.TotemBar (must be a table with statusbar inside)
		
		.TotemBar only:
			.delay : The interval for updates (Default: 0.1)
			.colors : The colors for the statusbar, depending on the totem
			.Name : The totem name
			.Destroy (boolean): Enables/Disable the totem destruction on right click
			
			NOT YET IMPLEMENTED
			.Icon (boolean): If true an icon will be added to the left or right of the bar
			.IconSize : If the Icon is enabled then changed the IconSize (default: 8)
			.IconJustify : any anchor like "TOPLEFT", "BOTTOMRIGHT", "TOP", etc
			
		.TotemBar.bg only:
			.multiplier : Sets the multiplier for the text or the background (can be two differents multipliers)

--]]
local _, ns = ...
local oUF = ns.oUF or oUF

if not oUF then return end

local _, pClass = UnitClass("player")
local total = 0
local delay = 0.01

-- In the order, fire, earth, water, air
local colors = {
	[1] = {.58,.23,.10},
	[2] = {.23,.45,.13},		
	[3] = {.19,.48,.60},
	[4] = {.42,.18,.74},	
}

local GetTotemInfo, SetValue, GetTime = GetTotemInfo, SetValue, GetTime
	
local Abbrev = function(name)	
	return (string.len(name) > 10) and string.gsub(name, "%s*(.)%S*%s*", "%1. ") or name
end
	
local function UpdateSlot(self, slot)
	local totem = self.TotemBar
	if not totem[slot] then return end

	local haveTotem, name, startTime, duration, totemIcon = GetTotemInfo(slot)

	totem[slot]:SetStatusBarColor(unpack(totem.colors[slot]))
	totem[slot]:SetValue(0)
	
	-- Multipliers
	if (totem[slot].bg.multiplier) then
		local mu = totem[slot].bg.multiplier
		local r, g, b = totem[slot]:GetStatusBarColor()
		r, g, b = r*mu, g*mu, b*mu
		totem[slot].bg:SetVertexColor(r, g, b) 
	end
	
	totem[slot].ID = slot
	
	-- If we have a totem then set his value 
	if(haveTotem) then
		
		if totem[slot].Name then
			totem[slot].Name:SetText(Abbrev(name))
		end					
		if(duration > 0) then	
			totem[slot]:SetValue(1 - ((GetTime() - startTime) / duration))	
			-- Status bar update
			totem[slot]:SetScript("OnUpdate",function(self,elapsed)
					total = total + elapsed
					if total >= delay then
						total = 0
						haveTotem, name, startTime, duration, totemIcon = GetTotemInfo(self.ID)
							if ((GetTime() - startTime) == 0) or (duration == 0) then
								self:SetValue(0)
							else
								self:SetValue(1 - ((GetTime() - startTime) / duration))
							end
					end
				end)					
		else
			-- There's no need to update because it doesn't have any duration
			totem[slot]:SetScript("OnUpdate",nil)
			totem[slot]:SetValue(0)
		end 
	else
		-- No totem = no time 
		if totem[slot].Name then
			totem[slot].Name:SetText(" ")
		end
		totem[slot]:SetValue(0)
	end

end

local function Update(self, unit)
	-- Update every slot on login, still have issues with it
	for i = 1, 4 do 
		UpdateSlot(self, i)
	end
end

local function Event(self,event,...)
	if event == "PLAYER_TOTEM_UPDATE" then
		UpdateSlot(self, ...)
	end
end

local function Enable(self, unit)
	local totem = self.TotemBar
	
	if(totem) then
		self:RegisterEvent("PLAYER_TOTEM_UPDATE" , Event, true)
		totem.colors = setmetatable(totem.colors or {}, {__index = colors})
		delay = totem.delay or delay
		if totem.Destroy then
			-- since 5.1, DestroyTotem is restricted/protected with Blizzard UI only, so, use some kind of hack ...
			for i = 1, 4 do
				if totem[i] then
					local t = _G['TotemFrameTotem'..i]
					t:ClearAllPoints()
					t:SetParent(totem[i])
					t:SetAllPoints(totem[i])
					t:SetFrameLevel(totem[i]:GetFrameLevel() + 1)
					t:SetFrameStrata(totem[i]:GetFrameStrata())
					t:SetAlpha(0)
				end
			end
			
			hooksecurefunc("TotemFrame_Update", function()
				for i=1, MAX_TOTEMS do
					local t = _G['TotemFrameTotem'..i]
					local slot = t.slot
					
					if slot and slot > 0 then
						t:ClearAllPoints()
						t:SetAllPoints(totem[slot])
					end
				end
			end)
		end
	
		return true
	end	
end

local function Disable(self,unit)
	local totem = self.TotemBar
	if(totem) then
		self:UnregisterEvent("PLAYER_TOTEM_UPDATE", Event)
		
		TotemFrame:Show()
	end
end
			
oUF:AddElement("TotemBar",Update,Enable,Disable)