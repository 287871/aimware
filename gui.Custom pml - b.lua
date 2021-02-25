--[[
Working on aimware
Making gui.custom based on aw
by qi
]]
--@There is an example already on line 446
--@gui reference
--[[
gui_custom_pml_window
gui_custom_pml_main
gui_custom_pml_lua
gui_custom_pml_set
]]
--var
local renderer = {}
local dpi, dpi_scale, fonts = 0, {0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3}, {}
local b64_aimware =
    [[
        "iVBORw0KGgoAAAANSUhEUgAAAHgAAAB4CAYAAAA5ZDbSAAAACXBIWXMAAC4jAAAuIwF4pT92AAAFwmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDIgNzkuMTYwOTI0LCAyMDE3LzA3LzEzLTAxOjA2OjM5ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpIiB4bXA6Q3JlYXRlRGF0ZT0iMjAyMC0wNi0xOFQxNDo0ODo1MSswMjowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMC0wNi0xOFQxNDo0ODo1MSswMjowMCIgeG1wOk1vZGlmeURhdGU9IjIwMjAtMDYtMThUMTQ6NDg6NTErMDI6MDAiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6ZTM3ODA4YTUtZDIxYi1lOTQ1LWJiODUtNTk3OTUxZjM5MzIzIiB4bXBNTTpEb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6OTM4ZDBmNWItNTNkMi0wYjRkLWFhZDItZjBl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"
    ]]
local b64_avatars =
    [[
        "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"
    ]]
