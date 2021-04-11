--api
local math_modf = math.modf
local math_min = math.min
local math_max = math.max
local math_abs = math.abs
local math_pi = math.pi
local math_sin = math.sin
local math_floor = math.floor

local menu = gui.Reference("menu")

--require
local function require(filename, url)
    local filename = filename .. ".lua"

    local function http_write(body)
        file.Write(filename, body)
    end

    local module = RunScript(filename) or http.Get(url, http_write)

    return module or error("unable to load module " .. filename, 2)
end

local renderer =
    require("libraries/renderer", "https://raw.githubusercontent.com/287871/aimware/renderer/renderer.lua")

--drag
local dragging = function(reference, name, base_x, base_y)
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
                    self.x_reference:SetValue(q / j * self.res)
                    self.y_reference:SetValue(r / k * self.res)
                end,
                get = function(self)
                    local j, k = draw.GetScreenSize()
                    return self.x_reference:GetValue() / self.res * j, self.y_reference:GetValue() / self.res * k
                end
            }
        }
        function a.new(r, u, v, w, x)
            x = x or 10000
            local j, k = draw.GetScreenSize()
            local y = gui.Slider(r, "x", u .. " position x", v / j * x, 0, x)
            local z = gui.Slider(r, "y", u .. " position y", w / k * x, 0, x)
            y:SetInvisible(true)
            z:SetInvisible(true)
            return setmetatable(
                {
                    reference = r,
                    name = u,
                    x_reference = y,
                    y_reference = z,
                    res = x
                },
                p
            )
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
    end)().new(reference, name, base_x, base_y)
end

--ui
local screen_size = {draw.GetScreenSize()}

local reference = gui.Reference("misc", "general", "extra")
local ragebot_accuracy_weapon = gui.Reference("ragebot", "accuracy", "weapon")

local ui_style = gui.Combobox(reference, "style", "Style", "Solid", "Fade", "Dynamic fade")

--watermark
local ui_watermark = gui.Checkbox(reference, "watermark", "Show Watermark", 1)
local ui_watermark_clr = {
    gui.ColorPicker(ui_watermark, "clr", "clr", 255, 64, 48, 255),
    gui.ColorPicker(ui_watermark, "clr2", "clr2", 96, 133, 255, 255),
    gui.ColorPicker(ui_watermark, "clr3", "clr3", 17, 17, 17, 150)
}

--keybinds
local ui_keybinds = gui.Checkbox(reference, "keybinds", "Show Keyings", 1)
local ui_keybinds_clr = {
    gui.ColorPicker(ui_keybinds, "clr", "clr", 255, 64, 48, 255),
    gui.ColorPicker(ui_keybinds, "clr2", "clr2", 96, 133, 255, 255),
    gui.ColorPicker(ui_keybinds, "clr3", "clr3", 17, 17, 17, 150)
}
local ui_keybinds_dragging = dragging(ui_keybinds, "keybinds", screen_size[1] * 0.25, screen_size[2] * 0.35)

--spectators
local ui_spectators = gui.Checkbox(reference, "spectators", "Show Spectators", 1)
local ui_spectators_clr = {
    gui.ColorPicker(ui_spectators, "clr", "clr", 255, 64, 48, 255),
    gui.ColorPicker(ui_spectators, "clr2", "clr2", 96, 133, 255, 255),
    gui.ColorPicker(ui_spectators, "clr3", "clr3", 17, 17, 17, 150)
}
local ui_spectators_dragging = dragging(ui_spectators, "spectators", screen_size[1] * 0.15, screen_size[2] * 0.35)

ui_watermark:SetDescription("Shows watermark aimware.net.")
ui_keybinds:SetDescription("Shows the active key indicator.")
ui_spectators:SetDescription("Show current audience indicator.")

--string
local function string_split(str, sep)
    local r = {}
    for str in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(r, str)
    end
    return r
end

