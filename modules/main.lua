-- ReadableEcoOverlay: makes the economy overlay (Ctrl+R - mass/energy
-- income and drain shown over every unit) easier to read:
--   * darker background: the overlay's three background textures are
--     replaced with copies whose inside is ~85% opaque instead of ~53%;
--     the light frame and the mass/energy icons are unchanged
--   * a real font: the game asks for "Ariel" (a typo - no such font, so the
--     engine falls back to something else); this uses "Arial Bold", one
--     size bigger
--   * text colors are NOT changed: the game's own green (positive) /
--     red (negative) logic stays as it is
--
-- The overlay is drawn by the engine, which reads its look from the
-- EconOverlayParams table in /lua/ui/game/econoverlayparams.lua. That file
-- is loaded through the game's import system, so the hook in
-- hook/lua/ui/game/econoverlayparams.lua applies the overrides right after
-- the table is defined. Init() applies them once more to the loaded module
-- as a safety net (confirmed in testing: the module copy is the one used).

local FONT_NAME = 'Arial Bold'
local FONT_SIZE = 10

local location = nil

-- Same approach as BuildTimers: find our own folder instead of assuming a
-- folder name, so the textures load whatever the folder is called.
local function FindLocation()
    if location then return location end
    for _, mod in __active_mods or {} do
        if mod.name == 'ReadableEcoOverlay' and mod.author == 'BagFromWalmart' and mod.location then
            location = mod.location
            return location
        end
    end
    location = '/mods/readableecooverlay'
    return location
end

function GetOverrides()
    local loc = FindLocation()
    return {
        leftTexture = loc .. '/textures/econ_bmp_l.dds',
        midTexture = loc .. '/textures/econ_bmp_m.dds',
        rightTexture = loc .. '/textures/econ_bmp_r.dds',
        fontName = FONT_NAME,
        fontSize = FONT_SIZE,
    }
end

function ApplyTo(params)
    if type(params) ~= 'table' then return false end
    for key, value in GetOverrides() do
        params[key] = value
    end
    return true
end

local initialized = false

function Init()
    if initialized then return end
    initialized = true

    local ok, module = pcall(import, '/lua/ui/game/econoverlayparams.lua')
    if ok and module then
        ApplyTo(module.EconOverlayParams)
    end
end
