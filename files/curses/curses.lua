local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")

dofile_once(ns.file("curses/utils.lua"))

local curses = {}

curses.bane_of_midas = load_curse("bane_of_midas")
curses.heartbreak = load_curse("heartbreak")
curses.mortality = load_curse("mortality")

return curses
