local _, AskMrRobot = ...

function AskMrRobot.spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function AskMrRobot.sortSlots(t)
    return AskMrRobot.spairs(t, function(x, a, b)
        if a == nil and b == nil then return 0 end
        return AskMrRobot.sortedSlots[a] < AskMrRobot.sortedSlots[b]
    end)
end
