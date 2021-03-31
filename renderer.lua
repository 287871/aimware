local renderer = {}

local math_modf = math.modf
local string_format = string.format
local string_match = string.match
local string_sub = string.sub
local math_sin = math.sin
local math_cos = math.cos
local math_rad = math.rad
local math_abs = math.abs

local function renderer_assert(expression, level, message, ...)
    if (not expression) then
        error(string_format(message, ...), level)
    end
end

--[[

syntax: renderer.create_font(name, height, weight)

name - Optional font name, Default to "verdana"

height - Optional font height, Default to 12

weight - Optional font weight, Default to 0

]]
function renderer.create_font(name, height, weight)
    if name then
        renderer_assert(type(name) == "string", 3, "'" .. tostring(string) .. "' must be a string.")
    end
    if height then
        renderer_assert(type(height) == "number", 3, "'" .. tostring(height) .. "' must be a number.")
    end
    if weight then
        renderer_assert(type(weight) == "number", 3, "'" .. tostring(weight) .. "' must be a number.")
    end

    return draw.CreateFont(name or "verdana", height or 12, weight or 0)
end

--[[

syntax: renderer.screen_size(name, height, weight)

Get game resolution settings, returns width, height.

]]
function renderer.screen_size()
    return draw.GetScreenSize()
end

--[[

syntax: renderer.set_font(name, height, weight)

Set current font for drawing. To be used with renderer.text

]]
function renderer.set_font(font)
    renderer_assert(type(font) == "userdata", 3, "Invalid font '" .. tostring(font) .. "'.")
    draw.SetFont(font)
end

--[[

syntax: renderer.color(color)

color - Hexadecimal color

Convert hex color

Return decision system color
]]
function renderer.color(color)
    local clr = string_match(color, [[#(........)]]) or renderer_assert(false, 3, "'" .. "'" .. tostring(color) .. "' wrong color parameter")
    local r = tonumber(string_match(clr, [[(..)]]), 16)
    local g = tonumber(string_match(clr, [[..(..)]]), 16)
    local b = tonumber(string_match(clr, [[....(..)]]), 16)
    local a = tonumber(string_match(clr, [[......(..)]]), 16)
    draw.Color(r, g, b, a)
    return r, g, b, a
end

--[[

syntax: renderer.text(x, y, r, g, b, a, string, mode)

x - Screen coordinate

y - Screen coordinate

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

string - Text that will be drawn

mode - String: "s" for shadows

This can only be called from the paint callback.

]]
function renderer.text(x, y, r, g, b, a, string, mode)
    local x, y = math_modf(x), math_modf(y)

    renderer_assert(type(x and y) == "number", 3, "'" .. tostring(x and y) .. "' must be a number.")

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    renderer_assert(type(string) == "string" ,3, "'" .. tostring(string) .. "' must be a string.")

    if mode == "s" then
        draw.Color(0, 0, 0, a)
        draw.Text(x + 1, y + 1, string)
        draw.Color(r, g, b, a)
        draw.Text(x, y, string)
    elseif mode == "" then
        draw.Color(r, g, b, a)
        draw.Text(x, y, string)
    else
        renderer_assert(false, 3, "'" .. "'" .. tostring(mode) .. "' wrong parameter mode")
    end

    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.measure_text(string, font)

string - Text that will be measured

font - Text font to be measured

Returns width, height. This can only be called from the paint callback.

]]
local default_font = draw.CreateFont("Verdana", 15)
function renderer.measure_text(string, font)
    renderer_assert(type(string) == "string", 3, "'" .. tostring(string) .. "' must be a string.")

    if font then
        renderer_assert(type(font) == "userdata", 3, "Invalid font '" .. tostring(font) .. "'.")
        draw.SetFont(font)
    end

    local w, h = draw.GetTextSize(string)
    draw.SetFont(default_font)
    return w, h
end

--[[

syntax: renderer.rectangle(x, y, w, h, r, g, b, a)

x - Screen coordinate

y - Screen coordinate

w - Width in pixels

h - Height in pixels

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

mode - String: "f" for filled, "o" for out lined, "s" for shadow

radius - Optional shadow rect radius

This can only be called from the paint callback.

]]
function renderer.rectangle(x, y, w, h, r, g, b, a, mode, radius)
    renderer_assert(type(x and y and w and h) == "number", 3, "'" .. tostring(x and y and w and h) .. "' must be a number.")

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    draw.Color(r, g, b, a)

    local w = (w < 0) and (x - math_abs(w)) or x + w
    local h = (h < 0) and (y - math_abs(h)) or y + h

    if mode == "f" then
        draw.FilledRect(x, y, w, h)
    elseif mode == "o" then
        draw.OutlinedRect(x, y, w, h)
    elseif mode == "s" then
        draw.ShadowRect(x, y, w, h, radius or 0)
    else
        renderer_assert(false, 3, "'" .. "'" .. tostring(mode) .. "' wrong parameter mode")
    end
    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.line(xa, ya, xb, yb, r, g, b, a)

xa - Screen coordinate of point A

ya - Screen coordinate of point A

xb - Screen coordinate of point B

yb - Screen coordinate of point B

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

This can only be called from the paint callback.

]]
function renderer.line(xa, ya, xb, yb, r, g, b, a)
    renderer_assert(type(xa and ya and xb and yb) == "number", 3, "'" .. tostring(xa and ya and xb and yb) .. "' must be a number.")

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    draw.Color(r, g, b, a)
    draw.Line(xa, ya, xb, yb)
    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.gradient(x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr)

