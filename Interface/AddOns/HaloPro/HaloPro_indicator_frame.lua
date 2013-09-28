local _, HaloPro = ...

local HP_f, HP_t, HP_Unlocked_Msg
local prev_unlocked_msg_visibility, prev_alpha, prev_visibility, prev_theme, prev_texture

function HaloPro.SetFrames(unlocked_msg, frame, texture)
    HP_Unlocked_Msg, HP_f, HP_t = unlocked_msg, frame, texture
end

local texture_cache = {}

function HaloPro.FrameTextureUpdate(unlocked_msg_visibility, alpha, visibility, theme, texture)
    if unlocked_msg_visibility ~= nil then
        if prev_unlocked_msg_visibility ~= unlocked_msg_visibility then
            if unlocked_msg_visibility then HP_Unlocked_Msg:Show() else HP_Unlocked_Msg:Hide() end
            prev_unlocked_msg_visibility = unlocked_msg_visibility
        end
    end

    if visibility ~= nil then
        if prev_visibility ~= visibility then
            if visibility then HP_f:Show() else HP_f:Hide() end
            prev_visibility = visibility
        end
    end
    -- Don't bother doing anything else with frame or its texture if it is invisible anyway
    if not prev_visibility then return end
	
    if alpha ~= nil then
        if prev_alpha ~= alpha then
            HP_f:SetAlpha(alpha)
            prev_alpha = alpha
        end
    end

    if (theme ~= nil and prev_theme ~= theme) or (texture ~= nil and prev_texture ~= texture) then
        if theme then prev_theme = theme end
        if texture then prev_texture = texture end

        local token = prev_theme .. prev_texture
        local cached_texture = texture_cache[token]
        if cached_texture then
            HP_t:SetTexture(cached_texture)
        else
            local full_path = "Interface\\AddOns\\HaloPro\\HaloPro_Art\\" .. prev_theme .. "\\" .. prev_texture
            HP_t:SetTexture(full_path)
            texture_cache[token] = HP_t:GetTexture()
        end
    end
end