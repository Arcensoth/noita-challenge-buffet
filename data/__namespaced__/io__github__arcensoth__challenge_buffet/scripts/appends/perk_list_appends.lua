local ns = dofile_once("mods/io__github__arcensoth__challenge_buffet/files/namespacing.lua")

table.insert(perk_list, dofile_once(ns.file("perks/heartbreak/data.lua")).definition)
table.insert(perk_list, dofile_once(ns.file("perks/gold_allergy/data.lua")).definition)
table.insert(perk_list, dofile_once(ns.file("perks/mortality/data.lua")).definition)
