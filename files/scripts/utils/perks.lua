local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
dofile_once(ns.base_file("scripts/perks/perk.lua"))

function grant_perk(entity, perk_id)
	local x, y = EntityGetTransform(entity)
	local perk_item_entity = perk_spawn(x, y - 8, perk_id)
	perk_pickup(perk_item_entity, entity, nil, false, false)
end

function spawn_perk_that_keeps_others(x, y, perk_id)
	local perk_entity_id = perk_spawn(x, y, perk_id)
	EntityAddComponent(
		perk_entity_id,
		"VariableStorageComponent",
		{
			name = "perk_dont_remove_others",
			value_bool = "1",
		}
	)
	return perk_entity_id
end
