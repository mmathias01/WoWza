local _, class = UnitClass("player")
if class ~= "PRIEST" then
	-- No point in running HP on non-priest
	HaloPro_OnLoad = function() end
	HaloPro_Panel_OnLoad = HaloPro_OnLoad
	return
end

HP_UpdateInterval = .1 -- update frequency == 1/HP_UpdateDelay

local AppName, HaloPro= ...
--local OptionsAppName = AppName .. "_Options"
local VERSION = AppName .. "-v2.6.0"


local rc = LibStub("LibRangeCheck-2.0")
--local LSM = LibStub:GetLibrary("LibSharedMedia-3.0", true)
--local LibDualSpec = LibStub("LibDualSpec-1.0", true)
--local L = LibStub("AceLocale-3.0"):GetLocale(AppName)
local _G = _G
local FrameTextureUpdate = HaloPro.FrameTextureUpdate

local Halo_Check
local Theme_select_Spec_store
local HP_VAR_frame = CreateFrame("FRAME"); -- Need a frame to respond to events
HP_VAR_frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
HP_VAR_frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when logging out or reloadingUI
HP_VAR_frame:RegisterEvent("PLAYER_ENTERING_WORLD"); -- Fired when entering instances
HP_VAR_frame:RegisterEvent("PLAYER_LEAVING_WORLD"); -- Fired when leaving instances

HP_VAR_frame:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_ENTERING_WORLD" and HP_VAR_Check_Count == 1 then
		Theme_select_Spec_store()
		if HP_currentSpec == 1 then
			HP_f:SetFrameStrata(HP_Strata1)
			xOfs = xOfs_Spec1_backup
			yOfs = yOfs_Spec1_backup
			Rel_Set_Point = Rel_Set_Point_Spec1_backup
			if Theme_Icon_Spec1_Flag == 0 then
				HP_width = HP_Spec1_Width 
				HP_height =	HP_Spec1_Height
			elseif Theme_Icon_Spec1_Flag == 1 then
				HP_width = HP_width_Icon1 
				HP_height =	HP_height_Icon1 
			end
			HP_Tracking = HP_Tracking_Spec1
		elseif HP_currentSpec == 2 then
			HP_f:SetFrameStrata(HP_Strata2)
			xOfs = xOfs_Spec2_backup
			yOfs = yOfs_Spec2_backup
			Rel_Set_Point = Rel_Set_Point_Spec2_backup
			if Theme_Icon_Spec2_Flag == 0 then
				HP_width = HP_Spec2_Width 
				HP_height =	HP_Spec2_Height
			elseif Theme_Icon_Spec2_Flag == 1 then
				HP_width = HP_width_Icon2 
				HP_height =	HP_height_Icon2 
			end
			HP_Tracking = HP_Tracking_Spec2
		end
		--HP_width = floor(HP_width)
		--HP_height = floor(HP_height)
		if HP_VertBar_Flag == 1 then
			HP_t:SetTexCoord(0,1, 1,1, 0,0, 1,0)
		else
			HP_t:SetTexCoord(0,0, 0,1, 1,0, 1,1)
		end
		--HP_f:SetWidth(HP_width)
		--HP_f:SetHeight(HP_height)
		HP_resize_check = 1
		HP_f:ClearAllPoints()
		HP_f:SetPoint(Rel_Set_Point,xOfs,yOfs)
		
		--print "Re-applied Size and Positioning"
		HP_VAR_Check_Count = 2
		
	end
	if event == "ADDON_LOADED" and arg1 == "HaloPro" then
		if HP_VAR_Check_Count == nil then
			-- Our saved variables, if they exist, have been loaded at this point.
			Theme_select_Spec_store()
			if HP_currentSpec == 1 then
				HP_f:SetFrameStrata(HP_Strata1)
				xOfs = xOfs_Spec1_backup
				yOfs = yOfs_Spec1_backup
				Rel_Set_Point = Rel_Set_Point_Spec1_backup
				if Theme_Icon_Spec1_Flag == 0 then
					HP_width = HP_Spec1_Width 
					HP_height =	HP_Spec1_Height
				elseif Theme_Icon_Spec1_Flag == 1 then
					HP_width = HP_width_Icon1 
					HP_height =	HP_height_Icon1 
				end
				HP_Tracking = HP_Tracking_Spec1
			elseif HP_currentSpec == 2 then
				HP_f:SetFrameStrata(HP_Strata2)
				xOfs = xOfs_Spec2_backup
				yOfs = yOfs_Spec2_backup
				Rel_Set_Point = Rel_Set_Point_Spec2_backup
				if Theme_Icon_Spec2_Flag == 0 then
					HP_width = HP_Spec2_Width 
					HP_height =	HP_Spec2_Height
				elseif Theme_Icon_Spec2_Flag == 1 then
					HP_width = HP_width_Icon2 
					HP_height =	HP_height_Icon2 
				end
				HP_Tracking = HP_Tracking_Spec2
			end
			if HP_VertBar_Flag == 1 then
				HP_t:SetTexCoord(0,1, 1,1, 0,0, 1,0)
			else
				HP_t:SetTexCoord(0,0, 0,1, 1,0, 1,1)
			end
			HP_f:SetWidth(HP_width)
			HP_f:SetHeight(HP_height)
			HP_f:ClearAllPoints()
			HP_f:SetPoint(Rel_Set_Point,xOfs,yOfs)
			
			--[[print(Rel_Set_Point)
			print(xOfs)
			print(yOfs)
			print("Variables Loaded and set to temp variables")]]
			HP_VAR_Check_Count = 1
		end
	elseif event == "PLAYER_LOGOUT" or event == "PLAYER_LEAVING_WORLD" then
		if HP_VAR_Check_Count == 2 then
			--print("Gather current settings and save to variables")
			HP_VAR_Check_Count = 1
			Theme_select_Spec_store()
			point, relativeTo, relativePoint, xOfs, yOfs = HP_f:GetPoint()
			local HP_Round_xOfs = xOfs - (floor(xOfs))
			local HP_Round_yOfs = yOfs - (floor(yOfs))
			if HP_Round_xOfs < .5 then
				xOfs = (floor(xOfs))
			else
				xOfs = (ceil(xOfs))
			end
			if HP_Round_yOfs < .5 then
				yOfs = (floor(yOfs))
			else
				yOfs = (ceil(yOfs))
			end
			Rel_Set_Point = ""..point..""
			HP_currentSpec = GetActiveSpecGroup()
			if HP_currentSpec == 1 then
				HP_Strata1 = HP_f:GetFrameStrata()
				xOfs_Spec1_backup = xOfs
				yOfs_Spec1_backup = yOfs
				Rel_Set_Point_Spec1_backup = Rel_Set_Point
				if Theme_Icon_Spec1_Flag == 0 then
					if HP_VertBar_Flag == 1 then
						HP_Spec1_Width = HP_f:GetHeight()
						local HP_Round_Spec1_Width = HP_Spec1_Width - (floor(HP_Spec1_Width))
						if HP_Round_Spec1_Width < .5 then
							HP_Spec1_Width = floor(HP_Spec1_Width)
						else
							HP_Spec1_Width = ceil(HP_Spec1_Width)
						end
						HP_Spec1_Height = HP_f:GetWidth()
						local HP_Round_Spec1_Height = HP_Spec1_Height - (floor(HP_Spec1_Height))
						if HP_Round_Spec1_Height < .5 then
							HP_Spec1_Height = floor(HP_Spec1_Height)
						else
							HP_Spec1_Height = ceil(HP_Spec1_Height)
						end
					else
						HP_Spec1_Width = HP_f:GetWidth()
						local HP_Round_Spec1_Width = HP_Spec1_Width - (floor(HP_Spec1_Width))
						if HP_Round_Spec1_Width < .5 then
							HP_Spec1_Width = floor(HP_Spec1_Width)
						else
							HP_Spec1_Width = ceil(HP_Spec1_Width)
						end
						HP_Spec1_Height = HP_f:GetHeight()
						local HP_Round_Spec1_Height = HP_Spec1_Height - (floor(HP_Spec1_Height))
						if HP_Round_Spec1_Height < .5 then
							HP_Spec1_Height = floor(HP_Spec1_Height)
						else
							HP_Spec1_Height = ceil(HP_Spec1_Height)
						end
					end
				elseif Theme_Icon_Spec1_Flag == 1 then
					HP_width_Icon1 = HP_f:GetWidth()
					local HP_Round_width_Icon1 = HP_width_Icon1 - (floor(HP_width_Icon1))
					if HP_Round_width_Icon1 < .5 then
						HP_width_Icon1 = floor(HP_width_Icon1)
					else 
						HP_width_Icon1 = ceil(HP_width_Icon1)
					end
					HP_height_Icon1 = HP_width_Icon1 
				end
			elseif HP_currentSpec == 2 then
				HP_Strata2 = HP_f:GetFrameStrata()
				xOfs_Spec2_backup = xOfs
				yOfs_Spec2_backup = yOfs
				Rel_Set_Point_Spec2_backup = Rel_Set_Point
				if Theme_Icon_Spec2_Flag == 0 then
					if HP_VertBar_Flag == 1 then
						HP_Spec2_Width = HP_f:GetHeight()
						local HP_Round_Spec2_Width = HP_Spec2_Width - (floor(HP_Spec2_Width))
						if HP_Round_Spec2_Width < .5 then
							HP_Spec2_Width = floor(HP_Spec2_Width)
						else
							HP_Spec2_Width = ceil(HP_Spec2_Width)
						end
						HP_Spec2_Height = HP_f:GetWidth()
						local HP_Round_Spec2_Height = HP_Spec2_Height - (floor(HP_Spec2_Height))
						if HP_Round_Spec2_Height < .5 then
							HP_Spec2_Height = floor(HP_Spec2_Height)
						else
							HP_Spec2_Height = ceil(HP_Spec2_Height)
						end
					else
						HP_Spec2_Width = HP_f:GetWidth()
						local HP_Round_Spec2_Width = HP_Spec2_Width - (floor(HP_Spec2_Width))
						if HP_Round_Spec2_Width < .5 then
							HP_Spec2_Width = floor(HP_Spec2_Width)
						else
							HP_Spec2_Width = ceil(HP_Spec2_Width)
						end
						HP_Spec2_Height = HP_f:GetHeight()
						local HP_Round_Spec2_Height = HP_Spec2_Height - (floor(HP_Spec2_Height))
						if HP_Round_Spec2_Height < .5 then
							HP_Spec2_Height = floor(HP_Spec2_Height)
						else
							HP_Spec2_Height = ceil(HP_Spec2_Height)
						end
					end
				elseif Theme_Icon_Spec1_Flag == 1 then
					HP_width_Icon2 = HP_f:GetWidth()
					local HP_Round_width_Icon2 = HP_width_Icon2 - (floor(HP_width_Icon2))
					if HP_Round_width_Icon2 < .5 then
						HP_width_Icon2 = floor(HP_width_Icon2)
					else 
						HP_width_Icon2 = ceil(HP_width_Icon2)
					end
					HP_height_Icon2 = HP_width_Icon2 
				end
			end
			HP_Restore_Tracking_PerSpec()
		end
	end
end)
function HP_Restore_Strata()
	HP_currentSpec = GetActiveSpecGroup()
	if HP_currentSpec == 1 then
		HP_f:SetFrameStrata(HP_Strata1)
	elseif HP_currentSpec == 2 then
		HP_f:SetFrameStrata(HP_Strata2)
	end
end
function HP_Restore_Tracking_PerSpec()
	HP_currentSpec = GetActiveSpecGroup()
	if HP_currentSpec == 1 then
		HP_Tracking_Spec1 = HP_Tracking
	elseif HP_currentSpec == 2 then
		HP_Tracking_Spec2 = HP_Tracking
	end
end
function HaloPro_OnLoad(self)
	
	-- Global variables called OnLoad
	HP_FadeIN = 0.85
	HP_FadeOUT = 0
	HP_FO_Time = 0
	HP_FI_Time = 0
	HP_pulseflag = 0
	HP_tcount = 0
	HP_tcount_counter = 0
	HP_cdFlag = 0
	HP_oneTimeC = 0
	HP_fadeouttimer = 1.5
	HP_options_open_Flag = 0
	HP_playonce = 1
	HP_resize_check = 1
	HP_Init_Once = 1
	HP_Fade_MsgMode_Flag = 0
	HP_Testmode = 0

	-- Setup default values
	default_width = 350
	default_height = 10
	default_fadeintimer = 20
	default_off_cd_warning = 1
	default_Lock_Flag = 0
	default_OffCD_Flag = 1
	default_tcount_time1 = 1
	default_flash_num = 3
	default_max_alpha_adjust = 0.85
	default_HP_Sound_Flag = 1
	default_HP_Sound = "MapPing"
	default_HP_Strata_Flag = 0
	default_HP_Strata = "HIGH"
	default_Theme_select_Spec1 = "Shadow"
	default_Theme_Index_Spec1 = 1
	default_Theme_select_Spec2 = "Holy"
	default_Theme_Index_Spec2 = 2
	default_Theme_Icon_Spec1_Flag = 0
	default_Theme_Icon_Spec2_Flag = 0
	default_HP_Border_Flag = 1
	default_HP_DarkLight = "Dark"
	default_HP_Border_Theme = "glowTex.tga"
	default_HP_Border_Background = "background.tga"
	default_HP_Border_Thickness = 0
	default_HP_Border_Background_Thickness = (default_HP_Border_Thickness + 1)
	default_HP_Colour_R = 1
	default_HP_Colour_G = 1
	default_HP_Colour_B = 1
	default_HP_width_Icon1 = 64
	default_HP_width_Icon2 = 64
	default_HP_height_Icon1 = 64
	default_HP_height_Icon2 = 64
	default_HP_VertBar_Flag = 0
	default_HP_InCombatOnly = 0
	default_HP_Always_On_Flag = 'No'
	default_HP_Tracking = 'target'
	default_HP_Monitor_DS = 1
	default_HP_Monitor_CC = 1
	default_HC_spellName = "Halo"
	--SpellToMonitor = "Halo"  -- set to "Mind Blast" if testing is needed without Halo present

	-- Creates Message that says which mode is enabled
	HP_DSMode_Msg = CreateFrame("Frame", "HP_DSMode_Msg", UIParent)
	HP_DSMode_Msg:SetAllPoints()
	HP_DSMode_Msg = HP_DSMode_Msg:CreateFontString(nil, 'OVERLAY')
	HP_DSMode_Msg:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
	HP_DSMode_Msg:SetText('|cff00ddaaHaloPro is now Activated')
	HP_DSMode_Msg:SetPoint('CENTER',0,200)
	HP_DSMode_Msg:SetAlpha(0)
	
	First_Time_init()
	Halo_Check()
	Theme_select_Spec_store()
	-- Creates config messages
	HP_Unlocked_Msg = CreateFrame("Frame", "HP_Unlocked_Msg", UIParent)
	HP_Unlocked_Msg:SetAllPoints()
	HP_Unlocked_Msg = HP_Unlocked_Msg:CreateFontString(nil, 'OVERLAY')
	HP_Unlocked_Msg:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
	HP_Unlocked_Msg:SetText('|cff00ddaa--(please target something you can attack or heal)--|n|nwhile hovering over the HaloPro graphic|n|nmousewheel to adjust width|nshift + mousewheel to adjust height|nleft click and drag with mouse to re-position|n|nHaloPro is currently unlocked|n/HP lock when adjustments are complete|r')
	HP_Unlocked_Msg:SetPoint('CENTER',0,200)

	-- Creates the main bar
	HP_f = CreateFrame("Frame","HaloPro_MainFrame",UIParent)
	HP_Restore_Strata()
	HP_f:SetFrameLevel(502)
	HP_f:SetMovable(true)
	HP_f:SetResizable(true)
	HP_f:SetClampedToScreen(true)
	HP_f:EnableMouse(true)
	HP_f:EnableKeyboard(true)
	HP_f:EnableMouseWheel(true)
	HP_f:SetUserPlaced(true)
	HP_f:RegisterForDrag("LeftButton")
	HP_f:SetScript("OnDragStart", HP_f.StartMoving)
	HP_f:SetScript('OnDragStop', function(self)
		HP_f:StopMovingOrSizing()
		HP_Get_Position()
		HP_Set_Position()
	end)

	HP_f:SetScript('OnMouseWheel', function(self, delta)
		if IsShiftKeyDown() then
			if delta == 1 then
				if HP_currentSpec == 1 and Theme_Icon_Spec1_Flag == 1 then
					HP_width = HP_width_Icon1
					HP_height = HP_height_Icon1
					HP_width = HP_width + 1
					HP_height = HP_height + 1
					HP_width_Icon1 = HP_width
					HP_height_Icon1 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				elseif HP_currentSpec == 2 and Theme_Icon_Spec2_Flag == 1 then
					HP_width = HP_width_Icon2
					HP_height = HP_height_Icon2
					HP_width = HP_width + 1
					HP_height = HP_height + 1
					HP_width_Icon2 = HP_width
					HP_height_Icon2 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				else
					HP_height = HP_height + 1
					HP_Resize_height()
					HP_Resize_width()
				end
				if HP_VertBar_Flag == 1 then
					print("Increasing HaloPro width to " .. HP_height)
				else
					print("Increasing HaloPro height to " .. HP_height)
				end
			elseif delta == -1 then
				if HP_currentSpec == 1 and Theme_Icon_Spec1_Flag == 1 then
					HP_width = HP_width_Icon1
					HP_height = HP_height_Icon1
					HP_width = HP_width - 1
					HP_height = HP_height - 1
					HP_width_Icon1 = HP_width
					HP_height_Icon1 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				elseif HP_currentSpec == 2 and Theme_Icon_Spec2_Flag == 1 then
					HP_width = HP_width_Icon2
					HP_height = HP_height_Icon2
					HP_width = HP_width - 1
					HP_height = HP_height - 1
					HP_width_Icon2 = HP_width
					HP_height_Icon2 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				else
					HP_height = HP_height - 1
					HP_Resize_height()
					HP_Resize_width()
				end
				if HP_VertBar_Flag == 1 then
					print("Decreasing HaloPro width to " .. HP_height)
				else
					print("Decreasing HaloPro height to " .. HP_height)
				end
			end
		else
			if delta == 1 then
				if HP_currentSpec == 1 and Theme_Icon_Spec1_Flag == 1 then
					HP_width = HP_width_Icon1
					HP_height = HP_height_Icon1
					HP_width = HP_width + 1
					HP_height = HP_height + 1
					HP_width_Icon1 = HP_width
					HP_height_Icon1 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				elseif HP_currentSpec == 2 and Theme_Icon_Spec2_Flag == 1 then
					HP_width = HP_width_Icon2
					HP_height = HP_height_Icon2
					HP_width = HP_width + 1
					HP_height = HP_height + 1
					HP_width_Icon2 = HP_width
					HP_height_Icon2 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				else
					HP_width = HP_width + 1
					HP_Resize_height()
					HP_Resize_width()
				end
				if HP_VertBar_Flag == 1 then
					print("Increasing HaloPro height to " .. HP_width)
				else
					print("Increasing HaloPro width to " .. HP_width)
				end
			elseif delta == -1 then
				if HP_currentSpec == 1 and Theme_Icon_Spec1_Flag == 1 then
					HP_width = HP_width_Icon1
					HP_height = HP_height_Icon1
					HP_width = HP_width - 1
					HP_height = HP_height - 1
					HP_width_Icon1 = HP_width
					HP_height_Icon1 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				elseif HP_currentSpec == 2 and Theme_Icon_Spec2_Flag == 1 then
					HP_width = HP_width_Icon2
					HP_height = HP_height_Icon2
					HP_width = HP_width - 1
					HP_height = HP_height - 1
					HP_width_Icon2 = HP_width
					HP_height_Icon2 = HP_height
					HP_Resize_height()
					HP_Resize_width()
				else
					HP_width = HP_width - 1
					HP_Resize_height()
					HP_Resize_width()
				end
				if HP_VertBar_Flag == 1 then
					print("Decreasing HaloPro height to " .. HP_width)
				else
					print("Decreasing HaloPro width to " .. HP_width)
				end
			end
		end
	end)


	HP_t = HP_f:CreateTexture(HP_center,"BACKGROUND")
	--if HP_VertBar_Flag == 1 then
		--HP_t:SetTexCoord(0,1, 1,1, 0,0, 1,0)
	--else
	--	HP_t:SetTexCoord(0,0, 0,1, 1,0, 1,1)
	--end
	HaloPro.SetFrames(HP_Unlocked_Msg, HP_f, HP_t)
	FrameTextureUpdate(false, 1, false, Theme_select_Spec1, "center.tga")
	HP_t:SetAllPoints(HP_f)
	HP_f.texture = HP_t
	HP_f:SetPoint("CENTER",xOfs,yOfs)
	HP_f:SetWidth(HP_width) 	-- Set these to whatever height/width is needed
	HP_f:SetHeight(HP_height) 	-- for your Texture

	-- Create OnUpdateFrame
	local HP_UPdate_Master = CreateFrame("Frame","HP_UPdate_Master",UIParent)
	HP_UPdate_Master:RegisterEvent("PLAYER_TALENT_UPDATE")
	HP_UPdate_Master:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	HP_UPdate_Master:SetFrameLevel(501)
	HP_currentSpec = GetActiveSpecGroup()
	if HP_currentSpec == 1 then
		HP_UPdate_Master:SetFrameStrata(HP_Strata1)
	elseif HP_currentSpec == 2 then
		HP_UPdate_Master:SetFrameStrata(HP_Strata2)
	end
	HP_UPdate_Master:SetScript("OnEvent", function()
		Halo_Check()
		Theme_select_Spec_store()
		HP_resize_check = 1
	end)
	HP_UPdate_Master:SetScript('OnUpdate', HaloPro_OnUpdate)

	if HP_Lvl90_Flag == 1 then
		FrameTextureUpdate(nil, nil, true)
	elseif HP_Lvl90_Flag == 0 then
		HP_f_Hide()
	end
	HP_f:SetScript('OnShow', function(self)
		HP_Lock()
	end)

	print("HaloPro has initialized")

