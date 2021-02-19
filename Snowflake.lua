--Other hacker Lua porting working for aimware
--Transplant personnel QI

--var
local background_alpha = 0
local snowflake_alpha = 0
local snowflakes = {}
local time = 0
local stored_time = 0
local screen = {draw.GetScreenSize()}

--function
local function clamp(min, max, val)
    if val > max then return max end
    if val < min then return min end
    return val
end

local function draw_Snowflake(x, y, size)
    local base = 4 + size
    draw.Color( 255, 255, 255, snowflake_alpha - 75)
    draw.Line(x - base, y - base, x + base + 1, y + base + 1)
    draw.Line(x - base, y - base, x + base, y + base)
    base = 5 + size
    draw.Line(x - base, y, x + base + 1, y)
    draw.Line(x, y - base, x, y + base + 1)
end

local function OnRender()

    local frametime = globals.FrameTime()
    time = time + frametime

    if background_alpha ~= 255 then
        background_alpha = clamp(0, 255, background_alpha + 10)
        snowflake_alpha = clamp(0, 255, snowflake_alpha + 10)
    end

    if not background_alpha ~= 0 then
        background_alpha = clamp(0, 255, background_alpha - 10)
        snowflake_alpha = clamp(0, 255, snowflake_alpha - 10)
    end

    if #snowflakes < 128 then
        if time > stored_time then
            stored_time = time

            table.insert(snowflakes, {
                math.random(10, screen[1] - 10),
                1,
                math.random(1, 3),
                math.random(-60, 60) / 100,
                math.random(-3, 0)
            })
        end
    end

    local fps = 1 / frametime

    for i = 1, #snowflakes do
        local snowflake = snowflakes[i]
        local x, y, vspeed, hspeed, size = snowflake[1], snowflake[2], snowflake[3], snowflake[4], snowflake[5]

        if screen[2] <= y then
            snowflake[1] = math.random(10, screen[1] - 10)
            snowflake[2] = 1
            snowflake[3] = math.random(1, 3)
            snowflake[4] = math.random(-60, 60) / 100
            snowflake[5] = math.random(-3, 0)
        end

        draw_Snowflake(x, y, size)

        snowflake[2] = snowflake[2] + vspeed / fps * 100
        snowflake[1] = snowflake[1] + hspeed / fps * 100
    end
    
end
callbacks.Register("Draw", OnRender)