local svg = {
    ["main"] = {
        '<svg t="1614224032795" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2116" width="48" height="48"><path d="M847.954845 559.202258c-76.872248-62.952399-153.407338-126.290122-230.13509-189.435184l-105.867921-87.17968c-3.034431 2.167451-5.731703 4.045908-8.139981 6.020696-110.395484 90.98476-220.790969 181.96952-330.89746 273.243274a23.649294 23.649294 0 0 0-6.935842 16.231797 48122.798119 48122.798119 0 0 0-0.337159 276.566698c0 28.562183 15.172154 43.397178 44.071496 43.397178h212.795485c3.756914 0 7.61016-0.529821 12.474882-0.818815v-229.460771h153.214675v230.23142h224.018062c31.114958 0 45.371966-14.449671 45.371967-45.709125 0.144497-90.647601-0.096331-181.247037 0.240827-271.701976a24.853434 24.853434 0 0 0-9.873941-21.385512z m134.959925-62.422578l0.288993-0.192662c16.95428 14.016181 17.676764 22.204327 3.612418 38.965945-9.055127 10.789087-18.062088 21.481844-27.020885 32.319097-13.245532 15.65381-21.915334 16.617121-37.376481 3.756915a1262199.980433 1262199.980433 0 0 0-410.418815-342.457197 1752169.723424 1752169.723424 0 0 0-410.081656 342.168203c-15.701976 13.052869-24.323612 12.28222-37.520978-3.323424l-26.153904-31.355786c-15.364817-18.15842-14.738664-25.768579 3.227093-40.699906 62.229915-51.826152 124.411665-103.652305 186.545249-155.526622L458.054563 148.831609c36.894826-30.633302 71.236877-30.536971 107.987206 0l125.519473 104.904609c3.275259 2.793603 6.74318 5.394544 12.763876 10.259266V184.47413c0-11.945061-0.288993-23.986453 0.240827-36.076011 0.385325-13.486359 6.839511-20.036877 20.133208-20.133208h56.064723c18.206585 0 38.0508 0 56.642709 0.192662 14.738664 0.096331 20.374036 7.273001 20.374036 24.901599 0 72.489182 0.529821 145.12286-0.43349 217.612042-0.240828 16.183631 4.575729 26.250235 17.050611 36.220508 36.750329 29.140169 72.344685 59.580809 108.517028 89.587958z" p-id="2117" fill="#ffffff"></path></svg>'
    },
    ["lua"] = {
        '<svg t="1614225139315" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="5262" width="64" height="64"><path d="M979.180759 554.921339c-29.860191-37.160386-67.743498-61.067219-113.603222-71.729838 14.589183-22.403082 21.863226-46.935699 21.863227-73.597852 0-37.690902-13.335746-69.865561-39.992295-96.535186-26.662152-26.660284-58.83868-39.99603-96.529582-39.99603-34.130469 0-63.645077 11.023146-88.525145 33.069437-20.968448-50.488661-54.312484-91.377601-99.992878-122.666822-45.691603-31.281749-96.628586-46.933831-152.807215-46.933832-75.372464 0-139.731123 26.67336-193.064768 80.007005-53.337381 53.320569-79.997665 117.682963-79.997665 193.061032 0 5.335046 0.356791 12.973352 1.066636 22.929862-41.241995 19.201308-74.488894 48.265725-99.731357 87.210064C12.625901 558.661102 0 601.602989 0 648.53682c0 65.774613 23.381921 122.042906 70.132687 168.791804 46.752634 46.761974 103.020928 70.140159 168.797408 70.14016h580.272147c56.524211 0 104.788068-20.015761 144.793438-60.002452 39.999766-39.997898 60.002452-88.261755 60.002452-144.799043-0.005604-47.996731-14.945974-90.596772-44.817373-127.74595z" p-id="5263" fill="#ffffff"></path></svg>'
    },
    ["set"] = {
        '<svg t="1614225312902" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="21085" width="200" height="200"><path d="M911.96 1000.405c-114.653 60.002-254.668-18.468-270.645-148-3.19-25.403-2.595-50.761 5.942-74.92 3.85-11.131 1.05-17.522-6.586-25.209a132435.64 132435.64 0 0 1-370.924-370.673c-8.437-8.49-15.177-9.908-27.003-6.59C136.87 404.81 26.856 338.222 5.037 230.409-3 190.695-0.603 150.665 18.07 113.252c8.08-1.272 10.58 5.37 14.376 9.21 36.485 36.089 72.475 72.68 109.064 108.62 30.85 30.247 68.035 31.993 95.189 5.312 26.652-26.23 25.163-64.867-4.691-95.193C192.371 101 152.191 61.341 109.56 18.76c59.604-24.435 115.856-25.63 171.268 3.268 78.816 41.086 119.346 134.178 94.837 219.584-3.796 13.277-0.65 20.09 7.936 28.676 122.792 122.314 245.388 244.782 367.58 367.63 9.836 9.836 17.915 10.48 30.993 7.384 74.23-17.667 139.474 0.901 190.53 57.409 48.972 54.302 63.048 118 38.885 188.68-5.29 15.37-8.681 21.562-23.308 6.09-35.795-37.74-73.024-74.175-110.265-110.615-19.468-19.067-42.881-26.809-69.49-16.772-23.457 8.886-37.384 26.403-40.63 51.512-3.095 24.157 7.237 43.075 24.015 59.598 39.635 39.134 79.07 78.564 120.044 119.2h0.006z m0 0" p-id="21086" fill="#ffffff"></path><path d="M1.897 922.44c-3.096-24.108 7.785-45.727 25.802-63.794C128.934 756.917 230.661 655.539 331.99 553.81c7.187-7.234 11.182-8.735 19.219-0.5 38.48 39.336 77.52 78.215 116.9 116.65 7.541 7.492 7.886 11.583 0.15 19.274-101.879 101.178-202.607 203.451-305.33 303.885-49.672 48.565-124.197 35.09-153.596-24.958-6.69-13.678-7.435-17.774-7.435-45.722z m645.214-480.667c-3.545-3.018-6.985-5.618-10.031-8.636-15.872-15.7-31.049-32.116-47.52-47.043-10.038-9.037-7.837-14.305 0.745-22.64 37.734-36.841 73.923-75.398 112.464-111.41 30.293-28.376 56.802-59.203 70.93-98.26 22.362-61.694 63.193-103.03 124.88-125.115 19.373-6.963 37.99-25.88 55.863-24.586 18.318 1.323 29.198 27.504 45.67 39.858 20.218 15.127 22.169 28.976 8.236 50.967-19.011 29.95-33.839 62.671-49.515 94.665-5.591 11.404-12.877 19.267-24.559 24.08-86.056 35.268-157.83 89.997-218.678 159.981-18.073 20.69-38.635 39.113-58.208 58.526-3.135 3.073-6.487 6.018-10.277 9.613z m0 0" p-id="21087" fill="#ffffff"></path></svg>'
    },
    ["help"] = {
        '<svg t="1614225440385" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="26819" width="200" height="200"><path d="M509.324 727.044c-35.275 0-63.79 28.020-63.79 62.494 0 34.478 28.618 62.495 63.79 62.495 35.267 0 63.783-28.017 63.783-62.495 0-34.474-28.618-62.494-63.783-62.494z" p-id="26820" fill="#ffffff"></path><path d="M648.316 331.12c-33.981-30-79.579-45.005-137.009-45.005-54.543 0-98.652 14.807-132.24 44.413-33.581 29.606-53.156 70.437-54.247 108.096-1.091 37.654 88.422 29.805 91.702 11.227 3.478-19.673 18.182-51.467 35.273-65.87 17.087-14.407 38.351-21.662 63.786-21.662 26.327 0 47.391 6.958 62.891 20.769 15.5 13.909 23.344 30.498 23.344 49.87 0 13.914-4.467 26.731-13.21 38.354-5.666 7.349-23.15 22.849-52.262 46.595-29.113 23.647-48.587 45.006-58.321 63.984-9.738 18.977-14.603 43.12-14.603 72.524 0 2.882 0.199 10.833 0.397 23.852h90.805c-0.494-27.522 1.892-46.603 6.958-57.23 5.069-10.731 18.181-24.837 39.246-42.323 40.731-33.881 67.263-60.605 79.777-80.278 12.419-19.673 18.677-40.538 18.581-62.597 0-39.838-16.893-74.714-50.87-104.718z" p-id="26821" fill="#ffffff"></path></svg>'
    }
}

