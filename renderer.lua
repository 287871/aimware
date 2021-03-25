local renderer = {
    version = 1.0,
    link = {
        ch = "https://aimware28.coding.net/p/coding-code-guide/d/aimware/git/raw/master/renderer.lua?download=false",
        en = "?"
    }
}

local math_modf = math.modf
local string_format = string.format

local function renderer_assert(expression, level, message, ...)
    if (not expression) then
        error(string_format(message, ...), level)
    end
end

--[[

syntax: renderer.text(x, y, r, g, b, a, flags, max_width, ...)

x - Screen coordinate

y - Screen coordinate

r - Red (0-255)

g - Green (0-255)

b - Blue (0-255)

a - Alpha (0-255)

string - Text that will be drawn

shadow - Shadow through true, no shadow through false


This can only be called from the paint callback.

]]
function renderer.text(x, y, r, g, b, a, string, shadow)
    local x, y = math_modf(x), math_modf(y)

    renderer_assert(type(x and y) == "number", 3, "'" .. tostring(x and y) .. "' must be a number.")

    renderer_assert(type(r and g and b and a) == "number", 3, "'" .. tostring(r and g and b and a) .. "' must be a number.")

    renderer_assert(type(string) == "string", 3, "'" .. tostring(string) .. "' must be a string.")

    renderer_assert(type(shadow) == "boolean", 3, "'" .. tostring(shadow) .. "' must be a boolean.")

    if shadow then
        draw.Color(0, 0, 0, a)
        draw.Text(x + 1, y + 1, string)
        draw.Color(r, g, b, a)
        draw.Text(x, y, string)
    else
        draw.Color(r, g, b, a)
        draw.Text(x, y, string)
    end
end
--[[

syntax: renderer_gradient(x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr)

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
    renderer.assert(type(x and y and w and h) == "number", 3, "'" .. tostring(x and y and w and h) .. "' must be a number.")

    renderer.assert(type(r1 and g1 and b1 and a1) == "number", 3, "'" .. tostring(r1 and g1 and b1 and a1) .. "' must be a number.")

    renderer.assert(type(r2 and g2 and b2 and a2) == "number", 3, "'" .. tostring(r2 and g2 and b2 and a2) .. "' must be a number.")

    renderer.assert(type(ltr) == "boolean", 3, "'" .. tostring(ltr) .. "' must be a boolean.")

    if ltr then
        if a1 ~= 0 then
            if a1 and a2 ~= 255 then
                for i = 0, w do
                    draw.Color(r1, g1, b1, i / h * a1)
                    draw.FilledRect(x + w - i, y, x + w - i + 1, y + h)
                end
            else
                draw.Color(r1, g1, b1, a1)
                draw.FilledRect(x, y, x + w, y + h)
            end
        end
        if a2 ~= 0 then
            for i = 0, w do
                draw.Color(r2, g2, b2, i / w * a2)
                draw.FilledRect(x + i - 1, y, x + i, y + h)
            end
        end
    else
        if a1 ~= 0 then
            if a1 and a2 ~= 255 then
                for i = 0, h do
                    draw.Color(r1, g1, b1, i / h * a1)
                    draw.FilledRect(x, y + h - i, x + w, y + h - i + 1)
                end
            else
                draw.Color(r1, g1, b1, a1)
                draw.FilledRect(x, y, x + w, y + h)
            end
        end
        if a2 ~= 0 then
            for i = 0, h do
                draw.Color(r2, g2, b2, i / w * a2)
                draw.FilledRect(x, y + i, x + w, y + i + 1)
            end
        end
    end
end

return renderer
