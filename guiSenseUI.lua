--[[
Working on aimware
Making gui.custom based on aw
by qi
]]
local renderer = {}
local active_window_index = 1
local font = draw.CreateFont("Astriumtabs2", 41, 1000)
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
        draw.Color(12, 12, 12, 255)
        draw.FilledRect(x + 6, y - 19, x2 - 6, y2 - 6)

        renderer.gradient(x + 6, y - 19, (x2 - x) * 0.5, 1, {34, 166, 242, 255}, {228, 4, 245, 255}, nil)
        renderer.gradient(x + (x2 - x) * 0.5, y - 19, (x2 - x) * 0.5 - 7, 1, {228, 4, 245, 255}, {230, 233, 15, 255}, nil)
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

local function is_in_rect(x, y, x1, y1, x2, y2)
    return x >= x1 and x < x2 and y >= y1 and y < y2
end

local active_draw_Button_index = 1

local function is_in_rect(x, y, x1, y1, x2, y2)
    return x >= x1 and x < x2 and y >= y1 and y < y2
end

--@The code of cheeseot  draw_Button I'm just changing it a little bit
local function update_draw_Button(index, name, font, x3, y3, w3, h3, textY)
    return function(x, y, x2, y2, active)
        local mx, my = input.GetMousePos()

        draw.SetFont(font)
        draw.Color(12, 12, 12, 255)
        draw.FilledRect(x - 16, y - 47, x2, y2)

        if (active_draw_Button_index == index or is_in_rect(mx, my, x - 16, y - 47, x2, y2)) then
            if active_draw_Button_index == index then
                draw.Color(6, 6, 6, 255)
                draw.FilledRect(x - 16 + x3, y - 32 + y3, x2 + w3, y2 + 2 + h3)
                draw.Color(34, 34, 34, 255)
                draw.FilledRect(x - 16 + x3, y - 31 + y3, x2 + 1 + w3, y2 + 1 + h3)
                draw.Color(17, 17, 17, 255)
                draw.FilledRect(x - 16 + x3, y - 30 + y3, x2 + 2 + w3, y2 + h3)
            end

            draw.Color(238, 238, 238, 255)
            if (input.IsButtonPressed(1)) then
                active_draw_Button_index = index
            end
        else
            draw.Color(185, 185, 185, 200)
        end

        draw.Text(x + 4, y - 23 + textY, name)
    end
end

local function draw_Button(window, parent, x, y, h, w, x2, y2, w2, h2, index, name, font, textY)
    local tab_width = num_of_tabs
    return gui.Custom(window, parent, x, y, h, w, update_draw_Button(index, name, font, x2, y2, w2, h2, textY))
end

local function draw_Groupbox(ref, x, y, w, h)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(34, 34, 34, 255)
        draw.FilledRect(x - 62, y - 94, x2, y2)
        draw.Color(17, 17, 17, 255)
        draw.FilledRect(x - 61, y - 94, x2, y2)
    end

    gui._Custom(ref, "", x, y, w, h, paint)
end

local function draw_Groupbox_a(ref, x, y, w, h)
    local function paint(x, y, x2, y2)
        local mx, my = input.GetMousePos()
        local reX, reY = ref:GetValue()

        draw.Color(12, 12, 12, 255)
        draw.FilledRect(x - 62.5, y - 2.5, x2 + 1.5, y2 + 1.5)
        draw.Color(34, 34, 34, 255)
        draw.FilledRect(x - 62, y - 2, x2 + 1, y2 + 1)
        draw.Color(24, 24, 24, 255)
        draw.FilledRect(x - 61, y - 1, x2, y2)
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
local Window = gui.Window("SenseGUI", "Sense Gui Menu", 300, 10, 500, 410)
local SenseGUI = draw_window(Window, 0, 0, 500, 410)