--64Bit to Png Decoder
local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function dec(data)
    data = string.gsub(data, "[^" .. b .. "=]", "")
    return (data:gsub(
        ".",
        function(x)
            if (x == "=") then
                return ""
            end
            local r, f = "", (b:find(x) - 1)
            for i = 6, 1, -1 do
                r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ):gsub(
        "%d%d%d?%d?%d?%d?%d?%d?",
        function(x)
            if (#x ~= 8) then
                return ""
            end
            local c = 0
            for i = 1, 8 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
            end
            return string.char(c)
        end
    ))
end

--jpg
local avatars_dec = dec(b64_avatars)
local avatars_rgba, avatars_width, avatars_height = common.DecodeJPEG(avatars_dec)
local avatars_texture = draw.CreateTexture(avatars_rgba, avatars_width, avatars_height)

--png
local aimware_dec = dec(b64_aimware)
local aimware_rgba, aimware_w, aimware_h = common.DecodePNG(aimware_dec)
local aimware_texture = draw.CreateTexture(aimware_rgba, aimware_w, aimware_h)

--svg
local main_rgba, main_width, main_height = common.RasterizeSVG(svg.main[1])
local main_texture = draw.CreateTexture(main_rgba, main_width, main_height)

local lua_rgba, lua_width, lua_height = common.RasterizeSVG(svg.lua[1])
local lua_texture = draw.CreateTexture(lua_rgba, lua_width, lua_height)

local set_rgba, set_width, set_height = common.RasterizeSVG(svg.set[1])
local set_texture = draw.CreateTexture(set_rgba, set_width, set_height)

local help_rgba, help_width, help_height = common.RasterizeSVG(svg.help[1])
local help_texture = draw.CreateTexture(help_rgba, help_width, help_height)

--font
callbacks.Register(
    "Draw",
    "dpi",
    function()
        if dpi ~= dpi_scale[gui.GetValue("adv.dpi") + 1] then
            dpi = dpi_scale[gui.GetValue("adv.dpi") + 1]
            fonts = {
                text = draw.CreateFont("Bahnschrift", 22 * dpi),
                text2 = draw.CreateFont("Bahnschrift", 18 * dpi, 10000)
            }
        end
    end
)

--Set Gui Location
local function SetGuiLocation(GuiObject, x, y, w, h)
    GuiObject:SetPosX(x)
    GuiObject:SetPosY(y)
    GuiObject:SetWidth(w)
    GuiObject:SetHeight(h)
end

--renderer
renderer.text = function(x, y, clr, shadow, string, font, flags)
    local alpha = 255
    if font then
        draw.SetFont(font)
    end
    local textW, textH = draw.GetTextSize(string)
    if clr[4] then
        alpha = clr[4]
    end
    if flags == "l" then
        x = x - textW
    elseif flags == "r" then
        x = x + textW
    elseif flags == "lc" then
        x = x - (textW / 2)
    elseif flags == "rc" then
        x = x + (textW / 2)
    end
    if shadow then
        draw.Color(0, 0, 0, alpha)
        draw.Text(x + 1, y + 1, string)
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    draw.Text(x, y, string)
end

renderer.rectangle = function(x, y, w, h, clr, fill, radius)
    local alpha = 255
    if clr[4] then
        alpha = clr[4]
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    if fill then
        draw.FilledRect(x, y, x + w, y + h)
    else
        draw.OutlinedRect(x, y, x + w, y + h)
    end
    if fill == "s" then
        draw.ShadowRect(x, y, x + w, y + h, radius)
    end
end

renderer.gradient = function(x, y, w, h, clr, clr1, vertical)
    local r, g, b, a = clr1[1], clr1[2], clr1[3], clr1[4]
    local r1, g1, b1, a1 = clr[1], clr[2], clr[3], clr[4]

    if a and a1 == nil then
        a, a1 = 255, 255
    end

    if vertical then
        if clr[4] ~= 0 then
            if a1 and a ~= 255 then
                for i = 0, w do
                    renderer.rectangle(x, y + w - i, w, 1, {r1, g1, b1, i / w * a1}, true)
                end
            else
                renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
            end
        end
        if a2 ~= 0 then
            for i = 0, h do
                renderer.rectangle(x, y + i, w, 1, {r, g, b, i / h * a}, true)
            end
        end
    else
        if clr[4] ~= 0 then
            if a1 and a ~= 255 then
                for i = 0, w do
                    renderer.rectangle(x + w - i, y, 1, h, {r1, g1, b1, i / w * a1}, true)
                end
            else
                renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
            end
        end
        if a2 ~= 0 then
            for i = 0, w do
                renderer.rectangle(x + i, y, 1, h, {r, g, b, i / w * a}, true)
            end
        end
    end
end

renderer.circle = function(x, y, radius, clr, fill)
    local alpha = 255
    if clr[4] then
        alpha = clr[4]
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    if fill then
        draw.FilledCircle(x, y, radius)
    else
        draw.OutlinedCircle(x, y, radius)
    end
end

renderer.triangle = function(x, y, w, h, w1, h1, clr)
    local alpha = 255

    if clr[4] then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    draw.Triangle(x, y, x - w, y + h, x + w1, y + h1)
end

renderer.roundedrect = function(x, y, w, h, fill, radius, clr, tl, tr, bl, br)
    local alpha = 255
    if clr[4] then
        alpha = clr[4]
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    if fill then
        draw.RoundedRectFill(x, y, x + w, y + h, radius, tl, tr, bl, br)
    else
        draw.RoundedRect(x, y, x + w, y + h, radius, tl, tr, bl, br)
    end
end

renderer.circle_smooth = function(x, y, radius, clr)
    local alpha = 255
    if clr[4] then
        alpha = clr[4]
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    for i = 0, radius * 0.61 do
        local a2 = i / radius * alpha
        renderer.circle(x, y, radius + i * 0.5, {clr[1], clr[2], clr[3], 255})
    end
end
renderer.circle_smooth_a = function(x, y, radius, clr)
    local alpha = 255
    if clr[4] then
        alpha = clr[4]
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    for i = 0, radius * 0.2 do
        local a2 = i / radius * alpha
        renderer.circle(x, y, radius * 0.95 + i * 0.2, {clr[1], clr[2], clr[3], a2})
        renderer.circle(x, y, radius - i * 0.2, {clr[1], clr[2], clr[3], a2})
    end
end

--return Dpi
local function Dpi() -- 18 25 30 37 43 49 55 60 66 73
    local dpi = gui.GetValue("adv.dpi")
    if dpi == 0 then
        return 18
    elseif dpi == 1 then
        return 25
    elseif dpi == 2 then
        return 30
    elseif dpi == 3 then
        return 37
    elseif dpi == 4 then
        return 43
    elseif dpi == 5 then
        return 49
    elseif dpi == 6 then
        return 55
    elseif dpi == 7 then
        return 60
    elseif dpi == 8 then
        return 66
    elseif dpi == 9 then
        return 73
    end
end
callbacks.Register(
    "Draw",
    function()
        Dpi()
    end
)

-- Mouse position check
local function is_in_rect(x, y, x1, y1, x2, y2)
    return x >= x1 and x < x2 and y >= y1 and y < y2
end
--draw window
local function DrawWindow(parent, x, y, w, h, name, clr, clr2)
    local function update(x, y, w, h)
        --x,y
        local mouse_x, mouse_y = input.GetMousePos()
        local parent_x, parent_y = parent:GetValue()
        local dpi = Dpi()
        --clr
        local r, g, b, a = clr[1], clr[2], clr[3], clr[4]
        local r2, g2, b2, a2 = clr2[1], clr2[2], clr2[3], clr2[4]

        renderer.roundedrect(x, y, w - x, h - y, true, 10, {r, g, b, a}, 0, 0, 10, 10)
        renderer.roundedrect(x, y - dpi - 3, w - x, dpi, true, 10, {r2, g2, b2, a2}, 1, 1, 0, 0)
        renderer.roundedrect(x, y - dpi - 3, w - x, dpi, true, 10, {r2, g2, b2, a2}, 1, 1, 0, 0)
        renderer.roundedrect(x, y - 3, w - x, 3, true, 0, {255, 255, 255, 255}, 1, 1, 0, 0)
        renderer.text(x + dpi * 0.5, y - dpi * 0.9, {r, g, b, a}, nil, name, fonts.text)
    end
    local custom = gui.Custom(parent, "", x, y, w, h, update)
end

--draw window tab
local function DrawWindowTab(texture, tl, tr, bl, br, type)
    return function(x1, y1, x2, y2, active)
        local mx, my = input.GetMousePos()
        local dpi = Dpi()

        if type then
            draw.Color(221, 225, 255, 255)
            draw.SetTexture(texture)
            draw.FilledRect(x1 + dpi * 0.5, y1 + dpi * 0.8, x1 + dpi * 3.3, y1 + dpi * 3.7)
        else
            draw.Color(221, 225, 224, 255)
            draw.RoundedRectFill(x1, y1, x2, y2, 10, tl, tr, bl, br)
            if is_in_rect(mx, my, x1, y1, x2, y2) then
                draw.Color(106, 106, 106, 255)
            else
                draw.Color(255, 255, 255, 255)
            end
            draw.SetTexture(texture)
            draw.FilledRect(x1 + dpi * 1.1, y1 + dpi * 0.7, x1 + dpi * 2.6, y1 + dpi * 2.3)
            if texture == lua_texture then
                if is_in_rect(mx, my, x1, y1, x2, y2) then
                    renderer.text(x1 + dpi * 1.35, y1 + dpi * 1.3, {221, 225, 224, 255}, nil, "Lua", fonts.text2)
                else
                    renderer.text(x1 + dpi * 1.35, y1 + dpi * 1.3, {180, 180, 180, 255}, nil, "Lua", fonts.text2)
                end
            end
        end
    end
end

-- draw tab bgd
local function DrawTab(parent, x, y, w, h, clr, clr2, font)
    local function update(x, y, w, h)
        --x,y
        local mouse_x, mouse_y = input.GetMousePos()
        local parent_x, parent_y = parent:GetValue()
        local dpi = Dpi()
        --clr
        local r, g, b, a = clr[1], clr[2], clr[3], clr[4]
        local r2, g2, b2, a2 = clr2[1], clr2[2], clr2[3], clr2[4]

        renderer.roundedrect(x, y, w - x + 1, h - y, true, 10, {r2, g2, b2, a2}, 0, 0, 10, 0)
        renderer.roundedrect(x + 1, y, w - x - 1, h - y, true, 10, {r, g, b, a}, 0, 0, 10, 0)
    end
    local custom = gui.Custom(parent, "", x, y, w, h, update)
end

--window
local window = gui.Window("guimenu", "GUI Menu", 300, 10, 714, 500)
local draw_window_bgd = DrawWindow(window, 0, 0, 714, 500, "aimware", {106, 106, 106, 255}, {221, 225, 224, 255})

--groubox
local main_Groupbox = gui.Groupbox(window, "Main", 0, 0, 0, 0)
SetGuiLocation(main_Groupbox, 119.5, 25, 572.8, 442.8)

local lua_Groupbox = gui.Groupbox(window, "Lua", 0, 0, 0, 0)
SetGuiLocation(lua_Groupbox, 119.5, 25, 572.8, 442.8)

local set_Groupbox = gui.Groupbox(window, "Settings", 0, 0, 0, 0)
SetGuiLocation(set_Groupbox, 119.5, 25, 572.8, 442.8)

main_Groupbox:SetInvisible(false)
lua_Groupbox:SetInvisible(true)
set_Groupbox:SetInvisible(true)

local function main()
    main_Groupbox:SetInvisible(false)
    lua_Groupbox:SetInvisible(true)
    set_Groupbox:SetInvisible(true)
end
local main = gui.Button(window, "main", main)
SetGuiLocation(main, 1, 116, 96, 71)

local function lua()
    main_Groupbox:SetInvisible(true)
    lua_Groupbox:SetInvisible(false)
    set_Groupbox:SetInvisible(true)
end
local lua = gui.Button(window, "lua", lua)
SetGuiLocation(lua, 1, 187, 96, 71)

local function set()
    main_Groupbox:SetInvisible(true)
    lua_Groupbox:SetInvisible(true)
    set_Groupbox:SetInvisible(false)
end
local set = gui.Button(window, "set", set)
SetGuiLocation(set, 1, 258, 96, 71)

local function help()
    main_Groupbox:SetInvisible(true)
    lua_Groupbox:SetInvisible(true)
    set_Groupbox:SetInvisible(true)
    panorama.RunScript([[
        SteamOverlayAPI.OpenExternalBrowserURL("https://aimware.net/forum/thread/148735");
    ]])
end
local help = gui.Button(window, "help", help)
SetGuiLocation(help, 1, 425, 96, 71)

local draw_Tab_bgd = DrawTab(window, 0, 0, 96, 500, {221, 225, 224, 255}, {255, 255, 255, 255})

--
local draw_user_tab = gui.Custom(window, "tab.user", 0, 0, 96, 71, DrawWindowTab(avatars_texture, 0, 0, 0, 0, true))
local draw_main_tab = gui.Custom(window, "tab.main", 0, 116, 96, 71, DrawWindowTab(main_texture, 0, 0, 0, 0))
local draw_lua_tab = gui.Custom(window, "tab.lua", 0, 187, 96, 71, DrawWindowTab(lua_texture, 0, 0, 0, 0))
local draw_set_tab = gui.Custom(window, "tab.set", 0, 258, 96, 71, DrawWindowTab(set_texture, 0, 0, 0, 0))
local draw_help_tab = gui.Custom(window, "tab.help", 0, 425, 96, 75, DrawWindowTab(help_texture, 0, 0, 1, 0))

local open_menu_key_ref = gui.Reference("Settings", "Advanced", "Manage advanced settings")
local open_menu_key = gui.Keybox(open_menu_key_ref, "open.customgui.key", "Open Custom Gui Menu Key", 46)
open_menu_key:SetDescription("Bind for custom gui menu toggle")

callbacks.Register(
    "Draw",
    function()
        window:SetOpenKey(open_menu_key:GetValue())
    end
)

--@gui reference
gui_custom_pml_window = window
gui_custom_pml_main = main_Groupbox
gui_custom_pml_lua = lua_Groupbox
gui_custom_pml_set = set_Groupbox

--gui.Custom end

----------------------------------quick peek

--English
--@Original code ferrariboi https://aimware.net/forum/user/306847
--modify Qi
--I won't go back when he's hurt --weapon_fire
--Open after shooting Speed Burst,Need to open Speed Burst --cheat.RequestSpeedBurst()
--Add excessive animation, which is suitable for my custom gui and works for the original menu
--Original menu location MISC > Movement > Other  My custom GUI location <LUA>  --https://aimware.net/forum/thread/148735
--Also fixed some minor bugs

--中文
--@原代码来自 ferrariboi https://aimware.net/forum/user/306847
--改动者 柒
--现在只有开火时会回去 切枪和受到伤害不会触发命令 --weapon_fire
--开枪后启用闪现,需要打开闪现
--添加过度动画，他适用于我的自定义gui pml 上 也可为原菜单工作
--原菜单位置 MISC > Movement > Other  我的定义gui pml 位置 <LUA> luaQQ交流群：1093993910 --群文件
--还修复了一些小错误

--inspect
local quick_peek_ref = gui.Reference("MISC", "Movement", "Other")
if pcall(gui.GetValue, "adv.open.customgui.key") then
    quick_peek_ref = gui_custom_pml_lua
end

--var
local peek_abs_origin = {}
local is_peeking = false
local has_shot = false
local peek_alpha = 0

-- gui
local quick_peek = gui.Checkbox(quick_peek_ref, "quick.peek", "Quick peek", 0)
quick_peek:SetDescription("Return to the original position after firing.")
local quick_peek_clr = gui.ColorPicker(quick_peek, "clr", "clr", 115, 115, 115, 200)
local quick_peek_clr2 = gui.ColorPicker(quick_peek, "clr2", "clr2", 255, 255, 255, 200)

--alpha
local function alpha_stop(val, min, max)
    if val < min then
        return min
    end
    if val > max then
        return max
    end
    return val
end

-- DrawCircle
local function DrawCircle(pos, radius)
    local WorldToScreen = client.WorldToScreen
    local center = {WorldToScreen(Vector3(pos.x, pos.y, pos.z))}
    local r, g, b, a = quick_peek_clr:GetValue()
    local r2, g2, b2, a2 = quick_peek_clr2:GetValue()
    local sin = math.sin
    local cos = math.cos
    local rad = math.rad
    if center[1] and center[2] then
        for degrees = 1, 360, 1 do
            local cur_point = nil
            local old_point = nil

            local pos_x1 = pos.x + sin(rad(degrees)) * radius
            local pos_x2 = pos.x + sin(rad(degrees - 1)) * radius
            local pos_y1 = pos.y + cos(rad(degrees)) * radius
            local pos_y2 = pos.y + cos(rad(degrees - 1)) * radius
            if pos.z then
                cur_point = {WorldToScreen(Vector3(pos_x1, pos_y1, pos.z))}
                old_point = {WorldToScreen(Vector3(pos_x2, pos_y2, pos.z))}
            end

            if cur_point[1] and cur_point[2] and old_point[1] and old_point[2] then
                draw.Color(r, g, b, a)
                draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], center[1], center[2])
                draw.Color(r2, g2, b2, a2)
                draw.Line(cur_point[1], cur_point[2], old_point[1], old_point[2])
            end
        end
    end