end

local TimeSinceLastUpdate = 0
function HaloPro_OnUpdate(self, elapsed)
	local unlocked_msg_visibility, alpha, visibility, theme, texture
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	if HP_Init_Once == 1 then
		HP_Restore_Strata()
		if HP_VertBar_Flag == 1 then
			HP_t:SetTexCoord(0,1, 1,1, 0,0, 1,0)
		else
			HP_t:SetTexCoord(0,0, 0,1, 1,0, 1,1)
		end
		if HP_Always_Show_Flag == 'No' then
			HP_Always_Show_button:UnlockHighlight()
			HP_Always_Show_button:SetButtonState("NORMAL")
			HP_Always_Show_button:SetText("Always Show:".. HP_Always_Show_Flag)
		elseif HP_Always_Show_Flag == 'Yes' then
			HP_Always_Show_button:LockHighlight()
			HP_Always_Show_button:SetButtonState("PUSHED")
			HP_Always_Show_button:SetText("Always Show:".. HP_Always_Show_Flag)
		end
		HP_Border_Control()
		HP_Init_Once = 0
	end
	local HP_Combat_Check = UnitAffectingCombat("player")
	if HP_Combat_Check == 1 and HP_InCombatOnly == 1 then
		HP_Bar_Display_Confirm = 1
	elseif HP_Combat_Check == nil and HP_InCombatOnly == 1 then
		HP_Bar_Display_Confirm = 0
	else
		HP_Bar_Display_Confirm = 1
	end
	local Chosen_Theme = 0
	if HP_currentSpec == 1 then
		Chosen_Theme = Theme_select_Spec1
		if HP_resize_check == 1 and Theme_Icon_Spec1_Flag == 1 then
			HP_width = HP_width_Icon1
			HP_height = HP_height_Icon1
			HP_Resize_height()
			HP_Resize_width()
			xOfs = xOfs_Spec1_backup
			yOfs = yOfs_Spec1_backup
			Rel_Set_Point = Rel_Set_Point_Spec1_backup
			HP_Strata = HP_Strata1
			HP_Restore_Strata()
			HP_Set_Position()
			HP_Tracking = HP_Tracking_Spec1 
			HP_Border_Control_Apply()
			HP_resize_check = 0
		elseif HP_resize_check == 1 then
			HP_width = HP_Spec1_Width
			HP_height = HP_Spec1_Height
			HP_Resize_height()
			HP_Resize_width()
			xOfs = xOfs_Spec1_backup
			yOfs = yOfs_Spec1_backup
			Rel_Set_Point = Rel_Set_Point_Spec1_backup
			HP_Strata = HP_Strata1
			HP_Restore_Strata()
			HP_Set_Position()
			HP_Tracking = HP_Tracking_Spec1 
			HP_Border_Control_Apply()
			HP_resize_check = 0
		end
	elseif HP_currentSpec == 2 then
		Chosen_Theme = Theme_select_Spec2
		if HP_resize_check == 1 and Theme_Icon_Spec2_Flag == 1 then
			HP_width = HP_width_Icon2
			HP_height = HP_height_Icon2
			HP_Resize_height()
			HP_Resize_width()
			xOfs = xOfs_Spec2_backup
			yOfs = yOfs_Spec2_backup
			Rel_Set_Point = Rel_Set_Point_Spec2_backup
			HP_Strata = HP_Strata2
			HP_Restore_Strata()
			HP_Set_Position()
			HP_Tracking = HP_Tracking_Spec2 
			HP_Border_Control_Apply()
			HP_resize_check = 0
		elseif HP_resize_check == 1 then
			HP_width = HP_Spec2_Width
			HP_height = HP_Spec2_Height
			HP_Resize_height()
			HP_Resize_width()
			xOfs = xOfs_Spec2_backup
			yOfs = yOfs_Spec2_backup
			Rel_Set_Point = Rel_Set_Point_Spec2_backup
			HP_Strata = HP_Strata2
			HP_Restore_Strata()
			HP_Set_Position()
			HP_Tracking = HP_Tracking_Spec2 
			HP_Border_Control_Apply()
			HP_resize_check = 0
		end
	else
		Chosen_Theme = default_Theme_select_Spec1
	end
	if HP_Lvl90_Flag == 1 then

		if HP_options_open_Flag == 1 then
			visibility = true
			unlocked_msg_visibility = false
		end
		if HP_Bar_Display_Confirm == 1 then
			local minRange, maxRange = rc:GetRange(HP_Tracking)
			HP_WeakAura = 0
			if HP_Always_Show_Flag == 'Yes' then
				if not minRange or not maxRange then --nothing targetted
					if HP_tcount_time1 >= 1 then
						if (HP_tcount <= HP_tcount_time1) then
							if OffCD_Flag == 1 then
								alpha = 1
								theme = Chosen_Theme texture = "offcd.tga"
							end
						else
							if HP_pulseflag == 0 then
								alpha = HP_max_alpha_adjust - 0.40
							end
							HP_playonce = 1
                            theme = Chosen_Theme texture = "center.tga"
						end
						if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
							HP_tcount_counter = HP_tcount_counter + 1
							if HP_tcount_counter < HP_flash_num then
								HP_tcount = 0
							end
						end
					end
				end
			end
			if UnitCanAttack('player', HP_Tracking) or UnitCanAssist('player', HP_Tracking) and not UnitIsUnit(HP_Tracking, 'player') then
				--ConfirmSweetSpot = CheckInteractDistance(HP_Tracking, 4)
				--print(ConfirmSweetSpot)

                if not minRange then --nothing targetted
					HP_WeakAura = 0
                    print (minRange.."  -  "..maxRange)
                    if HP_options_open_Flag == 1 then
                        theme = Chosen_Theme texture = "center.tga"
                        visibility = true
                        unlocked_msg_visibility = false
                    else
                        if HP_Always_Show_Flag == 'Yes' then
							visibility = true
						else
							visibility = false
						end
						if Lock_Flag == 1 then
                            unlocked_msg_visibility = false
                        end
                        HP_playonce = 1
                    end
                elseif not maxRange then --nothing targetted
					HP_WeakAura = 0
                    if HP_options_open_Flag == 1 then
                        theme = Chosen_Theme texture = "right.tga"
                        visibility = true
                        unlocked_msg_visibility = false
                    else
                        if HP_Always_Show_Flag == 'Yes' then
							visibility = true
						else
							visibility = false
						end
						if Lock_Flag == 1 then
                            unlocked_msg_visibility = false
                        end
                        HP_playonce = 1
                    end
                elseif maxRange <= L_HP_Range then
                    visibility = true
					HP_WeakAura = 0
                    if HP_tcount_time1 == 1 then
                        if (HP_tcount <= HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.25
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "left.tga"
                        end
                        if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
                            HP_tcount_counter = HP_tcount_counter + 1
                            if HP_tcount_counter < HP_flash_num then
                                HP_tcount = 0
                            end
                        end
                    elseif HP_tcount_time1 > 1 then
                        if (HP_tcount < HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.25
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "left.tga"
                        end
                        if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
                            HP_tcount_counter = HP_tcount_counter + 1
                            if HP_tcount_counter < HP_flash_num then
                                HP_tcount = 0
                            end
                        end
                    end
                elseif minRange >= ML_HP_Range_A and maxRange <= ML_HP_Range_B then
                    visibility = true
					HP_WeakAura = 0
                    if HP_tcount_time1 == 1 then
                        if (HP_tcount <= HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.15
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "mid_left.tga"
                        end
                        if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
                            HP_tcount_counter = HP_tcount_counter + 1
                            if HP_tcount_counter < HP_flash_num then
                                HP_tcount = 0
                            end
                        end
                    elseif HP_tcount_time1 > 1 then
                        if (HP_tcount < HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.15
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "mid_left.tga"
                        end
                        if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
                            HP_tcount_counter = HP_tcount_counter + 1
                            if HP_tcount_counter < HP_flash_num then
                                HP_tcount = 0
                            end
                        end
                    end
                elseif minRange >= C_HP_Range_A and maxRange <= C_HP_Range_B then
                    visibility = true
					if HP_tcount_time1 == 1 then
                        if (HP_tcount <= HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust
                            end
                            if HP_playonce == 1 then
                                if HP_Sound_Flag == 1 then
                                    if HP_Spell_Confirm == "Halo" or HP_Spell_Confirm == "Cascade" then
                                        PlaySound(HP_Sound,"master")
                                    end
                                end
                                HP_playonce = 0
                            end
                            --if ConfirmSweetSpot == 1 then
                                theme = Chosen_Theme texture = "center.tga"
                            --else
                            --	if HP_pulseflag == 0 then
                            --		alpha = HP_max_alpha_adjust - 0.15
                            --	end
                            --	HP_playonce = 1
                            --	theme = Chosen_Theme texture = "mid_right.tga"
                            --end
                        end
				    elseif HP_tcount_time1 > 1 then
                        if (HP_tcount < HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust
                            end
                            if HP_playonce == 1 then
                                if HP_Sound_Flag == 1 and HP_Spell_Confirm == "Halo" then
                                    if HP_cdFlag == 0 then
                                        if HP_Spell_Confirm == "Halo" or HP_Spell_Confirm == "Cascade" then
                                            PlaySound(HP_Sound,"master")
                                        end
                                    end
                                end
                                HP_playonce = 0
                            end
                            --if ConfirmSweetSpot == 1 then
                                theme = Chosen_Theme texture = "center.tga"
                            --else
                            --	if HP_pulseflag == 0 then
                            --		alpha = HP_max_alpha_adjust - 0.15
                            --	end
                            --	HP_playonce = 1
                            --	theme = Chosen_Theme texture = "mid_right.tga"
                            --end
                        end
					end
					if alpha == HP_max_alpha_adjust then
						HP_WeakAura = 1
					else
						HP_WeakAura = 0
					end
                    if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
                        HP_tcount_counter = HP_tcount_counter + 1
                        if HP_tcount_counter < HP_flash_num then
                            HP_tcount = 0
                        end
                    end
                elseif minRange >= MR_HP_Range_A and maxRange <= MR_HP_Range_B then
                    visibility = true
					HP_WeakAura = 0
                    if HP_tcount_time1 == 1 then
                        if (HP_tcount <= HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.15
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "mid_right.tga"
                        end
                    elseif HP_tcount_time1 > 1 then
                        if (HP_tcount < HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.15
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "mid_right.tga"
                        end
                    end
                    if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
                        HP_tcount_counter = HP_tcount_counter + 1
                        if HP_tcount_counter < HP_flash_num then
                            HP_tcount = 0
                        end
                    end
                elseif minRange >= R_HP_Range then
                    visibility = true
					HP_WeakAura = 0
                    if HP_tcount_time1 == 1 then
                        if (HP_tcount <= HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.25
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "right.tga"
                        end
                    elseif HP_tcount_time1 > 1 then
                        if (HP_tcount < HP_tcount_time1) then
                            if OffCD_Flag == 1 then
                                alpha = 1
                                theme = Chosen_Theme texture = "offcd.tga"
                            end
                        else
                            if HP_pulseflag == 0 then
                                alpha = HP_max_alpha_adjust - 0.25
                            end
                            HP_playonce = 1
                            theme = Chosen_Theme texture = "right.tga"
                        end
                    end
                    if HP_tcount == (HP_tcount_time1 + HP_tcount_time1) then
                        HP_tcount_counter = HP_tcount_counter + 1
                        if HP_tcount_counter < HP_flash_num then
                            HP_tcount = 0
                        end
                    end
                end
			else
				if HP_Always_Show_Flag == 'Yes' then
					visibility = true
				else
					visibility = false
				end
				if Lock_Flag == 1 then
					unlocked_msg_visibility = false
				end
				if HP_options_open_Flag == 1 then
					visibility = true
					unlocked_msg_visibility = false
				end
			end
			while (TimeSinceLastUpdate > HP_UpdateInterval) do

				local start, duration, enabled = GetSpellCooldown(SpellToMonitor)
				local framerate = GetFramerate()
				local spellcd = GetTime()
				HP_FO_Time = HP_fadeouttimer/framerate
				HP_tcount = HP_tcount + 1
				if HP_tcount >= 5000 then
					HP_tcount = 1000
				end
				if ( start > 0 and duration > 1.5) then
					spellcd = spellcd - start
					spellcd = duration - spellcd
					if HP_fadeintimer == nil then
						HP_fadeintimer = default_fadeintimer
					end
					if spellcd <= HP_fadeintimer then
						duration = HP_fadeintimer
						spellcd = spellcd / duration
						HP_FI_Time = HP_max_alpha_adjust - spellcd
						HP_FadeIN = HP_FI_Time
					end
					if HP_cdFlag == 0 then
						HP_pulseflag = 1
						HP_cdFlag = 1
						HP_FadeIN = 0
					end
					if HP_FadeIn_Disable == 1 or HP_Spell_Confirm == "Divine Star"then
						HP_FadeIN = HP_max_alpha_adjust
					end
					alpha = HP_FadeIN
				else
					HP_FadeIN = HP_max_alpha_adjust
					HP_cdFlag = 0
					if HP_pulseflag == 1 then
						visibility = true
						if OffCD_Flag == 1 then
							theme = Chosen_Theme texture = "offcd.tga"
							alpha = HP_max_alpha_adjust
						end
						HP_tcount_counter = 0
						HP_tcount = 0
						HP_pulseflag = 0
					end
				end
				TimeSinceLastUpdate = TimeSinceLastUpdate - HP_UpdateInterval
			end
		elseif HP_Bar_Display_Confirm == 0 then
			if HP_Always_Show_Flag == 'Yes' then
				visibility = true
			else
				visibility = false
			end
			if Lock_Flag == 1 then
				unlocked_msg_visibility = false
			end
			if HP_options_open_Flag == 1 then
				visibility = true
				unlocked_msg_visibility = false
			end
		end
	elseif HP_Lvl90_Flag == 0 then
		if HP_Always_Show_Flag == 'Yes' then
			visibility = true
		else
			visibility = false
		end
		unlocked_msg_visibility = false
	end
	FrameTextureUpdate(unlocked_msg_visibility, alpha, visibility, theme, texture)
end

function HP_f_Hide()
    if HP_Always_Show_Flag == 'No' then
        return FrameTextureUpdate(nil, nil, false)
    end
    if HP_Lvl90_Flag == 0 then
        return FrameTextureUpdate(nil, nil, false)
    end
end

function First_Time_init()
	if HP_Strata == nil then
		HP_Strata = default_HP_Strata
	end
	if HP_Strata1 == nil then
		HP_Strata1 = default_HP_Strata
	end 
	if HP_Strata2 == nil then
		HP_Strata2 = default_HP_Strata
	end
	if HP_Strata_Flag == nil then
		HP_Strata_Flag = default_HP_Strata_Flag
	end
	if HP_max_alpha_adjust == nil then
		HP_max_alpha_adjust = default_max_alpha_adjust
	end
	if OffCD_Flag == nil then
		OffCD_Flag = default_off_cd_warning
	end
	if HP_fadeintimer == nil then
		HP_fadeintimer = default_fadeintimer
	end
	if HP_width == nil then
		HP_width = default_width
	end
	if HP_height == nil then
		HP_height = default_height
	end
	if HP_tcount_time1 == nil then
		HP_tcount_time1 = default_tcount_time1
	end
	if HP_flash_num == nil then
		HP_flash_num = default_flash_num
	end
	if Theme_select_Spec1 == nil then
		Theme_select_Spec1 = default_Theme_select_Spec1
	end
	if Theme_Index_Spec1 == nil then
		Theme_Index_Spec1 = default_Theme_Index_Spec1
	end
	if Theme_select_Spec2 == nil then
		Theme_select_Spec2 = default_Theme_select_Spec2
	end
	if Theme_Index_Spec2 == nil then
		Theme_Index_Spec2 = default_Theme_Index_Spec2
	end
	if Theme_Icon_Spec1_Flag == nil then
		Theme_Icon_Spec1_Flag = default_Theme_Icon_Spec1_Flag
	end
	if Theme_Icon_Spec2_Flag == nil then
		Theme_Icon_Spec2_Flag = default_Theme_Icon_Spec2_Flag
	end
	if HP_width_Icon1 == nil then
		HP_width_Icon1 = default_HP_width_Icon1
	end
	if HP_width_Icon2 == nil then
		HP_width_Icon2 = default_HP_width_Icon2
	end
	if HP_height_Icon1 == nil then
		HP_height_Icon1 = default_HP_height_Icon1
	end
	if HP_heiht_Icon2 == nil then
		HP_height_Icon2 = default_HP_height_Icon2
	end
	if HP_Spec1_Width == nil then
		HP_Spec1_Width = HP_width
	end
	if HP_Spec1_Height == nil then
		HP_Spec1_Height = HP_height
	end
	if HP_Spec2_Width == nil then
		HP_Spec2_Width = HP_width
	end
	if HP_Spec2_Height == nil then
		HP_Spec2_Height = HP_height
	end
	if xOfs_Spec1_backup == nil then
		xOfs_Spec1_backup = 0
	end
	if yOfs_Spec1_backup == nil then
		yOfs_Spec1_backup = 0
	end
	if Rel_Set_Point_Spec1_backup == nil then
		Rel_Set_Point_Spec1_backup = "CENTER"
	end
	if xOfs_Spec2_backup == nil then
		xOfs_Spec2_backup = 0
	end
	if yOfs_Spec2_backup == nil then
		yOfs_Spec2_backup = 0
	end
	if Rel_Set_Point_Spec2_backup == nil then
		Rel_Set_Point_Spec2_backup = "CENTER"
	end
	if HP_Sound == nil then
		HP_Sound = default_HP_Sound
	end
	if HP_Sound_Flag == nil then
		HP_Sound_Flag = default_HP_Sound_flag
	end
	if HP_Tracking == nil then
		HP_Tracking = default_HP_Tracking
	end
	if HP_Tracking_Spec1 == nil then
		HP_Tracking_Spec1 = HP_Tracking
	end 
	if HP_Tracking_Spec2 == nil then
		HP_Tracking_Spec2 = HP_Tracking
	end 
	if HP_FadeIn_Disable == nil then
		HP_FadeIn_Disable = 0
	end
	if HP_VertBar_Flag == nil then
		HP_VertBar_Flag = default_HP_VertBar_Flag
	end
	if HP_Always_Show_Flag == nil then
		HP_Always_Show_Flag = default_HP_Always_On_Flag
	end
	if HP_DarkLight == nil then
		HP_DarkLight = default_HP_DarkLight
	end
	if HP_Border_Flag == nil then
		HP_Border_Flag = default_HP_Border_Flag
	end
	if HP_Border_Theme == nil then
		HP_Border_Theme = default_HP_Border_Theme
	end
	if HP_Border_Background == nil then
		HP_Border_Background = default_HP_Border_Background
	end
	if HP_Border_Thickness == nil then
		HP_Border_Thickness = default_HP_Border_Thickness
	end
	if HP_Border_Background_Thickness == nil then
		HP_Border_Background_Thickness = default_HP_Border_Background_Thickness
	end
	if HP_Colour_R == nil then
		HP_Colour_R = default_HP_Colour_R
	end
	if HP_Colour_B == nil then
		HP_Colour_B = default_HP_Colour_B
	end
	if HP_Colour_G == nil then
		HP_Colour_G = default_HP_Colour_G
	end
	if HP_Monitor_DS == nil then
		HP_Monitor_DS = default_HP_Monitor_DS
	end
	if HP_Monitor_CC == nil then
		HP_Monitor_CC = default_HP_Monitor_CC
	end
	if HC_spellName == nil then
		HC_spellName = default_HC_spellName
	end
	HP_Always_Show_Temp = HP_Always_Show_Flag
end

function Theme_select_Spec_store()

	HP_currentSpec = GetActiveSpecGroup()
	if HP_currentSpec ~= spec_Flag then
		HP_resize_check = 1
	else
		HP_resize_check = 0
	end
	if HP_currentSpec == 1 then
		HP_activeSpec = "your Primary spec"
		spec_Flag = 1
	elseif HP_currentSpec == 2 then
		HP_activeSpec = "your Secondary spec"
		spec_Flag = 2
	else
		HP_activeSpec = "no spec: Under level 15?"
	end

	HP_currentSpecial = GetSpecialization()
	if HP_currentSpecial == 1 then
		HP_activeSpecial = "Discipline is your current specialization"
		if HP_currentSpec == 1 then
			default_Theme_Index_Spec1 = 3
		elseif HP_currentSpec == 2 then
			default_Theme_Index_Spec2 = 3
		end
	elseif HP_currentSpecial == 2 then
		HP_activeSpecial = "Holy is your current specialization"
		if HP_currentSpec == 1 then
			default_Theme_Index_Spec1 = 2
		elseif HP_currentSpec == 2 then
			default_Theme_Index_Spec2 = 2
		end
	elseif HP_currentSpecial == 3 then
		HP_activeSpecial = "Shadow is your current specialization"
		if HP_currentSpec == 1 then
			default_Theme_Index_Spec1 = 1
		elseif HP_currentSpec == 2 then
			default_Theme_Index_Spec2 = 1
		end
	end

	if Theme_Index_Spec1 == 1 then
		Theme_Icon_Spec1_Flag = 0
		Theme_select_Spec1 = "Shadow"
	elseif Theme_Index_Spec1 == 2 then
		Theme_Icon_Spec1_Flag = 0
		Theme_select_Spec1 = "Holy"
	elseif Theme_Index_Spec1 == 3 then
		Theme_Icon_Spec1_Flag = 0
		Theme_select_Spec1 = "Disc"
	elseif Theme_Index_Spec1 == 4 then
		Theme_Icon_Spec1_Flag = 1
		Theme_select_Spec1 = "Shadow_Icon"
	elseif Theme_Index_Spec1 == 5 then
		Theme_Icon_Spec1_Flag = 1
		Theme_select_Spec1 = "Holy_Icon"
	elseif Theme_Index_Spec1 == 6 then
		Theme_Icon_Spec1_Flag = 0
		Theme_select_Spec1 = "Custom"
	else
		Theme_select_Spec1 = default_Theme_select_Spec1
	end

	if Theme_Index_Spec2 == 1 then
		Theme_Icon_Spec2_Flag = 0
		Theme_select_Spec2 = "Shadow"
	elseif Theme_Index_Spec2 == 2 then
		Theme_Icon_Spec2_Flag = 0
		Theme_select_Spec2 = "Holy"
	elseif Theme_Index_Spec2 == 3 then
		Theme_Icon_Spec2_Flag = 0
		Theme_select_Spec2 = "Disc"
	elseif Theme_Index_Spec2 == 4 then
		Theme_Icon_Spec2_Flag = 1
		Theme_select_Spec2 = "Shadow_Icon"
	elseif Theme_Index_Spec2 == 5 then
		Theme_Icon_Spec2_Flag = 1
		Theme_select_Spec2 = "Holy_Icon"
	elseif Theme_Index_Spec2 == 6 then
		Theme_Icon_Spec2_Flag = 0
		Theme_select_Spec2 = "Custom"
	else
		Theme_select_Spec2 = default_Theme_select_Spec2
	end
end

function HP_Border_Control()

	-- Create border frame for main bar
	HP_f.Border = CreateFrame("Frame","HaloPro_MainFrame_Border",HP_f)
	HP_f.Border:SetFrameStrata(HP_Strata)
	HP_f.Border:SetFrameLevel(1)
	HP_f.Border:SetPoint("LEFT", HP_f, "LEFT", -(6+HP_Border_Thickness), 0)
	HP_f.Border:SetPoint("RIGHT", HP_f, "RIGHT", (6+HP_Border_Thickness), 0)
	HP_f.Border:SetPoint("BOTTOM", HP_f, "BOTTOM", 0, -(6+HP_Border_Thickness))
	HP_f.Border:SetPoint("TOP", HP_f, "TOP", 0, (6+HP_Border_Thickness))

	-- Create background border frame for main icon
	HP_t.Background = HP_f.Border:CreateTexture(HP_BB, "BACKGROUND")
	HP_t.Background:SetPoint("LEFT", HP_f.Border, "LEFT", -HP_Border_Background_Thickness, 0)
	HP_t.Background:SetPoint("RIGHT", HP_f.Border, "RIGHT", HP_Border_Background_Thickness, 0)
	HP_t.Background:SetPoint("BOTTOM", HP_f.Border, "BOTTOM", 0, -HP_Border_Background_Thickness)
	HP_t.Background:SetPoint("TOP", HP_f.Border, "TOP", 0, HP_Border_Background_Thickness)
	HP_t.Background.texture = HP_t.Background
	HP_t.Background:Hide()

	-- Create Borders in the theme panel previews
	HP_f.Border_preview1 = CreateFrame("Frame","HaloPro_Border_Preview_Spec1",Spec_1_Preview)
	HP_f.Border_preview1:SetFrameStrata("TOOLTIP")
	HP_f.Border_preview1:SetFrameLevel(1)
	HP_f.Border_preview1:SetPoint("LEFT", Spec_1_Preview, "LEFT", -(6+HP_Border_Thickness), 0)
	HP_f.Border_preview1:SetPoint("RIGHT", Spec_1_Preview, "RIGHT", (6+HP_Border_Thickness), 0)
	HP_f.Border_preview1:SetPoint("BOTTOM", Spec_1_Preview, "BOTTOM", 0, -(6+HP_Border_Thickness))
	HP_f.Border_preview1:SetPoint("TOP", Spec_1_Preview, "TOP", 0, (6+HP_Border_Thickness))

	HP_f.Border_preview2 = CreateFrame("Frame","HaloPro_Border_Preview_Spec1",Spec_2_Preview)
	HP_f.Border_preview2:SetFrameStrata("TOOLTIP")
	HP_f.Border_preview2:SetFrameLevel(1)
	HP_f.Border_preview2:SetPoint("LEFT", Spec_2_Preview, "LEFT", -(6+HP_Border_Thickness), 0)
	HP_f.Border_preview2:SetPoint("RIGHT", Spec_2_Preview, "RIGHT", (6+HP_Border_Thickness), 0)
	HP_f.Border_preview2:SetPoint("BOTTOM", Spec_2_Preview, "BOTTOM", 0, -(6+HP_Border_Thickness))
	HP_f.Border_preview2:SetPoint("TOP", Spec_2_Preview, "TOP", 0, (6+HP_Border_Thickness))

	-- Create background border frame for preview icon
	HP_t.Background_preview1 = HP_f.Border_preview1:CreateTexture(HP_BB_preview1, "BACKGROUND")
	HP_t.Background_preview1:SetPoint("LEFT", HP_f.Border_preview1, "LEFT", -HP_Border_Background_Thickness, 0)
	HP_t.Background_preview1:SetPoint("RIGHT", HP_f.Border_preview1, "RIGHT", HP_Border_Background_Thickness, 0)
	HP_t.Background_preview1:SetPoint("BOTTOM", HP_f.Border_preview1, "BOTTOM", 0, -HP_Border_Background_Thickness)
	HP_t.Background_preview1:SetPoint("TOP", HP_f.Border_preview1, "TOP", 0, HP_Border_Background_Thickness)
	HP_t.Background_preview1.texture = HP_t.Background_preview1
	HP_t.Background_preview1:Hide()

	HP_t.Background_preview2 = HP_f.Border_preview2:CreateTexture(HP_BB_preview2, "BACKGROUND")
	HP_t.Background_preview2:SetPoint("LEFT", HP_f.Border_preview2, "LEFT", -HP_Border_Background_Thickness, 0)
	HP_t.Background_preview2:SetPoint("RIGHT", HP_f.Border_preview2, "RIGHT", HP_Border_Background_Thickness, 0)
	HP_t.Background_preview2:SetPoint("BOTTOM", HP_f.Border_preview2, "BOTTOM", 0, -HP_Border_Background_Thickness)
	HP_t.Background_preview2:SetPoint("TOP", HP_f.Border_preview2, "TOP", 0, HP_Border_Background_Thickness)
	HP_t.Background_preview2.texture = HP_t.Background_preview2
	HP_t.Background_preview2:Hide()

	if HP_Border_Flag == 1 then
		HP_f.Border:Show()
	else
		HP_f.Border:Hide()
	end

	HP_Border_Control_Apply()
end
function HP_Border_Control_Apply()
	HP_Border_Background_Thickness = (HP_Border_Thickness + 1)

	-- Apply sizing to borders and backgrounds
	-- Main Bar Border
	HP_f.Border:SetPoint("LEFT", HP_f, "LEFT", -(6+HP_Border_Thickness), 0)
	HP_f.Border:SetPoint("RIGHT", HP_f, "RIGHT", (6+HP_Border_Thickness), 0)
	HP_f.Border:SetPoint("BOTTOM", HP_f, "BOTTOM", 0, -(6+HP_Border_Thickness))
	HP_f.Border:SetPoint("TOP", HP_f, "TOP", 0, (6+HP_Border_Thickness))

	-- Main Bar Background
	HP_t.Background:SetPoint("LEFT", HP_f.Border, "LEFT", -HP_Border_Background_Thickness, 0)
	HP_t.Background:SetPoint("RIGHT", HP_f.Border, "RIGHT", HP_Border_Background_Thickness, 0)
	HP_t.Background:SetPoint("BOTTOM", HP_f.Border, "BOTTOM", 0, -HP_Border_Background_Thickness)
	HP_t.Background:SetPoint("TOP", HP_f.Border, "TOP", 0, HP_Border_Background_Thickness)
	HP_t.Background.texture = HP_t.Background
	HP_t.Background:Hide()

	-- Spec 1 Preview Border
	HP_f.Border_preview1:SetPoint("LEFT", Spec_1_Preview, "LEFT", -(6+HP_Border_Thickness), 0)
	HP_f.Border_preview1:SetPoint("RIGHT", Spec_1_Preview, "RIGHT", (6+HP_Border_Thickness), 0)
	HP_f.Border_preview1:SetPoint("BOTTOM", Spec_1_Preview, "BOTTOM", 0, -(6+HP_Border_Thickness))
	HP_f.Border_preview1:SetPoint("TOP", Spec_1_Preview, "TOP", 0, (6+HP_Border_Thickness))

	-- Spec 2 Preview Border
	HP_f.Border_preview2:SetPoint("LEFT", Spec_2_Preview, "LEFT", -(6+HP_Border_Thickness), 0)
	HP_f.Border_preview2:SetPoint("RIGHT", Spec_2_Preview, "RIGHT", (6+HP_Border_Thickness), 0)
	HP_f.Border_preview2:SetPoint("BOTTOM", Spec_2_Preview, "BOTTOM", 0, -(6+HP_Border_Thickness))
	HP_f.Border_preview2:SetPoint("TOP", Spec_2_Preview, "TOP", 0, (6+HP_Border_Thickness))

	-- Spec 1 Preview Background
	HP_t.Background_preview1:SetPoint("LEFT", HP_f.Border_preview1, "LEFT", -HP_Border_Background_Thickness, 0)
	HP_t.Background_preview1:SetPoint("RIGHT", HP_f.Border_preview1, "RIGHT", HP_Border_Background_Thickness, 0)
	HP_t.Background_preview1:SetPoint("BOTTOM", HP_f.Border_preview1, "BOTTOM", 0, -HP_Border_Background_Thickness)
	HP_t.Background_preview1:SetPoint("TOP", HP_f.Border_preview1, "TOP", 0, HP_Border_Background_Thickness)
	HP_t.Background_preview1.texture = HP_t.Background_preview1
	HP_t.Background_preview1:Hide()

	-- Spec 2 Preview Background
	HP_t.Background_preview2:SetPoint("LEFT", HP_f.Border_preview2, "LEFT", -HP_Border_Background_Thickness, 0)
	HP_t.Background_preview2:SetPoint("RIGHT", HP_f.Border_preview2, "RIGHT", HP_Border_Background_Thickness, 0)
	HP_t.Background_preview2:SetPoint("BOTTOM", HP_f.Border_preview2, "BOTTOM", 0, -HP_Border_Background_Thickness)
	HP_t.Background_preview2:SetPoint("TOP", HP_f.Border_preview2, "TOP", 0, HP_Border_Background_Thickness)
	HP_t.Background_preview2.texture = HP_t.Background_preview2
	HP_t.Background_preview2:Hide()

	-- Apply main bar borders
	if HP_currentSpec == 1 and Theme_Icon_Spec1_Flag == 1 then
		if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
			HP_t.Background:Show()
		else
			HP_t.Background:Hide()
		end
	elseif HP_currentSpec == 2 and Theme_Icon_Spec2_Flag == 1 then
		if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
			HP_t.Background:Show()
		else
			HP_t.Background:Hide()
		end
	end
		HP_f.Border:SetBackdrop({edgeFile = "Interface\\AddOns\\HaloPro\\HaloPro_Art\\Border\\"..HP_DarkLight.."\\"..HP_Border_Theme,
									tile = true, tileSize = 8, edgeSize = (8+HP_Border_Thickness),
									insets = { left = (2+HP_Border_Thickness), right = (2+HP_Border_Thickness), top = (2+HP_Border_Thickness), bottom = (2+HP_Border_Thickness) }});
		HP_f.Border:SetBackdropBorderColor(HP_Colour_R,HP_Colour_G,HP_Colour_B,1)

	-- Apply theme preview bar borders
	if Theme_Icon_Spec1_Flag == 1 then
		if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
			HP_t.Background_preview1:Show()
		else
			HP_t.Background_preview1:Hide()
		end
	else
		HP_t.Background_preview1:Hide()
	end

	HP_f.Border_preview1:SetBackdrop({edgeFile = "Interface\\AddOns\\HaloPro\\HaloPro_Art\\Border\\"..HP_DarkLight.."\\"..HP_Border_Theme,
											tile = true, tileSize = 8, edgeSize = (8+HP_Border_Thickness),
											insets = { left = (2+HP_Border_Thickness), right = (2+HP_Border_Thickness), top = (2+HP_Border_Thickness), bottom = (2+HP_Border_Thickness) }});
	HP_f.Border_preview1:SetBackdropBorderColor(HP_Colour_R,HP_Colour_G,HP_Colour_B,1)
	if Theme_Icon_Spec2_Flag == 1 then
		if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
			HP_t.Background_preview2:Show()
		else
			HP_t.Background_preview2:Hide()
		end
	else
		HP_t.Background_preview2:Hide()
	end
	HP_f.Border_preview2:SetBackdrop({edgeFile = "Interface\\AddOns\\HaloPro\\HaloPro_Art\\Border\\"..HP_DarkLight.."\\"..HP_Border_Theme,
											tile = true, tileSize = 8, edgeSize = (8+HP_Border_Thickness),
											insets = { left = (2+HP_Border_Thickness), right = (2+HP_Border_Thickness), top = (2+HP_Border_Thickness), bottom = (2+HP_Border_Thickness) }});
	HP_f.Border_preview2:SetBackdropBorderColor(HP_Colour_R,HP_Colour_G,HP_Colour_B,1)
-- Set Backgrounds
	HP_t.Background:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\Border\\"..HP_DarkLight.."\\"..HP_Border_Background)
	HP_t.Background_preview1:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\Border\\"..HP_DarkLight.."\\"..HP_Border_Background)
	HP_t.Background_preview2:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\Border\\"..HP_DarkLight.."\\"..HP_Border_Background)

end

function HPSound()

	-- Create the HPSound_dropDown, and configure its appearance
	HPSound_dropDown = CreateFrame("Frame", "HPSoundDropDown", HP_Options_Sub_Panel, "UIDropDownMenuTemplate")
	HPSound_dropDown:SetPoint("Center",-140, 75)
	UIDropDownMenu_SetWidth(HPSound_dropDown, 125)
	UIDropDownMenu_SetText(HPSound_dropDown,HP_Sound)

	-- Create and bind the initialization function to the HPSound_dropDown menu
	UIDropDownMenu_Initialize(HPSound_dropDown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		if (level or 1) == 1 then
			for i=0,7 do
				if i == 0 then
					info.text, info.arg1 = "Human Exploration", i
				elseif i == 1 then
					info.text, info.arg1 = "PVP Enter Queue", i
				elseif i == 2 then
					info.text, info.arg1 = "Main Menu Open", i
				elseif i == 3 then
					info.text, info.arg1 = "Item Weapon Sound", i
				elseif i == 4 then
					info.text, info.arg1 = "Quest Added", i
				elseif i == 5 then
					info.text, info.arg1 = "Quest Completed", i
				elseif i == 6 then
					info.text, info.arg1 = "Mini Map Open", i
				elseif i == 7 then
					info.text, info.arg1 = "Map Ping", i
				elseif i == 8 then
					info.text, info.arg1 = "Talent Screen Open", i
				elseif i == 9 then
					info.text, info.arg1 = "Generic Sound", i
				elseif i == 10 then
					info.text, info.arg1 = "Deathbind Sound", i
				end
				UIDropDownMenu_AddButton(info)
			end
		else
			-- Display a nested group
		end
	end)

-- Implement the function to change the Sound
	function HPSound_dropDown:SetValue(newValue)
		if newValue == 0 then
			HP_Sound = "HumanExploration"
		elseif newValue == 1 then
			HP_Sound = "PVPENTERQUEUE"
		elseif newValue == 2 then
			HP_Sound = "igMainMenuOpen"
		elseif newValue == 3 then
			HP_Sound = "ITEMWEAPONSOUND"
		elseif newValue == 4 then
			HP_Sound = "QUESTADDED"
		elseif newValue == 5 then
			HP_Sound = "QUESTCOMPLETED"
		elseif newValue == 6 then
			HP_Sound = "igMiniMapOpen"
		elseif newValue == 7 then
			HP_Sound = "MapPing"
		elseif newValue == 8 then
			HP_Sound = "TalentScreenOpen"
		elseif newValue == 9 then
			HP_Sound = "ITEMGENERICSOUND"
		elseif newValue == 10 then
			HP_Sound = "Deathbind Sound"
		end


		-- Update the text; if we merely wanted it to display newValue, we would not need to do this
		UIDropDownMenu_SetText(HPSound_dropDown, HP_Sound)

		-- Because this is called from a sub-menu, only that menu level is closed by default.
		-- Close the entire menu with this next call
		CloseDropDownMenus()
		PlaySound(HP_Sound,"master")

	end
end

function HPFrameStrata()

	-- Create the HPFrameStrata_dropDown, and configure its appearance
	HPFrameStrata_dropDown = CreateFrame("Frame", "HPFrameStrataDropDown", HP_Options_Sub_Panel, "UIDropDownMenuTemplate")
	HPFrameStrata_dropDown:SetPoint("Center",-140, 35)
	UIDropDownMenu_SetWidth(HPFrameStrata_dropDown, 125)
	UIDropDownMenu_SetText(HPFrameStrata_dropDown,HP_Strata)

	-- Create and bind the initialization function to the HPSound_dropDown menu
	UIDropDownMenu_Initialize(HPFrameStrata_dropDown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		if (level or 1) == 1 then
			for i=0,7 do
				if i == 0 then
					info.text, info.arg1 = "BACKGROUND", i
				elseif i == 1 then
					info.text, info.arg1 = "LOW", i
				elseif i == 2 then
					info.text, info.arg1 = "MEDIUM", i
				elseif i == 3 then
					info.text, info.arg1 = "HIGH", i
				elseif i == 4 then
					info.text, info.arg1 = "DIALOG", i
				elseif i == 5 then
					info.text, info.arg1 = "FULLSCREEN", i
				elseif i == 6 then
					info.text, info.arg1 = "FULLSCREEN DIALOG", i
				elseif i == 7 then
					info.text, info.arg1 = "TOOLTIP", i
				end
				UIDropDownMenu_AddButton(info)
			end
		else
			-- Display a nested group
		end
	end)

-- Implement the function to change the Strata
	function HPFrameStrata_dropDown:SetValue(newValue)
		if newValue == 0 then
			HP_Strata = "BACKGROUND"
		elseif newValue == 1 then
			HP_Strata = "LOW"
		elseif newValue == 2 then
			HP_Strata = "MEDIUM"
		elseif newValue == 3 then
			HP_Strata = "HIGH"
		elseif newValue == 4 then
			HP_Strata = "DIALOG"
		elseif newValue == 5 then
			HP_Strata = "FULLSCREEN"
		elseif newValue == 6 then
			HP_Strata = "FULLSCREEN_DIALOG"
		elseif newValue == 7 then
			HP_Strata = "TOOLTIP"
		end


		-- Update the text; if we merely wanted it to display newValue, we would not need to do this
		UIDropDownMenu_SetText(HPFrameStrata_dropDown, HP_Strata)

		-- Because this is called from a sub-menu, only that menu level is closed by default.
		-- Close the entire menu with this next call
		CloseDropDownMenus()
		HP_currentSpec = GetActiveSpecGroup()
		if HP_currentSpec == 1 then
			HP_Strata1 = HP_Strata
		elseif HP_currentSpec == 2 then
			HP_Strata2 = HP_Strata
		end
		HP_Restore_Strata()
		print("")
		print("HaloPro strata, now set to: "..HP_Strata)
		print("")

	end
end

function XY_Relative_Pos()
	point, relativeTo, relativePoint, xOfs, yOfs = HP_f:GetPoint()
	Relative_Point = point -- user-configurable setting

	-- Create the XY_REL_dropDown, and configure its appearance
	XY_REL_dropDown = CreateFrame("Frame", "XY_RelDropDown", HP_Options_Sub_Panel, "UIDropDownMenuTemplate")
	XY_REL_dropDown:SetPoint("Center",-370, -80)
	UIDropDownMenu_SetWidth(XY_REL_dropDown, 100)
	UIDropDownMenu_SetText(XY_REL_dropDown,Relative_Point)
	-- Create and bind the initialization function to the XY_REL_dropDown menu
	UIDropDownMenu_Initialize(XY_REL_dropDown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		if (level or 1) == 1 then
			for i=0,8 do
				if i == 0 then
					info.text, info.arg1 = "TOPLEFT", i
				elseif i == 1 then
					info.text, info.arg1 = "TOP", i
				elseif i == 2 then
					info.text, info.arg1 = "TOPRIGHT", i
				elseif i == 3 then
					info.text, info.arg1 = "LEFT", i
				elseif i == 4 then
					info.text, info.arg1 = "CENTER", i
				elseif i == 5 then
					info.text, info.arg1 = "RIGHT", i
				elseif i == 6 then
					info.text, info.arg1 = "BOTTOMLEFT", i
				elseif i == 7 then
					info.text, info.arg1 = "BOTTOM", i
				elseif i == 8 then
					info.text, info.arg1 = "BOTTOMRIGHT", i
				end
				UIDropDownMenu_AddButton(info)
			end
		else
		-- Display a nested group
		end
end)

-- Implement the function to change the Relative_Point
function XY_REL_dropDown:SetValue(newValue)
	if newValue == 0 then
		Relative_Point = "TOPLEFT"
	elseif newValue == 1 then
		Relative_Point= "TOP"
	elseif newValue == 2 then
		Relative_Point = "TOPRIGHT"
	elseif newValue == 3 then
		Relative_Point = "LEFT"
	elseif newValue == 4 then
		Relative_Point = "CENTER"
	elseif newValue == 5 then
		Relative_Point = "RIGHT"
	elseif newValue == 6 then
		Relative_Point = "BOTTOMLEFT"
	elseif newValue == 7 then
		Relative_Point = "BOTTOM"
	elseif newValue == 8 then
		Relative_Point = "BOTTOMRIGHT"
	end

	-- Update the text; if we merely wanted it to display newValue, we would not need to do this
	UIDropDownMenu_SetText(XY_REL_dropDown, Relative_Point)
	point = Relative_Point
	-- Because this is called from a sub-menu, only that menu level is closed by default.
	-- Close the entire menu with this next call
	CloseDropDownMenus()
	HP_Set_Position()
end
end

function HaloPro_Panel_OnLoad(panel)
	panel.name = "HaloPro " .. GetAddOnMetadata("HaloPro", "Version"); -- Set the name for the Category for the Panel
	HP_Panel_Name_Store = panel.name

    panel.okay = function (self)      -- When the player clicks okay, run this function.
		if Lock_Flag == 0 and temp_HPShow == 1 then
			HP_InCombatOnly = 0
		end
		if HP_Lvl90_Flag == 0 then
			HP_f_Hide()
		end
		HP_options_open_Flag = 0
		HP_Lock()
	end;

    panel.cancel = function (self)        -- When the player clicks cancel, run this function.
		if Lock_Flag == 0 and temp_HPShow == 1 then
			HP_InCombatOnly = 0
		end
		if HP_Lvl90_Flag == 0 then
			HP_f_Hide()
		end
		HP_options_open_Flag = 0
		HP_Lock()
	end;

	panel.default = function (self)
		Default_HP_Settings()
	end;

	panel.refresh = function (self)

		if HP_Lvl90_Flag == 0 then
			if HC_spellName_120517 ~= nil or DS_spellName_110744 ~= nil or CC_spellName_121135 ~= nil then
				Lock_checkButton:Show()
				No_Halo_Msg:Hide()
			else
				Lock_Flag = 1
				Lock_checkButton:Hide()
				No_Halo_Msg:Show()
			end
		else
			Lock_checkButton:Show()
			No_Halo_Msg:Hide()
		end
		if Lock_Flag == 0 then
			Background_HaloPro_Frame:Hide()
			if temp_HPShow == 1 then
				HP_InCombatOnly = 1
			end
			HP_options_open_Flag = 1
			if HP_Lvl90_Flag == 1 then
				HP_options_open_Flag = 1
				FrameTextureUpdate(nil, nil, true)
			end
			Lock_checkButton:SetChecked(false)
			Lock_checkButton.text:SetText("HaloPro is Unlocked - Check to lock")
			FadeINSlider:SetValue(HP_fadeintimer)
			MaxASlider:SetValue(HP_max_alpha_adjust)
			FlashNumSlider:SetValue(HP_flash_num)
			FlashSpeedSlider:SetValue(HP_tcount_time1)
			Set_HP_Height:Show()
			Set_HP_Width:Show()
			Set_HP_X_Pos:Show()
			Set_HP_Y_Pos:Show()
			point, relativeTo, relativePoint, xOfs, yOfs = HP_f:GetPoint()
			local HP_Round_xOfs = xOfs - (floor(xOfs))
			if HP_Round_xOfs < .5 then
				xOfs = (floor(xOfs))
			else
				xOfs = (ceil(xOfs))
			end
			Set_HP_X_Pos:SetText(xOfs)
			local HP_Round_yOfs = yOfs - (floor(yOfs))
			if HP_Round_yOfs < .5 then
				yOfs = (floor(yOfs))
			else
				yOfs = (ceil(yOfs))
			end
			Set_HP_Y_Pos:SetText(yOfs)
			Relative_Point = point -- user-configurable setting
			UIDropDownMenu_SetText(HPSound_dropDown,HP_Sound)
			UIDropDownMenu_SetText(HPFrameStrata_dropDown,HP_Strata)
			UIDropDownMenu_SetText(XY_REL_dropDown,Relative_Point)
			HP_Sub_Panel_Refresh(HP_Options_Sub_Panel)
			HP_VertBar_Button_Refresh(HP_Options_Sub_Panel)
			HP_Sound_Refresh(HP_Options_Sub_Panel)
			HP_Strata_Refresh(HP_Options_Sub_Panel)
			UnLocked_HP_Panel(panel)
			HP_Lock()
			HP_Track_Toggle:SetText("Track: "..HP_Tracking)
			HP_Always_Show_button:SetText("Always Show: "..HP_Always_Show_Flag)
			if HP_Always_Show_Flag == 'No' then
				HP_Always_Show_button:UnlockHighlight()
				HP_Always_Show_button:SetButtonState("NORMAL")
			elseif HP_Always_Show_Flag == 'Yes' then
				HP_Always_Show_button:LockHighlight()
				HP_Always_Show_button:SetButtonState("PUSHED")
			end
			if HP_Monitor_DS == 1 then
				HP_DS_Monitor_Button:LockHighlight()
				HP_DS_Monitor_Button:SetButtonState("PUSHED")
			elseif HP_Monitor_DS == 0 then
				HP_DS_Monitor_Button:UnlockHighlight()
				HP_DS_Monitor_Button:SetButtonState("NORMAL")
			end
			if HP_Monitor_CC == 1 then
				HP_CasC_Monitor_Button:LockHighlight()
				HP_CasC_Monitor_Button:SetButtonState("PUSHED")
			elseif HP_Monitor_CC == 0 then
				HP_CasC_Monitor_Button:UnlockHighlight()
				HP_CasC_Monitor_Button:SetButtonState("NORMAL")
			end
			if HP_FadeIn_Disable == 1 then
				Fade_Toggle_Button:LockHighlight()
				Fade_Toggle_Button:SetText("Fade In: Disabled")
			elseif HP_FadeIn_Disable == 0 then
				Fade_Toggle_Button:UnlockHighlight()
				Fade_Toggle_Button:SetText("Fade In: Enabled")
			end
			if HP_options_open_Flag == 1 then
				FrameTextureUpdate(nil, nil, true)
				FrameTextureUpdate(false)
			end
		elseif Lock_Flag == 1 then
			Background_HaloPro_Frame:Show()
			Lock_checkButton:SetChecked(true)
			Lock_checkButton.text:SetText("HaloPro is Locked")
			FadeINSlider:SetValue(HP_fadeintimer)
			MaxASlider:SetValue(HP_max_alpha_adjust)
			FlashNumSlider:SetValue(HP_flash_num)
			FlashSpeedSlider:SetValue(HP_tcount_time1)
			Set_HP_Height:Show()
			Set_HP_Width:Show()
			Set_HP_X_Pos:Show()
			Set_HP_Y_Pos:Show()
			point, relativeTo, relativePoint, xOfs, yOfs = HP_f:GetPoint()
			local HP_Round_xOfs = xOfs - (floor(xOfs))
			if HP_Round_xOfs < .5 then
				xOfs = (floor(xOfs))
			else
				xOfs = (ceil(xOfs))
			end
			Set_HP_X_Pos:SetText(xOfs)
			local HP_Round_yOfs = yOfs - (floor(yOfs))
			if HP_Round_yOfs < .5 then
				yOfs = (floor(yOfs))
			else
				yOfs = (ceil(yOfs))
			end
			Set_HP_Y_Pos:SetText(yOfs)
			Relative_Point = point -- user-configurable setting
			UIDropDownMenu_SetText(HPSound_dropDown,HP_Sound)
			UIDropDownMenu_SetText(HPFrameStrata_dropDown,HP_Strata)
			UIDropDownMenu_SetText(XY_REL_dropDown,Relative_Point)
			HP_Sub_Panel_Refresh(HP_Options_Sub_Panel)
			HP_VertBar_Button_Refresh(HP_Options_Sub_Panel)
			HP_Sound_Refresh(HP_Options_Sub_Panel)
			HP_Strata_Refresh(HP_Options_Sub_Panel)
			UnLocked_HP_Panel(panel)
			HP_Lock()
			HP_Track_Toggle:SetText("Track: "..HP_Tracking)
			HP_Always_Show_button:SetText("Always Show: "..HP_Always_Show_Flag)
			if HP_Always_Show_Flag == 'No' then
				HP_Always_Show_button:UnlockHighlight()
				HP_Always_Show_button:SetButtonState("NORMAL")
			elseif HP_Always_Show_Flag == 'Yes' then
				HP_Always_Show_button:LockHighlight()
				HP_Always_Show_button:SetButtonState("PUSHED")
			end
			if HP_Monitor_DS == 1 then
				HP_DS_Monitor_Button:LockHighlight()
				HP_DS_Monitor_Button:SetButtonState("PUSHED")
			elseif HP_Monitor_DS == 0 then
				HP_DS_Monitor_Button:UnlockHighlight()
				HP_DS_Monitor_Button:SetButtonState("NORMAL")
			end
			if HP_Monitor_CC == 1 then
				HP_CasC_Monitor_Button:LockHighlight()
				HP_CasC_Monitor_Button:SetButtonState("PUSHED")
			elseif HP_Monitor_CC == 0 then
				HP_CasC_Monitor_Button:UnlockHighlight()
				HP_CasC_Monitor_Button:SetButtonState("NORMAL")
			end
			if HP_FadeIn_Disable == 1 then
				Fade_Toggle_Button:SetText("Fade In: Disabled")
			elseif HP_FadeIn_Disable == 0 then
				Fade_Toggle_Button:SetText("Fade In: Enabled")
			end
			if HP_options_open_Flag == 1 then
				FrameTextureUpdate(nil, nil, true)
				FrameTextureUpdate(false)
			end
		end
	end

 -- Register in the Interface Addon Options GUI
 -- Set the name for the Category for the Options Panel
 -- Add the panel to the Interface Options

	InterfaceOptions_AddCategory(panel);  -- Add the panel to the Interface Options

	HaloPro_CreateOptionsPanel(panel)
end
function HP_Get_Position()
	point, relativeTo, relativePoint, xOfs, yOfs = HP_f:GetPoint()
	local HP_Round_xOfs = xOfs - (floor(xOfs))
	if HP_Round_xOfs < .5 then
		xOfs = (floor(xOfs))
	else 
		xOfs = (ceil(xOfs))
	end
	local HP_Round_yOfs = yOfs - (floor(xOfs))
	if HP_Round_yOfs < .5 then
		yOfs = (floor(yOfs))
	else
		yOfs = (ceil(yOfs))
	end
	if HP_options_open_Flag == 1 then
		Set_HP_X_Pos:SetText(xOfs)
		Set_HP_Y_Pos:SetText(yOfs)
	end
end
function HP_Set_Position()
	HP_f:ClearAllPoints()
	if HP_resize_check == 1 then
		HP_f:SetPoint(Rel_Set_Point,xOfs,yOfs)
	else
		Rel_Set_Point = ""..point..""
		HP_f:SetPoint(Rel_Set_Point,xOfs,yOfs)
	end
	if HP_currentSpec == 1 then
		xOfs_Spec1_backup = xOfs
		yOfs_Spec1_backup = yOfs
		Rel_Set_Point_Spec1_backup = Rel_Set_Point
	elseif HP_currentSpec == 2 then
		xOfs_Spec2_backup = xOfs
		yOfs_Spec2_backup = yOfs
		Rel_Set_Point_Spec2_backup = Rel_Set_Point
	end

	HP_Sub_Panel_Refresh(HP_Options_Sub_Panel)
end
function HP_Resize_height()
	HP_currentSpec = GetActiveSpecGroup()
	if HP_currentSpec == 1 then
		if Theme_Index_Spec1 == 1 or Theme_Index_Spec1 == 2 or Theme_Index_Spec1 == 3 then
			HP_Spec1_Height = HP_height
		end
	elseif HP_currentSpec == 2 then
		if Theme_Index_Spec2 == 1 or Theme_Index_Spec2 == 2 or Theme_Index_Spec2 == 3 then
			HP_Spec2_Height = HP_height
		end
	end

	if HP_VertBar_Flag == 1 then
		HP_f:SetHeight(HP_width) 	-- for your Texture
		HP_f:SetWidth(HP_height) 	-- Set these to whatever height/width is needed
	else
		HP_f:SetHeight(HP_height) -- for your Texture
		HP_f:SetWidth(HP_width) -- for your Texture
	end

	HP_Sub_Panel_Refresh(HP_Options_Sub_Panel)
end
function HP_Resize_width()
	HP_currentSpec = GetActiveSpecGroup()
	if HP_currentSpec == 1 then
		if Theme_Index_Spec1 == 1 or Theme_Index_Spec1 == 2 or Theme_Index_Spec1 == 3 then
			HP_Spec1_Width = HP_width
		end
	elseif HP_currentSpec == 2 then
		if Theme_Index_Spec2 == 1 or Theme_Index_Spec2 == 2 or Theme_Index_Spec2 == 3 then
			HP_Spec2_Width = HP_width
		end
	end

	if HP_VertBar_Flag == 1 then
		HP_f:SetWidth(HP_height) 	-- Set these to whatever height/width is needed
		HP_f:SetHeight(HP_width) 	-- for your Texture
	else
		HP_f:SetWidth(HP_width) -- for your Texture
		HP_f:SetHeight(HP_height) -- for your Texture
	end

	HP_Sub_Panel_Refresh(HP_Options_Sub_Panel)
end
function HP_Sub_Panel_Refresh(HP_Options_Sub_Panel)
	Set_HP_Height:SetNumber(HP_height)
	HeightSlider:SetValue(HP_height)
	Set_HP_Width:SetNumber(HP_width)
	WidthSlider:SetValue(HP_width)
	XposSlider:SetValue(xOfs)
	Set_HP_X_Pos:SetText(xOfs)
	YposSlider:SetValue(yOfs)
	Set_HP_Y_Pos:SetText(yOfs)
end
function HP_VertBar_Button_Refresh(HP_Options_Sub_Panel)
	if HP_VertBar_Flag == nil then
		HP_VertBar_Flag = default_HP_VertBar_Flag
	end
	if HP_VertBar_Flag == 0  then
		HP_t:SetTexCoord(0,0, 0,1, 1,0, 1,1)
		HP_Resize_height()
		HP_Resize_width()
		VertBar_checkButton:SetChecked(false)
		VertBar_checkButton.text:SetText("Horizontal Bar Enabled - Check to enable Vertical Bar")
	elseif HP_Sound_Flag == 1 then
		HP_t:SetTexCoord(0,1, 1,1, 0,0, 1,0)
		HP_Resize_height()
		HP_Resize_width()
		VertBar_checkButton:SetChecked(true)
		VertBar_checkButton.text:SetText("Vertical Bar Enabled - Uncheck to restore Horizontal Bar")
	end
	if HP_VertBar_Flag == 1 then
		HeightSlider.tooltipText = 'Adjust the width of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and mouse wheel scroll, to adjust width)'   -- Creates a tooltip on mouseover.
		_G[HeightSlider:GetName() .. 'Low']:SetText('shorter')    -- Sets the left-side slider text (default is "Low").
		_G[HeightSlider:GetName() .. 'High']:SetText('wider')     -- Sets the right-side slider text (default is "High").
		_G[HeightSlider:GetName() .. 'Text']:SetText('Width')     -- Sets the "title" text (top-centre of slider).
		WidthSlider.tooltipText = 'Adjust the height of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and SHIFT + mouse wheel scroll, to adjust height)'   -- Creates a tooltip on mouseover.
		_G[WidthSlider:GetName() .. 'Low']:SetText('thinner')     -- Sets the left-side slider text (default is "Low").
		_G[WidthSlider:GetName() .. 'High']:SetText('thicker')    -- Sets the right-side slider text (default is "High").
		_G[WidthSlider:GetName() .. 'Text']:SetText('Height')     -- Sets the "title" text (top-centre of slider).
	else
		WidthSlider.tooltipText = 'Adjust the width of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and mouse wheel scroll, to adjust width)'   -- Creates a tooltip on mouseover.
		_G[WidthSlider:GetName() .. 'Low']:SetText('shorter')    -- Sets the left-side slider text (default is "Low").
		_G[WidthSlider:GetName() .. 'High']:SetText('wider')     -- Sets the right-side slider text (default is "High").
		_G[WidthSlider:GetName() .. 'Text']:SetText('Width')     -- Sets the "title" text (top-centre of slider).
		HeightSlider.tooltipText = 'Adjust the height of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and SHIFT + mouse wheel scroll, to adjust height)'   -- Creates a tooltip on mouseover.
		_G[HeightSlider:GetName() .. 'Low']:SetText('thinner')     -- Sets the left-side slider text (default is "Low").
		_G[HeightSlider:GetName() .. 'High']:SetText('thicker')    -- Sets the right-side slider text (default is "High").
		_G[HeightSlider:GetName() .. 'Text']:SetText('Height')     -- Sets the "title" text (top-centre of slider).
	end
	
	-- OnClick Handler for Vertical Bar
	VertBar_checkButton:SetScript("OnClick", function(self)
		isVertBar_checkButton = self:GetChecked();
		if isVertBar_checkButton == nill then
			WidthSlider.tooltipText = 'Adjust the width of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and mouse wheel scroll, to adjust width)'   -- Creates a tooltip on mouseover.
			_G[WidthSlider:GetName() .. 'Low']:SetText('shorter')    -- Sets the left-side slider text (default is "Low").
			_G[WidthSlider:GetName() .. 'High']:SetText('wider')     -- Sets the right-side slider text (default is "High").
			_G[WidthSlider:GetName() .. 'Text']:SetText('Width')     -- Sets the "title" text (top-centre of slider).
			HeightSlider.tooltipText = 'Adjust the height of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and SHIFT + mouse wheel scroll, to adjust height)'   -- Creates a tooltip on mouseover.
			_G[HeightSlider:GetName() .. 'Low']:SetText('thinner')     -- Sets the left-side slider text (default is "Low").
			_G[HeightSlider:GetName() .. 'High']:SetText('thicker')    -- Sets the right-side slider text (default is "High").
			_G[HeightSlider:GetName() .. 'Text']:SetText('Height')     -- Sets the "title" text (top-centre of slider).
			HP_VertBar_Flag = 0
			HP_t:SetTexCoord(0,0, 0,1, 1,0, 1,1)
			HP_Resize_height()
			HP_Resize_width()
			VertBar_checkButton:SetChecked(false)
			VertBar_checkButton.text:SetText("Horizontal Bar Enabled - Check to enable Vertical Bar")
		else
			HeightSlider.tooltipText = 'Adjust the width of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and mouse wheel scroll, to adjust width)'   -- Creates a tooltip on mouseover.
			_G[HeightSlider:GetName() .. 'Low']:SetText('shorter')    -- Sets the left-side slider text (default is "Low").
			_G[HeightSlider:GetName() .. 'High']:SetText('wider')     -- Sets the right-side slider text (default is "High").
			_G[HeightSlider:GetName() .. 'Text']:SetText('Width')     -- Sets the "title" text (top-centre of slider).
			WidthSlider.tooltipText = 'Adjust the height of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and SHIFT + mouse wheel scroll, to adjust height)'   -- Creates a tooltip on mouseover.
			_G[WidthSlider:GetName() .. 'Low']:SetText('thinner')     -- Sets the left-side slider text (default is "Low").
			_G[WidthSlider:GetName() .. 'High']:SetText('thicker')    -- Sets the right-side slider text (default is "High").
			_G[WidthSlider:GetName() .. 'Text']:SetText('Height')     -- Sets the "title" text (top-centre of slider).
			HP_VertBar_Flag = 1
			HP_t:SetTexCoord(0,1, 1,1, 0,0, 1,0)
			HP_Resize_height()
			HP_Resize_width()
			VertBar_checkButton:SetChecked(true)
			VertBar_checkButton.text:SetText("Vertical Bar Enabled - Uncheck to restore Horizontal Bar")
		end
	end)
end
function HP_Sound_Refresh(HP_Options_Sub_Panel)
	if HP_Sound_Flag == nil then
		HP_Sound_Flag = default_HP_Sound_Flag
	end
	if HP_Sound_Flag == 0  then
		Sound_checkButton:SetChecked(false)
		Sound_checkButton.text:SetText("Sound warning is disabled - Check to enable sound warning")
		HPSound_dropDown:Hide()
	elseif HP_Sound_Flag == 1 then
		Sound_checkButton:SetChecked(true)
		Sound_checkButton.text:SetText("WILL play sound warning |n  when in proper spell range")
		HPSound_dropDown:Show()
	end

	-- OnClick Handler for Sound
	Sound_checkButton:SetScript("OnClick", function(self)
		isSound_checkButton = self:GetChecked();
		if isSound_checkButton == nill then
			HP_Sound_Flag = 0
			Sound_checkButton:SetChecked(false)
			Sound_checkButton.text:SetText("Sound warning is disabled - Check to enable sound warning")
			HPSound_dropDown:Hide()
		else
			HP_Sound_Flag = 1
			Sound_checkButton:SetChecked(true)
			Sound_checkButton.text:SetText("WILL play sound warning |n  when in proper spell range")
			HPSound_dropDown:Show()
		end
	end)
end
function HP_Strata_Refresh(HP_Options_Sub_Panel)
	if HP_Strata_Flag == nil then
		HP_Strata_Flag = 0
	end
	if HP_Strata_Flag == 0  then
		HP_Strata_checkButton:SetChecked(false)
		HP_Strata_checkButton.text:SetText("HaloPro Strata Level Locked - Check to adjust Strata Level")
		HPFrameStrata_dropDown:Hide()
	elseif HP_Strata_Flag == 1 then
		HP_Strata_checkButton:SetChecked(true)
		HP_Strata_checkButton.text:SetText("HaloPro Strata Level unlocked |n Adjust level with dropdown menu")
		HPFrameStrata_dropDown:Show()
	end

	-- OnClick Handler for Strata Adjustment
	HP_Strata_checkButton:SetScript("OnClick", function(self)
		isHP_Strata_checkButton = self:GetChecked();
		if isHP_Strata_checkButton == nill then
			HP_Strata_Flag = 0
			HP_Strata_checkButton:SetChecked(false)
			HP_Strata_checkButton.text:SetText("HaloPro Strata Level Locked - Check to adjust Strata Level")
			HPFrameStrata_dropDown:Hide()
		else
			HP_Strata_Flag = 1
			HP_Strata_checkButton:SetChecked(true)
			HP_Strata_checkButton.text:SetText("HaloPro Strata Level unlocked |n Adjust level with dropdown menu")
			HPFrameStrata_dropDown:Show()
		end
	end)
end
function HaloPro_CreateOptionsPanel(panel)
	HP_Options = {};
	HP_Options.panel = CreateFrame( "Frame","HP_Options_Panel",panel)

	-- Make a child panel to hold the theme options
	HP_Options_Theme = CreateFrame( "Frame", "HP_Options_Theme", panel);
	HP_Options_Theme.name = "Theme";
	HP_Options_Theme.parent = HP_Panel_Name_Store; -- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
 	InterfaceOptions_AddCategory(HP_Options_Theme); -- Add the child to the Interface Options

	HP_Options_Theme.okay = function (self)      -- When the player clicks okay, run this function.
		if HP_Lvl90_Flag == 0 then
			HP_f_Hide()
		end
		HP_options_open_Flag = 0
		HP_Lock()
		collectgarbage("collect")
	end;

    HP_Options_Theme.cancel = function (self)        -- When the player clicks cancel, run this function.
		if HP_Lvl90_Flag == 0 then
			HP_f_Hide()
		end
		HP_options_open_Flag = 0
		HP_Lock()
		collectgarbage("collect")
	end;

	HP_Options_Theme.default = function (self)
		Default_HP_Settings()
	end;

	HP_Options_Theme.refresh = function (self)
		Theme_select_Spec_store()
		Spec1_T_Slider:SetValue(Theme_Index_Spec1)
		Spec1_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec1.."\\center.tga")
		Spec2_T_Slider:SetValue(Theme_Index_Spec2)
		Spec2_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec2.."\\center.tga")
		Current_Talents_Msg:SetText('Currently, you are using '..HP_activeSpec..'|n&|n')
		Current_Special_Msg:SetText(HP_activeSpecial)
		if HP_Border_Flag == 0 then
			HP_Border_Control_Apply()
			Border_checkButton:SetChecked(false)
			Border_checkButton.text:SetText("HaloPro borders are disabled - Check to enable borders")
			if HP_DarkLight == "Dark" then
				DarkLight_Slider:SetValue(1)
			elseif HP_DarkLight == "Light" then
				DarkLight_Slider:SetValue(2)
			end
			HP_f.Border:Hide()
			HP_f.Border_preview1:Hide()
			HP_f.Border_preview2:Hide()
			HP_Border_Opts_Main:Hide()
		elseif HP_Border_Flag == 1 then
			HP_Border_Control_Apply()
			Border_checkButton:SetChecked(true)
			Border_checkButton.text:SetText("HaloPro borders are enabled - Uncheck to disable borders")
			if HP_DarkLight == "Dark" then
				DarkLight_Slider:SetValue(1)
			elseif HP_DarkLight == "Light" then
				DarkLight_Slider:SetValue(2)
			end
			HP_f.Border:Show()
			HP_f.Border_preview1:Show()
			HP_f.Border_preview2:Show()
			HP_Border_Opts_Main:Show()
		end
		if HP_Border_Theme == "glowTex.tga" then
			HP_Border_Slider:SetValue(1)
		elseif HP_Border_Theme == "border.tga" then
			HP_Border_Slider:SetValue(2)
		elseif HP_Border_Theme == "solidBorder.tga" then
			HP_Border_Slider:SetValue(3)
		end
		HP_Thickness_Slider:SetValue(HP_Border_Thickness)
	end

	-- Create No Halo messages
	No_Halo_Msg = CreateFrame("Frame", "No_Halo_Msg", panel)
	No_Halo_Msg:SetAllPoints()
	No_Halo_Msg = No_Halo_Msg:CreateFontString(nil, 'OVERLAY')
	No_Halo_Msg:SetFont(STANDARD_TEXT_FONT, 22, "OUTLINE")
	No_Halo_Msg:SetText('You currently do not know any tier 6 (lvl 90) talents.|n|nPlease learn either: Cascade, Divine Star or Halo,|n|nto use HaloPro|r')
	--HP_Unlocked_Msg:SetText('|cff00ddaashift + mousewheel to scale bar|nalt + mousewheel to change buttons padding|nmousewheel to change columns|r')
	No_Halo_Msg:SetPoint('CENTER',0,10)
	No_Halo_Msg:Hide()

	-- Create Background Menu Image Frame
	Background_HaloPro_Frame = CreateFrame("Frame", "Background_HaloPro_Frame", panel)
	--Background_HaloPro_Frame:SetAllPoints()
	Background_HaloPro_Frame:SetFrameStrata("BACKGROUND")
	Background_HaloPro_Frame:SetWidth(625)
	Background_HaloPro_Frame:SetHeight(870)
	Background_HaloPro_Frame:SetAlpha(0.35)
	Background_HaloPro_Frame:SetPoint('CENTER',0,-18)
	Background_HaloPro_Frame:Hide()
	-- Create Background Menu Image
	Background_HaloPro_Image = Background_HaloPro_Frame:CreateTexture(HP_bg_Image,"BACKGROUND")
	Background_HaloPro_Image:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\Menu_Art\\HaloPro_Priest.tga")
	Background_HaloPro_Image:SetAllPoints(Background_HaloPro_Frame)
	Background_HaloPro_Frame.texture = Background_HaloPro_Image

	-- Create the Lock Button
	Lock_Button = "Lock HaloPro"
	template = "UICheckButtonTemplate"
	Lock_checkButton = CreateFrame("CheckButton",Lock_Button,panel,template) --frameType, frameName, frameParent, frameTemplate
	Lock_checkButton:SetPoint("TopLeft",10,-10)
	Lock_checkButton.text = _G[Lock_Button.."Text"]

	if Lock_Flag == 0 then
		Lock_checkButton:SetChecked(false)
		Lock_checkButton.text:SetText("HaloPro is Unlocked - Check to lock")
		HP_Lock()
	elseif Lock_Flag == 1 then
		Lock_checkButton:SetChecked(true)
		Lock_checkButton.text:SetText("HaloPro is Locked")
		HP_Lock()
	end
	isLock_checkButton = Lock_checkButton:GetChecked()
	if isLock_checkButton == nill then
		Lock_Flag = 0
		HP_Lock()
	else
		Lock_Flag = 1
		HP_Lock()
	end

	-- Create Warn when off cooldown button
	HP_OffCD_Warn_Button = "Flash when off cooldown"
	template = "UICheckButtonTemplate"
	HP_OffCD_Flash_checkButton = CreateFrame("CheckButton",HP_OffCD_Warn_Button,panel,template) --frameType, frameName, frameParent, frameTemplate
	HP_OffCD_Flash_checkButton:SetPoint("TopLeft",10,-60)
	HP_OffCD_Flash_checkButton.text = _G[HP_OffCD_Warn_Button.."Text"]
	isHP_OffCD_Flash_checkButton = HP_OffCD_Flash_checkButton:GetChecked();
		if isOffCD_Flash_checkButton == nill then
			OffCD_Flag = 0
			HP_OffCD_Flash_checkButton:SetChecked(false)
			HP_OffCD_Flash_checkButton.text:SetText("Will NOT warn when spell is off cooldown |n  - Check to enable warning")
		else
			OffCD_Flag = 1
			HP_OffCD_Flash_checkButton:SetChecked(true)
			HP_OffCD_Flash_checkButton.text:SetText("WILL warn when spell is off cooldown")
		end

	-- Option to only show in combat button
	HP_In_Combat_Only_Button = "Only Show When In Combat"
	template = "UICheckButtonTemplate"
	HP_In_Combat_checkButton = CreateFrame("CheckButton",HP_In_Combat_Only_Button,panel,template) --frameType, frameName, frameParent, frameTemplate
	HP_In_Combat_checkButton:SetPoint("TopLeft",10,-100)
	HP_In_Combat_checkButton.text = _G[HP_In_Combat_Only_Button.."Text"]
	isHP_In_Combat_checkButton = HP_In_Combat_checkButton:GetChecked();
		if isIn_Combat_checkButton == nill then
			HP_InCombatOnly = 0
			temp_HPShow = HP_InCombatOnly
			HP_In_Combat_checkButton:SetChecked(false)
			HP_In_Combat_checkButton.text:SetText("Will show both IN and OUT of combat |n  - Check to show only when IN combat")
		else
			HP_InCombatOnly = 1
			temp_HPShow = HP_InCombatOnly
			HP_In_Combat_checkButton:SetChecked(true)
			HP_In_Combat_checkButton.text:SetText("WILL show ONLY when IN combat")
		end

	-- Create sub panel to hold width and height sliders / editboxes
	HP_Options_Sub_Panel = CreateFrame("MessageFrame", "Width_Sub_Panel", panel)
	HP_Options_Sub_Panel:SetPoint("TopLeft",80, -100)
	HP_Options_Sub_Panel:SetWidth(1200)
	HP_Options_Sub_Panel:SetHeight(100)
	HP_Options_Sub_Panel:Show()
	XY_Relative_Pos()
	HPSound()
	HPFrameStrata()

	-- Create Button to toggle Fade Option
	Fade_Toggle = "Toggle Fade In"
	template = "UIPanelButtonTemplate"
	Fade_Toggle_Button = CreateFrame("Button",Fade_Toggle,HP_Options_Sub_Panel,template)
	Fade_Toggle_Button:SetPoint("Center",-368,-255)
	Fade_Toggle_Button:SetWidth(140)
	Fade_Toggle_Button:SetText("Fade In: Enabled")
	if HP_FadeIn_Disable == 0 then
		Fade_Toggle_Button:SetButtonState("NORMAL")
	elseif HP_FadeIn_Disable == 1 then
		Fade_Toggle_Button:SetButtonState("PUSHED")
	end

	-- Create Button to monitor Divine Star
	HP_DS_Monitor = "Monitor Divine Star"
	template = "UIPanelButtonTemplate"
	HP_DS_Monitor_Button = CreateFrame("Button",Theme_Panel_Shortcut,HP_Options_Sub_Panel,template)
	HP_DS_Monitor_Button:SetPoint("Bottom",-605,-120)
	HP_DS_Monitor_Button:SetWidth(120)
	HP_DS_Monitor_Button:SetText("Monitor D.S.")
	if HP_Monitor_DS == 1 then
		HP_DS_Monitor_Button:LockHighlight()
		HP_DS_Monitor_Button:SetButtonState("PUSHED")
	elseif HP_Monitor_DS == 0 then
		HP_DS_Monitor_Button:UnlockHighlight()
		HP_DS_Monitor_Button:SetButtonState("NORMAL")
	end

	-- Create Button to monitor Cascade
	HP_CasC_Monitor = "Monitor Cascade"
	template = "UIPanelButtonTemplate"
	HP_CasC_Monitor_Button = CreateFrame("Button",Theme_Panel_Shortcut,HP_Options_Sub_Panel,template)
	HP_CasC_Monitor_Button:SetPoint("Bottom",-130,-120)
	HP_CasC_Monitor_Button:SetWidth(120)
	HP_CasC_Monitor_Button:SetText("Monitor Cascade")

	-- Create Button to jump to Theme panel
	Theme_Panel_Shortcut = "Change Theme"
	template = "UIPanelButtonTemplate"
	Theme_Button = CreateFrame("Button",Theme_Panel_Shortcut,HP_Options_Sub_Panel,template)
	Theme_Button:SetPoint("Bottom",-605,-355)
	Theme_Button:SetWidth(120)
	Theme_Button:SetText("Change Theme")

	-- Create Button to always show HaloPro
	HP_Always_Show = "Do not hide"
	template = "UIPanelButtonTemplate"
	HP_Always_Show_button = CreateFrame("Button",HP_Always_Show,HP_Options_Sub_Panel,template)
	HP_Always_Show_button:SetPoint("Bottom",-368,-355)
	HP_Always_Show_button:SetWidth(120)
	HP_Always_Show_button:SetText("Always Show: "..HP_Always_Show_Flag)
	HP_Always_Show_button:SetButtonState("NORMAL")
	HP_Always_Show_button:UnlockHighlight()

	-- Create Button to toggle tracking target
	HP_Tracking_Switch = "Tracking Unit"
	template = "UIPanelButtonTemplate"
	HP_Track_Toggle = CreateFrame("Button",HP_Tracking_Switch,HP_Options_Sub_Panel,template)
	HP_Track_Toggle:SetPoint("Bottom",-130,-355)
	HP_Track_Toggle:SetWidth(120)
	HP_Track_Toggle:SetText("Track: "..HP_Tracking)
	HP_Track_Toggle:SetButtonState("NORMAL")
	HP_Track_Toggle:UnlockHighlight()

	-- Create Vertical Bar button
	VertBar_Button = "Switch to Vertical Bar"
	template = "UICheckButtonTemplate"
	VertBar_checkButton = CreateFrame("CheckButton",VertBar_Button,HP_Options_Sub_Panel,template) --frameType, frameName, frameParent, frameTemplate
	VertBar_checkButton:SetPoint("Center",-405,125)
	VertBar_checkButton.text = _G[VertBar_Button.."Text"]
	isVertBar_checkButton = VertBar_checkButton:GetChecked();
	if isVertBar_checkButton == nil then
		HP_VertBar_Flag = 0
		HP_t:SetTexCoord(0,0, 0,1, 1,0, 1,1)
		VertBar_checkButton:SetChecked(false)
		VertBar_checkButton.text:SetText("Horizontal Bar Enabled - Check to enable Vertical Bar")
	else
		HP_VertBar_Flag = 1
		HP_t:SetTexCoord(0,1, 1,1, 0,0, 1,0)
		VertBar_checkButton:SetChecked(true)
		VertBar_checkButton.text:SetText("Vertical Bar Enabled - Uncheck to restore Horizontal Bar")
	end

	-- Create Sound Enable button
	Sound_Warn_Button = "Enable Sound Warning"
	template = "UICheckButtonTemplate"
	Sound_checkButton = CreateFrame("CheckButton",Sound_Warn_Button,HP_Options_Sub_Panel,template) --frameType, frameName, frameParent, frameTemplate
	Sound_checkButton:SetPoint("Center",-405,75)
	Sound_checkButton.text = _G[Sound_Warn_Button.."Text"]
	isSound_checkButton = Sound_checkButton:GetChecked();
	if isSound_checkButton == nil then
		HP_Sound_Flag = 0
		Sound_checkButton:SetChecked(false)
		Sound_checkButton.text:SetText("Sound warning disabled |n  - Check to enable sound warning")
	else
		HP_Sound_Flag = 1
		Sound_checkButton:SetChecked(true)
		Sound_checkButton.text:SetText("WILL play sound warning |n  when in proper spell range")
	end

	-- Create Strata Adjust Enable button
	HP_Strata_Button = "Enable Strata Adjustment"
	template = "UICheckButtonTemplate"
	HP_Strata_checkButton = CreateFrame("CheckButton",HP_Strata_Button,HP_Options_Sub_Panel,template) --frameType, frameName, frameParent, frameTemplate
	HP_Strata_checkButton:SetPoint("Center",-405,35)
	HP_Strata_checkButton.text = _G[HP_Strata_Button.."Text"]
	isHP_Strata_checkButton = HP_Strata_checkButton:GetChecked();
	if isHP_Strata_checkButton == nil then
		HP_Strata_checkButton:SetChecked(false)
		HP_Strata_checkButton.text:SetText("HaloPro Strata Level Locked - Check to adjust Strata Level")
	else
		HP_Strata_checkButton:SetChecked(true)
		HP_Strata_checkButton.text:SetText("HaloPro Strata Level unlocked |n Adjust level with dropdown menu")
	end

	-- Create Editbox to set HaloPro width
	Set_HP_Width = CreateFrame("EditBox", "Edit_Box_Width", HP_Options_Sub_Panel, "InputBoxTemplate")
	Set_HP_Width:SetWidth(70)
	Set_HP_Width:SetHeight(20)
	Set_HP_Width:SetPoint("Left",40, -40)
	Set_HP_Width:SetAutoFocus(false)
	Set_HP_Width:EnableKeyboard(true)
	Set_HP_Width:SetFontObject("GameFontHighlight")
	Set_HP_Width:SetJustifyH("Center")
	Set_HP_Width:SetJustifyV("Center")
	Set_HP_Width:SetTextInsets(0, 5, 0, 0)
	Set_HP_Width:SetNumeric(true)
	Set_HP_Width:SetNumber(HP_width)
	Set_HP_Width:Hide()

	-- Create Editbox to set HaloPro height
	Set_HP_Height = CreateFrame("EditBox", "Edit_Box_Height", HP_Options_Sub_Panel, "InputBoxTemplate")
	Set_HP_Height:SetWidth(70)
	Set_HP_Height:SetHeight(20)
	Set_HP_Height:SetPoint("Left",350, -40)
	Set_HP_Height:SetAutoFocus(false)
	Set_HP_Height:EnableKeyboard(true)
	Set_HP_Height:SetFontObject("GameFontHighlight")
	Set_HP_Height:SetJustifyH("Center")
	Set_HP_Height:SetJustifyV("Center")
	Set_HP_Height:SetTextInsets(0, 5, 0, 0)
	Set_HP_Height:SetNumeric(true)
	Set_HP_Height:SetNumber(HP_height)
	Set_HP_Height:Hide()

	-- Create Editbox to set HaloPro X position
	Set_HP_X_Pos = CreateFrame("EditBox", "Edit_Box_X", HP_Options_Sub_Panel, "InputBoxTemplate")
	Set_HP_X_Pos:SetWidth(70)
	Set_HP_X_Pos:SetHeight(20)
	Set_HP_X_Pos:SetPoint("Left",40, -125)
	Set_HP_X_Pos:SetAutoFocus(false)
	Set_HP_X_Pos:EnableKeyboard(true)
	Set_HP_X_Pos:SetFontObject("GameFontHighlight")
	Set_HP_X_Pos:SetJustifyH("Center")
	Set_HP_X_Pos:SetJustifyV("Center")
	Set_HP_X_Pos:SetTextInsets(0, 5, 0, 0)
	Set_HP_X_Pos:SetText(0)
	Set_HP_X_Pos:Hide()

	-- Create Editbox to set HaloPro X position
	Set_HP_Y_Pos = CreateFrame("EditBox", "Edit_Box_Y", HP_Options_Sub_Panel, "InputBoxTemplate")
	Set_HP_Y_Pos:SetWidth(70)
	Set_HP_Y_Pos:SetHeight(20)
	Set_HP_Y_Pos:SetPoint("Left",350, -125)
	Set_HP_Y_Pos:SetAutoFocus(false)
	Set_HP_Y_Pos:EnableKeyboard(true)
	Set_HP_Y_Pos:SetFontObject("GameFontHighlight")
	Set_HP_Y_Pos:SetJustifyH("Center")
	Set_HP_Y_Pos:SetJustifyV("Center")
	Set_HP_Y_Pos:SetTextInsets(0, 5, 0, 0)
	Set_HP_Y_Pos:SetText(0)
	Set_HP_Y_Pos:Hide()

	-- Create width slider
	HP_Width_Slider = "Adjust the width of HaloPro"
	WidthSlider = CreateFrame("Slider", "HP_Width_Slider", HP_Options_Sub_Panel, "OptionsSliderTemplate")
	WidthSlider:SetWidth(250)
	WidthSlider:SetHeight(15)
	WidthSlider:SetOrientation('Horizontal')
	WidthSlider:SetPoint("Left",-52,-22)
	WidthSlider.text = _G[HP_Width_Slider.."Text"]
	WidthSlider:SetMinMaxValues(1,1000)
	WidthSlider:SetValue(HP_width)
	WidthSlider:SetValueStep(1)
	WidthSlider:SetStepsPerPage(1)

	WidthSlider.tooltipText = 'Adjust the width of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and mouse wheel scroll, to adjust width)'   -- Creates a tooltip on mouseover.
	_G[WidthSlider:GetName() .. 'Low']:SetText('shorter')    -- Sets the left-side slider text (default is "Low").
	_G[WidthSlider:GetName() .. 'High']:SetText('wider')     -- Sets the right-side slider text (default is "High").
	_G[WidthSlider:GetName() .. 'Text']:SetText('Width')     -- Sets the "title" text (top-centre of slider).

	-- Create height slider
	HP_Height_Slider = "Adjust the height of HaloPro"
	HeightSlider = CreateFrame("Slider", "HP_Height_Slider", HP_Options_Sub_Panel, "OptionsSliderTemplate")
	HeightSlider:SetWidth(250)
	HeightSlider:SetHeight(15)
	HeightSlider:SetOrientation('Horizontal')
	HeightSlider:SetPoint("Left",258,-22)
	HeightSlider.text = _G[HP_Width_Slider.."Text"]
	HeightSlider:SetMinMaxValues(1,1000)
	HeightSlider:SetValue(HP_height)
	HeightSlider:SetValueStep(1)
	HeightSlider:SetStepsPerPage(1)

	HeightSlider.tooltipText = 'Adjust the height of HaloPro (While HaloPro is unlocked, you can place your cursor over the HaloPro bar, and SHIFT + mouse wheel scroll, to adjust height)'   -- Creates a tooltip on mouseover.
	_G[HeightSlider:GetName() .. 'Low']:SetText('thinner')     -- Sets the left-side slider text (default is "Low").
	_G[HeightSlider:GetName() .. 'High']:SetText('thicker')    -- Sets the right-side slider text (default is "High").
	_G[HeightSlider:GetName() .. 'Text']:SetText('Height')     -- Sets the "title" text (top-centre of slider).

	-- Create X position slider
	HP_Xpos_Slider = "Adjust the X Position of HaloPro"
	XposSlider = CreateFrame("Slider", "HP_Xpos_Slider", HP_Options_Sub_Panel, "OptionsSliderTemplate")
	XposSlider:SetWidth(250)
	XposSlider:SetHeight(15)
	XposSlider:SetOrientation('Horizontal')
	XposSlider:SetPoint("Left",-52,-107)
	XposSlider.text = _G[HP_Xpos_Slider.."Text"]
	XposSlider:SetMinMaxValues(-2000,2000)
	XposSlider:SetValue(xOfs)
	XposSlider:SetValueStep(1)
	XposSlider:SetStepsPerPage(1)

	XposSlider.tooltipText = 'Adjust the X position of HaloPro (While HaloPro is unlocked, you can left click on the HaloPro bar and drag to reposition)'   -- Creates a tooltip on mouseover.
	_G[XposSlider:GetName() .. 'Low']:SetText('left')        	-- Sets the left-side slider text (default is "Low").
	_G[XposSlider:GetName() .. 'High']:SetText('right')     	-- Sets the right-side slider text (default is "High").
	_G[XposSlider:GetName() .. 'Text']:SetText('X Position')    -- Sets the "title" text (top-centre of slider).

	-- Create Y postion slider
	HP_Ypos_Slider = "Adjust the Y Position of HaloPro"
	YposSlider = CreateFrame("Slider", "HP_Ypos_Slider", HP_Options_Sub_Panel, "OptionsSliderTemplate")
	YposSlider:SetWidth(250)
	YposSlider:SetHeight(15)
	YposSlider:SetOrientation('Horizontal')
	YposSlider:SetPoint("Left",258,-107)
	YposSlider.text = _G[HP_Ypos_Slider.."Text"]
	YposSlider:SetMinMaxValues(-2000,2000)
	YposSlider:SetValue(yOfs)
	YposSlider:SetValueStep(1)
	YposSlider:SetStepsPerPage(1)

	YposSlider.tooltipText = 'Adjust the Y position of HaloPro (While HaloPro is unlocked, you can left click on the HaloPro bar and drag to reposition)'   -- Creates a tooltip on mouseover.
	_G[YposSlider:GetName() .. 'Low']:SetText('lower')        	-- Sets the left-side slider text (default is "Low").
	_G[YposSlider:GetName() .. 'High']:SetText('higher')     	-- Sets the right-side slider text (default is "High").
	_G[YposSlider:GetName() .. 'Text']:SetText('Y Position')   	-- Sets the "title" text (top-centre of slider).

	-- Create Max Alpha slider
	Max_Alpha_Slider = "Adjust the max alpha of HaloPro"
	MaxASlider = CreateFrame("Slider", "Max_Alpha_Slider", panel, "OptionsSliderTemplate")
	MaxASlider:SetWidth(306)
	MaxASlider:SetHeight(20)
	MaxASlider:SetOrientation('Horizontal')
	MaxASlider:SetPoint("Center",-20,-50)
	MaxASlider.text = _G[Max_Alpha_Slider.."Text"]
	MaxASlider:SetMinMaxValues(0.1,1.0)
	MaxASlider:SetValue(HP_max_alpha_adjust)
	MaxASlider:SetValueStep(0.025)
	MaxASlider:SetStepsPerPage(0.025)

	MaxASlider.tooltipText = 'Adjust the Max alpha of HaloPro (lower# means more transparent)'   -- Creates a tooltip on mouseover.
	_G[MaxASlider:GetName() .. 'Low']:SetText('0.1')        	-- Sets the left-side slider text (default is "Low").
	_G[MaxASlider:GetName() .. 'High']:SetText('1.0')     		-- Sets the right-side slider text (default is "High").
	_G[MaxASlider:GetName() .. 'Text']:SetText('Max Alpha: ' .. HP_max_alpha_adjust)       -- Sets the "title" text (top-centre of slider).

	-- Create Fade In Timer Slider
	Fade_IN_Slider = "Adjust how many seconds before spell is off cooldown, should HaloPro start to fade in (Auto disabled for Divine Star - too short a cooldown)"
	FadeINSlider = CreateFrame("Slider", "Fade_IN_Slider", panel, "OptionsSliderTemplate")
	FadeINSlider:SetWidth(306)
	FadeINSlider:SetHeight(20)
	FadeINSlider:SetOrientation('Horizontal')
	FadeINSlider:SetPoint("Center",-20,-100)
	FadeINSlider.text = _G[Fade_IN_Slider.."Text"]
	FadeINSlider:SetMinMaxValues(0,40)
	FadeINSlider:SetValue(HP_fadeintimer)
	FadeINSlider:SetValueStep(1)
	FadeINSlider:SetStepsPerPage(1)

	FadeINSlider.tooltipText = 'Set how many seconds left on the spell cooldown, should HaloPro begin to fade back in'   -- Creates a tooltip on mouseover.
	_G[FadeINSlider:GetName() .. 'Low']:SetText('0')        	-- Sets the left-side slider text (default is "Low").
	_G[FadeINSlider:GetName() .. 'High']:SetText('40')     		-- Sets the right-side slider text (default is "High").
	_G[FadeINSlider:GetName() .. 'Text']:SetText('Begin fade in at: ' .. HP_fadeintimer .. " secs")       -- Sets the "title" text (top-centre of slider).

	-- Create Number of Off Cooldown Flashes Slider
	Flash_Num_Slider = "Adjust how many times HaloPro should flash when it comes off cooldown"
	FlashNumSlider = CreateFrame("Slider", "Flash_Num_Slider", panel, "OptionsSliderTemplate")
	FlashNumSlider:SetWidth(306)
	FlashNumSlider:SetHeight(20)
	FlashNumSlider:SetOrientation('Horizontal')
	FlashNumSlider:SetPoint("Center",-20,-175)
	FlashNumSlider.text = _G[Flash_Num_Slider.."Text"]
	FlashNumSlider:SetMinMaxValues(1,5)
	FlashNumSlider:SetValue(HP_flash_num)
	FlashNumSlider:SetValueStep(1)
	FlashNumSlider:SetStepsPerPage(1)

	FlashNumSlider.tooltipText = 'Set how many seconds left on the spell cooldown, should HaloPro begin to fade back in'   -- Creates a tooltip on mouseover.
	_G[FlashNumSlider:GetName() .. 'Low']:SetText('1')        	-- Sets the left-side slider text (default is "Low").
	_G[FlashNumSlider:GetName() .. 'High']:SetText('5')     	-- Sets the right-side slider text (default is "High").
	_G[FlashNumSlider:GetName() .. 'Text']:SetText('# flashes when off cooldown: ' .. HP_flash_num .. " flashes")       -- Sets the "title" text (top-centre of slider).

	-- Create Flash speed Slider
	Flash_Speed_Slider = "Adjust how fast HaloPro should flash when it comes off cooldown"
	FlashSpeedSlider = CreateFrame("Slider", "Flash_Speed_Slider", panel, "OptionsSliderTemplate")
	FlashSpeedSlider:SetWidth(306)
	FlashSpeedSlider:SetHeight(20)
	FlashSpeedSlider:SetOrientation('Horizontal')
	FlashSpeedSlider:SetPoint("Center",-20,-225)
	FlashSpeedSlider.text = _G[Flash_Speed_Slider.."Text"]
	FlashSpeedSlider:SetMinMaxValues(1,5)
	FlashSpeedSlider:SetValue(HP_tcount_time1)
	FlashSpeedSlider:SetValueStep(1)
	FlashSpeedSlider:SetStepsPerPage(1)

	FlashSpeedSlider.tooltipText = 'Set how fast HaloPro should flash when spell is off cooldown'   -- Creates a tooltip on mouseover.
	_G[FlashSpeedSlider:GetName() .. 'Low']:SetText('Fast')       	-- Sets the left-side slider text (default is "Low").
	_G[FlashSpeedSlider:GetName() .. 'High']:SetText('Slow')     	-- Sets the right-side slider text (default is "High").
	_G[FlashSpeedSlider:GetName() .. 'Text']:SetText('Speed of flashes when off cooldown: ')       -- Sets the "title" text (top-centre of slider).

	UnLocked_HP_Panel()
	-- OnClick Handler Lock HP
	Lock_checkButton:SetScript("OnClick", function(self)
		isLock_checkButton = self:GetChecked();
		if isLock_checkButton == nill then
			Background_HaloPro_Frame:Hide()
			if HP_Lvl90_Flag == 1 then
				HP_options_open_Flag = 1
				FrameTextureUpdate(nil, nil, true)
			end
			Lock_checkButton.text:SetText("HaloPro is Unlocked - Check to lock")
			Lock_Flag = 0
			HP_OffCD_Flash_checkButton:Show()
			HP_In_Combat_checkButton:Show()
			if OffCD_Flag == 1 then
				FlashNumSlider:Show()
				FlashSpeedSlider:Show()
			end
			HP_Options_Sub_Panel:Show()
			HP_Sub_Panel_Refresh(HP_Options_Sub_Panel)
			MaxASlider:Show()
			FadeINSlider:Show()
			HP_Lock()
			if HP_options_open_Flag == 1 then
					FrameTextureUpdate(false)
			end
		else
			Background_HaloPro_Frame:Show()
			if HP_Lvl90_Flag == 1 then
				HP_options_open_Flag = 0
				HP_f_Hide()
			end
			Lock_checkButton.text:SetText("HaloPro is Locked")
			Lock_Flag = 1
			HP_OffCD_Flash_checkButton:Hide()
			HP_In_Combat_checkButton:Hide()
			HP_Options_Sub_Panel:Hide()
			MaxASlider:Hide()
			FadeINSlider:Hide()
			FlashNumSlider:Hide()
			FlashSpeedSlider:Hide()
			HP_Lock()
			if HP_options_open_Flag == 1 then
					FrameTextureUpdate(false)
			end
		end

	end)

	-- Set up size boxes on load
	HP_Options_Sub_Panel:SetScript("OnLoad", function(self)
		local height_entered = Set_HP_Height:GetNumber()
		HP_height = height_entered
		HP_Resize_height(UIParent)
		local width_entered = Set_HP_Width:GetNumber()
		HP_width = width_entered
		HP_Resize_width(UIParent)
	end)

	-- Various Handlers to save the changed width
	Set_HP_Width:SetScript("OnEditFocusLost", function(self)
		local width_entered = Set_HP_Width:GetNumber()
		HP_width = width_entered
		HP_Resize_width(UIParent)
	end)
	Set_HP_Width:SetScript("OnEnterPressed", function(self)
		local width_entered = Set_HP_Width:GetNumber()
		HP_width = width_entered
		HP_Resize_width(UIParent)
	end)
	Set_HP_Width:SetScript("OnTabPressed", function(self)
		local width_entered = Set_HP_Width:GetNumber()
		HP_width = width_entered
		HP_Resize_width(UIParent)
	end)

	-- Various Handlers to save the changed height
	Set_HP_Height:SetScript("OnEditFocusLost", function(self)
		local height_entered = Set_HP_Height:GetNumber()
		HP_height = height_entered
		HP_Resize_height(UIParent)
	end)
	Set_HP_Height:SetScript("OnEnterPressed", function(self)
		local height_entered = Set_HP_Height:GetNumber()
		HP_height = height_entered
		HP_Resize_height(UIParent)
	end)
	Set_HP_Height:SetScript("OnTabPressed", function(self)
		local height_entered = Set_HP_Height:GetNumber()
		HP_height = height_entered
		HP_Resize_height(UIParent)
	end)

	-- OnValueChanged Handler Width
	WidthSlider:SetScript("OnValueChanged", function(self, event)
		HP_width = event
		if HP_currentSpec == 1 then
			if Theme_Icon_Spec1_Flag == 1 then
				HP_width_Icon1 = HP_width
				HP_height_Icon1 = HP_width
				HP_height = HP_width
				HP_Resize_height()
				HP_Resize_width()
			else
				HP_Resize_width()
			end
		elseif HP_currentSpec == 2 then
			if Theme_Icon_Spec2_Flag == 1 then
				HP_width_Icon2 = HP_width
				HP_height_Icon2 = HP_width
				HP_height = HP_width
				HP_Resize_height()
				HP_Resize_width()
			else
				HP_Resize_width()
			end
		end
	end)
	-- OnValueChanged Handler Height
	HeightSlider:SetScript("OnValueChanged", function(self, event)
		HP_height = event
		if HP_currentSpec == 1 then
			if Theme_Icon_Spec1_Flag == 1 then
				HP_width_Icon1 = HP_height
				HP_height_Icon1 = HP_height
				HP_width = HP_height
				HP_Resize_height()
				HP_Resize_width()
			else
				HP_Resize_height()
			end
		elseif HP_currentSpec == 2 then
			if Theme_Icon_Spec2_Flag == 1 then
				HP_width_Icon2 = HP_height
				HP_height_Icon2 = HP_height
				HP_width = HP_height
				HP_Resize_height()
				HP_Resize_width()
			else
				HP_Resize_height()
			end
		end
    end)
	-- OnValueChanged Handler X position
	XposSlider:SetScript("OnValueChanged", function(self, event)
		xOfs = event
		HP_Set_Position()
	end)
	-- OnValueChanged Handler Y position
	YposSlider:SetScript("OnValueChanged", function(self, event)
		yOfs = event
		HP_Set_Position()
	end)
	-- Various Handlers to change X position
	Set_HP_X_Pos:SetScript("OnEditFocusLost", function(self)
		local X_Pos_entered = Set_HP_X_Pos:GetNumber()
		xOfs = X_Pos_entered
		Set_HP_X_Pos:ClearFocus()
		HP_Set_Position()
	end)
	Set_HP_X_Pos:SetScript("OnEnterPressed", function(self)
		local X_Pos_entered = Set_HP_X_Pos:GetNumber()
		xOfs = X_Pos_entered
		Set_HP_X_Pos:ClearFocus()
		HP_Set_Position()
	end)
	Set_HP_X_Pos:SetScript("OnTabPressed", function(self)
		local X_Pos_entered = Set_HP_X_Pos:GetNumber()
		xOfs = X_Pos_entered
		Set_HP_X_Pos:ClearFocus()
		HP_Set_Position()
	end)

	-- Various Handlers to change Y position
	Set_HP_Y_Pos:SetScript("OnEditFocusLost", function(self)
		local Y_Pos_entered = Set_HP_Y_Pos:GetNumber()
		yOfs = Y_Pos_entered
		Set_HP_Y_Pos:ClearFocus()
		HP_Set_Position()
	end)
	Set_HP_Y_Pos:SetScript("OnEnterPressed", function(self)
		local Y_Pos_entered = Set_HP_Y_Pos:GetNumber()
		yOfs = Y_Pos_entered
		Set_HP_Y_Pos:ClearFocus()
		HP_Set_Position()
	end)
	Set_HP_Y_Pos:SetScript("OnTabPressed", function(self)
		local Y_Pos_entered = Set_HP_Y_Pos:GetNumber()
		yOfs = Y_Pos_entered
		Set_HP_Y_Pos:ClearFocus()
		HP_Set_Position()
	end)

	-- OnValueChanged Handler Alpha HP
	MaxASlider:SetScript("OnValueChanged", function(self, event)
		event = math.floor( (event * 10^3) + 0.5) / (10^3)
		HP_max_alpha_adjust = event
		_G[MaxASlider:GetName() .. 'Text']:SetText('Alpha: ' .. HP_max_alpha_adjust)       -- Sets the "title" text (top-centre of slider).
	end)

	-- OnValueChanged Handler Fade In HP
	FadeINSlider:SetScript("OnValueChanged", function(self, event)
		event = math.floor( (event * 10^3) + 0.5) / (10^3)
		HP_fadeintimer = event
		_G[FadeINSlider:GetName() .. 'Text']:SetText('Begin fade in at: ' .. HP_fadeintimer .. " secs")       -- Sets the "title" text (top-centre of slider).
	end)

	-- OnValueChanged Handler Numer of Flashes
	FlashNumSlider:SetScript("OnValueChanged", function(self, event)
		event = math.floor(event)
		HP_flash_num = event
		_G[FlashNumSlider:GetName() .. 'Text']:SetText('# flashes when off cooldown: ' .. HP_flash_num .. " flashes")       -- Sets the "title" text (top-centre of slider).
	end)

	-- OnValueChanged Handler Speed of Flashes
	FlashSpeedSlider:SetScript("OnValueChanged", function(self, event)
		event = math.floor(event)
		HP_tcount_time1 = event
	end)

	-- Button to jump to the theme selection pane
	Theme_Button:SetScript("OnClick", function(self)
		InterfaceOptionsFrame_OpenToCategory(HP_Options_Theme)
	end)

	-- Button to toggle monitoring Divine Star
	HP_DS_Monitor_Button:SetScript("OnClick", function(self)
		if HP_Monitor_DS == 0 then
			HP_Monitor_DS = 1
			--HP_Always_Show_Temp = HP_Always_Show_Flag
			HP_DS_Monitor_Button:LockHighlight()
			HP_DS_Monitor_Button:SetButtonState("PUSHED")
			HP_DS_Monitor_Button:SetText("Monitor D.S.")
			HP_options_open_Flag = 1
			print("HaloPro is now monitoring Divine Star")
		elseif HP_Monitor_DS == 1 then
			HP_Monitor_DS = 0
			--HP_Always_Show_Temp = HP_Always_Show_Flag
			HP_DS_Monitor_Button:UnlockHighlight()
			HP_DS_Monitor_Button:SetButtonState("NORMAL")
			HP_DS_Monitor_Button:SetText("Monitor D.S.")
			HP_options_open_Flag = 1
			print("HaloPro is no longer monitoring Divine Star")
		end
	end)

	-- Button to toggle monitoring Cascade
	HP_CasC_Monitor_Button:SetScript("OnClick", function(self)
		if HP_Monitor_CC == 0 then
			HP_Monitor_CC = 1
			--HP_Always_Show_Temp = HP_Always_Show_Flag
			HP_CasC_Monitor_Button:LockHighlight()
			HP_CasC_Monitor_Button:SetButtonState("PUSHED")
			HP_CasC_Monitor_Button:SetText("Monitor Cascade")
			HP_options_open_Flag = 1
			print("HaloPro is now monitoring Cascade")
		elseif HP_Monitor_CC == 1 then
			HP_Monitor_CC = 0
			--HP_Always_Show_Temp = HP_Always_Show_Flag
			HP_CasC_Monitor_Button:UnlockHighlight()
			HP_CasC_Monitor_Button:SetButtonState("NORMAL")
			HP_CasC_Monitor_Button:SetText("Monitor Cascade")
			HP_options_open_Flag = 1
			print("HaloPro is no longer monitoring Cascade")
		end
	end)

	-- Button to toggle between target and focus target tracking
	HP_Track_Toggle:SetScript("OnClick", function(self)
		if HP_Tracking == 'focus' then
			HP_Tracking = 'target'
			HP_Track_Toggle:SetText("Track: "..HP_Tracking)
			HP_Always_Show_Flag = HP_Always_Show_Temp
			print("HaloPro is now tracking: Your Current Target")
		elseif HP_Tracking == 'target' then
			HP_Tracking = 'mouseover'
			HP_Track_Toggle:SetText("Track: "..HP_Tracking)
			HP_Always_Show_Temp = HP_Always_Show_Flag
			HP_Always_Show_Flag = 'Yes'
			print("HaloPro is now tracking: Your Mouseover Target")
		elseif HP_Tracking == 'mouseover' then
			HP_Tracking = 'focus'
			HP_Track_Toggle:SetText("Track: "..HP_Tracking)
			HP_Always_Show_Flag = HP_Always_Show_Temp
			print("HaloPro is now tracking: Your Focus Target")
		end
		HP_Restore_Tracking_PerSpec()
	end)

	-- Button to toggle to Always Show regardless of target or not
	HP_Always_Show_button:SetScript("OnClick", function(self)
		if HP_Always_Show_Flag == 'No' then
			HP_Always_Show_Flag = 'Yes'
			HP_Always_Show_Temp = HP_Always_Show_Flag
			HP_Always_Show_button:LockHighlight()
			HP_Always_Show_button:SetButtonState("PUSHED")
			HP_Always_Show_button:SetText("Always Show:".. HP_Always_Show_Flag)
			print("Always Show: Enabled - HaloPro will now stay displayed on the screen at all times regardless of target")
		elseif HP_Always_Show_Flag == 'Yes' then
			HP_Always_Show_Flag = 'No'
			HP_Always_Show_Temp = HP_Always_Show_Flag
			HP_Always_Show_button:UnlockHighlight()
			HP_Always_Show_button:SetButtonState("NORMAL")
			HP_Always_Show_button:SetText("Always Show:".. HP_Always_Show_Flag)
			print("Always Show: Disabled - HaloPro will now disappear when you are not targetting your tracked target")
		end
	end)

	-- Button to toggle to Fade In or Not Fade In (always on screen)
	Fade_Toggle_Button:SetScript("OnClick", function(self)
		if HP_FadeIn_Disable == 1 then
			HP_FadeIn_Disable = 0
			Fade_Toggle_Button:UnlockHighlight()
			Fade_Toggle_Button:SetText("Fade In: Enabled")
			print("Fade In: Enabled - HaloPro will now disappear when spell is on cooldown")
		elseif HP_FadeIn_Disable == 0 then
			HP_FadeIn_Disable = 1
			Fade_Toggle_Button:LockHighlight()
			Fade_Toggle_Button:SetText("Fade In: Disabled")
			print("Fade In: Disabled - HaloPro will no longer disappear when spell is on cooldown")
		end
	end)

	HaloPro_CreateOptionsPanelTheme(HP_Options_Theme)

end
function HaloPro_CreateOptionsPanelTheme(HP_Options_Theme)

	-- Create Current Talent Notification
	Current_Talents_Msg = CreateFrame("Frame", "HP_Talents_Msg", HP_Options_Theme)
	Current_Talents_Msg:SetAllPoints()
	Current_Talents_Msg = Current_Talents_Msg:CreateFontString(nil, 'OVERLAY')
	Current_Talents_Msg:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
	Current_Talents_Msg:SetPoint('CENTER',0,210)
	Current_Talents_Msg:SetText('Currently, you are using '..HP_activeSpec..'|n&')

	-- Create Current Specialization Notification
	Current_Special_Msg = CreateFrame("Frame", "HP_Special_Msg", HP_Options_Theme)
	Current_Special_Msg:SetAllPoints()
	Current_Special_Msg = Current_Special_Msg:CreateFontString(nil, 'OVERLAY')
	Current_Special_Msg:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
	Current_Special_Msg:SetPoint('CENTER',0,185)
	Current_Special_Msg:SetText(HP_activeSpecial)

	-- Create Spec 1 Theme Slider
	Spec1_Theme_Slider = "Set the theme of HaloPro when in Spec 1"
	Spec1_T_Slider = CreateFrame("Slider", "Spec1_Theme_Slider", HP_Options_Theme, "OptionsSliderTemplate")
	Spec1_T_Slider:SetWidth(306)
	Spec1_T_Slider:SetHeight(20)
	Spec1_T_Slider:SetOrientation('Horizontal')
	Spec1_T_Slider:SetPoint("Center",0,100)
	Spec1_T_Slider.text = _G[Spec1_Theme_Slider.."Text"]
	Spec1_T_Slider:SetMinMaxValues(1,6)
	Spec1_T_Slider:SetValue(Theme_Index_Spec1)
	Spec1_T_Slider:SetValueStep(1)
	Spec1_T_Slider:SetStepsPerPage(1)

	Spec1_T_Slider.tooltipText = 'Change the theme of HaloPro for your Primary Spec'   -- Creates a tooltip on mouseover.
	_G[Spec1_T_Slider:GetName() .. 'Low']:SetText('1')        	-- Sets the left-side slider text (default is "Low").
	_G[Spec1_T_Slider:GetName() .. 'High']:SetText('6')     	-- Sets the right-side slider text (default is "High").
	_G[Spec1_T_Slider:GetName() .. 'Text']:SetText('Theme for Primary Spec: ' .. Theme_select_Spec1)       -- Sets the "title" text (top-centre of slider).

	-- Create preview frame for Main Spec
	Spec_1_Preview = CreateFrame("Frame","Spec_1_Preview",HP_Options_Theme)
	Spec_1_Preview:SetFrameStrata("TOOLTIP")
	Spec_1_Preview:SetFrameLevel(500)
	if Theme_Icon_Spec1_Flag == 0 then
		Spec_1_Preview:SetWidth(500)
		Spec_1_Preview:SetHeight(18)
		Spec_1_Preview:SetPoint("Center",0,70)
	elseif Theme_Icon_Spec1_Flag == 1 then
		Spec_1_Preview:SetWidth(64)
		Spec_1_Preview:SetHeight(64)
		Spec_1_Preview:SetPoint("Center",0,45)
	end
	Spec1_t = Spec_1_Preview:CreateTexture(Spec_1_t_init,"BACKGROUND")

	-- Create Spec 2 Theme Slider
	Spec2_Theme_Slider = "Set the theme of HaloPro when in Spec 2"
	Spec2_T_Slider = CreateFrame("Slider", "Spec2_Theme_Slider", HP_Options_Theme, "OptionsSliderTemplate")
	Spec2_T_Slider:SetWidth(306)
	Spec2_T_Slider:SetHeight(20)
	Spec2_T_Slider:SetOrientation('Horizontal')
	Spec2_T_Slider:SetPoint("Center",0,-30)
	Spec2_T_Slider.text = _G[Spec2_Theme_Slider.."Text"]
	Spec2_T_Slider:SetMinMaxValues(1,6)
	Spec2_T_Slider:SetValue(Theme_Index_Spec2)
	Spec2_T_Slider:SetValueStep(1)
	Spec2_T_Slider:SetStepsPerPage(1)

	Spec2_T_Slider.tooltipText = 'Change the theme of HaloPro for your Secondary Spec'   -- Creates a tooltip on mouseover.
	_G[Spec2_T_Slider:GetName() .. 'Low']:SetText('1')        	-- Sets the left-side slider text (default is "Low").
	_G[Spec2_T_Slider:GetName() .. 'High']:SetText('6')     	-- Sets the right-side slider text (default is "High").
	_G[Spec2_T_Slider:GetName() .. 'Text']:SetText('Theme for Secondary Spec: ' .. Theme_select_Spec2)       -- Sets the "title" text (top-centre of slider).

	-- Create preview frame for Secondary Spec
	Spec_2_Preview = CreateFrame("Frame","Spec_2_Preview",HP_Options_Theme)
	Spec_2_Preview:SetFrameStrata("TOOLTIP")
	Spec_2_Preview:SetFrameLevel(500)
	if Theme_Icon_Spec2_Flag == 0 then
		Spec_2_Preview:SetWidth(500)
		Spec_2_Preview:SetHeight(18)
		Spec_2_Preview:SetPoint("Center",0,-60)
	elseif Theme_Icon_Spec2_Flag == 1 then
		Spec_2_Preview:SetWidth(64)
		Spec_2_Preview:SetHeight(64)
		Spec_2_Preview:SetPoint("Center",0,-80)
	end

	Spec2_t = Spec_2_Preview:CreateTexture(Spec_2_t_init,"BACKGROUND")

	Theme_select_Spec_store()
	local Chosen_Theme = 0
	if HP_currentSpec == 1 then
		Chosen_Theme = Theme_select_Spec1
	elseif HP_currentSpec == 2 then
		Chosen_Theme = Theme_select_Spec2
	else
		Chosen_Theme = default_Theme_select_Spec1
	end
	Spec1_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec1.."\\center.tga")
	Spec1_t:SetAllPoints(Spec_1_Preview)
	Spec_1_Preview.texture = Spec1_t
	Spec2_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec2.."\\center.tga")
	Spec2_t:SetAllPoints(Spec_2_Preview)
	Spec_2_Preview.texture = Spec1_2

	-- Create frame to hold border options
	HP_Border_Opts_Main = CreateFrame("Frame","HP_Border_Opts_Main",HP_Options_Theme)
	HP_Border_Opts_Main:SetFrameStrata("HIGH")
	HP_Border_Opts_Main:SetWidth(800)
	HP_Border_Opts_Main:SetHeight(300)
	HP_Border_Opts_Main:SetPoint("Center",0,-80)
	HP_Border_Opts_Main:Hide()

	-- Check Box to disable borders
	Border_CheckButton = "Disable Borders for HaloPro"
	template = "UICheckButtonTemplate"
	Border_checkButton = CreateFrame("CheckButton",Border_CheckButton,HP_Options_Theme,template) --frameType, frameName, frameParent, frameTemplate
	Border_checkButton:SetPoint("TopLeft",10,-10)
	Border_checkButton.text = _G[Border_CheckButton.."Text"]

	if HP_Border_Flag == 0 then
		Border_checkButton:SetChecked(false)
		Border_checkButton.text:SetText("HaloPro borders are disabled - Check to enable borders")
		HP_Border_Opts_Main:Hide()
		--HP_f.Border:Hide()
	elseif HP_Border_Flag == 1 then
		Border_checkButton:SetChecked(true)
		Border_checkButton.text:SetText("HaloPro borders are enabled - Uncheck to disable borders")
		HP_Border_Opts_Main:Show()
		--HP_f.Border:Show()
	end
	isBorder_checkButton = Border_checkButton:GetChecked()
	if isBorder_checkButton == nill then
		HP_Border_Flag = 0
		HP_Border_Opts_Main:Hide()
		--HP_f.Border:Hide()
	else
		HP_Border_Flag = 1
		HP_Border_Opts_Main:Show()
	end

	-- Create slider to choose a light or dark theme
	DarkLight_Theme_Slider = "Set the theme of HaloPro when in Spec 2"
	DarkLight_Slider = CreateFrame("Slider", "DarkLight_Theme_Slider", HP_Border_Opts_Main, "OptionsSliderTemplate")
	DarkLight_Slider:SetWidth(250)
	DarkLight_Slider:SetHeight(15)
	DarkLight_Slider:SetOrientation('Horizontal')
	DarkLight_Slider:SetPoint("Center",-150,-50)
	DarkLight_Slider.text = _G[DarkLight_Theme_Slider.."Text"]
	DarkLight_Slider:SetMinMaxValues(1,2)
	if HP_DarkLight == "Dark" then
		DarkLight_Slider:SetValue(1)
	elseif HP_DarkLight == "Light" then
		DarkLight_Slider:SetValue(2)
	end
	DarkLight_Slider:SetValueStep(1)
	DarkLight_Slider:SetStepsPerPage(1)

	DarkLight_Slider.tooltipText = 'Change the theme of the HaloPro border'   -- Creates a tooltip on mouseover.
	_G[DarkLight_Slider:GetName() .. 'Low']:SetText('Dark')        	-- Sets the left-side slider text (default is "Low").
	_G[DarkLight_Slider:GetName() .. 'High']:SetText('Light')     	-- Sets the right-side slider text (default is "High").
	_G[DarkLight_Slider:GetName() .. 'Text']:SetText('Border Theme: ' .. HP_DarkLight)

	-- Create slider to choose a border style
	HP_Border_Theme_Slider = "Set the style of border for HaloPro"
	HP_Border_Slider = CreateFrame("Slider", "HP_Border_Theme_Slider", HP_Border_Opts_Main, "OptionsSliderTemplate")
	HP_Border_Slider:SetWidth(250)
	HP_Border_Slider:SetHeight(15)
	HP_Border_Slider:SetOrientation('Horizontal')
	HP_Border_Slider:SetPoint("Center",150,-50)
	HP_Border_Slider.text = _G[HP_Border_Theme_Slider.."Text"]
	HP_Border_Slider:SetMinMaxValues(1,3)
	if HP_Border_Theme == "glowTex.tga" then
		HP_Border_Slider:SetValue(1)
	elseif HP_Border_Theme == "border.tga" then
		HP_Border_Slider:SetValue(2)
	elseif HP_Border_Theme == "solidBorder.tga" then
		HP_Border_Slider:SetValue(3)
	end
	HP_Border_Slider:SetValueStep(1)
	HP_Border_Slider:SetStepsPerPage(1)

	HP_Border_Slider.tooltipText = 'Change the style of the HaloPro border'   -- Creates a tooltip on mouseover.
	_G[HP_Border_Slider:GetName() .. 'Low']:SetText('Subtle')        	-- Sets the left-side slider text (default is "Low").
	_G[HP_Border_Slider:GetName() .. 'High']:SetText('Bold')     	-- Sets the right-side slider text (default is "High").
	_G[HP_Border_Slider:GetName() .. 'Text']:SetText('Border Style: ' .. HP_Border_Theme)

	-- Create slider to adjust border thickness
	Border_Thickness_Slider = "Set the thickness of the border"
	HP_Thickness_Slider = CreateFrame("Slider", "Border_Thickness_Slider", HP_Border_Opts_Main, "OptionsSliderTemplate")
	HP_Thickness_Slider:SetWidth(306)
	HP_Thickness_Slider:SetHeight(15)
	HP_Thickness_Slider:SetOrientation('Horizontal')
	HP_Thickness_Slider:SetPoint("Center",0,-130)
	HP_Thickness_Slider.text = _G[Border_Thickness_Slider.."Text"]
	HP_Thickness_Slider:SetMinMaxValues(-20,20)
	HP_Thickness_Slider:SetValue(HP_Border_Thickness)
	HP_Thickness_Slider:SetValueStep(0.25)
	HP_Thickness_Slider:SetStepsPerPage(0.25)

	HP_Thickness_Slider.tooltipText = 'Change the thickness of the HaloPro border'   -- Creates a tooltip on mouseover.
	_G[HP_Thickness_Slider:GetName() .. 'Low']:SetText('Narrow')        	-- Sets the left-side slider text (default is "Low").
	_G[HP_Thickness_Slider:GetName() .. 'High']:SetText('Thick')     	-- Sets the right-side slider text (default is "High").
	_G[HP_Thickness_Slider:GetName() .. 'Text']:SetText('Border Thickness: ' .. HP_Border_Thickness)

	-- Create Button to jump to Main Options panel
	Main_Panel_Shortcut = "Main Options"
	template = "UIPanelButtonTemplate"
	Main_Options_Button = CreateFrame("Button",Main_Panel_Shortcut,HP_Options_Theme,template)
	Main_Options_Button:SetPoint("BottomLeft",14,14)
	Main_Options_Button:SetWidth(120)
	Main_Options_Button:SetText("Main Options")

	-- Create Button to change border and background colour
	HP_Border_Colour_Launch = "Border and Background Colours"
	template = "UIPanelButtonTemplate"
	HP_Border_Colour_Button = CreateFrame("Button",HP_Border_Colour_Launch,HP_Options_Theme,template)
	HP_Border_Colour_Button:SetPoint("BottomRight",-14,14)
	HP_Border_Colour_Button:SetWidth(120)
	HP_Border_Colour_Button:SetText("Border Colour")

	-- Handler for the border disable checkbutton
	Border_checkButton:SetScript("OnClick", function(self)
		isBorder_checkButton = self:GetChecked();
		if isBorder_checkButton == nill then
			Border_checkButton.text:SetText("HaloPro borders are disabled - Check to enable borders")
			HP_Border_Flag = 0
			HP_f.Border:Hide()
			--HP_t.Background_preview1:Hide()
			--HP_t.Background_preview2:Hide()
			HP_f.Border_preview1:Hide()
			HP_f.Border_preview2:Hide()
			HP_Border_Opts_Main:Hide()
			HP_Border_Colour_Button:Hide()
		else
			Border_checkButton.text:SetText("HaloPro borders are enabled - Uncheck to disable borders")
			HP_Border_Flag = 1
			HP_f.Border:Show()
			HP_f.Border_preview1:Show()
			HP_f.Border_preview2:Show()
			HP_Border_Opts_Main:Show()
			HP_Border_Colour_Button:Show()
			if Theme_Icon_Spec1_Flag == 1 then
				if HP_currentSpec == 1 then
					if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
						HP_t.Background:Show()
					else
						HP_t.Background:Hide()
					end
				end
				if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
					HP_t.Background_preview1:Show()
				else
					HP_t.Background_preview1:Hide()
				end
			else
				if HP_currentSpec == 1 then
					HP_t.Background:Hide()
				end
				HP_t.Background_preview1:Hide()
			end
			if Theme_Icon_Spec2_Flag == 1 then
				if HP_currentSpec == 2 then
					if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
						HP_t.Background:Show()
					else
						HP_t.Background:Hide()
					end
				end
				if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
					HP_t.Background_preview2:Show()
				else
					HP_t.Background_preview2:Hide()
				end
			else
				if HP_currentSpec == 2 then
					HP_t.Background:Hide()
				end
				HP_t.Background_preview2:Hide()
			end
		end
	end)

	-- Handler for slider to choose Dark and Light theme's
	DarkLight_Slider:SetScript("OnValueChanged", function(self, event)
		event = math.floor(event)
		DarkLight_Index = event		
		if DarkLight_Index == 1 then
			HP_DarkLight = "Dark"
		elseif DarkLight_Index == 2 then
			HP_DarkLight = "Light"
		end
		HP_Border_Control_Apply()
		_G[DarkLight_Slider:GetName() .. 'Text']:SetText('Border Theme: ' .. HP_DarkLight)
	end)

	-- Handler for slider to choose border theme style
	HP_Border_Slider:SetScript("OnValueChanged", function(self, event)
		event = math.floor(event)
		HP_Border_Index = event
		if HP_Border_Index == 1 then
			HP_Border_Theme = "glowTex.tga"
		elseif HP_Border_Index == 2 then
			HP_Border_Theme = "border.tga"
		elseif HP_Border_Index == 3 then
			HP_Border_Theme = "solidBorder.tga"
		end
		HP_Border_Control_Apply()
		_G[HP_Border_Slider:GetName() .. 'Text']:SetText('Border Style: ' .. HP_Border_Theme)
	end)

	-- Handler for slider to choose the thickness of the border
	HP_Thickness_Slider:SetScript("OnValueChanged", function(self, event)
		event = math.floor(event)
		HP_Border_Thickness = event
		HP_Border_Control_Apply()
		_G[HP_Thickness_Slider:GetName() .. 'Text']:SetText('Border Thickness: ' .. HP_Border_Thickness)
	end)

	-- Handlers for all the other options on the Theme panel
	Spec1_T_Slider:SetScript("OnValueChanged", function(self, event)
		event = math.floor(event)
		Theme_Index_Spec1 = event
		--print(Theme_Index_Spec1)
		Theme_select_Spec_store()
		if Theme_Icon_Spec1_Flag == 0 then
			Spec_1_Preview:SetWidth(500)
			Spec_1_Preview:SetHeight(18)
			Spec_1_Preview:SetPoint("Center",0,70)
			if HP_Border_Flag == 1 then
				HP_t.Background_preview1:Hide()
			end
			if HP_currentSpec == 1 then
				HP_width = HP_Spec1_Width
				HP_height = HP_Spec1_Height
				HP_Resize_height()
				HP_Resize_width()
				if HP_Border_Flag == 1 then
					HP_t.Background:Hide()
				end
			end
		elseif Theme_Icon_Spec1_Flag == 1 then
			Spec_1_Preview:SetWidth(64)
			Spec_1_Preview:SetHeight(64)
			Spec_1_Preview:SetPoint("Center",0,45)
			if HP_Border_Flag == 1 then
				if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
					HP_t.Background_preview1:Show()
				else
					HP_t.Background_preview1:Hide()
				end
			end
			if HP_currentSpec == 1 then
				HP_resize_check = 1
				HP_width = HP_width_Icon1
				HP_height = HP_height_Icon1
				HP_Resize_height()
				HP_Resize_width()
				if HP_Border_Flag == 1 then
					if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
						HP_t.Background:Show()
					else
						HP_t.Background:Hide()
					end
				end
			end
		end
		if HP_currentSpec == 1 then
			HP_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec1.."\\center.tga")
		end
		Spec1_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec1.."\\center.tga")
		_G[Spec1_T_Slider:GetName() .. 'Text']:SetText('Theme for Primary Spec: ' .. Theme_select_Spec1)       -- Sets the "title" text (top-centre of slider).
	end)

	Spec2_T_Slider:SetScript("OnValueChanged", function(self, event)
		event = math.floor(event)
		Theme_Index_Spec2 = event
		Theme_select_Spec_store()
		if Theme_Icon_Spec2_Flag == 0 then
			Spec_2_Preview:SetWidth(500)
			Spec_2_Preview:SetHeight(18)
			Spec_2_Preview:SetPoint("Center",0,-60)
			if HP_Border_Flag == 1 then
				HP_t.Background_preview2:Hide()
			end
			if HP_currentSpec == 2 then
				HP_width = HP_Spec2_Width
				HP_height = HP_Spec2_Height
				HP_Resize_height()
				HP_Resize_width()
				if HP_Border_Flag == 1 then
					HP_t.Background:Hide()
				end
			end
		elseif Theme_Icon_Spec2_Flag == 1 then
			Spec_2_Preview:SetWidth(64)
			Spec_2_Preview:SetHeight(64)
			Spec_2_Preview:SetPoint("Center",0,-80)
			if HP_Border_Flag == 1 then
				if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
					HP_t.Background_preview2:Show()
				else
					HP_t.Background_preview2:Hide()
				end
			end
			if HP_currentSpec == 2 then
				HP_resize_check = 1
				HP_width = HP_width_Icon2
				HP_height = HP_height_Icon2
				HP_Resize_height()
				HP_Resize_width()
				if HP_Border_Flag == 1 then
					if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
						HP_t.Background:Show()
					else
						HP_t.Background:Hide()
					end
				end
			end
		end
		local Chosen_Theme = 0
		if HP_currentSpec == 2 then
			HP_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec2.."\\center.tga")
		end
		Spec2_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec2.."\\center.tga")
		_G[Spec2_T_Slider:GetName() .. 'Text']:SetText('Theme for Secondary Spec: ' .. Theme_select_Spec2)       -- Sets the "title" text (top-centre of slider).
	end)
	-- Handler for Colour picker
	HP_Border_Colour_Button:SetScript("OnClick", function(self)
		HP_DarkLight = "Light"
		DarkLight_Slider:SetValue(2)
		_G[DarkLight_Slider:GetName() .. 'Text']:SetText('Border Theme: ' .. HP_DarkLight)
		HP_Border_Control_Apply()
		ShowColorPickerHP(r, g, b, HPmyColorCallback);
	end)

	-- Handler for Main Menu shortcut
	Main_Options_Button:SetScript("OnClick", function(self)
		InterfaceOptionsFrame_OpenToCategory(HP_Panel_Name_Store)
	end)
end

function ShowColorPickerHP(r, g, b, changedCallback)
	--print("TESTING")
	local r,g,b = HP_Colour_R, HP_Colour_G, HP_Colour_B
	--print(r,g,b)
	--ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a;
	ColorPickerFrame.previousValues = {r,g,b};
	ColorPickerFrame.func, ColorPickerFrame.cancelFunc = changedCallback, changedCallback;
	ColorPickerFrame:SetColorRGB(r,g,b);
	ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
	ColorPickerFrame:Show();
	--print("TESTING 2")
	
	HP_ColourReset_Button = "Colour Reset"
	template = "UIPanelButtonTemplate"
	HP_ColourReset = CreateFrame("Button",HP_ColourReset_Button,ColorPickerFrame,template)
	HP_ColourReset:SetPoint("BottomRight",-25,40)
	HP_ColourReset:SetWidth(70)
	HP_ColourReset:SetText("Reset")
	HP_ColourReset:Show()
	
	-- Handler for colour reset
	HP_ColourReset:SetScript("OnClick", function(self)
		HP_Colour_R = 1
		HP_Colour_G = 1
		HP_Colour_B = 1
		HP_Border_Thickness = 0
		HP_Thickness_Slider:SetValue(HP_Border_Thickness)
		HP_Border_Control_Apply()
		ShowColorPickerHP(r, g, b, HPmyColorCallback);
	end)
end	
function HPmyColorCallback(restore)
		--print("HI")
		local newR, newG, newB;
		if restore then
			-- The user bailed, we extract the old color from the table created by ShowColorPicker.
			newR, newG, newB = unpack(restore);
		else
			-- Something changed
			newR, newG, newB  = ColorPickerFrame:GetColorRGB();
		end

		-- Update our internal storage.
		r, g, b  = newR, newG, newB; 

		-- And update any UI elements that use this color...
		HP_Colour_R = r
		HP_Colour_G = g
		HP_Colour_B = b

		if HP_Colour_R == 1 and HP_Colour_G == 1 and HP_Colour_B == 1 then
			if HP_DarkLight == "Dark" then
				DarkLight_Slider:SetValue(1)
			elseif HP_DarkLight == "Light" then
				DarkLight_Slider:SetValue(2)
			end
			_G[DarkLight_Slider:GetName() .. 'Text']:SetText('Border Theme: ' .. HP_DarkLight)
			if Theme_Icon_Spec1_Flag == 1 then
				HP_t.Background_preview1:Show()
				if HP_CurrentSpec == 1 then
					HP_t.Background:Show()
				end
			elseif Theme_Icon_Spec2_Flag == 1 then
				HP_t.Background_preview2:Show()
				if HP_CurrentSpec == 2 then
					HP_t.Background:Show()
				end
			end
			if Theme_Icon_Spec1_Flag ~= 1 and HP_CurrentSpec == 1 then
				HP_t.Background:Hide()
			elseif Theme_Icon_Spec2_Flag ~= 2 and HP_CurrentSpec == 2 then
				HP_t.Background:Hide()
			end
		else
			HP_t.Background:Hide()
			HP_t.Background_preview1:Hide()
			HP_t.Background_preview2:Hide()
		end

		HP_f.Border:SetBackdropBorderColor(HP_Colour_R,HP_Colour_G,HP_Colour_B,1)
		HP_f.Border_preview1:SetBackdropBorderColor(HP_Colour_R,HP_Colour_G,HP_Colour_B,1)
		HP_f.Border_preview2:SetBackdropBorderColor(HP_Colour_R,HP_Colour_G,HP_Colour_B,1)


		--print (r, g, b)
		--HP_Border_Control_Apply()
end
	
function UnLocked_HP_Panel(panel)

	if OffCD_Flag == nil then
		OffCD_Flag = default_OffCD_Flag
	end
	if OffCD_Flag == 0 then
			HP_OffCD_Flash_checkButton:SetChecked(false)
			HP_OffCD_Flash_checkButton.text:SetText("Will NOT warn when spell is off cooldown |n  - Check to enable warning")
	elseif OffCD_Flag == 1 then
			HP_OffCD_Flash_checkButton:SetChecked(true)
			HP_OffCD_Flash_checkButton.text:SetText("WILL warn when spell is off cooldown")
	end
	if HP_InCombatOnly == 0 then
			HP_In_Combat_checkButton:SetChecked(false)
			HP_In_Combat_checkButton.text:SetText("Will show both IN and OUT of combat |n  - Check to show only when IN combat")
	elseif HP_InCombatOnly == 1 then
			HP_In_Combat_checkButton:SetChecked(true)
			HP_In_Combat_checkButton.text:SetText("WILL show ONLY when IN combat")
	end


	if Lock_Flag == 0 then
		HP_OffCD_Flash_checkButton:Show()
		HP_In_Combat_checkButton:Show()
		HP_Options_Sub_Panel:Show()
		MaxASlider:Show()
		FadeINSlider:Show()
		if OffCD_Flag == 1 then
			FlashNumSlider:Show()
			FlashSpeedSlider:Show()
		end
		HP_Resize_height()
		HP_Resize_width()
	elseif Lock_Flag == 1 then
		HP_OffCD_Flash_checkButton:Hide()
		HP_In_Combat_checkButton:Hide()
		HP_Options_Sub_Panel:Hide()
		MaxASlider:Hide()
		FadeINSlider:Hide()
		FlashNumSlider:Hide()
		FlashSpeedSlider:Hide()
		HP_Resize_height()
		HP_Resize_width()
	end

	HP_OffCD_Flash_checkButton:SetScript("OnClick", function(self)
		isOffCD_Flash_checkButton = self:GetChecked();
		if isOffCD_Flash_checkButton == nill then
			OffCD_Flag = 0
			HP_OffCD_Flash_checkButton:SetChecked(false)
			HP_OffCD_Flash_checkButton.text:SetText("Will NOT warn when spell is off cooldown |n  - Check to enable warning")
			FlashNumSlider:Hide()
			FlashSpeedSlider:Hide()
		else
			OffCD_Flag = 1
			HP_OffCD_Flash_checkButton:SetChecked(true)
			HP_OffCD_Flash_checkButton.text:SetText("WILL warn when spell is off cooldown")
			FlashNumSlider:Show()
			FlashSpeedSlider:Show()
		end
	end)

	HP_In_Combat_checkButton:SetScript("OnClick", function(self)
		isIn_Combat_checkButton = self:GetChecked();
		if isIn_Combat_checkButton == nill then
			HP_InCombatOnly = 0
			temp_HPShow = HP_InCombatOnly
			HP_In_Combat_checkButton:SetChecked(false)
			HP_In_Combat_checkButton.text:SetText("Will show both IN and OUT of combat |n  - Check to show only when IN combat")
		else
			HP_InCombatOnly = 1
			temp_HPShow = HP_InCombatOnly
			HP_In_Combat_checkButton:SetChecked(true)
			HP_In_Combat_checkButton.text:SetText("WILL show ONLY when IN combat")
		end
	end)
end

function HP_Lock()
	if Lock_Flag == nil then
		Lock_Flag = default_Lock_Flag
	end
	if Lock_Flag == 0 then
		FrameTextureUpdate(true)
		HP_f:EnableMouse(true)
		HP_f:EnableKeyboard(true)
		HP_f:EnableMouseWheel(true)
	elseif Lock_Flag == 1 then
		FrameTextureUpdate(false)
		HP_f:EnableMouse(false)
		HP_f:EnableKeyboard(false)
		HP_f:EnableMouseWheel(false)
	end
end

function HP_Max_Alpha()
HP_f:SetMovable(true)
	HP_f:SetResizable(true)
	HP_f:EnableMouse(true)
	HP_f:EnableKeyboard(true)
	HP_f:EnableMouseWheel(true)
	if HP_max_alpha_adjust == nil then
		HP_max_alpha_adjust = HP_FadeIN
	end
	HP_max_alpha_adjust = HP_max_alpha_adjust - HP_max_alpha_adjust + maa_amount
	--[[if HP_max_alpha_adjust > 0.9 then
		HP_max_alpha_adjust = 1.0
	end]]
	HP_f:SetAlpha(HP_max_alpha_adjust)
	HP_f:EnableMouse(false)
	HP_f:EnableKeyboard(false)
	HP_f:EnableMouseWheel(false)
end

function Default_HP_Settings()
	Lock_Flag = default_Lock_Flag
	HP_f:SetMovable(true)
	HP_f:SetResizable(true)
	HP_f:EnableMouse(true)
	HP_f:EnableKeyboard(true)
	HP_f:EnableMouseWheel(true)
	HP_f:ClearAllPoints()
	HP_height = default_height
	HP_width = default_width
	xOfs_Spec1_backup = 0
	yOfs_Spec1_backup = 0
	xOfs_Spec2_backup = 0
	yOfs_Spec2_backup = 0
	Rel_Set_Point = "CENTER"
	Rel_Set_Point_Spec1_backup = "CENTER"
	Rel_Set_Point_Spec2_backup = "CENTER"
	HP_Spec1_Width = default_width
	HP_Spec1_Height = default_height
	HP_Spec2_Width = default_width
	HP_Spec2_Height = default_height
	HP_Tracking = default_HP_Tracking
	HP_Tracking_Spec1 = default_HP_Tracking
	HP_Tracking_Spec2 = default_HP_Tracking
	HP_Sound = default_HP_Sound
	HP_Sound_Flag = default_HP_Sound_Flag
	HP_Strata = default_HP_Strata
	HP_Strata1 = default_HP_Strata
	HP_Strata2 = default_HP_Strata
	HP_Strata_Flag = default_HP_Strata_Flag
	HP_InCombatOnly = default_HP_InCombatOnly
	HP_VertBar_Flag = default_HP_VertBar_Flag
	HP_f:SetHeight(HP_height)
	HP_f:SetWidth(HP_width)
	HP_FadeIn_Disable = 0
	Theme_select_Spec_store()
	Theme_Index_Spec1 = default_Theme_Index_Spec1
	Theme_Index_Spec2 = default_Theme_Index_Spec2
	Theme_Icon_Spec1_Flag = default_Theme_Icon_Spec1_Flag
	Theme_Icon_Spec2_Flag = default_Theme_Icon_Spec2_Flag
	Theme_select_Spec_store()
	HP_Border_Flag = default_HP_Border_Flag
	HP_DarkLight = default_HP_DarkLight
	HP_Border_Theme = default_HP_Border_Theme
	HP_Border_Background = default_HP_Border_Background
	HP_Border_Thickness = default_HP_Border_Thickness
	HP_Border_Background_Thickness = default_HP_Border_Background_Thickness
	HP_Colour_R = default_HP_Colour_R
	HP_Colour_B = default_HP_Colour_B
	HP_Colour_G = default_HP_Colour_G
	if HP_currentSpec == 1 then
		HP_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec1.."\\center.tga")
	elseif HP_currentSpec == 2 then
		HP_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec2.."\\center.tga")
	else
		HP_t:SetTexture("Interface\\AddOns\\HaloPro\\HaloPro_Art\\"..Theme_select_Spec1.."\\center.tga")
	end
	HP_Border_Control_Apply()
	HP_t:SetAllPoints(HP_f)
	HP_f.texture = HP_t
	HP_f:SetPoint("CENTER",0,0)
	FrameTextureUpdate(nil, nil, true)
	OffCD_Flag = default_off_cd_warning

	HP_fadeintimer = default_fadeintimer
	HP_tcount_time1 = default_tcount_time1
	HP_flash_num = default_flash_num
	HP_max_alpha_adjust = default_max_alpha_adjust
	HP_f:SetAlpha(HP_max_alpha_adjust)
	print(" ")
	print("-----------------------------------------------------------")
	print(" ")
	print(" HaloPro been reset to its default settings")
	print(" ")
	print("-----------------------------------------------------------")
