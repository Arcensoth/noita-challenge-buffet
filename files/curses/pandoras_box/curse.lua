dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local tags = dofile_once(ns.file("scripts/const/tags.lua"))

local curse = {}

-- @@ PROPERTIES

curse.code = "pandoras_box"
curse.name = "$challenge_buffet__curse__" .. curse.code .. "__name"
curse.description = "$challenge_buffet__curse__" .. curse.code .. "__desc"
curse.item_sprite = ns.file("curses/" .. curse.code .. "/item.png")
curse.icon_sprite = ns.file("curses/" .. curse.code .. "/icon.png")
curse.item_pickup_script = ns.file("curses/" .. curse.code .. "/handles/item_pickup.lua")

curse.process_entity_script = ns.file("curses/" .. curse.code .. "/handles/process_entity.lua")
curse.global_flag = ns.key("is_pandoras_box_active")
curse.processed_tag = ns.key("pandoras_box_processed")

-- @@ METHODS

curse.process_entity = function(entity_id)
    -- Short-circuit if the entity has already been processed.
    if EntityHasTag(entity_id, curse.processed_tag) then
        -- log.debug("Entity " .. entity_id .. " already processed; short-circuiting...")
        return
    end

    -- log.debug("Entity " .. entity_id .. " NOT already processed; processing...")

    -- Mark the entity as processed so we don't process it again.
    EntityAddTag(entity_id, curse.processed_tag)

    -- FIXME How to ignore entities that are polymorphed?
    -- local game_effects = EntityGetComponent(entity_id, "GameEffectComponent")
    -- if game_effects ~= nil then
    --     log.warning("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    --     log.warning("Entity has effects: " .. #game_effects)
    --     log.warning("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    --     for _, game_effect in pairs(game_effects) do
    --         local effect_name = ComponentGetValue2(game_effect, "effect")
    --         if (
    --             (effect_name == "POLYMORPH")
    --             or (effect_name == "POLYMORPH_RANDOM")
    --             or (effect_name == "POLYMORPH_UNSTABLE")
    --         ) then
    --             local entity_name = EntityGetName(entity_id)
    --             log.warning("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    --             log.warning("Polymorphed entity:  " .. entity_name .. " -> " .. effect_name)
    --             log.warning("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    --             return
    --         end
    --     end
    -- end

    -- Get the corresponding entry for this creature.
    local pandora_mobs = dofile_once(ns.file("curses/pandoras_box/tweaks/mobs.lua"))
    local entity_filename = EntityGetFilename(entity_id)
    local mob_entry = pandora_mobs.get_by_filename(entity_filename)

    if mob_entry == nil then
        log.warning("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        log.warning("Unregistered mob:" .. entity_filename)
        log.warning("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    else
        local replacement_entry = pandora_mobs.get_replacement(mob_entry)
        local x, y = EntityGetTransform(entity_id)

        -- log.debug("  " .. mob_entry.name .. " -> " .. replacement_entry.name)

        -- Remove the original entity.
        EntityKill(entity_id)

        -- Load the replacement entity.
        local new_entity_id = EntityLoad(replacement_entry.filename, x, y)

        -- Mark the new entity as processed so we don't process it.
        EntityAddTag(new_entity_id, curse.processed_tag)
    end
end

curse.poll_for_entities = function()
    local enemies = EntityGetWithTag("enemy")
    for i, entity_id in pairs(enemies) do
    	curse.process_entity(entity_id)
    end
end

-- @@ RETURN

return curse
