local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
dofile_once(ns.file("scripts/tweaks/gold_items/data/gold_items.lua"))

local pick_up_script = ns.file("scripts/tweaks/gold_items/item_pickup.lua")

log.info("Tweaking gold items to add pick-up script: " .. pick_up_script)

local content_to_insert = [[
    <LuaComponent
        script_item_picked_up="]] .. pick_up_script .. [["
    ></LuaComponent>
]]

for i, filename in pairs(GOLD_ITEMS) do
    local old_content = ModTextFileGetContent(filename)
    if old_content then
        local insertion_point = string.find(old_content, "</Entity>") - 1
        log.info("Tweaking item <" .. filename .. "> at insertion point: " .. insertion_point)
        new_content = old_content:sub(1, insertion_point) .. content_to_insert .. "\n" .. old_content:sub(insertion_point + 1)
        ModTextFileSetContent(filename, new_content)
    end
end
