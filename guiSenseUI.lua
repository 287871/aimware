function gui._Custom(ref, varname, x, y, w, h, paint)
    local function _paint(x, y, x2, y2)
        local width = x2 - x
        local height = y2 - y
        paint(x, y, x2, y2)
    end
    local custom = gui.Custom(ref, varname, x, y, w, h, _paint)
end

local renderer = {}

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

renderer.triangle = function(x, y, w, h, w1, h1, clr)
    local alpha = 255

    if clr[4] then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    draw.Triangle(x, y, x - w, y + h, x + w1, y + h1)
end

local function is_inside(a, b, x, y, w, h)
    return a >= x and a <= w and b >= y and b <= h
end

function draw_window(ref, x, y, w, h)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(4, 4, 4, 255)
        draw.FilledRect(x, y - 25, x2, y2)
        draw.Color(44, 44, 44, 255)
        draw.FilledRect(x + 1, y - 24, x2 - 1, y2 - 1)
        draw.Color(68, 68, 68, 255)
        draw.FilledRect(x + 5, y - 20, x2 - 5, y2 - 5)
        draw.Color(14, 14, 14, 255)
        draw.FilledRect(x + 6, y - 19, x2 - 6, y2 - 6)

        renderer.gradient(x + 6, y - 19, (x2 - x) * 0.5, 1, {34, 166, 242, 255}, {228, 4, 245, 255}, nil)
        renderer.gradient(x + (x2 - x) * 0.5, y - 19, (x2 - x) * 0.5 - 7, 1, {228, 4, 245, 255}, {230, 233, 15, 255}, nil)

        if is_inside(mx, my, reX, reY, reX + w, reY + 20) then
            draw.RoundedRect(x, y, x2, y + 25, 10, 50, 50, 50, 50)
        end

        if is_inside(mx, my, reX + w - 20, reY + h - 20, reX + w + 20, reY + h + 20) then
            renderer.triangle(x2 - 8, y2 - 8, 8, 0, 0, -8, {44, 44, 44, 255})
        end
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end
local font1 = draw.CreateFont("Verdana", 13)
function draw_Groupbox(ref, x, y, w, h, name)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(34, 34, 34, 255)
        draw.FilledRect(x - 16, y - 47, x2, y2)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 15, y - 46, x2 - 1, y2 - 1)

        draw.SetFont(font1)
        local Tw, Th = draw.GetTextSize(name)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 5, y - 47, x + Tw + 5, y + 2)
        draw.Color(255, 255, 255, 255)
        draw.Text(x, y - 52, name)
        draw.Text(x + 0.3, y - 51.8, name)
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

function draw_Button_a(ref, x, y, w, h, name, font)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.SetFont(font)
        draw.Color(34, 34, 34, 255)
        draw.FilledRect(x - 16, y - 47, x2, y2)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 15, y - 46, x2 - 1, y2 - 1)
        draw.Color(185, 185, 185, 255)
        draw.Text(x + 4, y - 23, name)
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

function draw_Button_b(ref, x, y, w, h, name)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(34, 34, 34, 255)
        draw.FilledRect(x - 48, y - 94, x2, y2)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 47, y - 93, x2 - 1, y2 - 1)
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

function draw_Checkbox(ref, x, y, w, h, name, font)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(34, 34, 34, 255)
        draw.FilledRect(x - 1, y - 1, x2, y2)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x, y, x2 - 1, y2 - 1)
        draw.Color(238, 238, 238, 255)
        draw.SetFont( font )
        draw.Text(x2 +5, y + 3, name)
        draw.Text(x2 +5, y + 3, name)
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

local Window = gui.Window("Sense GUI", "Main menu", 100, 100, 500, 410)
local SenseGUI = draw_window(Window, 0, 0, 500, 410)

local LegitbotG = gui.Groupbox(Window, "LegitbotG", 200, 0, 100, 100)
LegitbotG:SetPosX(115)
LegitbotG:SetPosY(0)
LegitbotG:SetWidth(360)
LegitbotG:SetHeight(100)

local RagebotG = gui.Groupbox(Window, "RagebotG", 200, 0, 100, 100)
RagebotG:SetPosX(100)
RagebotG:SetPosY(0)
RagebotG:SetWidth(100)
RagebotG:SetHeight(100)

local VisualsG = gui.Groupbox(Window, "VisualsG", 200, 0, 100, 100)
VisualsG:SetPosX(100)
VisualsG:SetPosY(0)
VisualsG:SetWidth(100)
VisualsG:SetHeight(100)

local MiscG = gui.Groupbox(Window, "MiscG", 200, 0, 100, 100)
MiscG:SetPosX(100)
MiscG:SetPosY(0)
MiscG:SetWidth(100)
MiscG:SetHeight(100)

local UserG = gui.Groupbox(Window, "UserG", 200, 0, 100, 100)
UserG:SetPosX(100)
UserG:SetPosY(0)
UserG:SetWidth(100)
UserG:SetHeight(100)

local function Legitbot()
    print("Legitbot")
    LegitbotG:SetInvisible(false)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(true)
end
local Legitbot = gui.Button(Window, "Legitbot", Legitbot)
Legitbot:SetPosX(15)
Legitbot:SetPosY(0)
Legitbot:SetWidth(85)
Legitbot:SetHeight(75)
local font2 = draw.CreateFont("Astriumtabs2", 41, 1000)
local Legitbot_drawBut = draw_Button_a(Window, 31, 47, 69, 28, "D", font2)
local Legitbot_drawBut_b = draw_Button_b(LegitbotG, 31, 47, 312, 291, "D")
local function Ragebot()
    print("Ragebot")
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(false)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(true)
end
local Ragebot = gui.Button(Window, "Ragebot", Ragebot)
Ragebot:SetPosX(15)
Ragebot:SetPosY(78)
Ragebot:SetWidth(85)
Ragebot:SetHeight(75)
local Ragebot_drawBut = draw_Button_a(Window, 31, 125, 69, 28, "C", font2)

local function Visuals()
    print("Visuals")
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(false)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(true)
end
local Visuals = gui.Button(Window, "Visuals", Visuals)
Visuals:SetPosX(15)
Visuals:SetPosY(156)
Visuals:SetWidth(85)
Visuals:SetHeight(75)
local Visuals_drawBut = draw_Button_a(Window, 31, 203, 69, 28, "E", font2)

local function Misc()
    print("Misc")
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(false)
    UserG:SetInvisible(true)
end
local Misc = gui.Button(Window, "Misc", Misc)
Misc:SetPosX(15)
Misc:SetPosY(234)
Misc:SetWidth(85)
Misc:SetHeight(75)
local Misc_drawBut = draw_Button_a(Window, 31, 281, 69, 28, "F", font2)

local function User()
    print("User")
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(false)
end
local User = gui.Button(Window, "User", User)
User:SetPosX(15)
User:SetPosY(312)
User:SetWidth(85)
User:SetHeight(75)
local User_drawBut = draw_Button_a(Window, 31, 359, 69, 28, "H", font2)
local Color = gui.ColorPicker(UserG, "varname", "clr", 255, 255, 255, 255)
LegitbotG:SetInvisible(false)
RagebotG:SetInvisible(true)
VisualsG:SetInvisible(true)
MiscG:SetInvisible(true)
UserG:SetInvisible(true)

local l_cD = draw_Checkbox(LegitbotG, 0, 0, 10, 10, "name", font1)
local l_c = gui.Checkbox(LegitbotG, "varname", "", 0)
l_c:SetHeight(15)
callbacks.Register(
    "Draw",
    function()
        if Color:IsActive() then
        end
    end
)
