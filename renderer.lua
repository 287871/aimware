local math_sin = math.sin
local math_cos = math.cos
local math_rad = math.rad
local math_abs = math.abs
local math_modf = math.modf
local math_floor = math.floor
local math_pi = 3.1415926535898

local tostring = tostring
local string_len = string.len
local string_sub = string.sub
local string_gsub = string.gsub
local string_match = string.match
local string_format = string.format

local ipairs = ipairs
local table_insert = table.insert
local setmetatable = setmetatable
local tonumber = tonumber
local type = type

local draw_Line,
    draw_OutlinedRect,
    draw_RoundedRectFill,
    draw_ShadowRect,
    draw_GetScreenSize,
    draw_SetFont,
    draw_GetTextSize,
    draw_FilledCircle,
    draw_OutlinedCircle,
    draw_SetScissorRect,
    draw_FilledRect,
    draw_SetTexture =
    draw.Line,
    draw.OutlinedRect,
    draw.RoundedRectFill,
    draw.ShadowRect,
    draw.GetScreenSize,
    draw.SetFont,
    draw.GetTextSize,
    draw.FilledCircle,
    draw.OutlinedCircle,
    draw.SetScissorRect,
    draw.FilledRect,
    draw.SetTexture
local draw_UpdateTexture,
    draw_TextShadow,
    draw_CreateTexture,
    draw_Triangle,
    draw_AddFontResource,
    draw_Color,
    draw_RoundedRect,
    draw_CreateFont,
    draw_Text =
    draw.UpdateTexture,
    draw.TextShadow,
    draw.CreateTexture,
    draw.Triangle,
    draw.AddFontResource,
    draw.Color,
    draw.RoundedRect,
    draw.CreateFont,
    draw.Text
local common_DecodePNG, common_DecodeJPEG, common_RasterizeSVG = common.DecodePNG, common.DecodeJPEG, common.RasterizeSVG

renderer = renderer or {screen_size = draw_GetScreenSize}

local function math_round(number, precision)
    local mult = 10 ^ (precision or 0)
    return math_floor(number * mult + 0.5) / mult
end

local function assert(expression, message, level, ...)
    if (not expression) then
        error(string_format(message, ...), 4)
    end
end

local function bad_argument(expression, name, expected)
    assert(type(expression) == expected, " bad argument #1 to '%s' (%s expected, got %s)", 4, name, expected, tostring(type(expression)))
end

local dpi, dpi_scale = 0, {0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3}
local function renderer_font(flags)
    if flags:find("d") and dpi ~= dpi_scale[gui.GetValue("adv.dpi") + 1] or not font then
        dpi = dpi_scale[gui.GetValue("adv.dpi") + 1]
        font = {
            def = draw_CreateFont("Verdana", 15),
            default = {draw_CreateFont("Verdana", 15 * dpi), draw_CreateFont("Verdana", 15 * dpi, 600)},
            large = {draw_CreateFont("Verdana", 18 * dpi), draw_CreateFont("Verdana", 18 * dpi, 600)},
            centered = {draw_CreateFont("Verdana", 12 * dpi), draw_CreateFont("Verdana", 12 * dpi, 600)},
            segoe_ui = draw_CreateFont("segoe ui", 30, 600)
        }
    end

    draw_SetFont(font.default[1])
    if flags:find("b") then
        draw_SetFont(font.default[2])
    end

    if flags:find("+") then
        draw_SetFont(font.large[1])

        if flags:find("b") then
            draw_SetFont(font.large[2])
        end
    end

    if flags:find("-") then
        draw_SetFont(font.centered[1])

        if flags:find("b") then
            draw_SetFont(font.centered[2])
        end
    end
end

function renderer.color(...)
    local arg = {...}
    local color_list = {}

    if type(arg[1]) == "number" then
        for i, v in ipairs(arg) do
            table_insert(color_list, v)
        end
    elseif type(arg[1]) == "string" then
        local hex = string_gsub(..., "#", "")
        local index = 1
        while index < string_len(hex) do
            local hex_sub = string_sub(hex, index, index + 1)
            table_insert(color_list, tonumber(hex_sub, 16) or error("parameter of error", 2))
            index = index + 2
        end
    end

    local r = color_list[1] or 255
    local g = color_list[2] or 255
    local b = color_list[3] or 255
    local a = color_list[4] or 255

    draw_Color(r, g, b, a)
    return r, g, b, a
end

