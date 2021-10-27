dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

local curses = dofile_once(ns.file("curses/curses.lua"))
local curse = curses.mortality

dofile_once(ns.file("curses/utils.lua"))

function item_pickup(entity_item, entity_who_picked, item_name)
	curse_pickup_common(entity_item, entity_who_picked, curse)

	-- Update the player's HP immediately.
	curse.update_hp(entity_who_picked, 0)

	-- Run a script to update the player's HP whenever they take damage.
    EntityAddComponent(entity_who_picked, "LuaComponent", {
		script_damage_received=curse.damage_received_script,
	})
end
