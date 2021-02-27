--[[
Working on aimware havoc vision rpg
by qi
]]
--aw api Improved my running speed
--region entities
local entities = {
    FindByClass = entities.FindByClass,
    GetLocalPlayer = entities.GetLocalPlayer,
    GetByIndex = entities.GetByIndex,
    GetByUserID = entities.GetByUserID,
    GetPlayerResources = entities.GetPlayerResources
}
--region client
local client = {
    WorldToScreen = client.WorldToScreen,
    Command = client.Command,
    ChatSay = client.ChatSay,
    ChatTeamSay = client.ChatTeamSay,
    AllowListener = client.AllowListener,
    GetPlayerNameByIndex = client.GetPlayerNameByIndex,
    GetPlayerNameByUserID = client.GetPlayerNameByUserID,
    GetPlayerInfo = client.GetPlayerInfo,
    GetLocalPlayerIndex = client.GetLocalPlayerIndex,
    SetConVar = client.SetConVar,
    GetConVar = client.GetConVar,
    GetPlayerIndexByUserID = client.GetPlayerIndexByUserID
}
--region globals
local globals = {
    TickInterval = globals.TickInterval,
    TickCount = globals.TickCount,
    RealTime = globals.RealTime,
    CurTime = globals.CurTime,
    FrameCount = globals.FrameCount,
    FrameTime = globals.FrameTime,
    AbsoluteFrameTime = globals.AbsoluteFrameTime,
    MaxClients = globals.MaxClients
}
--region draw
local draw = {
    Color = draw.Color,
    Line = draw.Line,
    FilledRect = draw.FilledRect,
    OutlinedRect = draw.OutlinedRect,
    RoundedRect = draw.RoundedRect,
    RoundedRectFill = draw.RoundedRectFill,
    ShadowRect = draw.ShadowRect,
    Triangle = draw.Triangle,
    FilledCircle = draw.FilledCircle,
    OutlinedCircle = draw.OutlinedCircle,
    GetTextSize = draw.GetTextSize,
    Text = draw.Text,
    TextShadow = draw.TextShadow,
    GetScreenSize = draw.GetScreenSize,
    CreateFont = draw.CreateFont,
    AddFontResource = draw.AddFontResource,
    SetFont = draw.SetFont,
    CreateTexture = draw.CreateTexture,
    UpdateTexture = draw.UpdateTexture,
    SetTexture = draw.SetTexture
}
--region common
local common = {
    Time = common.Time,
    DecodePNG = common.DecodePNG,
    DecodeJPEG = common.DecodeJPEG,
    RasterizeSVG = common.RasterizeSVG
}
--region gui
local gui = {
    GetValue = gui.GetValue,
    SetValue = gui.SetValue,
    Reference = gui.Reference,
    Checkbox = gui.Checkbox,
    Slider = gui.Slider,
    Keybox = gui.Keybox,
    Combobox = gui.Combobox,
    Editbox = gui.Editbox,
    Text = gui.Text,
    Groupbox = gui.Groupbox,
    ColorPicker = gui.ColorPicker,
    Window = gui.Window,
    Button = gui.Button,
    Multibox = gui.Multibox,
    Command = gui.Command,
    Custom = gui.Custom,
    Tab = gui.Tab,
    Listbox = gui.Listbox
}
--region input
local input = {
    GetMousePos = input.GetMousePos,
    IsButtonDown = input.IsButtonDown,
    IsButtonPressed = input.IsButtonPressed,
    IsButtonReleased = input.IsButtonReleased,
    Slider = input.Slider,
    Keybox = input.Keybox,
    GetMouseWheelDelta = input.GetMouseWheelDelta
}
--region engine
local engine = {
    TraceLine = engine.TraceLine,
    TraceHull = engine.TraceHull,
    GetPointContents = engine.GetPointContents,
    GetMapName = engine.GetMapName,
    GetServerIP = engine.GetServerIP,
    GetViewAngles = engine.GetViewAngles,
    SetViewAngles = engine.SetViewAngles
}
--region file
local file = {
    Open = file.Open,
    Delete = file.Delete,
    Enumerate = file.Enumerate
}
--region http
local http = {
    Get = http.Get
}
--region vector
local vector = {
    Add = vector.Add,
    Subtract = vector.Subtract,
    Multiply = vector.Multiply,
    Divide = vector.Divide,
    Length = vector.Length,
    LengthSqr = vector.LengthSqr,
    Distance = vector.Distance,
    Normalize = vector.Normalize,
    Angles = vector.Angles,
    AngleForward = vector.AngleForward,
    AngleRight = vector.AngleRight,
    AngleUp = vector.AngleUp,
    AngleNormalize = vector.AngleNormalize
}
--region network
local network = {
    Socket = network.Socket,
    GetAddrInfo = network.GetAddrInfo,
    GetNameInfo = network.GetNameInfo
}
--region materials
local materials = {
    Find = materials.Find,
    Enumerate = materials.Enumerate,
    Create = materials.Create
}
--region panorama
local panorama = {
    RunScript = panorama.RunScript
}

