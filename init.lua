local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local curse_utils = dofile_once(ns.file("curses/curse_utils.lua"))

dofile_once(ns.file("scripts/utils/translations.lua"))
append_translations(ns.file("translations.csv"))

-- @@ HELPERS

function init_world()
    -- For now just place curses in the mountain entrance.
    curse_utils.create_pickup(dofile_once(ns.file("curses/bane_of_midas/curse.lua")), 595 + 00, -100)
    curse_utils.create_pickup(dofile_once(ns.file("curses/heartbreak/curse.lua")),    595 + 20, -100)
    curse_utils.create_pickup(dofile_once(ns.file("curses/mortality/curse.lua")),     595 + 40, -100)
    -- curse_utils.create_pickup(dofile_once(ns.file("curses/pandoras_box/curse.lua")),  595 + 60, -100)

    -- Do some things if we're running the dev build.
    if (DebugGetIsDevBuild()) then
        dofile_once(ns.file("dev/init.lua"))
        dev_init_world()
    end
end

function init_player(player_entity)
    -- Do some things if we're running the dev build.
    if (DebugGetIsDevBuild()) then
        dofile_once(ns.file("dev/init.lua"))
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

dofile_once(ns.file("curses/pandoras_box/tweaks/init.lua"))
