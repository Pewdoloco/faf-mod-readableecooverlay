-- Appended to /lua/ui/game/econoverlayparams.lua when that file is loaded
-- through the game's import system. Applies the same overrides as
-- modules/main.lua directly to the freshly defined table.
do
    local ok, err = pcall(function()
        local location = '/mods/readableecooverlay'
        for _, mod in __active_mods or {} do
            if mod.name == 'ReadableEcoOverlay' and mod.author == 'BagFromWalmart' and mod.location then
                location = mod.location
            end
        end
        import(location .. '/modules/main.lua').ApplyTo(EconOverlayParams)
    end)
    if not ok then
        WARN('ReadableEcoOverlay: params hook failed - ' .. tostring(err))
    end
end