end

--return draw
callbacks.Register(
    "Draw",
    function()
        local lp = entities.GetLocalPlayer()
        if not lp then
            return
        end
        local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 10
        if quick_peek:GetValue() and not is_peeking then
            peek_abs_origin = lp:GetAbsOrigin()
            is_peeking = true
        end

        if not quick_peek:GetValue() and peek_alpha ~= 0 then
            peek_alpha = alpha_stop(peek_alpha - fade_factor, 0, 15) --A simple animation
        end
        if quick_peek:GetValue() and peek_alpha ~= 15 then
            peek_alpha = alpha_stop(peek_alpha + fade_factor, 0, 15)
        end

        if peek_alpha ~= 0 then
            DrawCircle(peek_abs_origin, peek_alpha)
        else
            if is_peeking then
                peek_abs_origin = lp:GetAbsOrigin()
            end
        end
    end
)

--move
callbacks.Register(
    "CreateMove",
    function(cmd)
        local lp = entities.GetLocalPlayer()

        if has_shot and quick_peek:GetValue() then
            local sin = math.sin
            local rad = math.rad
            local cos = math.cos
            local local_angle = {engine.GetViewAngles().x, engine.GetViewAngles().y, engine.GetViewAngles().z}
            local world_forward = {
                vector.Subtract(
                    {peek_abs_origin.x, peek_abs_origin.y, peek_abs_origin.z},
                    {lp:GetAbsOrigin().x, lp:GetAbsOrigin().y, lp:GetAbsOrigin().z}
                )
            }

            cmd.forwardmove = (((sin(rad(local_angle[2])) * world_forward[2]) + (cos(rad(local_angle[2])) * world_forward[1])) * 200)
            cmd.sidemove = (((cos(rad(local_angle[2])) * -world_forward[2]) + (sin(rad(local_angle[2])) * world_forward[1])) * 200)

            if vector.Length(world_forward) < 10 then
                has_shot = false
            end
        end
    end
)

--Check for shooting
client.AllowListener("weapon_fire")
callbacks.Register(
    "FireGameEvent",
    function(Event)
        if Event:GetName() == "weapon_fire" then
            local local_index = client.GetLocalPlayerIndex()
            local victim_index = client.GetPlayerIndexByUserID(Event:GetInt("userid"))
            local attacker_index = client.GetPlayerIndexByUserID(Event:GetInt("attacker"))

            if (victim_index == local_index and attacker_index ~= local_index) then
                has_shot = true
                if quick_peek:GetValue() then
                    cheat.RequestSpeedBurst() --Some tricks
                end
            end
        end
    end
)
--end
