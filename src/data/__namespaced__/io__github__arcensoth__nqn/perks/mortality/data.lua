local ns = dofile_once("mods/io__github__arcensoth__nqn/files/namespacing.lua")
local log = dofile_once("mods/io__github__arcensoth__nqn/files/logging.lua")

local data = {}

-- @@ PROPERTIES

data.name = "mortality"
data.perk_id = ns.key(data.name)
data.title = "Mortality"
data.description = "You are cursed: damage is applied to maximum health"

data.effect_tag = ns.key("mortality")

-- @@ METHODS

data.update_hp = function(entity, damage)
	-- Set max HP and max HP cap to match new HP.
	local damagemodels = EntityGetComponent(entity, "DamageModelComponent")
	if (damagemodels ~= nil) then
		for i, damagemodel in ipairs(damagemodels) do
			local current_hp = tonumber(ComponentGetValue(damagemodel, "hp"))
			local new_hp = current_hp - damage
			ComponentSetValue(damagemodel, "max_hp", new_hp)
			ComponentSetValue(damagemodel, "max_hp_cap", new_hp)
		end
	end
end

-- @@ HANDLERS

data.on_init = function(entity_perk_item, entity_who_picked, item_name)
    log.debug("Picked up mortality perk")
    -- Add a tag that we can detect when taking damage.
	EntityAddTag(entity_who_picked, data.effect_tag)
	-- Update HP immediately.
	data.update_hp(entity_who_picked, 0)
	-- Run a script to update HP whenever the player takes damage.
    EntityAddComponent(
        entity_who_picked,
        "LuaComponent",
        {
            script_damage_received=ns.file("perks/mortality/damage_received.lua"),
        }
    )
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
