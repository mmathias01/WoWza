local Skada = Skada
local SkadaFormatValueText = Skada.FormatValueText

local function FormatValues(value, enabled, ...)
    if value == nil then
        return
    elseif ( type(value) == "number" or ( type(value) == "string" and value:match("^[-+]?[%d.,]+$") )) and tonumber(value) > 1000 then
        value = Skada:FormatNumber(tonumber(value))
    end
    return value, enabled, FormatValues(...)
end

function Skada:FormatValueText(...)
    return SkadaFormatValueText(self, FormatValues(...))
end

