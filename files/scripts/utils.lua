dofile_once("data/scripts/lib/utilities.lua")

local utils = {}

utils.get_world_seed = function()
    return math.floor(tonumber(StatsGetValue("world_seed")))
end

utils.hash_string = function(s)
    -- https://stackoverflow.com/a/7666577
    local hash = 5381
    for i = 1, #s do
        local c = s:sub(i, i)
        local b = string.byte(c)
        hash = (hash * 33 + b) % 2147483647
    end
    return hash
end

utils.purge_effects_and_stains = function(entity_id)
    -- Reset any `StatusEffectDataComponent`.
    local status_components = EntityGetComponent(entity_id, "StatusEffectDataComponent")
    if (status_components ~= nil) then
        for i, status_component in pairs(status_components) do
            EntityRemoveComponent(entity_id, status_component)
        end
        EntityAddComponent(entity_id, "StatusEffectDataComponent")
    end
    -- Reset any `SpriteStainsComponent`.
    local stains_components = EntityGetComponent(entity_id, "SpriteStainsComponent")
    if (stains_components ~= nil) then
        for i, stains_component in pairs(stains_components) do
            EntityRemoveComponent(entity_id, stains_component)
        end
        EntityAddComponent(entity_id, "SpriteStainsComponent")
    end
    -- Remove any children with a `GameEffectComponent`.
    local children = EntityGetAllChildren(entity_id)
    if (children ~= nil) then
        for i, child in pairs(children) do
            local child_name = EntityGetName(child)
            local child_effect_components = EntityGetComponent(child, "GameEffectComponent")
            if (child_effect_components ~= nil) then
                for j, child_effect_component in pairs(child_effect_components) do
                    EntityRemoveComponent(child, child_effect_component)
                    EntityRemoveFromParent(child)
                    EntityKill(child)
                end
            end
        end
    end
end

return utils
