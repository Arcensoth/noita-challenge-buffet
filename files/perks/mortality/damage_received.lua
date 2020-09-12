local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/logging.lua")
local mortality_perk = dofile_once(ns.file("perks/mortality/data.lua"))

function damage_received(damage, message, entity_thats_responsible, is_fatal)
    local entity = GetUpdatedEntityID()
    log.debug("Received " .. damage .." damage from: " .. message .. " (entity: " .. entity_thats_responsible .. ")")
    mortality_perk.update_hp(entity, damage)
end
