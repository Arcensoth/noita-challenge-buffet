function heartbreak_perk_init(entity_perk_item, entity_who_picked, item_name)
	-- Permanently cap the player's max HP at their current max HP.
	local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
	if (damagemodels ~= nil) then
		for i, damagemodel in ipairs(damagemodels) do
			local current_hp = tonumber(ComponentGetValue(damagemodel, "hp"))
			local current_max_hp = tonumber(ComponentGetValue(damagemodel, "max_hp"))
			ComponentSetValue(damagemodel, "max_hp", current_max_hp)
			ComponentSetValue(damagemodel, "max_hp_cap", current_max_hp)
			ComponentSetValue(damagemodel, "hp", math.min(current_hp, current_max_hp))
		end
	end
	-- Stop temple hearts from overriding the cap and increasing maximum HP.
	EntityAddComponent(
		entity_who_picked,
		"VariableStorageComponent",
		{ 
			name = "temple_hearts_obey_max_hp_cap",
			value_int = 1,
		}
	)
end
