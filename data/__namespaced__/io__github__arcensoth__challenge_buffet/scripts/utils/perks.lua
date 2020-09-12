local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/namespacing.lua")
dofile_once(ns.base_file("scripts/perks/perk.lua"))

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
