function add_perk(perk)
	table.insert(perk_list, perk)
end

function add_perks(perks)
	for key, perk in pairs(perks) do
		add_perk(perk)
	end
end