--http time
local time, time_b, time_s, date = {0, 0, 0}, 0, 0
local function http_time()
    if time_s == 0 or (time_s + 1800 < common.Time()) then
        if not date then
            local function time_body(body)
                date = string.match(body, [[<th colspan="2" id="clock">(.+)</th>]]) or "00:00:00"
            end

            http.Get("http://time.tianqi.com/beijing/", time_body)
        else
            for i, str in pairs(string_split(string.match(date, [[(%d+:%d+:%d+)]]), ":")) do
                time[i] = tonumber(str)
            end

            time_s = common.Time()
            time_b = common.Time()
        end
    end

    time[3] = time[3] + common.Time() - time_b
    time_b = common.Time()

    if time[3] >= 60 then
        time[2], time[3], time_b = time[2] + 1, 0, common.Time()
    end
    if time[2] >= 60 then
        time[1], time[2] = time[1] + 1, 0
    end
    if time[1] >= 24 then
        time[1] = 0
    end

    local function format(t)
        local h = t[1] < 10 and "0" .. math_floor(t[1]) or math_floor(t[1])
        local m = t[2] < 10 and "0" .. math_floor(t[2]) or math_floor(t[2])
        local s = t[3] < 10 and "0" .. math_floor(t[3]) or math_floor(t[3])
        return string.format("%s:%s:%s", h, m, s)
    end

    return format(time)
end

--get ui weapon
local function ui_weapon(r)
    local w = string.lower(string.match(r, [["(.+)"]]))
    if w:find("heavy pistol") then
        return "hpistol"
    elseif w:find("auto sniper") then
        return "asniper"
    elseif w:find("submachine gun") then
        return "smg"
    elseif w:find("light machine gun") then
        return "lmg"
    else
        return w
    end
end

--clamp
local function clamp(val, min, max)
    if val > max then
        return max
    elseif val < min then
        return min
    else
        return val
    end
end

--on watermark
local alpha_watermark = 0
local function on_watermark()
    local fade = ((1.0 / 0.15) * globals.FrameTime()) * 250

    alpha_watermark = ui_watermark:GetValue() and clamp(alpha_watermark + fade, 0, 255) or clamp(alpha_watermark - fade, 0, 255)

    if alpha_watermark == 0 then
        return
    end

    local lp = entities.GetLocalPlayer()

    local name = lp and client.GetPlayerInfo(1)["name"] or client.GetConVar("name")
    local time = http_time()

    local text = string.format(" %s | %s | %s", prefix, name, time)

    if lp then
        local delay = entities.GetPlayerResources():GetPropInt("m_iPing", lp:GetIndex())
        local tick = 1 / globals.TickInterval()
        text = string.format(" %s | %s | delay: %dms | %dtick | %s", "aimware.net", name, delay, tick, time)
    end

    local x, y = draw.GetScreenSize()
    local x, y = math_modf(x * 0.99), math_modf(y * 0.02)
    local h, w = 18, renderer.measure_text("sr-", text) + 8

    local r, g, b, a = ui_watermark_clr[1]:GetValue()
    local r2, g2, b2, a2 = ui_watermark_clr[2]:GetValue()
    local r3, g3, b3, a3 = ui_watermark_clr[3]:GetValue()

    local a = a * alpha_watermark / 255
    local a2 = a2 * alpha_watermark / 255
    local a3 = a3 * alpha_watermark / 255

    ui_watermark_clr[2]:SetInvisible(false)
    renderer.rectangle(x - w, y + 1, w, h - 1, r3, g3, b3, a3, "f")
    if ui_style:GetValue() == 0 then
        ui_watermark_clr[2]:SetInvisible(true)
        renderer.rectangle(x, y, -w, 2, r, g, b, a, "f")
    elseif ui_style:GetValue() == 1 then
        renderer.gradient(x - w, y, w * 0.5, 1, 0, 0, 0, 0, r, g, b, a, true)
        renderer.gradient(x - w, y + h, w * 0.5, 1, 0, 0, 0, 0, r2, g2, b2, a2, true)

        renderer.gradient(x + 1, y, -w * 0.5, 1, r2, g2, b2, a2, 0, 0, 0, 0, true)
        renderer.gradient(x + 1, y + h, -w * 0.5, 1, r, g, b, a, 0, 0, 0, 0, true)

        renderer.gradient(x, y, 1, h + 1, r, g, b, a, r2, g2, b2, a2, nil)
        renderer.gradient(x - w, y + 1, 1, h, r2, g2, b2, a2, r, g, b, a, nil)
    elseif ui_style:GetValue() == 2 then
        local pulse = 8 + math_sin(math_abs(-math_pi + (globals.RealTime() * (0.6 / 1)) % (math_pi * 2))) * 20

        renderer.gradient(x - w, y, pulse * (w / 60), 1, 0, 0, 0, 0, r, g, b, a, true)
        renderer.gradient(x - w, y + h, pulse * (w / 60), 1, 0, 0, 0, 0, r2, g2, b2, a2, true)

        renderer.gradient(x + 1, y, -(pulse * (w / 60)), 1, r2, g2, b2, a2, 0, 0, 0, 0, true)
        renderer.gradient(x + 1, y + h, -(pulse * (w / 60)), 1, r, g, b, a, 0, 0, 0, 0, true)

        renderer.gradient(x, y, 1, h + 1, r, g, b, a, r2, g2, b2, a2, nil)
        renderer.gradient(x - w, y + 1, 1, h, r2, g2, b2, a2, r, g, b, a, nil)
    end

    renderer.text(x - 5, y + 5, 255, 255, 255, alpha_watermark, "sr-", text)