x - Screen coordinate

y - Screen coordinate

w - Width in pixels

h - Height in pixels

r1 - Red (0-255)

g1 - Green (0-255)

b1 - Blue (0-255)

a1 - Alpha (0-255)

r2 - Red (0-255)

g2 - Green (0-255)

b2 - Blue (0-255)

a2 - Alpha (0-255)

ltr - Left to right. Pass true for horizontal gradient, or false for vertical.

This can only be called from the paint callback.

]]
function renderer.gradient(x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr)
    renderer_assert(type(x and y and w and h) == "number", 3, "'" .. tostring(x and y and w and h) .. "' must be a number.")

    renderer_assert(type(r1 and g1 and b1 and a1) == "number", 3, "'" .. tostring(r1 and g1 and b1 and a1) .. "' must be a number.")

    renderer_assert(type(r2 and g2 and b2 and a2) == "number", 3, "'" .. tostring(r2 and g2 and b2 and a2) .. "' must be a number.")

    renderer_assert(type(ltr) == "boolean", 3, "'" .. tostring(ltr) .. "' must be a boolean.")

    local abs_w = math_abs(w)
    local abs_h = math_abs(h)
    if ltr then
        if a1 ~= 0 then
            if a1 and a2 ~= 255 then
                for i = 1, abs_w do
                    local a1 = i / abs_w * a1
                    local x = (w < 0) and (x + w + i - 1) or (x + i - 1)
                    renderer.rectangle(x, y, 1, h, r1, g1, b1, a1, "f")
                end
            else
                renderer.rectangle(x, y, w, h, r1, g1, b1, a1, "f")
            end
        end

        if a2 ~= 0 then
            for i = 1, abs_w do
                local a2 = i / abs_w * a2
                local x = (w < 0) and (x - i) or (x + w - i)
                renderer.rectangle(x, y, 1, h, r2, g2, b2, a2, "f")
            end
        end
    else
        if a1 ~= 0 then
            if a1 and a2 ~= 255 then
                for i = 1, abs_h do
                    local a1 = i / abs_h * a1
                    local y = (h < 0) and (y + h + i - 1) or (y + i - 1)
                    renderer.rectangle(x, y, w, 1, r1, g1, b1, a1, "f")
                end
            else
                renderer.rectangle(x, y, w, h, r1, g1, b1, a1, "f")
            end
        end
        if a2 ~= 0 then
            for i = 1, abs_h do
                local a2 = i / abs_h * a2
                local y = (h < 0) and (y - i) or (y + h - i)
                renderer.rectangle(x, y, w, 1, r2, g2, b2, a2, "f")
            end
        end
    end

    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.circle(x, y, r, g, b, a, radius, mode)

