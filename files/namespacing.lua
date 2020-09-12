-- [v0.5.0] Arcensoth's Namespacing Utilities
-- Ideally this would be in a common library - a dependency of this mod. But since dependency
-- resolution is out-of-scope for Noita modding, we can just copy-paste the code into each mod.

local ns = {}

-- NOTE Set these to whatever paths you want to namespace with.
ns.LOCAL_NAMESPACE = "io__github__arcensoth__nqn"
ns.LOCAL_FILESPACE = "__namespaced__/" .. ns.LOCAL_NAMESPACE

-- @@ FILES

function namespace_file( value, namespace )
	return "data/" .. namespace .. "/" .. value
end

function namespace_local_file( value )
	return namespace_file( value, ns.LOCAL_FILESPACE )
end

function namespace_vanilla_file( value )
	return "data/" .. value
end

function namespace_vanilla_sound( value )
	return "data/audio/Desktop/" .. value .. ".snd"
end

-- @@ KEYS

function namespace_key( value, namespace )
	return string.upper(namespace .. "__" .. value)
end

function namespace_local_key( value )
	return namespace_key( value, ns.LOCAL_NAMESPACE )
end

-- TODO update usage

ns.file = namespace_local_file
ns.key = namespace_local_key
ns.base_file = namespace_vanilla_file
ns.base_sound = namespace_vanilla_sound

return ns