local sin = math.sin
local cos = math.cos
local rad = math.rad

--var
local w, h = draw.GetScreenSize()
local avatars
local havoc_vision_rpg_tx, havoc_vision_rpg_ty, offsetX, offsetY, drag
local menu = gui.Reference("MENU")
local font = draw.CreateFont("Verdana", 13.5)
local font2 = draw.CreateFont("Verdana", 12)
local health_alpha = 0
local armor_alpha = 0
local renderer = {}

local cur_point = nil
local old_point = nil
local cur_point2 = nil
local old_point2 = nil
--gui

local ref = gui.Reference("Visuals", "Local", "Camera")
local havoc_vision_rpg = gui.Checkbox(ref, "havoc.vision.rpg", "havoc vision rpg", 1)
local havoc_vision_rpg_path = gui.Editbox(ref, "havoc.vision.rpg.path", "")
local havoc_vision_rpg_x = gui.Slider(havoc_vision_rpg, "x", "x", 400, 0, w)
local havoc_vision_rpg_y = gui.Slider(havoc_vision_rpg, "y", "y", 70, 0, h)
local havoc_vision_rpg_clr = gui.ColorPicker(havoc_vision_rpg, "clr", "clr", 255, 255, 118, 255)
local havoc_vision_rpg_clr2 = gui.ColorPicker(havoc_vision_rpg, "clr2", "clr2", 255, 255, 255, 255)
havoc_vision_rpg_path:SetValue("picture/1.jpg")

--- Update
local function update()
    local path = havoc_vision_rpg_path:GetValue()
    local avatars_data = file.Open(path, "r")
    local avatars = avatars_data:Read()
    avatars_data:Close()
    local_avatars_rgba, local_avatars_width, local_avatars_height = common.DecodeJPEG(avatars)
    local_avatars_texture = draw.CreateTexture(local_avatars_rgba, local_avatars_width, local_avatars_height)
end
update()
local updatebutton = gui.Button(ref, "Update", update)

--object
havoc_vision_rpg_x:SetInvisible(true)
havoc_vision_rpg_y:SetInvisible(true)
havoc_vision_rpg_path:SetHeight(20)
updatebutton:SetHeight(20)
local function SetGui()
    local havoc_vision_rpg = havoc_vision_rpg:GetValue()
    havoc_vision_rpg_clr:SetInvisible(not havoc_vision_rpg)
    havoc_vision_rpg_clr2:SetInvisible(not havoc_vision_rpg)
    havoc_vision_rpg_path:SetInvisible(not havoc_vision_rpg)
    updatebutton:SetInvisible(not havoc_vision_rpg)
end

--var
local function IsInside(a, b, x, y, w, h)
    return a >= x and a <= w and b >= y and b <= h
end

--drag menu
--@from An
local function DragMenu(x, y, w, h)
    if not menu:IsActive() then
        return havoc_vision_rpg_tx, havoc_vision_rpg_ty
    end
    local mouse_down = input.IsButtonDown(1)
    if mouse_down then
        local X, Y = input.GetMousePos()
        if not drag then
            local w, h = x + w, y + h
            if IsInside(X, Y, x, y, w, h) then
                offsetX, offsetY = X - x, Y - y
                drag = true
            end
        else
            havoc_vision_rpg_tx, havoc_vision_rpg_ty = X - offsetX, Y - offsetY
            havoc_vision_rpg_x:SetValue(havoc_vision_rpg_tx)
            havoc_vision_rpg_y:SetValue(havoc_vision_rpg_ty)
        end
    else
        drag = false
    end
    return havoc_vision_rpg_tx, havoc_vision_rpg_ty
