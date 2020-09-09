# Not Quite Nightmare

Additional features and challenges inspired by nightmare mode.

## Notes

### Relevant vanilla mechanics

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

To accomplish this, we introduce a new `VariableStorageComponent` named `temple_hearts_obey_max_hp_cap` containing a `value_int` that states whether temple hearts should obey the player's current maximum HP cap.
