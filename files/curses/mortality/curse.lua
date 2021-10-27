dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local tags = dofile_once(ns.file("scripts/const/tags.lua"))

local curse = {}

-- @@ PROPERTIES

curse.code = "mortality"
curse.name = "$challenge_buffet__curse__mortality__name"
curse.description = "$challenge_buffet__curse__mortality__desc"
curse.item_sprite = ns.file("curses/" .. curse.code .. "/item.png")
curse.icon_sprite = ns.file("curses/" .. curse.code .. "/icon.png")
curse.item_pickup_script = ns.file("curses/" .. curse.code .. "/handles/item_pickup.lua")

curse.damage_received_script = ns.file("curses/" .. curse.code .. "/handles/damage_received.lua")

-- @@ METHODS

curse.update_hp = function(entity_id, damage)
	-- Set max HP to match new HP.
	local damagemodels = EntityGetComponent(entity_id, "DamageModelComponent")
	if (damagemodels ~= nil) then
		for i, damagemodel in ipairs(damagemodels) do
			local current_max_hp = tonumber(ComponentGetValue(damagemodel, "max_hp"))
			local new_max_hp = current_max_hp - damage
			log.debug("Took " .. (damage * 25) .. " damage; decreasing max HP from " .. (current_max_hp * 25) .. " to " .. (new_max_hp * 25))
			ComponentSetValue(damagemodel, "max_hp", new_max_hp)
			-- Make sure to check whether max HP cap should be synced with max HP.
			if (EntityHasTag(entity_id, tags.sync_max_hp_with_cap)) then
				log.debug("Also syncing max HP cap with new max HP")
				ComponentSetValue(damagemodel, "max_hp_cap", new_max_hp)
			end
		end
	end
end

-- @@ RETURN

return curse