end
function HP_Fade_MsgMode(UIParent)
	--HP_DSMode_Msg:SetAlpha(1)
	HP_DSMode_Msg:SetText('|cff00ddaaHaloPro now in '..HC_spellName..' Mode')
	UIFrameFadeOut(HP_DSMode_Msg, 4, 1, 0)
end
function Halo_Check()

	-- Gets the local name of the spell as it would be written in the spellbook based off the spellid (there are 3 of them because as of beta there are three spellids, so just in case)
	--HC_name_120696 = GetSpellInfo(120696)
	--HC_name_120692 = GetSpellInfo(120692)
	HC_name_120517 = GetSpellInfo(120517) -- Halo
	DS_name_110744 = GetSpellInfo(110744) -- Divine Star
	CC_name_121135 = GetSpellInfo(121135) -- Cascade
	FW_name_6346 = GetSpellInfo(6346)
	Shoot_name_5019 = GetSpellInfo(5019)

	-- Checks to see if its actually in your spellbook aka learned, or else returns nil
	--HC_spellName_120696 = GetSpellInfo(HC_name_120696)
	--HC_spellName_120692 = GetSpellInfo(HC_name_120692)
	HC_spellName_120517 = GetSpellInfo(HC_name_120517) -- Halo
	DS_spellName_110744 = GetSpellInfo(DS_name_110744) -- Divine Star
	CC_spellName_121135 = GetSpellInfo(CC_name_121135) -- Cascade

	if HP_Testmode == 0 then
		if HC_spellName_120517 ~= nil then
			HP_Spell_Confirm = "Halo"
			HC_spellName = HC_spellName_120517
			HP_Lvl90_Flag = 1
			SpellToMonitor = 120517
			L_HP_Range = 15					-- Left <=
			ML_HP_Range_A = 15				-- Mid Left(A) >=
			ML_HP_Range_B = 20				-- Mid Left(B) <=
			C_HP_Range_A = 20				-- Center(A) >=
			C_HP_Range_B = 25				-- Center(B) <=
			MR_HP_Range_A = 25				-- Mid Right(A) >=
			MR_HP_Range_B = 30				-- Mid Ridht(B) <=
			R_HP_Range = 30					-- Right >=
			if HP_Fade_MsgMode_Flag == 0 or HP_Fade_MsgMode_Flag == 2 or HP_Fade_MsgMode_Flag == 3 then
				HP_Fade_MsgMode_Flag = 1
				HP_Fade_MsgMode()
			end
		elseif DS_spellName_110744 ~= nil then
			HP_Spell_Confirm = "Divine Star"
			HC_spellName = DS_name_110744
			if HP_Monitor_DS == 1 then
				HP_Lvl90_Flag = 1
				SpellToMonitor = 110744
				L_HP_Range = 0					-- Left <=
				ML_HP_Range_A = 0				-- Mid Left(A) >=
				ML_HP_Range_B = 0				-- Mid Left(B) <=
				C_HP_Range_A = 0				-- Center(A) >=
				C_HP_Range_B = 20				-- Center(B) <=
				MR_HP_Range_A = 20				-- Mid Right(A) >=
				MR_HP_Range_B = 25				-- Mid Ridht(B) <=
				R_HP_Range = 25					-- Right >=
				if HP_Fade_MsgMode_Flag == 0 or HP_Fade_MsgMode_Flag == 1 or HP_Fade_MsgMode_Flag == 3 then
					HP_Fade_MsgMode_Flag = 2
					HP_Fade_MsgMode()
				end
			else
				HP_Lvl90_Flag = 0
			end
		elseif CC_spellName_121135 ~= nil then
			HP_Spell_Confirm = "Cascade"
			HC_spellName = CC_name_121135
			if HP_Monitor_CC == 1 then
				HP_Lvl90_Flag = 1
				SpellToMonitor = 121135
				L_HP_Range = 30					-- Left <=
				ML_HP_Range_A = 30				-- Mid Left(A) >=
				ML_HP_Range_B = 35				-- Mid Left(B) <=
				C_HP_Range_A = 35				-- Center(A) >=
				C_HP_Range_B = 40				-- Center(B) <=
				MR_HP_Range_A = 40				-- Mid Right(A) >=
				MR_HP_Range_B = 45				-- Mid Ridht(B) <=
				R_HP_Range = 45					-- Right >=
				if HP_Fade_MsgMode_Flag == 0 or HP_Fade_MsgMode_Flag == 1 or HP_Fade_MsgMode_Flag == 2 then
					HP_Fade_MsgMode_Flag = 3
					HP_Fade_MsgMode()
				end
			else
				HP_Lvl90_Flag = 0
			end
		else
			HP_Lvl90_Flag = 0
		end
	else
		HP_Lvl90_Flag = 1
		SpellToMonitor = 8092
	end
