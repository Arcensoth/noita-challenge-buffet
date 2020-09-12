local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/logging.lua")

function purge_effects_and_stains(entity)
	-- Reset any `StatusEffectDataComponent`.
	local status_components = EntityGetComponent(entity, "StatusEffectDataComponent")
	if (status_components ~= nil) then
		for i, status_component in pairs(status_components) do
			EntityRemoveComponent(entity, status_component)
		end
		EntityAddComponent(entity, "StatusEffectDataComponent")
	end
	-- Reset any `SpriteStainsComponent`.
	local stains_components = EntityGetComponent(entity, "SpriteStainsComponent")
	if (stains_components ~= nil) then
		for i, stains_component in pairs(stains_components) do
			EntityRemoveComponent(entity, stains_component)
		end
		EntityAddComponent(entity, "SpriteStainsComponent")
	end
	-- Remove any children with a `GameEffectComponent`.
	local children = EntityGetAllChildren(entity)
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
