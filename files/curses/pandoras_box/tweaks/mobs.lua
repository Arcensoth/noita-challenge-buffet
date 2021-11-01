local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
local utils = dofile_once(ns.file("scripts/utils.lua"))

local pandora_mobs = {}

pandora_mobs.bases = {
    ns.base_file("entities/base_enemy_basic.xml"),
    ns.base_file("entities/base_enemy_flying.xml"),
    ns.base_file("entities/base_enemy_robot.xml"),
}

-- maps (name) -> (entry)
pandora_mobs.entries_by_name = {
    -- @@ TIER 1
    -- balanced around: pre-mines

    -- baby spiders
    longleg = {
        filename = "data/entities/animals/longleg.xml",
        groups = { "tier_1" },
        replacement_groups = { "tier_1", "tier_2" },
    },

    rat = {
        filename = "data/entities/animals/rat.xml",
        groups = { "tier_1" },
        replacement_groups = { "tier_1", "tier_2" },
    },

    -- weaker zombie dog from the first level
    zombie_weak = {
        filename = "data/entities/animals/zombie_weak.xml",
        groups = { "tier_1" },
        replacement_groups = { "tier_1", "tier_2" },
    },

    -- @@ TIER 2
    -- balanced around: mines

    -- small purple flying imp things from the second level
    bat = {
        filename = "data/entities/animals/bat.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- little angry lump
    miniblob = {
        filename = "data/entities/animals/miniblob.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- small firefly
    firebug = {
        filename = "data/entities/animals/firebug.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- small frogs from collapsed mines and fungal
    frog = {
        filename = "data/entities/animals/frog.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- weaker dynamite thrower from the first level
    miner_weak = {
        filename = "data/entities/animals/miner_weak.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- weaker shotgunner from the first level
    shotgunner_weak = {
        filename = "data/entities/animals/shotgunner_weak.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- weaker slimeshooter from the first level
    slimeshooter_weak = {
        filename = "data/entities/animals/slimeshooter_weak.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- baby purple squid thing that freezes if you get close
    tentacler_small = {
        filename = "data/entities/animals/tentacler_small.xml",
        groups = { "tier_2" },
        replacement_groups = { "tier_1", "tier_2", "tier_3" },
    },

    -- @@ TIER 3
    -- balanced around: collapsed mines, coal pits

    -- stendari from the first level
    -- hates to take a bath
    firemage_weak = {
        filename = "data/entities/animals/firemage_weak.xml",
        groups = { "tier_3", "mage" },
        replacement_groups = { "tier_2", "tier_3", "tier_4", "mage" },
    },

    -- floating fire skull from the first and second levels
    fireskull = {
        filename = "data/entities/animals/fireskull.xml",
        groups = { "tier_3", "skull" },
        replacement_groups = { "tier_2", "tier_3", "tier_4", "skull" },
    },

    -- small blue exploding mushroom
    fungus = {
        filename = "data/entities/animals/fungus.xml",
        groups = { "tier_3" },
        replacement_groups = { "tier_2", "tier_3", "tier_4" },
    },

    -- sparkle bomb throwers
    goblin_bomb = {
        filename = "data/entities/animals/goblin_bomb.xml",
        groups = { "tier_3" },
        replacement_groups = { "tier_2", "tier_3", "tier_4" },
    },

    -- stronger dynamite thrower found in first and second levels
    miner = {
        filename = "data/entities/animals/miner.xml",
        groups = { "tier_3" },
        replacement_groups = { "tier_2", "tier_3", "tier_4" },
    },

    -- cocktail thrower from the left side of the first level
    miner_fire = {
        filename = "data/entities/animals/miner_fire.xml",
        groups = { "tier_3" },
        replacement_groups = { "tier_2", "tier_3", "tier_4" },
    },

    -- stronger shotgunner from the first and second levels
    shotgunner = {
        filename = "data/entities/animals/shotgunner.xml",
        groups = { "tier_3" },
        replacement_groups = { "tier_2", "tier_3", "tier_4" },
    },

    -- stronger slimeshooter from the first and second levels
    slimeshooter = {
        filename = "data/entities/animals/slimeshooter.xml",
        groups = { "tier_3" },
        replacement_groups = { "tier_2", "tier_3", "tier_4" },
    },

    -- stronger zombie from the left side of the first level
    zombie = {
        filename = "data/entities/animals/zombie.xml",
        groups = { "tier_3" },
        replacement_groups = { "tier_2", "tier_3", "tier_4" },
    },

    -- @@ TIER 4
    -- balanced around: snowy depths

    -- weaker acid shooter from the first level
    acidshooter_weak = {
        filename = "data/entities/animals/acidshooter_weak.xml",
        groups = { "tier_4" },
        replacement_groups = { "tier_3", "tier_4", "tier_5" },
    },

    -- big purple flyer that spawns little purple flyers
    -- (tier +1 because of ads)
    bigbat = {
        filename = "data/entities/animals/bigbat.xml",
        groups = { "tier_4", "summoner" },
        replacement_groups = { "tier_3", "tier_4", "tier_5" },
    },

    -- big firefly
    bigfirebug = {
        filename = "data/entities/animals/bigfirebug.xml",
        groups = { "tier_4" },
        replacement_groups = { "tier_3", "tier_4", "tier_5" },
    },

    -- ice spirit summoner
    giant = {
        filename = "data/entities/animals/giant.xml",
        groups = { "tier_4", "summoner" },
        replacement_groups = { "tier_3", "tier_4", "tier_5" },
    },

    -- big green guy that carries 3 little green guys
    giantshooter_weak = {
        filename = "data/entities/animals/giantshooter_weak.xml",
        groups = { "tier_4", "summoner" },
        replacement_groups = { "tier_3", "tier_4", "tier_5" },
    },

    -- floating ice skull from snowy depths
    iceskull = {
        filename = "data/entities/animals/iceskull.xml",
        groups = { "tier_4", "skull" },
        replacement_groups = { "tier_3", "tier_4", "tier_5", "skull" },
    },

    -- @@ TIER 5
    -- balanced around: fungal

    -- stronger acid shooter from fungal
    acidshooter = {
        filename = "data/entities/animals/acidshooter.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- free flasks
    alchemist = {
        filename = "data/entities/animals/alchemist.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- purple ant thing that sprays acid
    ant = {
        filename = "data/entities/animals/ant.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- big angry lump
    blob = {
        filename = "data/entities/animals/blob.xml",
        groups = { "tier_5", "summoner" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- annoying little titanium robot with the shield
    drone_physics = {
        filename = "data/entities/animals/drone_physics.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- big frog from mines and fungal
    -- loves to slurp the player
    frog_big = {
        filename = "data/entities/animals/frog_big.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- big brown exploding mushroom
    fungus_big = {
        filename = "data/entities/animals/fungus_big.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- stronger big green guy that carries 3 little green guys
    giantshooter = {
        filename = "data/entities/animals/giantshooter.xml",
        groups = { "tier_5", "summoner" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },
    
    -- ice mage
    icemage = {
        filename = "data/entities/animals/icemage.xml",
        groups = { "tier_5", "mage" },
        replacement_groups = { "tier_4", "tier_5", "tier_6", "mage" },
    },

    -- blue beetle thing that shoots green exploding balls
    maggot = {
        filename = "data/entities/animals/maggot.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- blue hiisi suit that shoots invis bullets
    scavenger_invis = {
        filename = "data/entities/animals/scavenger_invis.xml",
        groups = { "tier_5", "small_hiisi", "healer" },
        replacement_groups = { "tier_4", "tier_5", "tier_6", "small_hiisi" },
    },

    -- swamp guy that shoots cursed orbs that make lightning clouds
    shaman = {
        filename = "data/entities/animals/shaman.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- big purple squid that freezes and slaps you with tentacles
    -- is it an eye or a beak?
    tentacler = {
        filename = "data/entities/animals/tentacler.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_4", "tier_5", "tier_6" },
    },

    -- floating wand from magic temple
    wand_ghost = {
        filename = "data/entities/animals/wand_ghost.xml",
        groups = { "tier_5" },
        replacement_groups = { "tier_7", "tier_8" },
    },

    -- @@ TIER 6
    -- balanced around: hiisi base, magic temple

    drone_lasership = {
        filename = "data/entities/animals/drone_lasership.xml",
        groups = { "tier_6" },
        replacement_groups = { "tier_5", "tier_6", "tier_7" },
    },

    -- floating purple ghost that shoots poly orbs
    necromancer = {
        filename = "data/entities/animals/necromancer.xml",
        groups = { "tier_6", "poly" },
        replacement_groups = { "tier_5", "tier_6", "tier_7" },
    },

    -- 4-eyed ghost that fires blue projectiles
    phantom_a = {
        filename = "data/entities/animals/phantom_a.xml",
        groups = { "tier_6" },
        replacement_groups = { "tier_5", "tier_6", "tier_7" },
    },

    -- 6-eyed ghost that fires green projectiles
    phantom_b = {
        filename = "data/entities/animals/phantom_b.xml",
        groups = { "tier_6" },
        replacement_groups = { "tier_5", "tier_6", "tier_7" },
    },

    -- big hiisi guy sometimes in hiisi base
    scavenger_clusterbomb = {
        filename = "data/entities/animals/scavenger_clusterbomb.xml",
        groups = { "tier_6", "big_hiisi" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "big_hiisi" },
    },

    -- hiisi glue shooters
    scavenger_glue = {
        filename = "data/entities/animals/scavenger_glue.xml",
        groups = { "tier_6", "small_hiisi" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "small_hiisi" },
    },

    -- hiisi grenadier
    scavenger_grenade = {
        filename = "data/entities/animals/scavenger_grenade.xml",
        groups = { "tier_6", "small_hiisi" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "small_hiisi" },
    },

    -- hiisi healer
    scavenger_heal = {
        filename = "data/entities/animals/scavenger_heal.xml",
        groups = { "tier_6", "small_hiisi", "healer" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "small_hiisi" },
    },

    -- mine thrower (also has a shotgun)
    scavenger_mine = {
        filename = "data/entities/animals/scavenger_mine.xml",
        groups = { "tier_6", "small_hiisi" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "small_hiisi" },
    },

    -- hiisi rifler
    scavenger_smg = {
        filename = "data/entities/animals/scavenger_smg.xml",
        groups = { "tier_6", "small_hiisi" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "small_hiisi" },
    },

    sniper = {
        filename = "data/entities/animals/sniper.xml",
        groups = { "tier_6", "small_hiisi" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "small_hiisi" },
    },

    -- weird floatign face thing in magic temple
    statue_physics = {
        filename = "data/entities/animals/statue_physics.xml",
        groups = { "tier_6" },
        replacement_groups = { "tier_5", "tier_6", "tier_7" },
    },

    tank = {
        filename = "data/entities/animals/tank.xml",
        groups = { "tier_6", "tank" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "tank" },
    },

    tank_rocket = {
        filename = "data/entities/animals/tank_rocket.xml",
        groups = { "tier_6", "tank" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "tank" },
    },

    -- red lumpy heart wizard
    wizard_hearty = {
        filename = "data/entities/animals/wizard_hearty.xml",
        groups = { "tier_6", "wizard" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "wizard" },
    },

    -- robot wizard
    wizard_neutral = {
        filename = "data/entities/animals/wizard_neutral.xml",
        groups = { "tier_6", "wizard" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "wizard" },
    },

    -- space suit wizard that reflects shots
    wizard_returner = {
        filename = "data/entities/animals/wizard_returner.xml",
        groups = { "tier_6", "wizard" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "wizard" },
    },

    -- tele wizard
    wizard_tele = {
        filename = "data/entities/animals/wizard_tele.xml",
        groups = { "tier_6", "wizard" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "wizard" },
    },

    -- swapper
    wizard_swapper = {
        filename = "data/entities/animals/wizard_swapper.xml",
        groups = { "tier_6", "wizard" },
        replacement_groups = { "tier_5", "tier_6", "tier_7", "wizard" },
    },

    -- @@ TIER 7
    -- balanced around: jungle

    -- hiisi CEO
    -- (tier up because of ads)
    scavenger_leader = {
        filename = "data/entities/animals/scavenger_leader.xml",
        groups = { "tier_7", "big_hiisi", "summoner" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "big_hiisi" },
    },

    thunderskull = {
        filename = "data/entities/animals/thunderskull.xml",
        groups = { "tier_7", "skull" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "skull" },
    },

    -- dark wizard
    wizard_dark = {
        filename = "data/entities/animals/wizard_dark.xml",
        groups = { "tier_8", "wizard" },
        replacement_groups = { "tier_7", "tier_8", "tier_9", "wizard" },
    },

    -- twitchy wizard
    wizard_twitchy = {
        filename = "data/entities/animals/wizard_twitchy.xml",
        groups = { "tier_8", "wizard" },
        replacement_groups = { "tier_7", "tier_8", "tier_9", "wizard" },
    },

    -- poly wizard
    wizard_poly = {
        filename = "data/entities/animals/wizard_poly.xml",
        groups = { "tier_8", "wizard", "poly" },
        replacement_groups = { "tier_7", "tier_8", "tier_9", "wizard" },
    },

    ["rainforest/bloom"] = {
        filename = "data/entities/animals/rainforest/bloom.xml",
        groups = { "tier_7" },
        replacement_groups = { "tier_6", "tier_7", "tier_8" },
    },

    ["rainforest/coward"] = {
        filename = "data/entities/animals/rainforest/coward.xml",
        groups = { "tier_7", "summoner" },
        replacement_groups = { "tier_6", "tier_7", "tier_8" },
    },

    ["rainforest/fly"] = {
        filename = "data/entities/animals/rainforest/fly.xml",
        groups = { "tier_7" },
        replacement_groups = { "tier_6", "tier_7", "tier_8" },
    },

    ["rainforest/fungus"] = {
        filename = "data/entities/animals/rainforest/fungus.xml",
        groups = { "tier_7" },
        replacement_groups = { "tier_6", "tier_7", "tier_8" },
    },

    ["rainforest/scavenger_clusterbomb"] = {
        filename = "data/entities/animals/rainforest/scavenger_clusterbomb.xml",
        groups = { "tier_7", "jungle_hiisi" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi" },
    },

    ["rainforest/scavenger_grenade"] = {
        filename = "data/entities/animals/rainforest/scavenger_grenade.xml",
        groups = { "tier_7", "jungle_hiisi" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi" },
    },

    ["rainforest/scavenger_heal"] = {
        filename = "data/entities/animals/rainforest/scavenger_heal.xml",
        groups = { "tier_7", "jungle_hiisi", "healer" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi", "healer" },
    },

    ["rainforest/scavenger_leader"] = {
        filename = "data/entities/animals/rainforest/scavenger_leader.xml",
        groups = { "tier_7", "jungle_hiisi", "summoner" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi", "summoner" },
    },

    ["rainforest/scavenger_mine"] = {
        filename = "data/entities/animals/rainforest/scavenger_mine.xml",
        groups = { "tier_7", "jungle_hiisi" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi" },
    },

    ["rainforest/scavenger_poison"] = {
        filename = "data/entities/animals/rainforest/scavenger_poison.xml",
        groups = { "tier_7", "jungle_hiisi" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi" },
    },

    ["rainforest/scavenger_smg"] = {
        filename = "data/entities/animals/rainforest/scavenger_smg.xml",
        groups = { "tier_7", "jungle_hiisi" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi" },
    },

    ["rainforest/sniper"] = {
        filename = "data/entities/animals/rainforest/sniper.xml",
        groups = { "tier_7", "jungle_hiisi" },
        replacement_groups = { "tier_6", "tier_7", "tier_8", "jungle_hiisi" },
    },

    -- @@ TIER 8
    -- balanced around: vault

    coward = {
        filename = "data/entities/animals/coward.xml",
        groups = { "tier_8", "summoner" },
        replacement_groups = { "tier_7", "tier_8", "tier_9" },
    },

    -- robocop
    roboguard = {
        filename = "data/entities/animals/roboguard.xml",
        groups = { "tier_8" },
        replacement_groups = { "tier_7", "tier_8", "tier_9" },
    },

    -- flying spear thrower bot
    spearbot = {
        filename = "data/entities/animals/spearbot.xml",
        groups = { "tier_8" },
        replacement_groups = { "tier_7", "tier_8", "tier_9" },
    },

    -- tank that shoots fast green plasma bolts
    tank_super = {
        filename = "data/entities/animals/tank_super.xml",
        groups = { "tier_8", "tank" },
        replacement_groups = { "tier_7", "tier_8", "tier_9", "tank" },
    },

    -- @@ TIER 9
    -- balanced around: temple of the art
    
    -- ukko
    thundermage = {
        filename = "data/entities/animals/thundermage.xml",
        groups = { "tier_9", "mage" },
        replacement_groups = { "tier_8", "tier_9", "mage" },
    },
}

-- maps (filename) -> (entry)
pandora_mobs.entries_by_filename = {}

-- maps (group) -> (entries)
-- which in turn maps (name) -> (entry)
pandora_mobs.entries_by_group = {}

-- build fields and indexes
for name, entry in pairs(pandora_mobs.entries_by_name) do
    -- add name field to entries
    entry["name"] = name

    -- calculate hash based on name
    entry["hash"] = utils.hash_string(name)
    
    -- build filename index
    pandora_mobs.entries_by_filename[entry.filename] = entry

    -- build group index
    for _, group in pairs(entry.groups) do
        local group_entries = pandora_mobs.entries_by_group[group]
        if group_entries == nil then
            group_entries = {}
            pandora_mobs.entries_by_group[group] = group_entries
        end
        group_entries[entry.name] = entry
    end
end

pandora_mobs.get_by_name = function(name)
    local entry = pandora_mobs.entries_by_name[name]
    return entry
end

pandora_mobs.get_by_filename = function(filename)
    local entry = pandora_mobs.entries_by_filename[filename]
    return entry
end

pandora_mobs.get_by_group = function(group)
    local group_entries = pandora_mobs.entries_by_group[group]
    return group_entries
end

pandora_mobs.get_replacements = function(entry)
    -- build flattened list of replacement entries
    local replacements = {}
    for _, group in pairs(entry.replacement_groups) do
        local group_entries = pandora_mobs.get_by_group(group)
        if group_entries ~= nil then
            for _, replacement_entry in pairs(group_entries) do
                replacements[#replacements + 1] = replacement_entry
            end
        end
    end
    return replacements
end

pandora_mobs.get_replacement = function(entry)
    name = entry.name
    local world_seed = utils.get_world_seed()
    local replacements = pandora_mobs.get_replacements(entry)
    local cap = #replacements
    local hash = entry.hash
    local v1 = world_seed * hash
    local v2 = v1 / 1000
    local vf = math.floor(v2 % cap)
    if vf < 0 then
        vf = vf * -1
    end
    local replacement = replacements[vf + 1]
    return replacement
end

pandora_mobs.print_tables = function()
    print("================================================================================")
    for name, entry in pairs(pandora_mobs.entries_by_name) do
        print(name .. " -> " .. entry.name)
        print("  filename: " .. entry.filename)
        print("  groups:")
        for _, group in pairs(entry.groups) do
            print("    " .. group)
        end
        print("  replacement_groups:")
        for _, replacement_group in pairs(entry.replacement_groups) do
            print("    " .. replacement_group)
        end
    end

    print("================================================================================")
    for filename, entry in pairs(pandora_mobs.entries_by_filename) do
        print(filename .. " -> " .. entry.name)
    end

    print("================================================================================")
    for group, group_entries in pairs(pandora_mobs.entries_by_group) do
        print(group)
        for name, entry in pairs(group_entries) do
            print("  " .. name .. " -> " .. entry.name)
        end
        print("")
    end

    print("================================================================================")
end

pandora_mobs.print_replacements = function(name)
    print("================================================================================")
    print("replacements for " .. name .. ":")
    local entry = pandora_mobs.get_by_name(name)
    local replacements = pandora_mobs.get_replacements(entry)
    for _, entry in pairs(replacements) do
        print("  " .. entry.name)
    end
    print("================================================================================")
end

pandora_mobs.print_replacement = function(name)
    local world_seed = utils.get_world_seed()
    local entry = pandora_mobs.get_by_name(name)
    local replacement = pandora_mobs.get_replacement(entry)
    print("[world_seed=" .. world_seed .. "] " .. name .. " -> " .. replacement.name)
end

return pandora_mobs
