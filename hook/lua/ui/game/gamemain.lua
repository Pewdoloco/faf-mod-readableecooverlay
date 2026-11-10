-- Non-destructive hook: wraps the vanilla CreateUI instead of replacing the file.
-- All real logic lives in modules/main.lua.
local ReadableEcoOriginalCreateUI = CreateUI

local function ReadableEcoFindLocation()
    for _, mod in __active_mods or {} do
        if mod.name == 'ReadableEcoOverlay' and mod.author == 'BagFromWalmart' and mod.location then
            return mod.location
        end
    end
    return '/mods/readableecooverlay'
end

CreateUI = function(isReplay)
    ReadableEcoOriginalCreateUI(isReplay)

    local ok, err = pcall(function()
        import(ReadableEcoFindLocation() .. '/modules/main.lua').Init()
    end)
    if not ok then
        WARN('ReadableEcoOverlay: failed to initialize - ' .. tostring(err))
    end
end