function renderer.measure_text(flags, ...)
    local arg = {...}
    local string = ""

    bad_argument(flags, "measure_text", "string")

    for i, v in ipairs(arg) do
        string = string .. tostring(v)
    end

    renderer_font(flags)

    local width, height = draw_GetTextSize(string)

    return width, height
end

function renderer.text(x, y, r, g, b, a, flags, ...)
    local arg = {...}
    bad_argument(x and y, "text", "number")
    bad_argument(flags, "text", "string")

    local x = math_round(x)
    local y = math_round(y)

    local string = ""

    for i, v in ipairs(arg) do
        string = string .. tostring(v)
    end

    renderer_font(flags)

    local w = renderer.measure_text(flags, ...)

    if flags:find("c") then
        x = x - math_round(w * 0.5)
    end
    if flags:find("r") then
        x = x - w
    end
    if flags:find("s") then
        renderer.color(0, 0, 0, a)
        draw_Text(x + 1, y + 1, string)
    end

    renderer.color(r, g, b, a)
    draw_Text(x, y, string)

    draw_SetFont(font.def)
    renderer.color()
end

function renderer.rectangle(x, y, w, h, r, g, b, a, flags, radius)
    bad_argument(x and y and w and h, "rectangle", "number")
    bad_argument(flags, "rectangle", "string")

    renderer.color(r, g, b, a)

    local w = (w < 0) and (x - math_abs(w)) or x + w
    local h = (h < 0) and (y - math_abs(h)) or y + h

    if flags:find("f") then
        draw_FilledRect(x, y, w, h)
    elseif flags:find("o") then
        draw_OutlinedRect(x, y, w, h)
    elseif flags:find("s") then
        draw_ShadowRect(x, y, w, h, radius or 0)
    end

    renderer.color()
end

function renderer.line(xa, ya, xb, yb, r, g, b, a)
    bad_argument(xa and ya and xb and yb, "line", "number")
    renderer.color(r, g, b, a)
    draw_Line(xa, ya, xb, yb)
    renderer.color()
end

function renderer.gradient(x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr)
    bad_argument(x and y and w and h, "gradient", "number")

    local abs_w = math_abs(w)
    local abs_h = math_abs(h)

    local rectangle = renderer.rectangle
    if ltr then
        if a1 ~= 0 then
            if a1 and a2 ~= 255 then
                for i = 1, abs_w do
                    local a1 = i / abs_w * a1
                    local x = (w < 0) and (x + w + i - 1) or (x + i - 1)
                    rectangle(x, y, 1, h, r1, g1, b1, a1, "f")
                end
            else
                rectangle(x, y, w, h, r1, g1, b1, a1, "f")
            end
        end

        if a2 ~= 0 then
            for i = 1, abs_w do
                local a2 = i / abs_w * a2
                local x = (w < 0) and (x - i) or (x + w - i)
                rectangle(x, y, 1, h, r2, g2, b2, a2, "f")
            end
        end
    else
        if a1 ~= 0 then
            if a1 and a2 ~= 255 then
                for i = 1, abs_h do
                    local a1 = i / abs_h * a1
                    local y = (h < 0) and (y + h + i - 1) or (y + i - 1)
                    rectangle(x, y, w, 1, r1, g1, b1, a1, "f")
                end
            else
                rectangle(x, y, w, h, r1, g1, b1, a1, "f")
            end
        end
        if a2 ~= 0 then
            for i = 1, abs_h do
                local a2 = i / abs_h * a2
                local y = (h < 0) and (y - i) or (y + h - i)
                rectangle(x, y, w, 1, r2, g2, b2, a2, "f")
            end
        end
    end
end

function renderer.circle(x, y, r, g, b, a, radius, flags)
    bad_argument(x and y and radius, "circle ", "number")
    bad_argument(flags, "circle", "string")

    renderer.color(r, g, b, a)

    if flags:find("f") then
        draw_FilledCircle(x, y, radius)
    elseif flags:find("o") then
        draw_OutlinedCircle(x, y, radius)
    end

    renderer.color()
end

