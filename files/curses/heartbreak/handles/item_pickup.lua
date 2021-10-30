dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local tags = dofile_once(ns.file("scripts/const/tags.lua"))

function item_pickup(entity_item, entity_who_picked, item_name)
	local heartbreak = dofile_once(ns.file("curses/heartbreak/curse.lua"))
	
	dofile_once(ns.file("curses/utils.lua"))
	curse_pickup_common(entity_item, entity_who_picked, heartbreak)

	-- Add a tag that can be used elsewhere to detect whether max HP cap should match max HP.
	EntityAddTag(entity_who_picked, tags.sync_max_hp_with_cap)

	-- Permanently cap the player's max HP at their current max HP.
	local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
	if (damagemodels ~= nil) then
		for i, damagemodel in ipairs(damagemodels) do
			local current_hp = tonumber(ComponentGetValue(damagemodel, "hp"))
			local current_max_hp = tonumber(ComponentGetValue(damagemodel, "max_hp"))
			ComponentSetValue(damagemodel, "max_hp", current_max_hp)
			ComponentSetValue(damagemodel, "max_hp_cap", current_max_hp)
			ComponentSetValue(damagemodel, "hp", math.min(current_hp, current_max_hp))
		end
	end

	-- Stop temple hearts from overriding the cap and increasing maximum HP.
	-- NOTE We use a non-namespaced key here because it's being used to append vanilla files.
	EntityAddTag(entity_who_picked, "temple_hearts_obey_max_hp_cap")
end
