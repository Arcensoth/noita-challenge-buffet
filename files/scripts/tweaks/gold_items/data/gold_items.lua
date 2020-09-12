local ns = dofile( "mods/io__github__arcensoth__challenge_buffet/files/scripts/utils/namespacing.lua" )

-- NOTE Other mods can append to this file to add their own items.

GOLD_ITEMS = {
    ns.base_file("entities/items/pickup/goldnugget.xml"),
    ns.base_file("entities/items/pickup/goldnugget_10.xml"),
    ns.base_file("entities/items/pickup/goldnugget_50.xml"),
    ns.base_file("entities/items/pickup/goldnugget_200.xml"),
    ns.base_file("entities/items/pickup/goldnugget_1000.xml"),
    ns.base_file("entities/items/pickup/goldnugget_10000.xml"),
    ns.base_file("entities/animals/boss_centipede/rewards/gold_reward.xml"),
}
