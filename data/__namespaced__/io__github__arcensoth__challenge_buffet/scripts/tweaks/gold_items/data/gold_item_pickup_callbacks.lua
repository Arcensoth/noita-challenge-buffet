local ns = dofile( "mods/io__github__arcensoth__challenge_buffet/files/namespacing.lua" )

-- NOTE Other mods can append to this file to add their own callbacks.
-- Must return a table containing a function with the following signature:
--      on_gold_item_pickup(entity_item, entity_who_picked, item_name)

GOLD_ITEM_PICKUP_CALLBACKS = {
    ns.file("perks/gold_allergy/data.lua")
}
