-- [v0.1.0] Arcensoth's Logging Utilities
-- Ideally this would be in a common library - a dependency of this mod. But since dependency
-- resolution is out-of-scope for Noita modding, we can just copy-paste the code into each mod.

local ns = dofile("mods/io__github__arcensoth__nqn/files/namespacing.lua")

local log = {}

log.levels = {}

log.LEVEL_DEBUG = 1
log.LEVEL_INFO = 2
log.LEVEL_WARNING = 3
log.LEVEL_ERROR = 4
log.LEVEL_CRITICAL = 5

-- NOTE Set this to whatever level you want to log at.
log.LEVEL = log.LEVEL_DEBUG

log.DO_GAME_PRINT = DebugGetIsDevBuild()

log.LEVEL_NAMES = {
	"DEBUG",
	"INFO",
	"WARNING",
	"ERROR",
	"CRITICAL",
}

log.log_with_level = function(message, level)
	if (level >= log.LEVEL) then
		local text = "[" .. ns.LOCAL_NAMESPACE .. ":" .. log.LEVEL_NAMES[level] .. "] " .. message
		print(text)
		if (log.DO_GAME_PRINT) then
			GamePrint(text)
		end
	end
end

log.debug = function(message)
	log.log_with_level(message, log.LEVEL_DEBUG)
end

log.info = function(message)
	log.log_with_level(message, log.LEVEL_INFO)
end

log.warning = function(message)
	log.log_with_level(message, log.LEVEL_WARNING)
end

log.error = function(message)
	log.log_with_level(message, log.LEVEL_ERROR)
end

log.critical = function(message)
	log.log_with_level(message, log.LEVEL_CRITICAL)
end

return log