local LegitbotG = gui.Groupbox(Window, "LegitbotG", 200, 0, 100, 100)
LegitbotG:SetPosX(108)
LegitbotG:SetPosY(-18)
LegitbotG:SetWidth(370)
LegitbotG:SetHeight(100)
local RagebotG = gui.Groupbox(Window, "RagebotG", 200, 0, 100, 100)
RagebotG:SetPosX(108)
RagebotG:SetPosY(-18)
RagebotG:SetWidth(370)
RagebotG:SetHeight(100)
local VisualsG = gui.Groupbox(Window, "VisualsG", 200, 0, 100, 100)
VisualsG:SetPosX(108)
VisualsG:SetPosY(-18)
VisualsG:SetWidth(370)
VisualsG:SetHeight(100)
local MiscG = gui.Groupbox(Window, "MiscG", 200, 0, 100, 100)
MiscG:SetPosX(108)
MiscG:SetPosY(-18)
MiscG:SetWidth(370)
MiscG:SetHeight(100)
local UserG = gui.Groupbox(Window, "UserG", 200, 0, 100, 100)
UserG:SetPosX(108)
UserG:SetPosY(-18)
UserG:SetWidth(370)
UserG:SetHeight(100)

local function Legitbot()
    LegitbotG:SetInvisible(false)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(true)
end
local Legitbot = gui.Button(Window, "Legitbot", Legitbot)
Legitbot:SetPosX(7)
Legitbot:SetPosY(-18)
Legitbot:SetWidth(85)
Legitbot:SetHeight(90)

local Legitbot_drawBut = draw_Button(Window, "legitbot.drawbutton", 22, 31, 70, 46, 0, 0, 0, 0, 1, "D", font, 15)
local Legitbot_draw_Groupbox = draw_Groupbox(LegitbotG, 31, 47, 338, 326)
local Legitbot_draw_GroupboxA = draw_Groupbox_a(LegitbotG, 53, -22, 295, 370)

local function Ragebot()
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(false)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(true)
end
local Ragebot = gui.Button(Window, "Ragebot", Ragebot)
Ragebot:SetPosX(7)
Ragebot:SetPosY(78)
Ragebot:SetWidth(85)
Ragebot:SetHeight(75)
local Ragebot_drawBut = draw_Button(Window, "ragebot.drawbutton", 22, 125, 70, 28, 0, -19, 0, 0, 2, "C", font, 0)
local Ragebot_draw_Groupbox = draw_Groupbox(RagebotG, 31, 47, 338, 326)
local Ragebot_draw_GroupboxA = draw_Groupbox_a(RagebotG, 53, -22, 295, 370)

local function Visuals()
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(false)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(true)
end
local Visuals = gui.Button(Window, "Visuals", Visuals)
Visuals:SetPosX(7)
Visuals:SetPosY(156)
Visuals:SetWidth(85)
Visuals:SetHeight(75)
local Visuals_drawBut = draw_Button(Window, "visuals.drawbutton", 22, 203, 70, 28, 0, -19, 0, 0, 3, "E", font, 0)
local Visuals_draw_Groupbox = draw_Groupbox(VisualsG, 31, 47, 338, 326)
local Visuals_draw_GroupboxA = draw_Groupbox_a(VisualsG, 53, -22, 295, 370)
local function Misc()
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(false)
    UserG:SetInvisible(true)
end
local Misc = gui.Button(Window, "Misc", Misc)
Misc:SetPosX(7)
Misc:SetPosY(234)
Misc:SetWidth(85)
Misc:SetHeight(75)
local Misc_drawBut = draw_Button(Window, "misc.drawbutton", 22, 280, 70, 30, 0, -19, 0, 0, 4, "F", font, 0)
local Misc_draw_Groupbox = draw_Groupbox(MiscG, 31, 47, 338, 326)
local Misc_draw_GroupboxA = draw_Groupbox_a(MiscG, 53, -22, 295, 370)
local function User()
    LegitbotG:SetInvisible(true)
    RagebotG:SetInvisible(true)
    VisualsG:SetInvisible(true)
    MiscG:SetInvisible(true)
    UserG:SetInvisible(false)
end
local User = gui.Button(Window, "User", User)
User:SetPosX(7)
User:SetPosY(312)
User:SetWidth(85)
User:SetHeight(90)
local User_drawBut = draw_Button(Window, "user.drawbutton", 22, 358, 70, 46, 0, -19, 0, -12, 5, "H", font, 0)
local User_draw_Groupbox = draw_Groupbox(UserG, 31, 47, 338, 326)
local User_draw_GroupboxA = draw_Groupbox_a(UserG, 53, -22, 295, 370)
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
--@gui reference
gui_custom_SenseUI_Reference = Window
gui_custom_Legitbot_Reference = LegitbotG
gui_custom_Ragebot_Reference = RagebotG
gui_custom_Visuals_Reference = VisualsG
gui_custom_Misc_Reference = MiscG
gui_custom_User_Reference = UserG
