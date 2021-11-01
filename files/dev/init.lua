local ns = dofile_once("mods/challenge_buffet/files/scripts/utils/namespacing.lua")
local log = dofile_once(ns.file("scripts/utils/logging.lua"))
dofile_once(ns.file("scripts/utils/perks.lua"))

function dev_spawn_items(items)
	for i, item in ipairs(items) do
		-- spawn the item
		local entity = EntityLoad(ns.base_file(item), 650 + i * 20, -120)
		-- stop it from disappearing
		local lifetime_components = EntityGetComponent(entity, "LifetimeComponent")
		if (lifetime_components ~= nil) then
			for i, lifetime_component in ipairs(lifetime_components) do
				EntityRemoveComponent(entity, lifetime_component)
			end
		end
	end
end

function dev_spawn_hearts()
	dev_spawn_items({
		"entities/items/pickup/heart.xml",
		"entities/items/pickup/heart.xml",
		"entities/items/pickup/heart.xml",
		"entities/items/pickup/heart_evil.xml",
		"entities/items/pickup/heart_better.xml",
		"entities/items/pickup/heart_fullhp.xml",
		"entities/items/pickup/heart_fullhp_temple.xml",
	})
end

function dev_spawn_gold_nuggets()
	dev_spawn_items({
		"entities/items/pickup/goldnugget.xml",
		"entities/items/pickup/goldnugget_10.xml",
		"entities/items/pickup/goldnugget_50.xml",
		"entities/items/pickup/goldnugget_200.xml",
		"entities/items/pickup/goldnugget_1000.xml",
		"entities/items/pickup/goldnugget_10000.xml",
	})
end

function dev_spawn_blood_money()
	dev_spawn_items({
		"entities/items/pickup/bloodmoney_10.xml",
		"entities/items/pickup/bloodmoney_50.xml",
		"entities/items/pickup/bloodmoney_200.xml",
		"entities/items/pickup/bloodmoney_1000.xml",
		"entities/items/pickup/bloodmoney_10000.xml",
	})
end

function dev_spawn_gold_statues()
	dev_spawn_items({
		"entities/animals/boss_centipede/rewards/gold_reward.xml",
		"entities/animals/boss_centipede/rewards/gold_reward.xml",
		"entities/animals/boss_centipede/rewards/gold_reward.xml",
	})
end

function dev_spawn_potions()
	local entity = EntityLoad(ns.file("dev/potion_gold.xml"), 760, -110)
	local entity = EntityLoad(ns.file("dev/potion_precursor.xml"), 780, -110)
	local entity = EntityLoad(ns.file("dev/potion_midas.xml"), 800, -110)
end

function dev_init_world()
	-- dev_spawn_hearts()
	-- dev_spawn_gold_nuggets()
	-- dev_spawn_blood_money()
	-- dev_spawn_gold_statues()
	dev_spawn_potions()
end

function dev_init_player(player_entity)
	EntitySetTransform(player_entity, 545, -100)
	grant_perk(player_entity, "EDIT_WANDS_EVERYWHERE")
	grant_perk(player_entity, "REMOVE_FOG_OF_WAR")
	grant_perk(player_entity, "PROTECTION_FIRE")
	grant_perk(player_entity, "PROTECTION_RADIOACTIVITY")
	grant_perk(player_entity, "PROTECTION_EXPLOSION")
	grant_perk(player_entity, "PROTECTION_MELEE")
	grant_perk(player_entity, "PROTECTION_ELECTRICITY")
	grant_perk(player_entity, "INVISIBILITY")
	grant_perk(player_entity, "MOVEMENT_FASTER")
	grant_perk(player_entity, "MOVEMENT_FASTER")
	grant_perk(player_entity, "MOVEMENT_FASTER")
	grant_perk(player_entity, "FASTER_LEVITATION")
	grant_perk(player_entity, "FASTER_LEVITATION")
	grant_perk(player_entity, "FASTER_LEVITATION")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "HOVER_BOOST")
	grant_perk(player_entity, "GENOME_MORE_LOVE")
	grant_perk(player_entity, "GENOME_MORE_LOVE")
	grant_perk(player_entity, "GENOME_MORE_LOVE")
	grant_perk(player_entity, "GENOME_MORE_LOVE")
	grant_perk(player_entity, "GENOME_MORE_LOVE")

	-- local pandora_mobs = dofile_once(ns.file("curses/pandoras_box/tweaks/mobs.lua"))
	-- pandora_mobs.print_tables()
	-- pandora_mobs.print_replacements("rat")
	-- pandora_mobs.print_replacements("frog")
	-- pandora_mobs.print_replacements("iceskull")
	-- pandora_mobs.print_replacements("tank")
	-- pandora_mobs.print_replacements("thundermage")
	-- pandora_mobs.print_replacement("rat")
	-- pandora_mobs.print_replacement("frog")
	-- pandora_mobs.print_replacement("tentacler_small")
	-- pandora_mobs.print_replacement("iceskull")
	-- pandora_mobs.print_replacement("sniper")
	-- pandora_mobs.print_replacement("tank")
	-- pandora_mobs.print_replacement("phantom_a")
	-- pandora_mobs.print_replacement("phantom_b")
	-- pandora_mobs.print_replacement("thundermage")
end
