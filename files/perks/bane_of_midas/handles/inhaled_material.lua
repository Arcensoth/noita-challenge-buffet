-- NOTE #unused

local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

function inhaled_material(material_name, count)
    local entity = GetUpdatedEntityID()
    log.debug("Inhaled material: " .. material_name .. " x" .. count)
end
