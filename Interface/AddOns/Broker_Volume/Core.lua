-- ********************************************************************************
-- Data Broker Volume Control (Broker_Volume)
-- A volume control for Data Broker.
-- By: Shenton
--
-- Core.lua
-- ********************************************************************************

local LibStub = LibStub;

-- Ace libs (<3)
local A = LibStub("AceAddon-3.0"):NewAddon("BrokerVolume", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("BrokerVolume", false);
A.L = L;

-- LibDBIcon
A.icon = LibStub("LibDBIcon-1.0");

-- Addon global
_G["BrokerVolumeGlobal"] = A;

-- ********************************************************************************
-- Variables
-- ********************************************************************************

-- Globals to locals
local floor = floor;
local ceil = ceil;
local abs = abs;
local format = format;
local tonumber = tonumber;
local tostring = tostring
local smatch = string.match;
local mmodf = math.modf;
local ipairs = ipairs

local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton;
local CloseDropDownMenus = CloseDropDownMenus;
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME;
local SetCVar = SetCVar;
local GetCVar = GetCVar;
local ActionStatus_DisplayMessage = ActionStatus_DisplayMessage;
local SOUND_DISABLED = SOUND_DISABLED;
local MUSIC_ENABLED = MUSIC_ENABLED;
local MUSIC_DISABLED = MUSIC_DISABLED;
local SOUND_EFFECTS_ENABLED = SOUND_EFFECTS_ENABLED;
local SOUND_EFFECTS_DISABLED = SOUND_EFFECTS_DISABLED;
local ENABLE_SOUND = ENABLE_SOUND;
local UIParent = UIParent;
local GetCursorPosition = GetCursorPosition;
local GameTooltip = GameTooltip;
local GetLFGProposal = GetLFGProposal;
local PlaySound = PlaySound;
local CreateFrame = CreateFrame;
local ToggleDropDownMenu = ToggleDropDownMenu;
local IsShiftKeyDown = IsShiftKeyDown;

-- AddOn version
A.version = GetAddOnMetadata("Broker_Volume", "Version");

-- Text colors
A.color =
{
    RED = "|cffff3333",
    YELLOW = "|cffffff33",
    ORANGE = "|cffff9933",
    GREEN = "|cff33ff99",
    WHITE = "|cffffffff",
    GRAY = "|cff999999",
    WARRIOR = "|cffc79c6e",
    RESET = "|r",
};

-- ********************************************************************************
-- Dropdown menu
-- ********************************************************************************

--- The dropdown menu structure function
-- @usage Called by ToggleDropDownMenu()
-- @param self Frame object
-- @param level Nesting level
local function DropdownMenu(self, level)
    if ( not level ) then return; end

    local info = self.info;

    if ( level == 1 ) then
        -- Menu title
        self.info.isTitle = 1;
        self.info.text = L["Broker Volume"];
        self.info.notCheckable = 1;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.keepShownOnClick = 1;
        self.info.isTitle = nil;
        self.info.notCheckable = nil;
        self.info.disabled = nil;

        -- Blizzlike mute
        self.info.text = L["Blizlike mute"];
        self.info.checked = A.db.profile.blizlike;
        self.info.func = function() A.db.profile.blizlike = not A.db.profile.blizlike; end;
        UIDropDownMenu_AddButton(self.info, level);

        -- Show/hide minimap icon
        self.info.text = L["Show/Hide minimap icon"];
        self.info.checked = not A.db.profile.minimap.hide;
        self.info.func = function()
            A.db.profile.minimap.hide = not A.db.profile.minimap.hide;
            A:ShowHideMinimap();
        end;
        UIDropDownMenu_AddButton(self.info, level);

        -- Queued volume
        self.info.text = L["Queued volume boost"];
        self.info.checked = A.db.profile.queuedVolume.enable;
        self.info.func = function() A.db.profile.queuedVolume.enable = not A.db.profile.queuedVolume.enable; end;
        UIDropDownMenu_AddButton(self.info, level);

        -- No tooltip mode
        self.info.text = L["No tooltip mode"];
        self.info.checked = A.db.profile.noTooltipMode;
        self.info.func = function()
            A.db.profile.noTooltipMode = not A.db.profile.noTooltipMode;
            A:SetTooltipMode();
        end;
        UIDropDownMenu_AddButton(self.info, level);

        -- Close
        self.info.text = L["Close"];
        self.info.notCheckable = 1;
        self.info.keepShownOnClick = nil;
        self.info.func = function() CloseDropDownMenus(); end;
        UIDropDownMenu_AddButton(self.info, level);
    end
end

-- ********************************************************************************
-- Functions
-- ********************************************************************************

--- Send a message to the chat frame with the addon name colored
-- @param text The message to display
-- @param color Bool, if true will color in red
function A:Message(text, color)
    if ( color ) then
        color = A.color["RED"];
    else
        color = A.color["GREEN"]
    end

    DEFAULT_CHAT_FRAME:AddMessage(color..L["Broker Volume"]..": "..A.color["RESET"]..text);
end

--- Handle the slash command
function A:SlashCommand(input)
    local arg1, arg2 = smatch(input, "(%a*)%s?(.*)");

    if ( arg1 == "" ) then
        A:Message(L["Command usage: /bv, /brokervolume"]);
        A:Message(L["    |cffc79c6eshow|r, show the minimap icon."]);
        A:Message(L["    |cffc79c6elevels|r, display volume levels."]);
        A:Message(L["    |cffc79c6e<master||effects||music||ambience> <0-100>|r, will set the volume for the given category."]);
    elseif ( arg1 == "show" ) then
        A.db.profile.minimap.hide = false;
        A:ShowHideMinimap();
    elseif ( arg1 == "levels" ) then
        local master = A:GetVolumePercent("Sound_MasterVolume");
        local effects = A:GetVolumePercent("Sound_SFXVolume");
        local music = A:GetVolumePercent("Sound_MusicVolume");
        local ambience = A:GetVolumePercent("Sound_AmbienceVolume");

        A:Message(L["Master: |cffc79c6e%s|r%% - Effects: |cffc79c6e%s|r%% - Music: |cffc79c6e%s|r%% - Ambience: |cffc79c6e%s|r%%"]:format(master, effects, music, ambience));
    elseif ( arg1 == "master" and arg2 ) then
        local volume = tonumber(arg2);

        if ( A:IsInRange(volume) ) then
            volume = A:SetVolumeNum(volume);
            SetCVar("Sound_MasterVolume", volume, "Doh!");
            A:Message(L["Master volume set to"]..": "..floor(volume * 100).."%");
        end
    elseif ( arg1 == "effects" and arg2 ) then
        local volume = tonumber(arg2);

        if ( A:IsInRange(volume) ) then
            volume = A:SetVolumeNum(volume);
            SetCVar("Sound_SFXVolume", volume, "Doh!");
            A:Message(L["Effects volume set to"]..": "..floor(volume * 100).."%");
        end
    elseif ( arg1 == "music" and arg2 ) then
        local volume = tonumber(arg2);

        if ( A:IsInRange(volume) ) then
            volume = A:SetVolumeNum(volume);
            SetCVar("Sound_MusicVolume", volume, "Doh!");
            A:Message(L["Music volume set to"]..": "..floor(volume * 100).."%");
        end
    elseif ( arg1 == "ambience" and arg2 ) then
        local volume = tonumber(arg2);

        if ( A:IsInRange(volume) ) then
            volume = A:SetVolumeNum(volume);
            SetCVar("Sound_AmbienceVolume", volume, "Doh!");
            A:Message(L["Ambience volume set to"]..": "..floor(volume * 100).."%");
        end
    else
        A:Message(L["Command usage: /bv, /brokervolume"]);
        A:Message(L["    |cffc79c6eshow|r, show the minimap icon."]);
        A:Message(L["    |cffc79c6elevels|r, display volume levels."]);
        A:Message(L["    |cffc79c6e<master||effects||music||ambience> <0-100>|r, will set the volume for the given category."]);
    end
end

--- Round
-- @param num The number to round
-- @param idp Number of decimal
-- @return The rounded number
function A:Round(num, idp)
    local mult = 10 ^ ( idp or 0 );

    return floor(num * mult + 0.5) / mult;
end

--- Ceil decade
-- @param val The number to round
-- @return Rounded number
function A:CeilDecade(num)
    return ceil(num / 10) * 10;
end

--- Get the volume level in percent
-- @param cat Volume category
-- @return The volume as percent
function A:GetVolumePercent(cat)
    local volume = tonumber(GetCVar(cat));

    volume = floor(volume * 100);

    return volume;
end

--- Check if the number is between 0-100
-- @param num The number to test
function A:IsInRange(num)
    if ( num >= 0 and num <= 100) then
        return true;
    else
        A:Message(L["You must provide a number between 0 and 100."], true);
    end

    return false;
end

--- ColorGradient function by Tekkub (http://tekkub.net/) & http://www.wowpedia.org/RGBPercToHex)
function A:ColorGradient(perc, r1, g1, b1, r2, g2, b2, r3, g3, b3)
    local r, g, b;

    if ( perc > 1 ) then perc = perc / 100; end

    if ( not r1 ) then
        r1, g1, b1, r2, g2, b2, r3, g3, b3 = 0, 1, 0, 1, 1, 0, 1, 0, 0;
    end

    if ( perc >= 1 ) then
        r, g, b = r3, g3, b3;
    elseif ( perc <= 0 ) then
        r, g, b = 0.5, 0.5, 1;
    else
        local segment, relperc = mmodf(perc*2);
        if ( segment == 1 ) then r1, g1, b1, r2, g2, b2 = r2, g2, b2, r3, g3, b3 end
        r = r1 + (r2-r1)*relperc;
        g = g1 + (g2-g1)*relperc;
        b = b1 + (b2-b1)*relperc;
    end

    r = r <= 1 and r >= 0 and r or 0;
    g = g <= 1 and g >= 0 and g or 0;
    b = b <= 1 and b >= 0 and b or 0;

    return "|cff"..format("%02x%02x%02x", r*255, g*255, b*255);
end

--- Set a number to match volume cvar
-- @param val The number to set
-- @return The rounded number
function A:SetVolumeNum(num)
    num = A:CeilDecade(num);
    num = num / 100;
    num = A:Round(num, 1);

    return num;
end

--- Blizzard default function Sound_ToggleMusic()
function A:ToggleMusic()
    if ( GetCVar("Sound_EnableAllSound") == "0" ) then
        ActionStatus_DisplayMessage(SOUND_DISABLED, true);
    else
        if ( GetCVar("Sound_EnableMusic") == "0" ) then
            SetCVar("Sound_EnableMusic", 1, "Doh!");
            ActionStatus_DisplayMessage(MUSIC_ENABLED, true)
        else
            SetCVar("Sound_EnableMusic", 0, "Doh!");
            ActionStatus_DisplayMessage(MUSIC_DISABLED, true)
        end
    end
end

--- Blizzard default function Sound_ToggleSound()
function A:ToggleSound()
    if ( GetCVar("Sound_EnableAllSound") == "0" ) then
        ActionStatus_DisplayMessage(SOUND_DISABLED, true);
    else
        if ( GetCVar("Sound_EnableSFX") == "0" ) then
            SetCVar("Sound_EnableSFX", 1, "Doh!");
            SetCVar("Sound_EnableAmbience", 1, "Doh!");
            ActionStatus_DisplayMessage(SOUND_EFFECTS_ENABLED, true);
        else
            SetCVar("Sound_EnableSFX", 0, "Doh!");
            SetCVar("Sound_EnableAmbience", 0, "Doh!");
            ActionStatus_DisplayMessage(SOUND_EFFECTS_DISABLED, true);
        end
    end
end

--- Toggle all sounds
function A:ToggleAll()
    if ( GetCVar("Sound_EnableAllSound") == "0" ) then
        ActionStatus_DisplayMessage(SOUND_DISABLED, true);
    else
        if ( GetCVar("Sound_EnableSFX") == "0" ) then
            SetCVar("Sound_EnableSFX", 1, "Doh!");
            SetCVar("Sound_EnableAmbience", 1, "Doh!");
            SetCVar("Sound_EnableMusic", 1, "Doh!");
            ActionStatus_DisplayMessage(ENABLE_SOUND, true);
        else
            SetCVar("Sound_EnableSFX", 0, "Doh!");
            SetCVar("Sound_EnableAmbience", 0, "Doh!");
            SetCVar("Sound_EnableMusic", 0, "Doh!");
            ActionStatus_DisplayMessage(L["Disable Sound"], true);
        end
    end
end

--- Force music
-- @param off Will disable music
function A:ForceMusic(off)
    if ( off ) then
        SetCVar("Sound_EnableMusic", 0, "Doh!");
        ActionStatus_DisplayMessage(MUSIC_DISABLED, true);
    else
        SetCVar("Sound_EnableMusic", 1, "Doh!");
        ActionStatus_DisplayMessage(MUSIC_ENABLED, true);
    end
end

--- Force effects
-- @param off Will disable all effects
function A:ForceSound(off)
    if ( off ) then
        SetCVar("Sound_EnableSFX", 0, "Doh!");
        SetCVar("Sound_EnableAmbience", 0, "Doh!");
        ActionStatus_DisplayMessage(SOUND_EFFECTS_DISABLED, true);
    else
        SetCVar("Sound_EnableSFX", 1, "Doh!");
        SetCVar("Sound_EnableAmbience", 1, "Doh!");
        ActionStatus_DisplayMessage(SOUND_EFFECTS_ENABLED, true);
    end
end

--- Force all sounds
-- @param off Will disable all sounds
function A:ForceAll(off)
    if ( off ) then
        SetCVar("Sound_EnableSFX", 0, "Doh!");
        SetCVar("Sound_EnableAmbience", 0, "Doh!");
        SetCVar("Sound_EnableMusic", 0, "Doh!");
        ActionStatus_DisplayMessage(L["Disable Sound"], true);
    else
        SetCVar("Sound_EnableSFX", 1, "Doh!");
        SetCVar("Sound_EnableAmbience", 1, "Doh!");
        SetCVar("Sound_EnableMusic", 1, "Doh!");
        ActionStatus_DisplayMessage(ENABLE_SOUND, true);
    end
end

--- 10% effects volume up or down
function A:EffectsVolumeUp()
    local volume = tonumber(GetCVar("Sound_SFXVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume <= 0.9) then
        SetCVar("Sound_SFXVolume", volume + 0.1, "Doh!");
    end
end
function A:EffectsVolumeDown()
    local volume = tonumber(GetCVar("Sound_SFXVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume >= 0.1 ) then
        SetCVar("Sound_SFXVolume", volume - 0.1, "Doh!");
    end
end

--- 10% music volume up or down
function A:MusicVolumeUp()
    local volume = tonumber(GetCVar("Sound_MusicVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume <= 0.9) then
        SetCVar("Sound_MusicVolume", volume + 0.1, "Doh!");
    end
end
function A:MusicVolumeDown()
    local volume = tonumber(GetCVar("Sound_MusicVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume >= 0.1 ) then
        SetCVar("Sound_MusicVolume", volume - 0.1, "Doh!");
    end
end

--- 10% ambience volume up or down
function A:AmbienceVolumeUp()
    local volume = tonumber(GetCVar("Sound_AmbienceVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume <= 0.9) then
        SetCVar("Sound_AmbienceVolume", volume + 0.1, "Doh!");
    end
end
function A:AmbienceVolumeDown()
    local volume = tonumber(GetCVar("Sound_AmbienceVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume >= 0.1 ) then
        SetCVar("Sound_AmbienceVolume", volume - 0.1, "Doh!");
    end
end

--- Show or hide the minimap icon
function A:ShowHideMinimap()
    if ( A.db.profile.minimap.hide ) then
        A:Message(L["Minimap icon is hidden if you want to show it back use: /bv show or /brokervolume show"], true);
        A.icon:Hide("BrokerVolumeIcon");
    else
        A.icon:Show("BrokerVolumeIcon");
    end
end

--- Return anchor points depending on cursor position
function A:GetAnchor()
    local ps = UIParent:GetEffectiveScale();
    local px, py = UIParent:GetCenter();
    local x, y = GetCursorPosition();

    px, py = px * ps, py * ps;

    if ( x > px ) then
        if ( y > py ) then
            return "TOPRIGHT", "BOTTOMLEFT";
        else
            return "BOTTOMRIGHT", "TOPLEFT";
        end
    else
        if ( y > py ) then
            return "TOPLEFT", "BOTTOMRIGHT";
        else
            return "BOTTOMLEFT", "TOPRIGHT";
        end
    end
end

--- Update Broker
function A:UpdateBroker()
    if ( GetCVar("Sound_EnableAllSound") == "0" ) then
        A.ldb.text = SOUND_DISABLED;
        A.ldb.icon = "Interface\\AddOns\\Broker_Volume\\Graphics\\sound-mute";
    elseif ( GetCVar("Sound_EnableSFX") == "0" ) then
        A.ldb.text = L["Mute"];
        A.ldb.icon = "Interface\\AddOns\\Broker_Volume\\Graphics\\sound-mute";
    else
        local volume = A:GetVolumePercent("Sound_MasterVolume");

        A.ldb.text = A:ColorGradient(volume)..volume.."|r%";

        if ( volume > 60 ) then
            A.ldb.icon = "Interface\\AddOns\\Broker_Volume\\Graphics\\sound-max";
        elseif ( volume > 30 ) then
            A.ldb.icon = "Interface\\AddOns\\Broker_Volume\\Graphics\\sound-medium";
        elseif ( volume > 0 ) then
            A.ldb.icon = "Interface\\AddOns\\Broker_Volume\\Graphics\\sound-low";
        else
            A.ldb.icon = "Interface\\AddOns\\Broker_Volume\\Graphics\\sound-mute";
        end
    end
end

--- Reset sound options after LFG proposal, when needed
function A:ResetQueuedVolume()
    if ( A.db.profile.queuedVolume.isQueued ) then
        if ( A.db.profile.queuedVolume.bgSound == "0" ) then SetCVar("Sound_EnableSoundWhenGameIsInBG", 0); end

        if ( A.db.profile.queuedVolume.soundState == "0" ) then
            if ( A.db.profile.blizlike ) then
                A:ForceSound(1);
            else
                A:ForceAll(1);
            end
        end

        if ( A.db.profile.queuedVolume.volume ) then SetCVar("Sound_MasterVolume", A.db.profile.queuedVolume.volume, "Doh!"); end

        A.db.profile.queuedVolume.bgSound = nil;
        A.db.profile.queuedVolume.soundState = nil;
        A.db.profile.queuedVolume.volume = nil;
        A.db.profile.queuedVolume.isQueued = nil;
    end
end

--- Set tooltip mode
function A:SetTooltipMode()
    if ( A.db.profile.noTooltipMode ) then
        A.ldb.OnEnter = function(self)
            if ( not A.slidersFrame ) then A:CreateSlidersFrame(); end
            local point, relativePoint = A:GetAnchor();
            A.slidersFrame:ClearAllPoints();
            A.slidersFrame:SetPoint(point, self, relativePoint, 0, 0);
            CloseDropDownMenus();
            GameTooltip:Hide();
            A.slidersFrame:Show();
            A.slidersFrame.closeTimer = A:ScheduleTimer("CloseSlidersFrame", 4);
        end
    else
        A.ldb.OnEnter = nil;
    end
end

-- ********************************************************************************
-- Events callbacks
-- ********************************************************************************

--- Callback function for event VARIABLES_LOADED
function A:VARIABLES_LOADED()
    A:UpdateBroker();
end

--- Callback function for event CVAR_UPDATE
function A:CVAR_UPDATE()
    A:UpdateBroker();
end

--- Callback function for event LFG_PROPOSAL_SHOW
function A:LFG_PROPOSAL_SHOW()
    if ( not A.db.profile.queuedVolume.enable ) then return; end

    local proposalExists = GetLFGProposal();

    if ( proposalExists ) then
        A.db.profile.queuedVolume.isQueued = 1;

        if ( GetCVar("Sound_EnableAllSound") == "0" ) then
            A:Message(L["Queued volume is enabled but all sound is currently disabled."], 1);
            return;
        end

        A.db.profile.queuedVolume.bgSound = GetCVar("Sound_EnableSoundWhenGameIsInBG");
        A.db.profile.queuedVolume.soundState = GetCVar("Sound_EnableSFX");
        A.db.profile.queuedVolume.volume = GetCVar("Sound_MasterVolume");

        if ( A.db.profile.queuedVolume.bgSound == "0" ) then SetCVar("Sound_EnableSoundWhenGameIsInBG", 1); end

        if ( A.db.profile.queuedVolume.soundState == "0" ) then
            if ( A.db.profile.blizlike ) then
                A:ForceSound();
            else
                A:ForceAll();
            end
        end

        SetCVar("Sound_MasterVolume", 1, "Doh!");

        if ( A.db.profile.queuedVolume.soundState == "0" ) then
            PlaySound("ReadyCheck");
        end
    end
end

--- Callback function for event LFG_PROPOSAL_FAILED
function A:LFG_PROPOSAL_FAILED()
    A:ResetQueuedVolume();
end

--- Callback function for event LFG_PROPOSAL_SUCCEEDED
function A:LFG_PROPOSAL_SUCCEEDED()
    A:ResetQueuedVolume();
end

--- Callback function for event PLAYER_ENTERING_WORLD
function A:PLAYER_ENTERING_WORLD()
    A:ResetQueuedVolume();
end

-- ********************************************************************************
-- Blizzard functions hooks
-- ********************************************************************************

--- Callback function for hook Sound_MasterVolumeUp()
function A:Sound_MasterVolumeUp()
    local volume = tonumber(GetCVar("Sound_MasterVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume <= 0.9) then
        SetCVar("Sound_MasterVolume", volume + 0.1, "Doh!");
    end
end

--- Callback function for hook Sound_MasterVolumeDown()
function A:Sound_MasterVolumeDown()
    local volume = tonumber(GetCVar("Sound_MasterVolume"));

    volume = A:Round(volume, 1);
    if ( volume and volume >= 0.1 ) then
        SetCVar("Sound_MasterVolume", volume - 0.1, "Doh!");
    end
end

--- Callback function for hook Sound_ToggleSound()
function A:Sound_ToggleSound()
    if ( A.db.profile.blizlike ) then
        A:ToggleSound();
    else
        A:ToggleAll();
    end
end

--- Callback function for hook Sound_ToggleMusic()
function A:Sound_ToggleMusic()
    if ( A.db.profile.blizlike ) then
        A:ToggleMusic();
    else
        A:ToggleAll();
    end
end

-- ********************************************************************************
-- Configuration DB
-- ********************************************************************************

--- Default configuration table for AceDB
local aceDefaultDB =
{
    profile =
    {
        blizlike = nil,
        noTooltipMode = nil,
        queuedVolume =
        {
            enable = 1,
            isQueued = nil,
            bgSound = nil,
            soundState = nil,
            volume = nil,
        },
        minimap =
        {
            hide = 1,
        },
    },
};

-- ********************************************************************************
-- Main
-- ********************************************************************************

--- AceAddon callback
-- Called after the addon is fully loaded
function A:OnInitialize()
    -- Config db
    A.db = LibStub("AceDB-3.0"):New("BrokerVolumeDB", aceDefaultDB);

    -- LDB
    A.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("Broker Volume",
    {
        type = "data source",
        text = "",
        label = L["Broker Volume"],
        icon = "Interface\\AddOns\\Broker_Volume\\Graphics\\sound-mute",
        tocname = "Broker_Volume",
        OnMouseWheel = function(self, delta)
            if ( delta > 0 ) then
                A:Sound_MasterVolumeUp();
            else
                A:Sound_MasterVolumeDown();
            end
        end,
        OnClick = function(self, button)
            if (button == "LeftButton") then
                if ( A.db.profile.blizlike ) then
                    A:ToggleSound();
                else
                    A:ToggleAll();
                end
            elseif ( button == "RightButton" ) then
                if ( A.db.profile.noTooltipMode ) then
                    if ( A.menuFrame.initialize ~= DropdownMenu ) then
                            A.menuFrame.initialize = DropdownMenu;
                    end
                    CloseDropDownMenus();
                    ToggleDropDownMenu(1, nil, A.menuFrame, self, 0, 0);
                    GameTooltip:Hide();
                else
                    if ( IsShiftKeyDown() ) then
                        if ( A.menuFrame.initialize ~= DropdownMenu ) then
                            A.menuFrame.initialize = DropdownMenu;
                        end
                        CloseDropDownMenus();
                        ToggleDropDownMenu(1, nil, A.menuFrame, self, 0, 0);
                        GameTooltip:Hide();
                    else
                        if ( not A.slidersFrame ) then A:CreateSlidersFrame(); end
                        local point, relativePoint = A:GetAnchor();
                        A.slidersFrame:ClearAllPoints();
                        A.slidersFrame:SetPoint(point, self, relativePoint, 0, 0);
                        CloseDropDownMenus();
                        GameTooltip:Hide();
                        A.slidersFrame:Show();
                    end
                end
            end
        end,
        OnTooltipShow = function(tooltip)
            if ( A.db.profile.noTooltipMode ) then return; end

            tooltip:AddDoubleLine(A.color["WHITE"]..L["Broker Volume"], A.color["GREEN"].." v"..A.version);
            tooltip:AddLine(" ");

            local master = A:GetVolumePercent("Sound_MasterVolume");
            local sfx = A:GetVolumePercent("Sound_SFXVolume");
            local music = A:GetVolumePercent("Sound_MusicVolume");
            local ambience = A:GetVolumePercent("Sound_AmbienceVolume");

            if ( GetCVar("Sound_EnableAllSound") == "0" ) then
                tooltip:AddLine(SOUND_DISABLED);
                tooltip:AddLine(" ");
            end

            if ( GetCVar("Sound_EnableSFX") == "0" ) then
                tooltip:AddLine(L["Mute"]);
                tooltip:AddLine(" ");
            end

            tooltip:AddLine(L["Master volume"]..": "..A:ColorGradient(master)..master.."%");
            tooltip:AddLine(L["Effects volume"]..": "..A:ColorGradient(sfx)..sfx.."%");
            tooltip:AddLine(L["Music volume"]..": "..A:ColorGradient(music)..music.."%");
            tooltip:AddLine(L["Ambience volume"]..": "..A:ColorGradient(ambience)..ambience.."%");

            tooltip:AddLine(" ");
            tooltip:AddLine(L["|cffc79c6eLeft-Click: |cff33ff99Mute sound\n|cffc79c6eRight-Click: |cff33ff99Display the volume sliders\n|cffc79c6eShift+Right-Click: |cff33ff99Display the configuration menu"]);
        end,
    });

    -- Set tooltip mode
    A:SetTooltipMode();

    -- LDBIcon
    A.icon:Register("BrokerVolumeIcon", A.ldb, A.db.profile.minimap);

    -- Menu frame & table
    A.menuFrame = CreateFrame("Frame", "BrokerVolumeMenuFrame");
    A.menuFrame.displayMode = "MENU";
    A.menuFrame.info = {};

    -- Events
    A:RegisterEvent("VARIABLES_LOADED");
    A:RegisterEvent("CVAR_UPDATE");
    A:RegisterEvent("LFG_PROPOSAL_SHOW");
    A:RegisterEvent("LFG_PROPOSAL_FAILED");
    A:RegisterEvent("LFG_PROPOSAL_SUCCEEDED");
    A:RegisterEvent("PLAYER_ENTERING_WORLD");

    -- Hooks
    A:RawHook("Sound_MasterVolumeUp", true);
    A:RawHook("Sound_MasterVolumeDown", true);
    A:RawHook("Sound_ToggleSound", true);
    A:RawHook("Sound_ToggleMusic", true);

    -- Commands
    A:RegisterChatCommand("brokervolume", "SlashCommand");
    A:RegisterChatCommand("bv", "SlashCommand");
end
