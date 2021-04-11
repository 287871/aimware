--make paimon gif for aw
--by qi /https://aimware.net/forum/user/366789

local math_min = math.min
local math_max = math.max
local math_modf = math.modf
local math_floor = math.floor

local counter = 0
local next_frame = 0
local paimon_gif = {}

local menu = gui.Reference("menu")
local screen_size = {draw.GetScreenSize()}

local function dragging(parent, varname, base_x, base_y)
    return (function()
        local a = {}
        local b, c, d, e, f, g, h, i, j, k, l, m, n, o
        local p = {
            __index = {
                drag = function(self, ...)
                    local q, r = self:get()
                    local s, t = a.drag(q, r, ...)
                    if q ~= s or r ~= t then
                        self:set(s, t)
                    end
                    return s, t
                end,
                set = function(self, q, r)
                    local j, k = draw.GetScreenSize()
                    self.parent_x:SetValue(q / j * self.res)
                    self.parent_y:SetValue(r / k * self.res)
                end,
                get = function(self)
                    local j, k = draw.GetScreenSize()
                    return self.parent_x:GetValue() / self.res * j, self.parent_y:GetValue() / self.res * k
                end
            }
        }
        function a.new(r, u, v, w, x)
            x = x or 10000
            local j, k = draw.GetScreenSize()
            local y = gui.Slider(r, u .. "x", " position x", v / j * x, 0, x)
            local z = gui.Slider(r, u .. "y", " position y", w / k * x, 0, x)
            y:SetInvisible(true)
            z:SetInvisible(true)
            return setmetatable({parent = r, varname = u, parent_x = y, parent_y = z, res = x}, p)
        end
        function a.drag(q, r, A, B, C, D, E)
            if globals.FrameCount() ~= b then
                c = menu:IsActive()
                f, g = d, e
                d, e = input.GetMousePos()
                i = h
                h = input.IsButtonDown(0x01) == true
                m = l
                l = {}
                o = n
                n = false
                j, k = draw.GetScreenSize()
            end
            if c and i ~= nil then
                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                    n = true
                    q, r = q + d - f, r + e - g
                    if not D then
                        q = math_max(0, math_min(j - A, q))
                        r = math_max(0, math_min(k - B, r))
                    end
                end
            end
            table.insert(l, {q, r, A, B})
            return q, r, A, B
        end
        return a
    end)().new(parent, varname, base_x, base_y)
end

local ui_dragging = dragging(gui.Reference("visuals", "other", "extra"), "paimongif", screen_size[1] * 0.2, screen_size[2] * 0.1)

local paimon_gif_lib_installed = false

local function paimon_file(name)
    if string.find(name, "picture/paimon_gif/(.-).png") then
        local png_open = file.Open(name, "r")
        local png_data = png_open:Read()
        png_open:Close()
        local texture = draw.CreateTexture(common.DecodePNG(png_data))
        table.insert(paimon_gif, texture)
        paimon_gif_lib_installed = true
    end
end
if not paimon_gif_lib_installed then
    for i = 0, 52 do
        local i = i > 9 and i or 0 .. i
        local function http_renderer(body)
            file.Write("picture/paimon_gif/paimon_00" .. i .. ".png", body)
        end

        http.Get(
        --ch    "https://aimware28.coding.net/p/coding-code-guide/d/aimware/git/raw/master/picture/paimon_gif/paimon_00" .. i .. ".png?download=false",
           "https://raw.githubusercontent.com/287871/aimware/b6f491ebf48d15fcf11ebd708b2e97a299d5e235/picture/paimon_gif/paimon_00" .. i .. ".png",
            http_renderer
        )
    end
end
local function on_draw()
    local time = math_floor(globals.CurTime() * 1000)

    if next_frame - time > 30 then
        next_frame = 0
    end

    if next_frame - time < 1 then
        counter = counter + 1

        next_frame = time + 30
    end

    local gif = paimon_gif[(counter % #paimon_gif) + 1]

    local w, h = 200, 200
    local x, y = ui_dragging:get()
    local x, y = math_modf(x), math_modf(y)
    ui_dragging:drag(w, h)

    draw.FilledRect(x, y, x + w, y + h, draw.SetTexture(gif))
end

file.Enumerate(paimon_file)
callbacks.Register("Draw", on_draw)
