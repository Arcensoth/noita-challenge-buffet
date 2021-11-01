dofile_once("data/scripts/lib/utilities.lua")

local utils = {}

utils.get_world_seed = function()
    return math.floor(tonumber(StatsGetValue("world_seed")))
end

utils.hash_string = function(s)
    -- https://stackoverflow.com/a/7666577
    local hash = 5381
    for i = 1, #s do
        local c = s:sub(i, i)
        local b = string.byte(c)
        hash = (hash * 33 + b) % 2147483647
    end
    return hash
end

return utils
