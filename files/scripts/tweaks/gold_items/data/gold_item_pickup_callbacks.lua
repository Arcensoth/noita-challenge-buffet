local ns = dofile("mods/challenge_buffet/files/scripts/utils/namespacing.lua")

-- NOTE Other mods can append to this file to add their own callbacks.
-- Must return a table containing a function with the following signature:
--      on_gold_item_pickup(entity_item, entity_who_picked, item_name)

GOLD_ITEM_PICKUP_CALLBACKS = {
    ns.file("curses/bane_of_midas/curse.lua")
}
