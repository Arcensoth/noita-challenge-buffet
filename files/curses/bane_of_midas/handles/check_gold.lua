dofile_once("data/scripts/lib/utilities.lua")

local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local bane_of_midas = dofile_once(ns.file("curses/bane_of_midas/curse.lua"))

bane_of_midas.check_gold(GetUpdatedEntityID())
