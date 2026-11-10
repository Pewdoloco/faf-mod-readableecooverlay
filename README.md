# ReadableEcoOverlay

> **AI disclosure:** this mod was written with substantial AI assistance
> (Claude, Anthropic) - design and implementation, working from the mod
> author's requirements and in-game testing. Disclosed per the
> [FAF Vault meta requirements](https://wiki.faforever.com/en/Development/Vault/Rules).

A UI-only mod for [Forged Alliance Forever](https://faforever.com) (Supreme
Commander: Forged Alliance) that makes the economy overlay - **Ctrl+R**,
the mass/energy income and drain shown over every unit - easier to read.

| | Game default | With this mod |
|---|---|---|
| Background behind the numbers | ~53% opaque | ~85% opaque (dark) |
| Font | "Ariel", size 9 - a typo in the game, no such font exists, so the engine falls back to another one | Arial Bold, size 10 |
| Text colors | green for income, red for drain | unchanged |
| Frame and mass/energy icons | - | unchanged |

## Install

Easiest: find **ReadableEcoOverlay** in the FAF client's mod vault and
install it.

Manual: drop the `ReadableEcoOverlay` folder into the folder below. The
mod works under any folder name, but the client only finds the preview
icon if the folder keeps this name.

```
Documents\My Games\Gas Powered Games\Supreme Commander Forged Alliance\mods\
```

Then enable it from the FAF client's mod manager.

## Safe for ranked

This is a `ui_only` mod - it never touches simulation Lua, so it doesn't
unrank games.

## How it works

The engine draws the overlay and reads its look from the
`EconOverlayParams` table in `/lua/ui/game/econoverlayparams.lua`. The hook
`hook/lua/ui/game/econoverlayparams.lua` replaces the three background
textures with darker copies from `textures/` and sets the font. The darker
textures were made from the game's own ones: only the inside of the frame
was put over a dark layer, the light frame and the icons are untouched.

The same textures are used for every faction's UI skin.

## License

MIT - see [LICENSE](LICENSE).
