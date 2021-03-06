--local variables for API. Automatically generated by https://github.com/simpleavaster/gslua/blob/master/authors/sapphyrus/generate_api.lua
--I only made a little change to make him work for aimware. changed by qi
local to_dump = {
    {name = "entities", table = entities},
    {name = "client", table = client},
    {name = "globals", table = globals},
    {name = "callbacks", table = callbacks},
    {name = "common", table = common},
    {name = "draw", table = draw},
    {name = "gui", table = gui},
    {name = "input", table = input},
    {name = "engine", table = engine},
    {name = "file", table = file},
    {name = "http", table = http},
    {name = "vector", table = vector},
    {name = "network", table = network},
    {name = "materials", table = materials},
    {name = "panorama", table = panorama},
    {name = "math", table = math},
    {name = "table", table = table},
    {name = "string", table = string}
}
local table_insert = table.insert
local table_remove = table.remove
local table_concat = table.concat
local string_len = string.len
local math_ceil = math.ceil

local function get_n_elements(table, n, start)
    local new_table = {}
    local start = start or 1
    for i = start, n do
        local element = table[i]
        if element ~= nil then
            table_insert(new_table, element)
        end
    end
    return new_table
end

function array_sub(t1, t2)
    local t = {}
    for i = 1, #t1 do
        t[t1[i]] = true
    end
    for i = #t2, 1, -1 do
        if t[t2[i]] then
            table_remove(t2, i)
        end
    end
end

local function log_raw(message)
    print("Copy and paste this into your script:")
    client.Command('echo "' .. message .. '"', true)
end

local function dump_api()
    log_raw(
        " --local variables for API. Automatically generated by https://github.com/simpleavaster/gslua/blob/master/authors/sapphyrus/generate_api.lua\n"
    )
    log_raw(" --I only made a little change to make him work for aimware ")

    for i = 1, #to_dump do
        local global = to_dump[i]["table"]
        local name = to_dump[i]["name"]
        local part1 = {}
        local part2 = {}
        local amt = 0
        for i, v in pairs(global) do
            table_insert(part1, name .. "_" .. i)
            table_insert(part2, name .. "." .. i)
            amt = amt + 1
        end
        local message = "local " .. table_concat(part1, ", ") .. " = " .. table_concat(part2, ", ")
        local messages = {}

        local parts = 1
        if string_len(message) > 450 then
            parts = math_ceil(string_len(message) / 450)
        end

        local split_at = math.floor(#part1 / parts)
        local start = 0

        for i = 1, parts do
            local split_at_temp = split_at * i + 2
            local part1_1, part2_1 = get_n_elements(part1, split_at_temp, start + 1), get_n_elements(part2, split_at_temp, start + 1)
            table_insert(messages, "local " .. table_concat(part1_1, ", ") .. " = " .. table_concat(part2_1, ", "))
            start = split_at_temp
        end
        for i = 1, #messages do
            log_raw(messages[i])
        end
    end
    log_raw("--end of local variables")
end

dump_api()