x - Screen coordinate

y - Screen coordinate

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

radius - Radius of the circle in pixels.

mode - String: "f" for filled, "o" for out lined

This can only be called from the paint callback.

]]
function renderer.circle(x, y, r, g, b, a, radius, mode)
    renderer_assert(type(x and y) == "number", 3, "'" .. tostring(x and y) .. "' must be a number.")

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    renderer_assert(type(radius) == "number", 3, "'" .. tostring(radius) .. "' must be a number.")

    draw.Color(r, g, b, a)
    if mode == "f" then
        draw.FilledCircle(x, y, radius)
    elseif mode == "o" then
        draw.OutlinedCircle(x, y, radius)
    else
        renderer_assert(false, 3, "'" .. "'" .. tostring(mode) .. "' wrong parameter mode")
    end

    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.circle_outline(x, y, r, g, b, a, radius, start_degrees, percentage, thickness, cycle)

x - Screen coordinate

y - Screen coordinate

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

radius - Radius of the circle in pixels.

start_degrees - Under the default cycle, 0 is the right side, 90 is the bottom, 180 is the left, 270 is the top.

percentage - Must be within [0.0-1.0]. 1.0 is a full circle, 0.5 is a half circle, etc.

thickness - Thickness of the outline in pixels.

cycle - Number of cycles 1 = 360.

This can only be called from the paint callback.

]]
function renderer.circle_outline(x, y, r, g, b, a, radius, start_degrees, percentage, thickness, cycle)
    local cycle = cycle or 1
    renderer_assert(type(x and y) == "number", 3, "'" .. tostring(x and y) .. "' must be a number.")

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    renderer_assert(type(radius) == "number", 3, "'" .. tostring(radius) .. "' must be a number.")

    renderer_assert(type(start_degrees) == "number", 3, "'" .. tostring(start_degrees) .. "' must be a number.")

    renderer_assert(type(percentage) == "number", 3, "'" .. tostring(percentage) .. "' must be a number.")

    renderer_assert(type(thickness) == "number", 3, "'" .. tostring(thickness) .. "' must be a number.")

    renderer_assert(type(cycle) == "number", 3, "'" .. tostring(cycle) .. "' must be a number.")

    draw.Color(r, g, b, a)

    for steps = start_degrees, (math_abs(percentage) * 360) + start_degrees - 1, 1 do
        local steps = steps - 89
        local sin_cur = math_sin(math_rad(steps * cycle))
        local sin_old = math_sin(math_rad(steps * cycle - (cycle * 2)))
        local cos_cur = math_cos(math_rad(steps * cycle))
        local cos_old = math_cos(math_rad(steps * cycle - (cycle * 2)))

        local x_sin_cur = (percentage > 0) and (x - sin_cur * radius) or (x + sin_cur * radius)
        local x_sin_old = (percentage > 0) and (x - sin_old * radius) or (x + sin_old * radius)
        local x_sin_cur2 = (percentage > 0) and (x - sin_cur * (radius - thickness)) or (x + sin_cur * (radius - thickness))
        local x_sin_old2 = (percentage > 0) and (x - sin_old * (radius - thickness)) or (x + sin_old * (radius - thickness))

        local cur_point = {x_sin_cur, y + cos_cur * radius}
        local old_point = {x_sin_old, y + cos_old * radius}
        local cur_point2 = {x_sin_cur2, y + cos_cur * (radius - thickness)}
        local old_point2 = {x_sin_old2, y + cos_old * (radius - thickness)}

        draw.Triangle(math_modf(cur_point[1]), cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])
    end

    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.triangle(x0, y0, x1, y1, x2, y2, r, g, b, a)

x0 - Screen coordinate X for point A

y0 - Screen coordinate Y for point A

x1 - Screen coordinate X for point B

y1 - Screen coordinate Y for point B

x2 - Screen coordinate X for point C

y2 - Screen coordinate Y for point C

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

