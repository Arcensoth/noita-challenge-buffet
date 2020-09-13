local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

-- @@ HELPERS

function init_world()
	-- NOTE This needs to be loaded here to avoid pre-loading the perk list.
	dofile_once(ns.file("scripts/utils/perks.lua"))
	-- For now just place cursed perks in the mountain entrance.
	spawn_perk_that_keeps_others(595, -100, ns.key("heartbreak"))
	spawn_perk_that_keeps_others(615, -100, ns.key("mortality"))
	spawn_perk_that_keeps_others(635, -100, ns.key("bane_of_midas"))
	-- Do some things if we're running the dev build.
	if (DebugGetIsDevBuild()) then
		dofile_once(ns.file("scripts/utils/dev.lua"))
		dev_init_world()
	end
end

function init_player(player_entity)
	-- Do some things if we're running the dev build.
	if (DebugGetIsDevBuild()) then
		dofile_once(ns.file("scripts/utils/dev.lua"))
		dev_init_player(player_entity)
	end
end

-- @@ HOOKS

function OnWorldInitialized()
	-- Make sure pixel scenes are generated into the world only once.
	local key = ns.key("world_initialized")
	local is_initialized = GlobalsGetValue(key)
	if (is_initialized == "yes") then
		return
	end
	GlobalsSetValue(key, "yes")
	init_world()
end

function OnPlayerSpawned(player_entity)
	-- Make sure player data is only modified once.
	local key = ns.key("player_initialized")
	local is_initialized = GlobalsGetValue(key)
	if (is_initialized == "yes") then
		return
	end
	GlobalsSetValue(key, "yes")
	init_player(player_entity)
end

-- @@ MAIN

if (DebugGetIsDevBuild()) then
	log.warning("Running on the dev build")
	ModMagicNumbersFileAdd(ns.file("magic_numbers/dev.xml"))
end

ModLuaFileAppend(
	ns.base_file("scripts/perks/perk_list.lua"),
	ns.file("scripts/appends/perk_list_appends.lua")
)

dofile_once(ns.file("scripts/tweaks/gold_items/init.lua"))