function renderer.circle_outline(x, y, r, g, b, a, radius, start_degrees, percentage, thickness, radian)
    bad_argument(x and y and radius and start_degrees and percentage and thickness, "circle_outline", "number")

    local thickness = radius - thickness
    local percentage = math_abs(percentage * 360)
    local radian = radian or 1

    renderer.color(r, g, b, a)

    for i = start_degrees + radian, start_degrees + percentage, radian do
        local cos_1 = math_cos(i * math_pi / 180)
        local sin_1 = math_sin(i * math_pi / 180)
        local cos_2 = math_cos((i + radian) * math_pi / 180)
        local sin_2 = math_sin((i + radian) * math_pi / 180)

        local x0 = x + cos_2 * thickness
        local y0 = y + sin_2 * thickness
        local x1 = x + cos_1 * radius
        local y1 = y + sin_1 * radius
        local x2 = x + cos_2 * radius
        local y2 = y + sin_2 * radius
        local x3 = x + cos_1 * thickness
        local y3 = y + sin_1 * thickness

        draw_Triangle(x1, y1, x2, y2, x3, y3)
        draw_Triangle(x3, y3, x2, y2, x0, y + sin_2 * thickness)
    end
    renderer.color()
end

function renderer.triangle(x0, y0, x1, y1, x2, y2, r, g, b, a)
    bad_argument(x0 and y0 and x1 and y1 and x2 and y2, "triangle", "number")

    renderer.color(r, g, b, a)
    draw_Triangle(x0, y0, x1, y1, x2, y2)
    renderer.color()
end

function renderer.rectangle_rounded(x, y, w, h, r, g, b, a, radius, flags, tl, tr, bl, br)
    bad_argument(x and y and w and h and radius, "rectangle_rounded", "number")

    local tl = tl or 0
    local tr = tr or 0
    local bl = bl or 0
    local br = br or 0

    local w = (w < 0) and (x - math_abs(w)) or x + w
    local h = (h < 0) and (y - math_abs(h)) or y + h

    renderer.color(r, g, b, a)

    if flags:find("f") then
        draw_RoundedRectFill(x, y, w, h, radius, tl, tr, bl, br)
    elseif flags:find("o") then
        draw_RoundedRect(x, y, w, h, radius, tl, tr, bl, br)
    end

    renderer.color()
end

local indicator_object = {}

function renderer.new_indicator()
    local lp = entities.GetLocalPlayer()

    if not (lp and lp:IsAlive()) then
        return
    end

    local temp = {}

    local screen_size = {draw_GetScreenSize()}
    local y = screen_size[2] / 1.4105 - #temp * 35

    for i = 1, #indicator_object do
        table_insert(temp, indicator_object[i])
    end

    if (not font) then
        renderer_font()
    end

    draw_SetFont(font.segoe_ui)
    local gradient = renderer.gradient

    for i = 1, #temp do
        local __ind = temp[i]

        local w, h = draw_GetTextSize(__ind.string)

        gradient(12 + (w * 0.5), y - (h * 0.25), (w * 0.5), h * 2, 0, 0, 0, 0, 0, 0, 0, 50, true)
        gradient(12, y - (h * 0.25), (w * 0.5) + 0.5, h * 2, 0, 0, 0, 50, 0, 0, 0, 0, true)

        renderer.color(__ind.r, __ind.g, __ind.b, __ind.a)
        draw_Text(15, y, __ind.string)

        y = y - 35
    end

    indicator_object = {}

    renderer.color()
end

function renderer.indicator(r, g, b, a, ...)
    local arg = {...}
    local string = ""

    bad_argument(arg[1], "indicator", "string")

    for i, v in ipairs(arg) do
        string = string .. tostring(v)
    end

    local indicator = {}

    local i = #indicator_object + 1
    indicator_object[i] = {}

    setmetatable(indicator_object[i], indicator)

    indicator.__index = indicator
    indicator.r = r or 255
    indicator.g = g or 255
    indicator.b = b or 255
    indicator.a = a or 255
    indicator.string = string or ""

    return indicator_object[i]
end

function renderer.load_svg(contents, scale)
    local rgba, width, height = common_RasterizeSVG(contents or nil, scale or 1)
    local texture = draw_CreateTexture(rgba, width, height)
    return texture, {rgba, width, height}
end

function renderer.load_png(contents)
    local rgba, width, height = common_DecodePNG(contents)
    local texture = draw_CreateTexture(rgba, width, height)
    return texture, {rgba, width, height}
end

function renderer.load_jpg(contents)
    local rgba, width, height = common.DecodeJPEG(contents or nil)
    local texture = draw_CreateTexture(rgba, width, height)
    return texture, {rgba, width, height}
end

function renderer.texture(texture, x, y, w, h, r, g, b, a)
    bad_argument(x and y and w and h, "texture", "number")

    draw_SetTexture(texture)
    renderer.rectangle(x, y, w, h, r, g, b, a, "f")
    draw_SetTexture(nil)
end

return renderer