end

--on keybinds
local keybinds_data = {
    {
        varname = "rbot.antiaim.base.lby",
        custom_name = "Anti-aim inverter",
        ui_offset = 4,
        alpha = 0
    },
    {
        varname = "rbot.antiaim.condition.shiftonshot",
        custom_name = "Shift on shot",
        ui_offset = 1,
        alpha = 0
    },
    {
        varname = "rbot.accuracy.weapon.shared.doublefire",
        custom_name = "Double tap",
        ui_offset = 3,
        alpha = 0
    },
    {
        varname = "rbot.accuracy.movement.slowkey",
        custom_name = "Slow walk",
        ui_offset = 2,
        alpha = 0
    },
    {
        varname = "rbot.antiaim.extra.fakecrouchkey",
        custom_name = "Fake duck",
        ui_offset = 2,
        alpha = 0
    }
}
local alpha_keybinds = 0
local function on_keybinds()
    local get = gui.GetValue
    local lp = entities.GetLocalPlayer()

    local x, y = ui_keybinds_dragging:get()
    local x, y = math_modf(x), math_modf(y)
    local w, h = 130, 20

    local string_dis = 0

    local fade = ((1.0 / 0.15) * globals.FrameTime()) * 150

    local weapon = ui_weapon(ragebot_accuracy_weapon:GetValue())
    local weapon_pcall = pcall(get, "rbot.accuracy.weapon." .. weapon .. ".doublefire")

    local temp = {}
    for index = 1, #keybinds_data do
        local k_index = keybinds_data[index]

        local varname = get(k_index.varname)

        if k_index.ui_offset == 2 then
            varname = varname ~= 0 and input.IsButtonDown(varname)
        elseif k_index.ui_offset == 3 then
            varname = weapon_pcall and get("rbot.accuracy.weapon." .. weapon .. ".doublefire") > 0
        elseif k_index.ui_offset == 4 then
            varname = varname < 0
        end

        k_index.alpha = varname and clamp(k_index.alpha + fade, 0, 255) or clamp(k_index.alpha - fade, 0, 255)

        if k_index.alpha ~= 0 then
            table.insert(temp, keybinds_data[index])

            if renderer.measure_text("sr-", k_index.custom_name) > 80 then
                string_dis = 20
            end
        end
    end

    if lp and (#temp ~= 0 or menu:IsActive()) and ui_keybinds:GetValue() then
        alpha_keybinds = clamp(alpha_keybinds + fade, 0, 255)
    else
        alpha_keybinds = clamp(alpha_keybinds - fade, 0, 255)
    end

    if alpha_keybinds == 0 then
        return
    end

    local w = w + string_dis
    ui_keybinds_dragging:drag(w, h + (#temp * 15))

    local r, g, b, a = ui_keybinds_clr[1]:GetValue()
    local r2, g2, b2, a2 = ui_keybinds_clr[2]:GetValue()
    local r3, g3, b3, a3 = ui_keybinds_clr[3]:GetValue()

    local a = a * alpha_keybinds / 255
    local a2 = a2 * alpha_keybinds / 255
    local a3 = a3 * alpha_keybinds / 255

    renderer.rectangle(x + 1, y + 1, w - 1, h - 1, r3, g3, b3, a3, "f")
    ui_keybinds_clr[2]:SetInvisible(false)
    if ui_style:GetValue() == 0 then
        ui_keybinds_clr[2]:SetInvisible(true)
        renderer.rectangle(x + 1, y, w - 1, 2, r, g, b, a, "f")
    elseif ui_style:GetValue() == 1 then
        renderer.gradient(x, y, w * 0.5, 1, 0, 0, 0, 0, r, g, b, a, true)
        renderer.gradient(x, y, 1, h, r2, g2, b2, a2, r, g, b, a, nil)
        renderer.gradient(x, y + h, w * 0.5, 1, 0, 0, 0, 0, r2, g2, b2, a2, true)

        renderer.gradient(x + w * 0.51, y, w * 0.5, 1, r2, g2, b2, a2, 0, 0, 0, 0, true)
        renderer.gradient(x + w, y, 1, h, r, g, b, a, r2, g2, b2, a2, nil)
        renderer.gradient(x + w * 0.51, y + h, w * 0.5, 1, r, g, b, a, 0, 0, 0, 0, true)
    elseif ui_style:GetValue() == 2 then
        local pulse = 8 + math_sin(math_abs(-math_pi + (globals.RealTime() * (0.6 / 1)) % (math_pi * 2))) * 20

        renderer.gradient(x, y, pulse * (w / 60), 1, 0, 0, 0, 0, r, g, b, a, true)
        renderer.gradient(x, y, 1, h, r2, g2, b2, a2, r, g, b, a, nil)
        renderer.gradient(x, y + h, pulse * (w / 60), 1, 0, 0, 0, 0, r2, g2, b2, a2, true)

        renderer.gradient(x + w + 1, y, -(pulse * (w / 60)), 1, r2, g2, b2, a2, 0, 0, 0, 0, true)
        renderer.gradient(x + w, y, 1, h, r, g, b, a, r2, g2, b2, a2, nil)
        renderer.gradient(x + w + 1.5, y + h, -(pulse * (w / 60)), 1, r, g, b, a, 0, 0, 0, 0, true)
    end

    renderer.text(x + w * 0.5, y + 5, 255, 255, 255, alpha_keybinds, "sc-", "keybinds")

    for index = 1, #temp do
        if temp[index].alpha ~= 0 then
            local activity_name = "[toggled]"
            if temp[index].ui_offset == 2 then
                activity_name = "[holding]"
            end

            renderer.text(x + 5, y + 8 + (index * 15), 255, 255, 255, temp[index].alpha, "s-", temp[index].custom_name)
            renderer.text(x + 80 + string_dis, y + 8 + (index * 15), 255, 255, 255, temp[index].alpha, "s-", activity_name)
        end
    end
end

--on spectators
local alpha = {}
local alpha_spectators = 0
local function on_spectators()
    local lp = entities.GetLocalPlayer()

    local temp = {}

    local x, y = ui_spectators_dragging:get()
    local x, y = math_modf(x), math_modf(y)

    local fade = ((1.0 / 0.15) * globals.FrameTime()) * 150

    for i, v in pairs(entities.FindByClass("CCSPlayer")) do
        local index = v:GetIndex()
        local m_hObserverTarget = v:GetPropEntity("m_hObserverTarget")

        if not alpha[index] then
            alpha[index] = 0
        end

        if
            ui_spectators:GetValue() and lp and lp:IsAlive() and not v:IsAlive() and index ~= 1 and m_hObserverTarget and m_hObserverTarget:IsPlayer() and
                v:GetName() ~= "GOTV"
         then
            alpha[index] = clamp(alpha[index] + fade, 0, 255)
        else
            alpha[index] = clamp(alpha[index] - fade, 0, 255)
        end

        if alpha[index] ~= 0 then
            table.insert(temp, v)
        end
    end

    for i, v in pairs(temp) do
        local index = v:GetIndex()
        local name = v:GetName()

        if string.len(name) > 18 and #temp > 3 then
            name = string.match(name, [[..................]]) .. ".."
        elseif string.len(name) > 14 then
            name = string.match(name, [[..............]]) .. ".."
        end

        local y = y + 10
        renderer.text(x + 25, y + (i * 15), 255, 255, 255, alpha[index], "s-", name)
        renderer.rectangle(x + 5, y - 2 + (i * 15), 14, 14, 4, 4, 4, alpha[index], "f")
        renderer.rectangle(x + 5.5, y - 1.5 + (i * 15), 13, 13, 24, 24, 24, alpha[index], "f")
        renderer.text(x + 9, y + (i * 15), 255, 255, 255, alpha[index], "s-", "?")
    end

    local w = #temp > 2 and 150 or 125
    local h = 20

    ui_spectators_dragging:drag(w, 15 + (#temp * 15))

    alpha_spectators =
        (ui_spectators:GetValue() and (#temp ~= 0 or menu:IsActive())) and clamp(alpha_spectators + fade, 0, 255) or
        clamp(alpha_spectators - fade, 0, 255)

    local r, g, b, a = ui_spectators_clr[1]:GetValue()
    local r2, g2, b2, a2 = ui_spectators_clr[2]:GetValue()
    local r3, g3, b3, a3 = ui_spectators_clr[3]:GetValue()

    local a = a * alpha_spectators / 255
    local a2 = a2 * alpha_spectators / 255
    local a3 = a3 * alpha_spectators / 255

    renderer.rectangle(x + 1, y + 1, w - 1, h - 1, r3, g3, b3, a3, "f")
    ui_spectators_clr[2]:SetInvisible(false)
    if ui_style:GetValue() == 0 then
        ui_spectators_clr[2]:SetInvisible(true)
        renderer.rectangle(x + 1, y, w - 1, 2, r, g, b, a, "f")
    elseif ui_style:GetValue() == 1 then
        renderer.gradient(x, y, w * 0.5, 1, 0, 0, 0, 0, r, g, b, a, true)
        renderer.gradient(x, y, 1, h, r2, g2, b2, a2, r, g, b, a, nil)
        renderer.gradient(x, y + h, w * 0.5, 1, 0, 0, 0, 0, r2, g2, b2, a2, true)

        renderer.gradient(x + w * 0.51, y, w * 0.5, 1, r2, g2, b2, a2, 0, 0, 0, 0, true)
        renderer.gradient(x + w, y, 1, h, r, g, b, a, r2, g2, b2, a2, nil)
        renderer.gradient(x + w * 0.51, y + h, w * 0.5, 1, r, g, b, a, 0, 0, 0, 0, true)
    elseif ui_style:GetValue() == 2 then
        local pulse = 8 + math_sin(math_abs(-math_pi + (globals.RealTime() * (0.6 / 1)) % (math_pi * 2))) * 20

        renderer.gradient(x, y, pulse * (w / 60), 1, 0, 0, 0, 0, r, g, b, a, true)
        renderer.gradient(x, y, 1, h, r2, g2, b2, a2, r, g, b, a, nil)
        renderer.gradient(x, y + h, pulse * (w / 60), 1, 0, 0, 0, 0, r2, g2, b2, a2, true)

        renderer.gradient(x + w + 1, y, -(pulse * (w / 60)), 1, r2, g2, b2, a2, 0, 0, 0, 0, true)
        renderer.gradient(x + w, y, 1, h, r, g, b, a, r2, g2, b2, a2, nil)
        renderer.gradient(x + w + 1, y + h, -(pulse * (w / 60)), 1, r, g, b, a, 0, 0, 0, 0, true)
    end

    renderer.text(x + w * 0.5, y + 5, 255, 255, 255, alpha_spectators, "sc-", "spectators")
end

--on draw
local function on_draw()
    on_watermark()
    on_keybinds()
    on_spectators()
end
--callbacks
callbacks.Register("Draw", on_draw)
