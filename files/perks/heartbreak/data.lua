local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local tags = dofile_once(ns.file("scripts/const/tags.lua"))

local data = {}

-- @@ PROPERTIES

data.name = "heartbreak"
data.perk_id = ns.key(data.name)
data.title = "Heartbreak"
data.description = "You are cursed: maximum health cannot be increased"

-- @@ HANDLERS

data.on_init = function(entity_perk_item, entity_who_picked, item_name)
	log.debug("Picked up perk: " .. data.name)
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
	EntityAddTag(entity_who_picked, "temple_hearts_obey_max_hp_cap")
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
