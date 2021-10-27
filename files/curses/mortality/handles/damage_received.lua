dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

local curses = dofile_once(ns.file("curses/curses.lua"))
local curse = curses.mortality

function damage_received(damage, message, entity_thats_responsible, is_fatal)
    local entity = GetUpdatedEntityID()
    log.debug("Received " .. damage .." damage from: " .. message .. " (entity: " .. entity_thats_responsible .. ")")
    curse.update_hp(entity, damage)
end
