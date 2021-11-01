dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

function item_pickup(entity_item, entity_who_picked, item_name)
    local pandoras_box = dofile_once(ns.file("curses/pandoras_box/curse.lua"))
    
    dofile_once(ns.file("curses/utils.lua"))
    curse_pickup_common(entity_item, entity_who_picked, pandoras_box)

    -- Set the global flag to activate the curse.
    GlobalsSetValue(pandoras_box.global_flag, "yes")

    -- Poll for mobs to process.
    pandoras_box.poll_for_entities()
end
