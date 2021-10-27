dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local tags = dofile_once(ns.file("scripts/const/tags.lua"))

dofile_once(ns.file("scripts/utils/effects.lua"))

local curse = {}

-- @@ PROPERTIES

curse.code = "bane_of_midas"
curse.name = "$challenge_buffet__curse__bane_of_midas__name"
curse.description = "$challenge_buffet__curse__bane_of_midas__desc"
curse.item_sprite = ns.file("curses/" .. curse.code .. "/item.png")
curse.icon_sprite = ns.file("curses/" .. curse.code .. "/icon.png")
curse.item_pickup_script = ns.file("curses/" .. curse.code .. "/handles/item_pickup.lua")

curse.damage_received_script = ns.file("curses/" .. curse.code .. "/handles/damage_received.lua")

curse.gold_materials_that_damage = "gold,gold_static,gold_static_dark,gold_molten,gold_radioactive,gold_box2d,gold_b2,bloodgold_box2d"
curse.gold_materials_how_much_damage = "0.00001,0.00001,0.00001,0.00001,0.00001,0.00001,0.00001,0.00001"

curse.midas_materials_that_damage = "midas,midas_precursor"
curse.midas_materials_how_much_damage = "0.00001,0.00001"

-- @@ METHODS

curse.do_gold_death = function(entity)
    -- Make sure this only happens once.
    if (EntityHasTag(entity, tags.bane_of_midas_death)) then
        return nil
    end
    EntityAddTag(entity, tags.bane_of_midas_death)

    -- Get the player's coordinates.
    local x, y = EntityGetTransform(entity)
    log.debug("Spawning gold death at: " .. x .. ", " .. y)

    -- Make sure they aren't invincible.
    purge_effects_and_stains(entity)

    -- Create a devastating projectile right on top of the player.
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/gold_death.xml"), x, y)
    
    -- Some cosmetic effects.
    EntityLoad(ns.file("curses/" .. curse.code .. "/projectiles/gold_burst.xml"), x, y)
    GamePlaySound(ns.base_sound("misc.snd"), "game_effect/frozen/create", x, y)
    
    -- Place the gold player statue.
    EntityLoad(ns.base_file("entities/animals/boss_centipede/rewards/gold_reward.xml"), x, y + 10)
end

curse.do_midas_death = function(entity)
    -- Make sure this only happens once.
    if (EntityHasTag(entity, tags.bane_of_midas_death)) then
        return nil
    end
    EntityAddTag(entity, tags.bane_of_midas_death)

    -- Get the player's coordinates.
    local x, y = EntityGetTransform(entity)
    log.debug("Spawning midas death at: " .. x .. ", " .. y)

    -- Make sure they aren't invincible.
    purge_effects_and_stains(entity)
    
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

-- @@ HANDLES

-- NOTE This is accessed dynamically by the `gold_item_pickup_callbacks.lua` script.
curse.on_gold_item_pickup = function(entity_item, entity_who_picked, item_name)
    if (EntityHasTag(entity_who_picked, tags.bane_of_midas)) then
        log.debug("Picked up gold while cursed with " .. curse.code)
        curse.do_gold_death(entity_who_picked)
    end
end

-- @@ RETURN

return curse
