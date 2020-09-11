local ns = dofile_once("mods/io__github__arcensoth__nqn/files/namespacing.lua")
local heartbreak_perk = dofile_once(ns.file("perks/heartbreak/data.lua"))
local gold_allergy_perk = dofile_once(ns.file("perks/gold_allergy/data.lua"))

table.insert(perk_list, heartbreak_perk.definition)
table.insert(perk_list, gold_allergy_perk.definition)
