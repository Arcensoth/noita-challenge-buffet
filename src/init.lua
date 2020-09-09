-- @@ IMPORTS

dofile_once( "mods/io__github__arcensoth__nqn/files/namespacing.lua" )

-- @@ HELPERS

function init_world()
	dofile_once( "data/scripts/perks/perk.lua" )
	-- Place the starting perks in the mountain entrance.
	perk_spawn( 634, -100, namespace_local_key( "heartbreak" ) )
end

function init_player( player_entity )
end

-- @@ HOOKS

function OnWorldInitialized()
	-- Make sure pixel scenes are generated into the world only once.
	local key = namespace_local_key( "world_initialized" )
	local is_initialized = GlobalsGetValue( key )
	if( is_initialized == "yes" ) then
		return
	end
	GlobalsSetValue( key, "yes" )
	init_world()
end

function OnPlayerSpawned( player_entity )
	-- Make sure player data is only modified once.
	local key = namespace_local_key( "player_initialized" )
	local is_initialized = GlobalsGetValue( key ) 
	if( is_initialized == "yes" ) then
		return
	end
	GlobalsSetValue( key, "yes" )
	init_player( player_entity )
end

-- @@ MAIN

ModLuaFileAppend(
	namespace_vanilla_file( "scripts/perks/perk_list.lua" ),
	namespace_local_file( "scripts/appends/perk_list_appends.lua" )
)
