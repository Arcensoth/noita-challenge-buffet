local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

local curse_utils = {}

curse_utils.create_pickup = function(curse, pos_x, pos_y)
    log.debug("Creating curse item `" .. curse.code .. "` at (" .. pos_x .. ", " .. pos_y .. ")")

    -- Create a new entity using the curse base.
    local entity_id = EntityLoad(ns.file("curses/base.xml"), pos_x, pos_y)

    -- Turn it into an item that can be picked up.
    EntityAddComponent(entity_id, "ItemComponent", {
        item_name=curse.name,
        ui_description=curse.description,
        ui_display_description_on_pick_up_hint=1,
        play_spinning_animation=0,
        play_hover_animation=0,
        play_pick_sound=0,
        stats_count_as_item_pick_up=0,
    })

    EntityAddComponent(entity_id, "UIInfoComponent", {
        name=curse.name,
    })

    -- Give it a visual sprite.
    EntityAddComponent(entity_id, "SpriteComponent", {
        image_file=curse.item_sprite,
        offset_x=8,
        offset_y=8,
        update_transform=1,
        update_transform_rotation=0,
    })

    -- Make it bob up and down.
    EntityAddComponent(entity_id, "SpriteOffsetAnimatorComponent", {
      sprite_id=-1,
      x_amount=0,
      x_phase=0,
      x_phase_offset=0,
      x_speed=0,
      y_amount=2,
      y_speed=1,
    })

    -- Do something whenever it's picked up.
    EntityAddComponent(entity_id, "LuaComponent", {
        script_item_picked_up=curse.item_pickup_script,
    })
end

curse_utils.on_pickup = function(curse, picker_entity_id, item_entity_id)
    -- Get the item's coordinates.
    local pos_x, pos_y = EntityGetTransform(item_entity_id)

    log.debug("Picked up curse item `" .. curse.code .. "` at (" .. pos_x .. ", " .. pos_y .. ")")

    -- Run some cosmetic effects at the item's location.
    EntityLoad(ns.file("curses/pickup_effect.xml"), pos_x, pos_y)

    -- Remove the item.
    EntityKill(item_entity_id)

    -- Add the curse icon to the picker's UI.
    -- NOTE Without the child entity, only the first icon shows up in the UI.
    local ui_entity = EntityCreateNew("")
    EntityAddComponent(ui_entity, "UIIconComponent", {
        name = curse.name,
        description = curse.description,
        icon_sprite_file = curse.icon_sprite
    })
    EntityAddChild(picker_entity_id, ui_entity)
end

return curse_utils