end

 -- Slash command setup
SLASH_HaloPro1, SLASH_HaloPro2 = '/hp', '/halopro';
function SlashCmdList.HaloPro(msg, editbox)
	local command, rest = msg:match("^(%S*)%s*(.-)$")
	if command == "fade" and #rest >=0 then
		if HP_fadeintimer == nil then
			HP_fadeintimer = default_fadeintimer
		end
		HP_fadeintimer = HP_fadeintimer - HP_fadeintimer + rest
		print(" ")
		print("-----------------------------------------------------------")
		print(" ")
		print(" HaloPro will now start to fade in with " .. HP_fadeintimer .. "secs remaining on the cd")
		print(" ")
		print("-----------------------------------------------------------")
		print(" ")
	elseif command == "maxalpha" and #rest >=0 then
		maa_amount = rest
		HP_Max_Alpha()
		print(" ")
		print("-----------------------------------------------------------")
		print(" ")
		print(" HaloPro alpha is now maxed at " .. HP_max_alpha_adjust)
		print(" ")
		print("-----------------------------------------------------------")
		print(" ")
	elseif command == "cdhide" and rest == "yes" then
		HP_FadeIn_Disable = 0
		Fade_Toggle_Button:UnlockHighlight()
		Fade_Toggle_Button:SetText("Fade In: Enabled")
		print(" ")
		print("Fade In: Enabled - HaloPro will now disappear when spell is on cooldown")
		print(" ")
	elseif command == "cdhide" and rest == "no" then
		HP_FadeIn_Disable = 1
		Fade_Toggle_Button:LockHighlight()
		Fade_Toggle_Button:SetText("Fade In: Disabled")
		print(" ")
		print("Fade In: Disabled - HaloPro will not disappear when spell is on cooldown")
		print(" ")
	elseif command == "offcd" and rest == "yes" then
		OffCD_Flag = 1
		print(" ")
		print("Halo cooldown warning: Enabled!")
		print(" ")
	elseif command == "offcd" and rest == "no" then
		OffCD_Flag = 0
		print(" ")
		print("Halo cooldown warning: Disabled!")
		print(" ")
	elseif command == "sound" and rest == "no" then
		HP_Sound_Flag = 0
		print(" ")
		print("HaloPro's sound warning is now disabled")
		print(" ")
		HP_Sound_Refresh(HP_Options_Sub_Panel)
	elseif command == "sound" and rest == "yes" then
		HP_Sound_Flag = 1
		print(" ")
		print("HaloPro's sound warning is now enabled")
		print(" ")
		HP_Sound_Refresh(HP_Options_Sub_Panel)
	elseif command == "track" and rest == "target" then
		HP_Tracking = 'target'
		HP_Track_Toggle:SetText("Track: "..HP_Tracking)
		HP_Always_Show_Flag = HP_Always_Show_Temp
		HP_Restore_Tracking_PerSpec()
		print(" ")
		print("HaloPro will now track your current target")
		print(" ")
	elseif command == "track" and rest == "focus" then
		HP_Tracking = 'focus'
		HP_Track_Toggle:SetText("Track: "..HP_Tracking)
		HP_Always_Show_Flag = HP_Always_Show_Temp
		HP_Restore_Tracking_PerSpec()
		print(" ")
		print("HaloPro will now track your focus target")
		print(" ")
	elseif command == "track" and rest == "mouseover" then
		HP_Tracking = 'mouseover'
		HP_Track_Toggle:SetText("Track: "..HP_Tracking)
		HP_Always_Show_Temp = HP_Always_Show_Flag
		HP_Always_Show_Flag = 'Yes'
		HP_Restore_Tracking_PerSpec()
		print(" ")
		print("HaloPro will now track your mouseover target")
		print(" ")
	else
		if msg == 'default'	then
			Default_HP_Settings()
		elseif msg == 'lock' then
			Lock_Flag = 1
			if temp_HPShow == 1 then
				HP_InCombatOnly = 1
			end
			HP_Lock(UIParent)
			print(" ")
			print("-----------------------------------------------------------")
			print(" ")
			print(" HaloPro is now locked and can not be moved or resized")
			print(" ")
			print(" To unlock again use /hp unlock, or /halopro unlock")
			print(" ")
			print(" /hp default returns to default size and center of screen")
			print(" ")
			print("-----------------------------------------------------------")
			print(" ")
		elseif msg == 'unlock' then
			Lock_Flag = 0
			temp_HPShow = HP_InCombatOnly
			if temp_HPShow == 1 then
				HP_InCombatOnly = 0
			end
			FrameTextureUpdate(true)
			HP_f:SetMovable(true)
			HP_f:SetResizable(true)
			HP_f:EnableMouse(true)
			HP_f:EnableKeyboard(true)
			HP_f:EnableMouseWheel(true)
			print(" ")
			print("-----------------------------------------------------------")
			print(" ")
			print(" HaloPro is now unlocked!")
			print(" ")
			print(" Left mouse drag to move")
			print(" ")
			print(" Mouse scroll with pointer on bar to adjust width")
			print(" ")
			print(" Shift + mouse scroll with pointer on bar to adjust height")
			print(" ")
			print("-----------------------------------------------------------")
			print(" ")
		elseif msg == 'options' then
			InterfaceOptionsFrame_OpenToCategory(HP_Panel_Name_Store)
		elseif msg == 'testmode' then
			if HP_Testmode == 0 then
				print(" ")
				print("HaloPro is now in 'Test Mode' - switching to monitor Mind Blast")
				print(" ")
				HP_Testmode = 1
				--SpellToMonitor = "Mind Blast"
			else
				print(" ")
				print("HaloPro's is now in 'Normal Mode' - now monitoring lvl 90 talents")
				print(" ")
				HP_Testmode = 0
			end
		elseif msg == 'tracktoggle' then
			if HP_Tracking == 'focus' then
				HP_Tracking = 'target'
				HP_Track_Toggle:SetText("Track: "..HP_Tracking)
				HP_Always_Show_Flag = HP_Always_Show_Temp
				print("HaloPro is now tracking: Your Current Target")
			elseif HP_Tracking == 'target' then
				HP_Tracking = 'mouseover'
				HP_Track_Toggle:SetText("Track: "..HP_Tracking)
				HP_Always_Show_Temp = HP_Always_Show_Flag
				HP_Always_Show_Flag = 'Yes'
				print("HaloPro is now tracking: Your Mouseover Target")
			elseif HP_Tracking == 'mouseover' then
				HP_Tracking = 'focus'
				HP_Track_Toggle:SetText("Track: "..HP_Tracking)
				HP_Always_Show_Flag = HP_Always_Show_Temp
				print("HaloPro is now tracking: Your Focus Target")
			end
		--[[elseif msg == 'hpmacro' then
			temptarget = "Spinalcrack"
			templine = "/cast [target="..temptarget.."]Cascade"
			DeleteMacro("MyMacro")
			testmacroId = CreateMacro("MyMacro", "INV_MISC_QUESTIONMARK", templine, nil);]]
		else
			print(" ")
			print("-----------------------------------------------------------")
			print(" ")
			print("/hp or /halopro options...")
			print(" ")
			print(" 'options' - bring up the HaloPro Options gui")
			print(" 'default' - unlocks and resets bar position and size")
			print(" 'lock' - locks down to the bar so it can't be moved or resized")
			print(" 'unlock' - unlocks the bar so it can be moved or resized")
			print(" 'maxalpha #alpha(0.0 - 1.0)' - sets the max alpha of the bar")
			print(" 'fade #secs' - sets how many seconds left on the spell cd to start fading back in")
			print(" 'cdhide yes/no - should HaloPro hide when spell is on cooldown?")
			print(" 'offcd yes/no' - should the bar flash when s[ell comes off cooldown?")
			print(" 'sound yes/no' - should HaloPro play a sound when at the correct distance for max damage?")
			print(" 'track target/focus/mouseover' - sets whether HaloPro should track your current target, mouseover target or your focus target")
			print(" 'tracktoggle' - toggles between tracking current target, mouseover target and focus target - very macro friendly")
			print(" ")
			print("-----------------------------------------------------------")
			print(" ")
		end
	end
end