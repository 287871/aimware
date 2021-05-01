--Working on aimware weapon circle hud
--By qi

local math_min = math.min
local math_max = math.max
local math_modf = math.modf

local draw =
    require and require("libraries/draw", "https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/draw/draw.lua") or
    http.Get(
        "https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/require.lua",
        function(body)
            local r = file.Open("autorun.lua", "a")
            r:Write(body)
            r:Close()
            load(body)()
        end
    )

local images = require("libraries/images", "https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/images/images.lua")
local weapon_icon =
    images.load(
    require("libraries/imagepack_icons", "https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/images/imagepack_icons.lua")
)

local csgo_weapons = require("libraries/csgo_weapons", "https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/csgo_weapons.lua ")

local x, y = draw.get_screen_size()
local ui_drag = draw.drag(gui.Reference("visuals", "other", "extra"), "circlehud.", x * 0.55, y * 0.8)

local circle_outline_texture =
    draw.load_svg(
    [[<defs><radialGradient id="a" cx="50%" cy="50%" r="50%" fx="50%" fy="50%"><stop offset="80%" style="stop-color:rgb(13,13,13); stop-opacity:0.5" /><stop offset="100%" style="stop-color:rgb(130,130,130); stop-opacity:0.5" /></radialGradient></defs><ellipse cx="200" cy="200" rx="100" ry="100" style="fill:url(#a)" /></svg>]]
)

--regionend
local font = draw.new_font("verdana", 12)
local function draw_hud_circle()
    local lp = entities.GetLocalPlayer()

    if not (lp and lp:IsAlive()) then
        return
    end

    local m_hActiveWeapon = lp:GetPropEntity("m_hActiveWeapon")
    local weapons = csgo_weapons[lp:GetWeaponID() or 1]

    local x, y = ui_drag:get()
    local x, y = x + 50, y + 50

    ui_drag:drag(200, 200)

    draw.set_font(font)

    draw.color(255, 255, 255)
    draw.texture(circle_outline_texture, x - 50, y - 50, x + 50, y + 50)

    local ammo = m_hActiveWeapon:GetProp("m_iClip1") or -1
    local reserve

    if ammo ~= -1 then
        reserve = m_hActiveWeapon:GetProp("m_iPrimaryReserveAmmoCount") or 0
    else
        reserve = ""
    end

    local bar_width = 1 / weapons.primary_clip_size

    draw.color(255, 255, 255, 175)

    for i = 1, ammo do
        draw.circle_outline(x, y, 50, 180 - bar_width * 360 * i, bar_width - 0.005, 5, 2)
    end
    if ammo == -1 then
        draw.circle_outline(x, y, 50, 0, 1, 5, 10)
    end

    draw.text(x, y + 25, "sc", reserve)

    local wep_name = weapons.item_class:sub(8, -1)
    local draw_icon = weapon_icon[wep_name]
    local icon_measure = {draw_icon:measure()}

    draw_icon:draw(x - icon_measure[1] * 0.8 / 2, y - icon_measure[2] * 0.8 / 2, icon_measure[1] * 0.8, icon_measure[2] * 0.8)

    draw.color(10, 10, 10, 75)
    draw.circle_outline(x, y, 60, 120, 0.34, 5, 10)
    draw.circle_outline(x, y, 60, 300, 0.34, 5, 10)

    local health = math_min(100, lp:GetHealth())
    local hpr = (50 * health / 100) + (255 * (1 - health / 100))
    local hpg = (255 * health / 100) + (75 * (1 - health / 100))
    local hpb = (65 * health / 100) + (20 * (1 - health / 100))

    draw.color(hpr, hpg, hpb, 150)
    draw.circle_outline(x, y, 60, 120, 0.34 * health / 100, 5, 10)
    draw.text(x, y - 62, "sc", health)

    local armor = math_min(100, lp:GetProp("m_ArmorValue"))

    draw.color(75, 75, 255, 175)
    draw.circle_outline(x, y, 60, 300, 0.34 * armor / 100, 5, 10)
    draw.text(x, y + 52, "sc", armor)
end

callbacks.Register("Draw", draw_hud_circle)
