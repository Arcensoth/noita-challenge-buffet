dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

local entity_id = GetUpdatedEntityID()

local pandoras_box = dofile_once(ns.file("curses/pandoras_box/curse.lua"))

local is_pandoras_box_active = GlobalsGetValue(pandoras_box.global_flag)
if (is_pandoras_box_active == "yes") then
    pandoras_box.process_entity(entity_id)
end
