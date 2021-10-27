-- [v0.5.0] Arcensoth's Namespacing Utilities
-- Ideally this would be in a common library - a dependency of this mod. But since dependency
-- resolution is out-of-scope for Noita modding, we can just copy-paste the code into each mod.

local ns = {}

-- NOTE Set this to whatever you want to use as a namespace.
ns.NAMESPACE = "challenge_buffet"

ns.base_file = function(value)
	return "data/" .. value
end

ns.base_sound = function(value)
	return "data/audio/Desktop/" .. value
end

ns.file = function(value)
	return "mods/" .. ns.NAMESPACE .. "/files/" .. value
end

ns.key = function(value)
	return string.upper(ns.NAMESPACE .. "__" .. value)
end

return ns
