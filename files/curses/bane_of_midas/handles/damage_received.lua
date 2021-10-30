dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

function damage_received(damage, message, entity_thats_responsible, is_fatal)
    local bane_of_midas = dofile_once(ns.file("curses/bane_of_midas/curse.lua"))

    -- Optimzation: short-circuit immediately if we're dealing non-negligible damage.
    if (damage > 0.001) then
        return nil
    end

    -- Check all of the entity's damage components to see which one just fired...
    local entity = GetUpdatedEntityID()
    local damage_components = EntityGetComponent(entity, "DamageModelComponent")
	if (damage_components ~= nil) then
        for i, damage_component in ipairs(damage_components) do
            -- Only care about the ones that caused damaged recently.
            local current_frame = GameGetFrameNum()
            local m_last_frame = ComponentGetValue2(damage_component, "mLastMaterialDamageFrame")
            if (m_last_frame >= current_frame) then
                -- Only care about damage being caused by gold materials.
                local materials_that_damage = ComponentGetValue2(damage_component, "materials_that_damage")
                if (materials_that_damage == bane_of_midas.gold_materials_that_damage) then
                    bane_of_midas.do_gold_death(entity)
                elseif (materials_that_damage == bane_of_midas.midas_materials_that_damage) then
                    bane_of_midas.do_midas_death(entity)
                end
            end
		end
    end
end
