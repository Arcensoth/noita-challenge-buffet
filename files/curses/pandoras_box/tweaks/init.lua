local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))

local pandoras_box = dofile_once(ns.file("curses/pandoras_box/curse.lua"))

log.info("Tweaking base mobs to add Pandora's Box entity processing script: " .. pandoras_box.process_entity_script)

local content_to_insert = [[
    <LuaComponent
        script_source_file="]] .. pandoras_box.process_entity_script .. [["
        remove_after_executed="1"
    ></LuaComponent>
]]

local pandora_mobs = dofile_once(ns.file("curses/pandoras_box/tweaks/mobs.lua"))

for i, filename in pairs(pandora_mobs.bases) do
    local old_content = ModTextFileGetContent(filename)
    if old_content then
        local insertion_point = string.find(old_content, "</Entity>") - 1
        log.info("Tweaking base mob <" .. filename .. "> at insertion point: " .. insertion_point)
        new_content = old_content:sub(1, insertion_point) .. content_to_insert .. "\n" .. old_content:sub(insertion_point + 1)
        ModTextFileSetContent(filename, new_content)
    end
end
