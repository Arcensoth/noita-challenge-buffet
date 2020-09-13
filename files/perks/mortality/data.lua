local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local tags = dofile_once(ns.file("scripts/const/tags.lua"))

local data = {}

-- @@ PROPERTIES

data.name = "mortality"
data.perk_id = ns.key(data.name)
data.title = "Mortality"
data.description = "You are cursed: take damage to maximum health"

-- @@ METHODS

data.update_hp = function(entity, damage)
	-- Set max HP to match new HP.
	local damagemodels = EntityGetComponent(entity, "DamageModelComponent")
	if (damagemodels ~= nil) then
		for i, damagemodel in ipairs(damagemodels) do
			local current_max_hp = tonumber(ComponentGetValue(damagemodel, "max_hp"))
			local new_max_hp = current_max_hp - damage
			log.debug("Took " .. (damage * 25) .. " damage; decreasing max HP from " .. (current_max_hp * 25) .. " to " .. (new_max_hp * 25))
			ComponentSetValue(damagemodel, "max_hp", new_max_hp)
			-- Make sure to check whether max HP cap should be synced with max HP.
			if (EntityHasTag(entity, tags.sync_max_hp_with_cap)) then
				log.debug("Also syncing max HP cap with new max HP")
				ComponentSetValue(damagemodel, "max_hp_cap", new_max_hp)
			end
		end
	end
end

-- @@ HANDLERS

data.on_init = function(entity_perk_item, entity_who_picked, item_name)
    log.debug("Picked up perk: " .. data.name)
	-- Update HP immediately.
	data.update_hp(entity_who_picked, 0)
	-- Run a script to update HP whenever the player takes damage.
    EntityAddComponent(
        entity_who_picked,
        "LuaComponent",
        {
            script_damage_received=ns.file("perks/mortality/handles/damage_received.lua"),
        }
    )
end

-- @@ PERK DEFINITION

data.definition = {
	id = data.perk_id,
	ui_name = data.title,
	ui_description = data.description,
	ui_icon = ns.file("perks/" .. data.name .. "/icon.png"),
	perk_icon = ns.file("perks/" .. data.name .. "/item.png"),
	stackable = false,
	usable_by_enemies = false,
	func = data.on_init,
}

-- @@ RETURN

return data
