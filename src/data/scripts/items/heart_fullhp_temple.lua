-- NOTE We overwrite this file to allow disabling of the maximum HP cap increase.

dofile( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
	local max_hp = 0
	local max_hp_addition = 0.4
	local healing = 0

	-- NOTE START CHANGES
	local obey_max_hp_cap = 0

	local vs_components = EntityGetComponent( entity_who_picked, "VariableStorageComponent" )

	if( vs_components ~= nil ) then
		for key,comp_id in pairs(vs_components) do 
			local var_name = ComponentGetValue( comp_id, "name" )
			if( var_name == "temple_hearts_obey_max_hp_cap") then
				local comp_value = ComponentGetValueInt( comp_id, "value_int" )
				if( comp_value ~= nil ) then
					obey_max_hp_cap = comp_value
				end
			end
		end
	end
	
	if (obey_max_hp_cap >= 1) then
		max_hp_addition = 0
	end
	-- NOTE END CHANGES
	
	local x, y = EntityGetTransform( entity_item )

	local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
		for i,damagemodel in ipairs(damagemodels) do
			max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
			local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
			local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
			
			max_hp = max_hp + max_hp_addition
			
			if ( max_hp_cap > 0 ) then
				max_hp_cap = math.max( max_hp, max_hp_cap )
			end
			
			healing = max_hp - hp
			
			-- if( hp > max_hp ) then hp = max_hp end
			ComponentSetValue( damagemodel, "max_hp_cap", max_hp_cap)
			ComponentSetValue( damagemodel, "max_hp", max_hp)
			ComponentSetValue( damagemodel, "hp", max_hp)
		end
	end

	EntityLoad("data/entities/particles/image_emitters/heart_fullhp_effect.xml", x, y-12)
	EntityLoad("data/entities/particles/heart_out.xml", x, y-8)
	GamePrintImportant( "$log_heart_fullhp_temple", GameTextGet( "$logdesc_heart_fullhp_temple", tostring(math.floor(max_hp_addition * 25)), tostring(math.floor(max_hp * 25)), tostring(math.floor(healing * 25)) ) )
	--GameTriggerMusicEvent( "music/temple/enter", true, x, y )

	-- remove the item from the game
	EntityKill( entity_item )
end
