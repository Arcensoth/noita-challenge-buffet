local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local bane_of_midas = dofile_once(ns.file("curses/bane_of_midas/curse.lua"))

function item_pickup(entity_item, entity_who_picked, item_name)
    bane_of_midas.on_pickup(entity_who_picked, entity_item)
end
