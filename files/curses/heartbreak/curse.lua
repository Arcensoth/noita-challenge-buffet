local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")

local curse = {}

-- @@ PROPERTIES

curse.code = "heartbreak"
curse.name = "$challenge_buffet__curse__heartbreak__name"
curse.description = "$challenge_buffet__curse__heartbreak__desc"
curse.item_sprite = ns.file("curses/" .. curse.code .. "/item.png")
curse.icon_sprite = ns.file("curses/" .. curse.code .. "/icon.png")
curse.item_pickup_script = ns.file("curses/" .. curse.code .. "/handles/item_pickup.lua")

-- @@ RETURN

return curse
