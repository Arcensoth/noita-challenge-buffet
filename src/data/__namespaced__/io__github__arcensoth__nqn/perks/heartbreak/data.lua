dofile_once("mods/io__github__arcensoth__nqn/files/namespacing.lua")
dofile_once(namespace_local_file("perks/heartbreak/init.lua"))

HEARTBREAK_PERK_DATA = {
	id = namespace_local_key("heartbreak"),
	ui_name = "Heartbreak",
	ui_description = "You are cursed: maximum health can no longer be increased",
	ui_icon = namespace_local_file("perks/heartbreak/icon.png"),
	perk_icon = namespace_local_file("perks/heartbreak/item.png"),
	stackable = false,
	usable_by_enemies = false,
	func = heartbreak_perk_init,
}
