--color
color = {}

local color_mt = {
    __index = color,
    __call = function(tbl, ...)
        return color.new_rgba(...)
    end
}

--update
local function update_rgba(color)
    color.r = math.min(255, math.max(0, color.r))
    color.g = math.min(255, math.max(0, color.g))
    color.b = math.min(255, math.max(0, color.b))
    color.a = math.min(255, math.max(0, color.a))
    draw.Color(color.r, color.g, color.b, color.a)
end

local function update_hex(color)
    local hex = color.hex
    local length = hex:len()

    if (length == 3) then
        local insert = hex:sub(2)
        hex = hex .. insert .. insert
    elseif (length == 4) then
        hex = hex .. hex:sub(2)
    end

    local hex = hex:gsub("#", "")

    draw.Color(
        tonumber("0x" .. hex:sub(1, 2)),
        tonumber("0x" .. hex:sub(3, 4)),
        tonumber("0x" .. hex:sub(5, 6)),
        tonumber("0x" .. hex:sub(7, 8)) or 255
    )
end

local function update_hsv(color)
    local h, s, v, a = color.h, color.s, color.v, color.a
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    elseif i == 5 then
        r, g, b = v, p, q
    end

    draw.Color(r * 255, g * 255, b * 255, a * 255)
end

--new
function color.new_rgba(r, g, b, a)
    local object = setmetatable({r = r or 255, g = g or 255, b = b or 255, a = a or 255}, color_mt)
    update_rgba(object)
    return object
end

function color.new_hex(hex)
    local object = setmetatable({hex = hex or "#ffffffff"}, color_mt)
    update_hex(object)
    return object
end

function color.new_hsv(h, s, v, a)
    local object = setmetatable({h = h or 1, s = s or 1, v = v or 1, a = a or 1}, color_mt)
    update_hsv(object)
    return object
end

function color.new_from_ui_color_picker(ui_reference)
    local r, g, b, a = ui_reference:GetValue()
    return color.new_rgba(r, g, b, a)
end

--set
function color.set_rgba(self, r, g, b, a)
    self.r, self.g, self.b, self.a = r, g, b, a or 255
    update_rgba(self)
    return self
end

function color.set_r(self, r)
    self.r = r or 0
    update_rgba(self)
    return self
end

function color.set_g(self, g)
    self.g = g or 0
    update_rgba(self)
    return self
end

function color.set_b(self, b)
    self.b = b or 0
    update_rgba(self)
    return self
end

function color.set_a(self, a)
    self.a = a or 0
    update_rgba(self)
    return self
end

function color.set_hex(self, hex)
    self.hex = hex or "#ffffffff"
    update_hex(self)
    return self
end

function color.set_hsv(self, h, s, v, a)
    self.h, self.s, self.v, self.a = h, s, v, a or 1
    update_hsv(self)
    return self
end

function color.set_from_ui_color_picker(self, ui_reference)
    local r, g, b, a = ui_reference:GetValue()
    self:set_rgba(r, g, b, a)
    return self
end

--unpack
function color.unpack_rgba(self)
    return self.r, self.g, self.b, self.a
end

function color.unpack_hex(self)
    return self.hex
end

function color.unpack_hsv(self)
    return self.h, self.s, self.v, self.a
end

return color

--[[examples
local ui_color = gui.ColorPicker(gui.Reference(), "color", "color", 255, 255, 255, 255)

local function on_draw()
    --rgba
    local rgba = color.new_rgba(255, 255, 255, 255):set_rgba(255, 0, 0):set_a(150):unpack_rgba()

    print("rgba -" .. rgba)

    draw.Text(100, 100, "rgba")

    --hex
    local hex = color.new_hex("#5478ffff"):set_hex("#b43d34ff"):unpack_hex()

    print("hex -" .. hex)

    draw.Text(120, 120, "hex")

    --hsv
    local hsv = color.new_hsv(globals.RealTime() * 0.1, 1, 1, 0.5):set_hsv(globals.RealTime() * 0.1, 1, 1):unpack_hsv()

    print("hsv -" .. hsv)

    draw.Text(140, 140, "hsv")

    --ui_color
    local ui_color = color.new_from_ui_color_picker(ui_color):set_from_ui_color_picker(ui_color):unpack_rgba()

    print("ui_color -" .. ui_color)

    draw.Text(160, 160, "ui_color")
end

callbacks.Register("Draw", on_draw)
]]
