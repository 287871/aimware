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

--
function gui._Custom(ref, varname, x, y, w, h, paint)
    local function _paint(x, y, x2, y2)
        local width = x2 - x
        local height = y2 - y
        paint(x, y, x2, y2)
    end
    local custom = gui.Custom(ref, varname, x, y, w, h, _paint)
end

local function is_inside(a, b, x, y, w, h)
    return a >= x and a <= w and b >= y and b <= h
end

local function draw_window(ref, x, y, w, h)
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
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

local function draw_Button(ref, x, y, w, h, name, font)
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

local function draw_Groupbox(ref, x, y, w, h, textW)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(34, 34, 34, 255)
        draw.FilledRect(x - 48, y - 94, x2, y2)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 47, y - 93, x2 - 1, y2 - 1)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 35, y - 95, x + textW, y - 90)
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

local function draw_Keybox(ref, x, y, w, h)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 47, y - 93, x2 - 1, y2 - 1)
    end
    gui._Custom(ref, "", x, y, w, h, paint)
end

--
local Window = gui.Window("SenseGUI", "Sense Gui Menu", 100, 100, 500, 410)
local SenseGUI = draw_window(Window, 0, 0, 500, 410)

local LegitbotG = gui.Groupbox(Window, "LegitbotG", 200, 0, 100, 100)
LegitbotG:SetPosX(115)
LegitbotG:SetPosY(5)
LegitbotG:SetWidth(360)
LegitbotG:SetHeight(100)
local RagebotG = gui.Groupbox(Window, "RagebotG", 200, 0, 100, 100)
RagebotG:SetPosX(115)
RagebotG:SetPosY(5)
RagebotG:SetWidth(360)
RagebotG:SetHeight(100)
local VisualsG = gui.Groupbox(Window, "VisualsG", 200, 0, 100, 100)
VisualsG:SetPosX(115)
VisualsG:SetPosY(5)
VisualsG:SetWidth(360)
VisualsG:SetHeight(100)
local MiscG = gui.Groupbox(Window, "MiscG", 200, 0, 100, 100)
MiscG:SetPosX(115)
MiscG:SetPosY(5)
MiscG:SetWidth(360)
MiscG:SetHeight(100)
local UserG = gui.Groupbox(Window, "UserG", 200, 0, 100, 100)
UserG:SetPosX(115)
UserG:SetPosY(5)
UserG:SetWidth(360)
UserG:SetHeight(100)

local function Legitbot()
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
local font = draw.CreateFont("Astriumtabs2", 41, 1000)
local Legitbot_drawBut = draw_Button(Window, 31, 47, 69, 28, "D", font)
local Legitbot_draw_Groupbox = draw_Groupbox(LegitbotG, 31, 47, 312, 285, 15)
local Legitbot_draw_Groupbox_text = gui.Text(LegitbotG, "Legitbot")
Legitbot_draw_Groupbox_text:SetPosY(-50)

local function Ragebot()
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
local Ragebot_drawBut = draw_Button(Window, 31, 125, 69, 28, "C", font)
local Ragebot_draw_Groupbox = draw_Groupbox(RagebotG, 31, 47, 312, 285, 15)
local Ragebot_draw_Groupbox_text = gui.Text(RagebotG, "Ragebot")
Ragebot_draw_Groupbox_text:SetPosY(-50)

local function Visuals()
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
local Visuals_drawBut = draw_Button(Window, 31, 203, 69, 28, "E", font)
local Visuals_draw_Groupbox = draw_Groupbox(VisualsG, 31, 47, 312, 285, 12)
local Visuals_draw_Groupbox_text = gui.Text(VisualsG, "Visuals")
Visuals_draw_Groupbox_text:SetPosY(-50)

local function Misc()
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
local Misc_drawBut = draw_Button(Window, 31, 281, 69, 28, "F", font)
local Misc_draw_Groupbox = draw_Groupbox(MiscG, 31, 47, 312, 285, -2)
local Misc_draw_Groupbox_text = gui.Text(MiscG, "Misc")
Misc_draw_Groupbox_text:SetPosY(-50)

local function User()
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
local User_drawBut = draw_Button(Window, 31, 359, 69, 28, "H", font)
local User_draw_Groupbox = draw_Groupbox(UserG, 31, 47, 312, 285, -2)
local User_draw_Groupbox_text = gui.Text(UserG, "User")
User_draw_Groupbox_text:SetPosY(-50)

LegitbotG:SetInvisible(false)
RagebotG:SetInvisible(true)
VisualsG:SetInvisible(true)
MiscG:SetInvisible(true)
UserG:SetInvisible(true)

local open_menu_key_ref = gui.Reference("Settings", "Advanced", "Manage advanced settings")
local open_menu_key = gui.Keybox(open_menu_key_ref, "open.semenu.key", "Open Sense UI Menu Ke", 46)
open_menu_key:SetDescription("Bind for sense ui menu toggle")
callbacks.Register(
    "Draw",
    function()
        Window:SetOpenKey(open_menu_key:GetValue())
    end
)
--gui
gui_custom_SenseUI_Reference = Window
gui_custom_Legitbot_Reference = LegitbotG
gui_custom_Ragebot_Reference = RagebotG
gui_custom_Visuals_Reference = VisualsG
gui_custom_Misc_Reference = MiscG
gui_custom_User_Reference = UserG
