local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

function load_curse(name)
	return dofile_once(ns.file("curses/" .. name .. "/curse.lua"))
end

function create_curse_item(pos_x, pos_y, curse)
	log.debug("Creating curse item `" .. curse.code .. "` at (" .. pos_x .. ", " .. pos_y .. ")")

	-- Create a new entity using the curse base.
	local entity = EntityLoad(ns.file("curses/base.xml"), pos_x, pos_y)

	-- Turn it into an item that can be picked up.
	EntityAddComponent(entity, "ItemComponent", {
		item_name=curse.name,
		ui_description=curse.description,
		ui_display_description_on_pick_up_hint=1,
		play_spinning_animation=0,
		play_hover_animation=0,
		play_pick_sound=0,
		stats_count_as_item_pick_up=0,
	})

	EntityAddComponent(entity, "UIInfoComponent", {
		name=curse.name,
	})

	-- Give it a visual sprite.
	EntityAddComponent(entity, "SpriteComponent", {
		image_file=curse.item_sprite,
		offset_x=8,
		offset_y=8,
		update_transform=1,
		update_transform_rotation=0,
	})

	-- Make it bob up and down.
	EntityAddComponent(entity, "SpriteOffsetAnimatorComponent", {
      sprite_id=-1,
      x_amount=0,
    --   x_amount=0.1,
      x_phase=0,
      x_phase_offset=0,
      x_speed=0,
    --   x_speed=60,
      y_amount=2,
      y_speed=1,
	})

	-- Do something whenever it's picked up.
	EntityAddComponent(entity, "LuaComponent", {
		script_item_picked_up=curse.item_pickup_script,
	})
end

function curse_pickup_common(entity_item, entity_who_picked, curse)
	-- Get the item's coordinates.
	local pos_x, pos_y = EntityGetTransform(entity_item)

	log.debug("Picked up curse item `" .. curse.code .. "` at (" .. pos_x .. ", " .. pos_y .. ")")

	-- Run some cosmetic effects at the item's location.
	EntityLoad(ns.file("curses/pickup_effect.xml"), pos_x, pos_y)

	-- Remove the item.
	EntityKill(entity_item)

	-- Add the curse icon to the UI.
	-- NOTE Without the child entity, only the first icon shows up in the UI.
	local ui_entity = EntityCreateNew("")
	EntityAddComponent(ui_entity, "UIIconComponent", {
		name = curse.name,
		description = curse.description,
		icon_sprite_file = curse.icon_sprite
	})
	EntityAddChild(entity_who_picked, ui_entity)
end