end

--renderer rectangle
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
--renderer gradient
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
--renderer circle
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
--renderer circle_smooth
renderer.circle_smooth = function(x, y, radius, clr)
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
--renderer circle ring
renderer.circle_ring = function(x, y, start, radius, number, thickness, clr, number2)
    if thickness > radius then
        thickness = radius
    end
    local alpha = 255
    if clr[4] then
        alpha = clr[4]
    end
    local _number2 = 1
    if number2 then
        _number2 = number2
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)

    for steps = start, number + start - 1, 1 do
        local sin_cur = sin(rad((steps * _number2) + (45 * _number2)))
        local sin_old = sin(rad((steps * _number2) + (45 * _number2) - (2 * _number2)))
        local cos_cur = cos(rad((steps * _number2) + (45 * _number2)))
        local cos_old = cos(rad((steps * _number2) + (45 * _number2) - (2 * _number2)))
        local cur_point = {x + sin_cur * radius, y + cos_cur * radius}
        local old_point = {x + sin_old * radius, y + cos_old * radius}
        local cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)}
        local old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)}

        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])
    end
end
--renderer roundedrect
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
--renderer end

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
--gradient
local function Gradient(x, y)
    local r, g, b, a = 34, 34, 34, 255
    renderer.gradient(x - 115, y - 23, 25, 23, {r, g, b, 0}, {r, g, b, a})
    renderer.gradient(x + 150, y, 25, 20, {r, g, b, a}, {r, g, b, 0})
    renderer.gradient(x + 170, y - 35, 45, 25, {r, g, b, a}, {r, g, b, 0})
end
--information b filled rect
local function IBFilledRect(x, y)
    local r, g, b, a = 34, 34, 34, 255
    draw.Color(r, g, b, a)
    draw.FilledRect(x - 90, y - 23, x - 45, y)
    draw.FilledRect(x + 50, y, x + 150, y + 20)
end
local function IBFilledRect2(x, y)
    local r, g, b, a = 34, 34, 34, 255
    draw.Color(r, g, b, a)
    draw.FilledRect(x + 40, y - 35, x + 170, y - 10)
end
--let drag position save
local function PositionSave()
    local x = havoc_vision_rpg_x:GetValue()
    local y = havoc_vision_rpg_y:GetValue()
    if havoc_vision_rpg_tx ~= x or havoc_vision_rpg_ty ~= y then
        havoc_vision_rpg_tx = x
        havoc_vision_rpg_ty = y
    end
end
--return x, y
local function Position()
    local x, y = DragMenu(havoc_vision_rpg_tx, havoc_vision_rpg_ty, 100, 100)
    local x, y = x + 50, y + 50
    return x, y
end
--get information
local function GetInformation(localplayer)
    local hp = localplayer:GetHealth()
    local armor = localplayer:GetProp("m_ArmorValue")
    local money = localplayer:GetProp("m_iAccount")
    local teamnumber = localplayer:GetTeamNumber()
    return hp, armor, money, teamnumber
end
--Multiple blood colors
local function HealthColor(var, alpha)
    if var > 85 then
        return 134, 200, 134, alpha
    elseif var > 75 then
        return 171, 151, 106, alpha
    elseif var > 50 then
        return 190, 90, 90, alpha
    elseif var > 30 then
        return 200, 0, 60, alpha
    elseif var >= 0 then
        return 255, 0, 0, alpha
    end
end
-- get naem
local function GetName()
    local name = client.GetPlayerNameByIndex(1)
    if string.len(name) > 8 then -- Calculate name length
        name = string.match(name, [[........]]) .. "..."
    end
    return name
end
--Picture
local function Picture(x, y)
    local texture = local_avatars_texture
    local r, g, b, a = 255, 255, 255, 255
    local w = local_avatars_width
    local h = local_avatars_height
    draw.Color(r, g, b, a)
    draw.SetTexture(texture)
    draw.FilledRect(x - 39, y - 39, x + w - 145, y + h - 146)
    draw.SetTexture(nil)
end
--circle ring
local function CircleRing(x, y, clr, alpha)
    local r, g, b, a = clr[1], clr[2], clr[3], clr[4]
    renderer.circle_ring(x, y, 4 - alpha, 57, alpha, 2, {r, g, b, a}, 2)
