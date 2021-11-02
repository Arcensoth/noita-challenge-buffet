dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local utils = dofile_once(ns.file("scripts/utils.lua"))
local curse_utils = dofile_once(ns.file("curses/curse_utils.lua"))

local curse = {}

-- @@ PROPERTIES

curse.code = "bane_of_midas"
curse.name = "$challenge_buffet__curse__" .. curse.code .. "__name"
curse.description = "$challenge_buffet__curse__" .. curse.code .. "__desc"
curse.item_sprite = ns.file("curses/" .. curse.code .. "/item.png")
curse.icon_sprite = ns.file("curses/" .. curse.code .. "/icon.png")
curse.item_pickup_script = ns.file("curses/" .. curse.code .. "/handles/item_pickup.lua")

curse.check_gold_script = ns.file("curses/" .. curse.code .. "/handles/check_gold.lua")

-- @@ METHODS

curse.on_pickup = function(picker_entity_id, item_entity_id)
    curse_utils.on_pickup(curse, picker_entity_id, item_entity_id)

    -- Add a script to poll their wallet.
    EntityAddComponent(picker_entity_id, "LuaComponent", {
        script_source_file=curse.check_gold_script,
        execute_every_n_frame=15,
    })
end

curse.check_gold = function(entity_id)
    -- Check if they have any gold in their wallet.
    local wallet_components = EntityGetComponent(entity_id, "WalletComponent")
    if wallet_components ~= nil then
        for i, wallet_component in ipairs(wallet_components) do
            local money = tonumber(ComponentGetValue(wallet_component, "money"))
            if money > 0 then
                curse.do_gold_death(entity_id)
            end
        end
    end
end

curse.do_gold_death = function(entity_id)
    -- Get the player's coordinates.
    local x, y = EntityGetTransform(entity_id)
    log.debug("Spawning gold death at: " .. x .. ", " .. y)

    -- Make sure they aren't invincible.
    utils.purge_effects_and_stains(entity_id)

    -- Create a devastating projectile right on top of the player.
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/gold_death.xml"), x, y)
    
    -- Some cosmetic effects.
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/gold_burst.xml"), x, y)
    GamePlaySound(ns.base_sound("misc.snd"), "game_effect/frozen/create", x, y)
    
    -- Place the gold player statue.
    EntityLoad(ns.base_file("entities/animals/boss_centipede/rewards/gold_reward.xml"), x, y + 10)
end

-- TODO Re-implement precursor/midas easter-egg using a custom stain?
curse.do_midas_death = function(entity_id)
    -- Get the player's coordinates.
    local x, y = EntityGetTransform(entity_id)
    log.debug("Spawning midas death at: " .. x .. ", " .. y)

    -- Make sure they aren't invincible.
    utils.purge_effects_and_stains(entity_id)
    
    -- Create a devastating projectile right on top of the player.
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/midas_death.xml"), x, y)

    -- Some cosmetic effects.
    GamePlaySound(ns.base_sound("event_cues.bank"), "event_cues/midas/create", x, y)
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/midas_burst.xml"), x, y)
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/midas_conversion.xml"), x, y)
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/midas_explosion.xml"), x, y)
    -- EntityLoad(ns.base_file("entities/animals/boss_centipede/ending/midas_sand.xml"), x, y)
    EntityLoad(ns.base_file("entities/animals/boss_centipede/ending/midas_chunks.xml"), x, y)
    -- EntityLoad(ns.base_file("entities/animals/boss_centipede/ending/midas_walls.xml"), x, y)
end

-- @@ RETURN

return curse
