# Not Quite Nightmare

Additional features and challenges inspired by nightmare mode.

> **This mod is largely a work-in-progress.** Currently all challenges come in the form of "cursed" perks that can be optionally picked-up in the mountain entrance. This may change in the future, as new curses and other challenges are implemented.

## Features

### Cursed perks

- Heartbreak: maximum health can no longer be increased
- Midas Curse: gold is now deadly and must be avoided

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

### Accounting for all cases of touching gold

In order to get Midas Curse to work, we must account for all cases of the player touching gold:

1. Picking up gold nuggets
2. Picking up bloody gold nuggets
3. Walking through gold dust
