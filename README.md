# Challenge Buffet

Pick your poison. Choose a set of unique challenges.

> **This mod is largely a work-in-progress.** Currently all challenges come in the form of "cursed" perks that can be optionally picked-up in the mountain entrance. This may change in the future, as new curses and other challenges are implemented.

## Features

### Cursed perks

- Heartbreak: maximum health cannot be increased
- Bane of Midas: gold is deadly and must be avoided
- Mortality: take damage to maximum health

## Developer notes

### Capping all cases of maximum HP increase

In order to get Heartbreak to work, all cases of maximum HP increase must be accounted for.

The following perks interact the player's maximum HP in some way:

- `EXTRA_HP` does not exceed the player's maximum HP cap.
- `GLASS_CANNON` sets the player's maximum HP and maximum HP cap to a pre-determined value.
- `HEARTS_MORE_EXTRA_HP` increases the player's maximum HP modifier.

The following items increase the player's maximum HP, but not beyond their maximum HP cap:

- `data/scripts/items/heart.lua`
- `data/scripts/items/heart_better.lua`
- `data/scripts/items/heart_evil.lua`

The following items increase the player's maximum HP _as well as_ their maximum HP cap:

- `data/scripts/items/heart_fullhp_temple.lua`

All in all, only `heart_fullhp_temple` needs to be adjusted to keep the player's maximum HP frozen at a particular value.

To accomplish this, we introduce a new tag `temple_hearts_obey_max_hp_cap` whose presence negates the maximum HP increase of temple hearts.

### Detecting when the player interacts with gold

In order to get Bane of Midas to work, we must account for two distinct cases of the player interacting with gold:

1. Picking up gold items
2. Walking through gold dust

#### Detecting when the player picks up gold items

Detecting when the player picks up gold items is a relatively straightforward process, however we do need to tweak the base vanilla file of every gold items we want to detect via `ModTextFileGetContent`/`ModTextFileSetContent`.

Specifically, to every gold item we add a `LuaComponent` with a `script_item_picked_up` that points to our own script. Within this script we basically just check if the player has the perk and should die.

#### Detecting when the player walks through gold dust

Detecting when the player walks through gold dust is much less straightforward, because there is no direct entry-point provided by the engine. In short: we can overwrite the base player definition to handle gold dust differently and add a damage handler that detects damage from a custom list of materials.

The player entity is defined in `data/entities/player.xml`, which inherits from `data/entities/player_base.xml`. The player base defines a `MaterialSuckerComponent` with `suck_gold="1"` which "if set will just suck gold and update wallet." We can make gold dust solid to the player by setting that to `0` instead.

Next we need to detect when the player comes into contact with gold dust. Due to limitations with the engine, this winds up being considerably more complex than might be expected.

We start by adding to the player an additional `DamageModelComponent` with `materials_damage=1` and `materials_that_damage` set to a list of materials. This causes the materials to damage the player. Since we don't want the materials themselves to be responsible for the player's death, we also set all `materials_how_much_damage` to a very low value.

Now that we have a `DamageModelComponent` we can create a event hook via a `LuaComponent` with `script_damage_received`. Unforunately the engine does not pass any information to the handler function that allows us to uniquely identify the source material that is responsible for damaging the player. Here is the function signature given by the component documentation:

```lua
damage_received(float damage, string message, int entity_thats_responsible, bool is_fatal)
```

The `message` parameter is a localized string, likely intended to be used with the UI, which means there's no way to accurately convert it back into a material ID. Note that `entity_thats_responsible` is always set to `0` because it's not an entity that's responsible for the damage; it's a material.

There is an accurate but somewhat unwieldy work-around: every time damage is received, scan over all of the `DamageModelComponent`s to check which ones recently fired via the `mLastMaterialDamageFrame` property. Then we check the `materials_that_damage` property to see if it matches the list of materials we provided earlier and, if so, proceed to kill the player.
