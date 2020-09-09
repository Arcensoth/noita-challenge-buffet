-- [v0.4.0]
-- Ideally this would be in a common library - a dependency of this mod. But since dependency
-- resolution is out-of-scope for Noita modding, we can just copy-paste the code into each mod.

local LOCAL_NAMESPACE = "io__github__arcensoth__nqn"
local LOCAL_FILESPACE = "__namespaced__/" .. LOCAL_NAMESPACE

-- @@ FILES

function namespace_file( value, namespace )
	return "data/" .. namespace .. "/" .. value
end

function namespace_local_file( value )
	return namespace_file( value, LOCAL_FILESPACE )
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
	return namespace_key( value, LOCAL_NAMESPACE )
end