end
local function CircleRing2(x, y, alpha)
    local r, g, b, a = 80, 163, 248, 200
    renderer.circle_ring(x, y - 0.5, -45, 41, alpha, 1, {r, g, b, a}, 2)
end
--health alpha animation
local function HealthAlpha(x, y, var, fade)
    if var ~= 180 then
        health_alpha = alpha_stop(health_alpha - fade, var, 180)
    else
        health_alpha = alpha_stop(health_alpha + fade, 0, var)
    end
    local r, g, b, a = HealthColor(var, 200)
    CircleRing(x, y, {r, g, b, a}, health_alpha)
end
--circle background
local function CircleBgdSmooth(x, y)
    renderer.circle(x, y + 37, 14.3, {80, 163, 248, 150}, true)
    renderer.circle_smooth(x, y + 37, 15, {80, 163, 248, 150})
end
--Circle background rounded rect
local function CircleBgdRoundedRect(x, y)
    local r, g, b, a = 34, 34, 34, 255
    local tl, tr, bl, br = 50, 50, 50, 50

    renderer.roundedrect(x - 50.5, y - 50.5, 101, 101, false, 50.5, {r, g, b, a}, tl, tr, bl, br)
    renderer.roundedrect(x - 46, y - 46, 92, 92, false, 46, {r, g, b, a}, tl, tr, bl, br)
    renderer.roundedrect(x - 44, y - 44, 88, 88, false, 44, {r, g, b, a}, tl, tr, bl, br)
    renderer.roundedrect(x - 55, y - 55, 110, 110, false, 55, {r, g, b, a}, tl, tr, bl, br)
end
--circle background
local function CircleBgd(x, y)
    CircleBgdSmooth(x, y)
    CircleBgdRoundedRect(x, y)
end
--armor
local function ArmorAlpha(x, y, var, fade)
    if var ~= 180 then
        armor_alpha = alpha_stop(armor_alpha - fade, var, 180)
    else
        armor_alpha = alpha_stop(armor_alpha + fade, 0, var)
    end
    CircleRing2(x, y, armor_alpha)
end
--information bar
local function information(x, y)
    Gradient(x, y)
    IBFilledRect(x, y)
end
--get server ip
local function GetServerIP()
    if (engine.GetServerIP() == "loopback") then -- Server
        return "localhost"
    elseif string.find(engine.GetServerIP(), "A") then
        return "valve"
    else
        return "unknown"
    end
end

--Health, Money Text
local function Text(x, y, hp, money, tbr, localplayer)
    local r, g, b, a = havoc_vision_rpg_clr:GetValue()
    local r2, g2, b2, a2 = havoc_vision_rpg_clr2:GetValue()

    local health = hp
    local money = money
    local teamnumber = tbr

    local server = GetServerIP()
    local userName = GetName()

    draw.SetFont(font)
    draw.Color(r2, g2, b2, a2)
    draw.TextShadow(x - 5, y + 27, teamnumber)

    draw.SetFont(font2)
    draw.TextShadow(x + 110, y + 5, "$" .. money)
    draw.TextShadow(x + 65, y - 27, server .. "  Hello " .. userName)

    draw.Color(r, g, b, a)
    draw.TextShadow(x + 65, y + 5, "Money ● ")

    local hp = health .. " hp"
    local hp_w, hp_h = draw.GetTextSize(hp)
    local r, g, b, a = HealthColor(health, 200)
    draw.Color(r, g, b)
    draw.TextShadow(x - 60 - hp_w, y - 16, hp)
end

--On draw
local function OnDraw(x, y, localplayer)
    local lp = localplayer
    local hp, armor, money, teamnumber = GetInformation(lp)
    local frame_time = globals.FrameTime()
    local fade_factor = ((1.0 / 0.15) * frame_time) * 30

    information(x, y)
    Picture(x, y)
    HealthAlpha(x, y, hp * 1.8, fade_factor)
    CircleBgd(x, y, var)
    ArmorAlpha(x, y, armor * 1.8, fade_factor)
    IBFilledRect2(x, y)
    Text(x, y, hp, money, teamnumber, lp)
end

--Callbacks
callbacks.Register(
    "Draw",
    "avatars_circle",
    function()
        SetGui()
        local lp = entities.GetLocalPlayer()
        if lp and havoc_vision_rpg:GetValue() then
            PositionSave()
            local x, y = Position()
            OnDraw(x, y, lp)
        end
    end
)
