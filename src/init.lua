local ns = dofile_once("mods/io__github__arcensoth__nqn/files/namespacing.lua")
local log = dofile_once("mods/io__github__arcensoth__nqn/files/logging.lua")

-- @@ HELPERS

function init_world()
	dofile_once(ns.file("scripts/utils/perks.lua"))

	-- For now just place cursed perks in the mountain entrance.
	spawn_perk_that_keeps_others(595, -100, ns.key("heartbreak"))
	spawn_perk_that_keeps_others(615, -100, ns.key("gold_allergy"))
	
	-- DELETEME
	-- spawn_perk_that_keeps_others(225, -90, ns.key("gold_allergy"))
	-- EntityLoad(ns.base_file("entities/animals/boss_centipede/rewards/gold_reward.xml"), 250, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/goldnugget.xml"), 650, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/goldnugget_10.xml"), 750, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/goldnugget_50.xml"), 670, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/goldnugget_200.xml"), 680, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/goldnugget_1000.xml"), 690, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/goldnugget_10000.xml"), 700, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/bloodmoney_10.xml"), 660, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/bloodmoney_50.xml"), 670, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/bloodmoney_200.xml"), 680, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/bloodmoney_1000.xml"), 690, -120)
	-- EntityLoad(ns.base_file("entities/items/pickup/bloodmoney_10000.xml"), 700, -120)
	-- EntityLoad(ns.base_file("entities/animals/boss_centipede/rewards/gold_reward.xml"), 720, -120)
end

function init_player(player_entity)
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

local IS_DEV = DebugGetIsDevBuild()

if (IS_DEV) then
	log.warning("Running on the dev build")
	ModMagicNumbersFileAdd(ns.file("magic_numbers/dev.xml"))
end

ModLuaFileAppend(
	ns.base_file("scripts/perks/perk_list.lua"),
	ns.file("scripts/appends/perk_list_appends.lua")
)

dofile_once(ns.file("scripts/tweaks/gold_items/init.lua"))
