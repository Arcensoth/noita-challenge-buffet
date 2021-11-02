dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local curse_utils = dofile_once(ns.file("curses/curse_utils.lua"))

function item_pickup(entity_item, entity_who_picked, item_name)
    local pandoras_box = dofile_once(ns.file("curses/pandoras_box/curse.lua"))
    
    curse_utils.on_pickup(pandoras_box, entity_who_picked, entity_item)

    -- Set the global flag to activate the curse.
    GlobalsSetValue(pandoras_box.global_flag, "yes")

    -- Poll for mobs to process.
    pandoras_box.poll_for_entities()
end
