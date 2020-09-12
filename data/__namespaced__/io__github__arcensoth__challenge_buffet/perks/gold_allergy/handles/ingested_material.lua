local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/namespacing.lua")
local log = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/logging.lua")
local gold_allergy_perk = dofile_once(ns.file("perks/gold_allergy/data.lua"))

function ingested_material(material_name, count)
    local entity = GetUpdatedEntityID()
    log.debug("Ingested material: " .. material_name .. " x" .. count)
end
