local ns = dofile_once( "mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua" )
local log = dofile_once( "mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/logging.lua" )
dofile_once(ns.file("scripts/tweaks/gold_items/data/gold_item_pickup_callbacks.lua"))

function item_pickup(entity_item, entity_who_picked, item_name)
    log.debug("Player picked up gold")
    for i, callback_file in pairs(GOLD_ITEM_PICKUP_CALLBACKS) do
        log.debug("Running callback: " .. callback_file)
        local callback = dofile_once(callback_file)
        callback.on_gold_item_pickup(entity_item, entity_who_picked, item_name)
    end
end
