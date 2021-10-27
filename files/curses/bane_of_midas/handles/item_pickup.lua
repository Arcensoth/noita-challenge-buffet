dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local tags = dofile_once(ns.file("scripts/const/tags.lua"))

local curses = dofile_once(ns.file("curses/curses.lua"))
local curse = curses.bane_of_midas

dofile_once(ns.file("curses/utils.lua"))

function item_pickup(entity_item, entity_who_picked, item_name)
	curse_pickup_common(entity_item, entity_who_picked, curse)

	-- Add a tag that we can detect during gold pick-ups.
    EntityAddTag(entity_who_picked, tags.bane_of_midas)

    -- Make gold dust solid for the player.
    local suckers = EntityGetComponent(entity_who_picked, "MaterialSuckerComponent")
	if (suckers ~= nil) then
		for i, sucker in ipairs(suckers) do
			ComponentSetValue(sucker, "suck_gold", 0)
		end
    end

    -- Cause the player to take (negligible) damage from gold materials.
    EntityAddComponent(entity_who_picked, "DamageModelComponent", {
		air_needed=0,
		falling_damages=0,
		fire_damage_amount=0,
		materials_damage=1,
		material_damage_min_cell_count=4,
		materials_that_damage=curse.gold_materials_that_damage,
		materials_how_much_damage=curse.gold_materials_how_much_damage,
	})
    EntityAddComponent(entity_who_picked, "DamageModelComponent", {
		air_needed=0,
		falling_damages=0,
		fire_damage_amount=0,
		materials_damage=1,
		material_damage_min_cell_count=1,
		materials_that_damage=curse.midas_materials_that_damage,
		materials_how_much_damage=curse.midas_materials_how_much_damage,
	})

    -- Detect when the player takes damage (from gold materials).
    EntityAddComponent(entity_who_picked, "LuaComponent", {
		script_damage_received=curse.damage_received_script,
    })
end