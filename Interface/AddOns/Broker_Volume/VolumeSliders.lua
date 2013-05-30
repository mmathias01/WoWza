-- ********************************************************************************
-- Data Broker Volume Control (Broker_Volume)
-- A volume control for Data Broker.
-- By: Shenton
--
-- VolumeSliders.lua
-- ********************************************************************************

local A = _G["BrokerVolumeGlobal"];
local L = A.L;

local format = format;

local CreateFrame = CreateFrame;
local UIParent = UIParent;
local TOOLTIP_DEFAULT_COLOR = TOOLTIP_DEFAULT_COLOR;
local TOOLTIP_DEFAULT_BACKGROUND_COLOR = TOOLTIP_DEFAULT_BACKGROUND_COLOR;
local GameFontNormalSmallLeft = GameFontNormalSmallLeft;
local GameFontHighlightSmallLeft = GameFontHighlightSmallLeft;
local ADD = ADD;
local SetCVar = SetCVar;

function A:CreateSlidersFrame()
    local f = CreateFrame("Frame", "BrokerVolumeSlidersFrame", UIParent);
    f:SetFrameStrata("DIALOG");
    f:SetSize(200, 255);
    f:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }});
    f:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
    f:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
    f:Hide();

    -- Mouse OnEnter/OnLeave
    f:SetScript("OnEnter", function()
        if ( A.slidersFrame.closeTimer ) then
            A:CancelTimer(A.slidersFrame.closeTimer, 1);
            A.slidersFrame.closeTimer = nil;
        end
    end);
    f:SetScript("OnLeave", function()
        A.slidersFrame.closeTimer = A:ScheduleTimer("CloseSlidersFrame", 2);
    end);

    -- Title
    f.title = f:CreateFontString();
    f.title:SetFontObject(GameFontNormalSmallLeft);
    f.title:SetText(L["Broker Volume"]);
    f.title:SetPoint("TOPLEFT", f, 10, -10);

    -- Version
    f.version = f:CreateFontString();
    f.version:SetFontObject(GameFontNormalSmallLeft);
    f.version:SetText(A.color["GREEN"].."v"..A.version);
    f.version:SetPoint("TOPRIGHT", f, -10, -10);

    --
    -- Master
    --

    -- Master Volume Text
    f.masterText = f:CreateFontString();
    f.masterText:SetFontObject(GameFontHighlightSmallLeft);
    f.masterText:SetText(L["Master volume"]);
    f.masterText:SetPoint("TOPLEFT", f, 10, -30);

    -- Master Volume Text Value
    f.masterValue = f:CreateFontString();
    f.masterValue:SetFontObject(GameFontHighlightSmallLeft);
    f.masterValue:SetPoint("TOPRIGHT", f, -10, -30);

    -- Master Volume Slider
    f.masterSlider = CreateFrame("Slider", "BrokerVolumeMasterSlider", f, "OptionsSliderTemplate");
    f.masterSlider:SetWidth(180);
    f.masterSlider:SetHeight(20);
    f.masterSlider:SetOrientation("HORIZONTAL");
    BrokerVolumeMasterSliderLow:SetText("0");
    BrokerVolumeMasterSliderHigh:SetText("100");
    f.masterSlider:SetMinMaxValues(0, 100);
    f.masterSlider.tooltipText = L["|cffffffff%s|r\nUse mouse wheel to change value."]:format(L["Master volume"]);
    f.masterSlider:SetValue(A:GetVolumePercent("Sound_MasterVolume"));
    f.masterSlider:SetValueStep(10);
    f.masterSlider:SetPoint("TOPLEFT", f, 10, -40);
    f.masterSlider:EnableMouseWheel(1);
    f.masterSlider:SetScript("OnShow", function(self, value)
        local volume = A:GetVolumePercent("Sound_MasterVolume");

        f.masterSlider:SetValue(volume);
        f.masterValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.masterSlider:SetScript("OnValueChanged", function(self, value)
        SetCVar("Sound_MasterVolume", A:SetVolumeNum(value), "Doh!");

        local volume = A:GetVolumePercent("Sound_MasterVolume");

        f.masterValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.masterSlider:SetScript("OnMouseWheel", function(self, delta)
        if ( delta > 0 ) then
            A:Sound_MasterVolumeUp();
        else
            A:Sound_MasterVolumeDown();
        end

        f.masterSlider:SetValue(A:GetVolumePercent("Sound_MasterVolume"));
    end);
    f.masterSlider:HookScript("OnEnter", function()
        if ( A.slidersFrame.closeTimer ) then
            A:CancelTimer(A.slidersFrame.closeTimer, 1);
            A.slidersFrame.closeTimer = nil;
        end
    end);
    f.masterSlider:Show();

    --
    -- Effects
    --

    -- Effects Volume Text
    f.effectsText = f:CreateFontString();
    f.effectsText:SetFontObject(GameFontHighlightSmallLeft);
    f.effectsText:SetText(L["Effects volume"]);
    f.effectsText:SetPoint("TOPLEFT", f, 10, -80);

    -- Effects Volume Text Value
    f.effectsValue = f:CreateFontString();
    f.effectsValue:SetFontObject(GameFontHighlightSmallLeft);
    f.effectsValue:SetPoint("TOPRIGHT", f, -10, -80);

    -- Effects Volume Slider
    f.effectsSlider = CreateFrame("Slider", "BrokerVolumeEffectsSlider", f, "OptionsSliderTemplate");
    f.effectsSlider:SetWidth(180);
    f.effectsSlider:SetHeight(20);
    f.effectsSlider:SetOrientation("HORIZONTAL");
    BrokerVolumeEffectsSliderLow:SetText("0");
    BrokerVolumeEffectsSliderHigh:SetText("100");
    f.effectsSlider:SetMinMaxValues(0, 100);
    f.effectsSlider.tooltipText = L["|cffffffff%s|r\nUse mouse wheel to change value."]:format(L["Effects volume"]);
    f.effectsSlider:SetValue(A:GetVolumePercent("Sound_SFXVolume"));
    f.effectsSlider:SetValueStep(10);
    f.effectsSlider:SetPoint("TOPLEFT", f, 10, -90);
    f.effectsSlider:EnableMouseWheel(1);
    f.effectsSlider:SetScript("OnShow", function(self, value)
        local volume = A:GetVolumePercent("Sound_SFXVolume");

        f.effectsSlider:SetValue(volume);
        f.effectsValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.effectsSlider:SetScript("OnValueChanged", function(self, value)
        SetCVar("Sound_SFXVolume", A:SetVolumeNum(value), "Doh!");

        local volume = A:GetVolumePercent("Sound_SFXVolume");

        f.effectsValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.effectsSlider:SetScript("OnMouseWheel", function(self, delta)
        if ( delta > 0 ) then
            A:EffectsVolumeUp();
        else
            A:EffectsVolumeDown();
        end

        f.effectsSlider:SetValue(A:GetVolumePercent("Sound_SFXVolume"));
    end);
    f.effectsSlider:HookScript("OnEnter", function()
        if ( A.slidersFrame.closeTimer ) then
            A:CancelTimer(A.slidersFrame.closeTimer, 1);
            A.slidersFrame.closeTimer = nil;
        end
    end);
    f.effectsSlider:Show();

    --
    -- Music
    --

    -- Music Volume Text
    f.musicText = f:CreateFontString();
    f.musicText:SetFontObject(GameFontHighlightSmallLeft);
    f.musicText:SetText(L["Music volume"]);
    f.musicText:SetPoint("TOPLEFT", f, 10, -130);

    -- Music Volume Text Value
    f.musicValue = f:CreateFontString();
    f.musicValue:SetFontObject(GameFontHighlightSmallLeft);
    f.musicValue:SetPoint("TOPRIGHT", f, -10, -130);

    -- Music Volume Slider
    f.musicSlider = CreateFrame("Slider", "BrokerVolumeMusicSlider", f, "OptionsSliderTemplate");
    f.musicSlider:SetWidth(180);
    f.musicSlider:SetHeight(20);
    f.musicSlider:SetOrientation("HORIZONTAL");
    BrokerVolumeMusicSliderLow:SetText("0");
    BrokerVolumeMusicSliderHigh:SetText("100");
    f.musicSlider:SetMinMaxValues(0, 100);
    f.musicSlider.tooltipText = L["|cffffffff%s|r\nUse mouse wheel to change value."]:format(L["Music volume"]);
    f.musicSlider:SetValue(A:GetVolumePercent("Sound_MusicVolume"));
    f.musicSlider:SetValueStep(10);
    f.musicSlider:SetPoint("TOPLEFT", f, 10, -140);
    f.musicSlider:EnableMouseWheel(1);
    f.musicSlider:SetScript("OnShow", function(self, value)
        local volume = A:GetVolumePercent("Sound_MusicVolume");

        f.musicSlider:SetValue(volume);
        f.musicValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.musicSlider:SetScript("OnValueChanged", function(self, value)
        SetCVar("Sound_MusicVolume", A:SetVolumeNum(value), "Doh!");

        local volume = A:GetVolumePercent("Sound_MusicVolume");

        f.musicValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.musicSlider:SetScript("OnMouseWheel", function(self, delta)
        if ( delta > 0 ) then
            A:MusicVolumeUp();
        else
            A:MusicVolumeDown();
        end

        f.musicSlider:SetValue(A:GetVolumePercent("Sound_MusicVolume"));
    end);
    f.musicSlider:HookScript("OnEnter", function()
        if ( A.slidersFrame.closeTimer ) then
            A:CancelTimer(A.slidersFrame.closeTimer, 1);
            A.slidersFrame.closeTimer = nil;
        end
    end);
    f.musicSlider:Show();

    --
    -- Ambience
    --

    -- Ambience Volume Text
    f.ambienceText = f:CreateFontString();
    f.ambienceText:SetFontObject(GameFontHighlightSmallLeft);
    f.ambienceText:SetText(L["Ambience volume"]);
    f.ambienceText:SetPoint("TOPLEFT", f, 10, -180);

    -- Ambience Volume Text Value
    f.ambienceValue = f:CreateFontString();
    f.ambienceValue:SetFontObject(GameFontHighlightSmallLeft);
    f.ambienceValue:SetPoint("TOPRIGHT", f, -10, -180);

    -- Music Volume Slider
    f.ambienceSlider = CreateFrame("Slider", "BrokerVolumeAmbienceSlider", f, "OptionsSliderTemplate");
    f.ambienceSlider:SetWidth(180);
    f.ambienceSlider:SetHeight(20);
    f.ambienceSlider:SetOrientation("HORIZONTAL");
    BrokerVolumeAmbienceSliderLow:SetText("0");
    BrokerVolumeAmbienceSliderHigh:SetText("100");
    f.ambienceSlider:SetMinMaxValues(0, 100);
    f.ambienceSlider.tooltipText = L["|cffffffff%s|r\nUse mouse wheel to change value."]:format(L["Ambience volume"]);
    f.ambienceSlider:SetValue(A:GetVolumePercent("Sound_AmbienceVolume"));
    f.ambienceSlider:SetValueStep(10);
    f.ambienceSlider:SetPoint("TOPLEFT", f, 10, -190);
    f.ambienceSlider:EnableMouseWheel(1);
    f.ambienceSlider:SetScript("OnShow", function(self, value)
        local volume = A:GetVolumePercent("Sound_AmbienceVolume");

        f.ambienceSlider:SetValue(volume);
        f.ambienceValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.ambienceSlider:SetScript("OnValueChanged", function(self, value)
        SetCVar("Sound_AmbienceVolume", A:SetVolumeNum(value), "Doh!");

        local volume = A:GetVolumePercent("Sound_AmbienceVolume");

        f.ambienceValue:SetText(A:ColorGradient(volume)..volume.."|r%");
    end);
    f.ambienceSlider:SetScript("OnMouseWheel", function(self, delta)
        if ( delta > 0 ) then
            A:AmbienceVolumeUp();
        else
            A:AmbienceVolumeDown();
        end

        f.ambienceSlider:SetValue(A:GetVolumePercent("Sound_AmbienceVolume"));
    end);
    f.ambienceSlider:HookScript("OnEnter", function()
        if ( A.slidersFrame.closeTimer ) then
            A:CancelTimer(A.slidersFrame.closeTimer, 1);
            A.slidersFrame.closeTimer = nil;
        end
    end);
    f.ambienceSlider:Show();

    -- Close
    f.close = CreateFrame("Button", "", f);
    f.close:SetSize(180, 16);
    f.close:SetNormalFontObject(GameFontHighlightSmallLeft);
    f.close:SetText(L["Close"]);
    f.close:SetPoint("TOPLEFT", f, 10, -230);
    f.close:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", ADD);
    f.close:SetScript("OnClick", function() f:Hide(); end);
    f.close:SetScript("OnEnter", function()
        if ( A.slidersFrame.closeTimer ) then
            A:CancelTimer(A.slidersFrame.closeTimer, 1);
            A.slidersFrame.closeTimer = nil;
        end
    end);
    f.close:Show();

    A.slidersFrame = f;
end

function A:CloseSlidersFrame()
    A.slidersFrame:Hide();
    A.slidersFrame.closeTimer = nil;
end