This can only be called from the paint callback.

]]
function renderer.triangle(x0, y0, x1, y1, x2, y2, r, g, b, a)
    renderer_assert(
        type(x0 and y0 and x1 and y1 and x2 and y2) == "number",
        3,
        "'" .. tostring(x0 and y0 and x1 and y1 and x2 and y2) .. "' must be a number."
    )

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    draw.Color(r, g, b, a)
    draw.Triangle(x0, y0, x1, y1, x2, y2)
    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.rounded_rect(x1, y1, x2, y2, r, g, b, a, radius, mode, tl, tr, bl, br)

x1 - Screen coordinate X for point A

y1 - Screen coordinate Y for point A

x2 - Screen coordinate X for point B

y2 - Screen coordinate Y for point B

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

radius - Radius of roundness

mode - String: "f" for filled, "o" for out lined

tl - Optional round top left corner

tr - Optional round top right corner

bl - Optional round bottom left corner

br - Optional round bottom right corner

This can only be called from the paint callback.

]]
function renderer.rectangle_rounded(x1, y1, x2, y2, r, g, b, a, radius, mode, tl, tr, bl, br)
    renderer_assert(type(x1 and y1 and x2 and y2) == "number", 3, "'" .. tostring(x1 and y1 and x2 and y2) .. "' must be a number.")

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    renderer_assert(type(radius) == "number", 3, "'" .. tostring(radius) .. "' must be a number.")

    local tl, tr, bl, br = tl or 0, tr or 0, bl or 0, br or 0

    draw.Color(r, g, b, a)
    if mode == "f" then
        draw.RoundedRectFill(x1, y1, x2, y2, radius, tl, tr, bl, br)
    elseif mode == "o" then
        draw.RoundedRect(x1, y1, x2, y2, radius, tl, tr, bl, br)
    else
        renderer_assert(false, 3, "'" .. "'" .. tostring(mode) .. "' wrong parameter mode")
    end
    draw.Color(255, 255, 255, 255)
end

--[[

syntax: renderer.world_to_screen(x, y, z)

x - Position in world space

y - Position in world space

z - Position in world space

Returns two screen coordinates (x, y), or nil if the world position is not visible on your screen. This can only be called from the paint callback.

]]
function renderer.world_to_screen(x, y, z)
    renderer_assert(type(x, y, z) == "number", 3, "'" .. tostring(x, y, z) .. "' must be a number.")
    local x, y = client.WorldToScreen(Vector3(x, y, z))
    return x, y
end

--[[

syntax: renderer.load_svg(contents, scale)

contents - SVG file contents

scale - Optional parameters set SVG scale

Returns a texture that can be used with renderer.texture and RGBA, width, height, or nil on failure

]]
function renderer.load_svg(contents, scale)
    local rgba, width, height = common.RasterizeSVG(contents or nil, scale or 1)
    local texture = draw.CreateTexture(rgba, width, height)
    return texture, rgba, width, height
end

--[[

syntax: renderer.load_png(contents)

contents - PNG file contents

Returns a texture that can be used with renderer.texture, or nil on failure

]]
function renderer.load_png(contents)
    local rgba, width, height = common.DecodePNG(contents or nil)
    local texture = draw.CreateTexture(rgba, width, height)
    return texture, rgba, width, height
end

--[[

syntax: renderer.load_jpg(contents)

contents - JPEG file contents

Returns a texture that can be used with renderer.texture, or nil on failure

]]
function renderer.load_jpg(contents)
    local rgba, width, height = common.DecodeJPEG(contents or nil)
    local texture = draw.CreateTexture(rgba, width, height)
    return texture, rgba, width, height
end

--[[

syntax: renderer.texture(texture, x, y, w, h)

texture - Loaded texture

x - X screen coordinate

y - Y screen coordinate

w - Width

h - Height

This can only be called from the paint callback.

]]
function renderer.texture(texture, x, y, w, h)
    renderer_assert(type(texture) == "userdata", 3, "Texture format error.")
    draw.SetTexture(texture)
    draw.FilledRect(x, y, x + w, y + h)
    draw.SetTexture(nil)
end

return renderer
