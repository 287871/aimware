--[[
Working on aimware steam avatars circle
Steam picture come from Chicken4676 https://aimware.net/forum/user/17687 Thank you very much.
by qi
]]
--gui
local X, Y = draw.GetScreenSize()
local Avatars_Circle_Reference = gui.Reference("Visuals" , "Local" , "Camera")
local Avatars_Circle_Checkbox = gui.Checkbox(Avatars_Circle_Reference, "avatarscircle.enable", "Avatars Enable", 0)
local Avatars_Circle_X = gui.Slider(Avatars_Circle_Checkbox, "avatarscircle.x", "X", 400, 0, X) --You can save the drag position
local Avatars_Circle_Y = gui.Slider(Avatars_Circle_Checkbox, "avatarscircle.y", "Y", 70, 0, Y)
local Avatars_Circle_Clr = gui.ColorPicker(Avatars_Circle_Checkbox, "clr", "clr", 255, 255, 118, 255)
local Avatars_Circle_Clr2 = gui.ColorPicker(Avatars_Circle_Checkbox, "clr2", "clr2", 255, 255, 255, 255)
Avatars_Circle_X:SetInvisible(true)
Avatars_Circle_Y:SetInvisible(true)

--var and steam avatars
local renderer = {}
local tX, tY, offsetX, offsetY, _drag
local MENU = gui.Reference("MENU")
local font = draw.CreateFont('Verdana', 13.5, 11.5)
local font2 = draw.CreateFont('Verdana', 12, 11.5)
--get steam picture  From chicken 4676 https://aimware.net/forum/user/17687
local function get_steam_profile_picture(index)
	local Index=client.GetLocalPlayerIndex()
	local SteamID = client.GetPlayerInfo( Index )["SteamID"]
	local SteamID = "7656" .. (0x116ebff0000 + SteamID)
	
	local steamcommunity_body = http.Get("https://steamcommunity.com/profiles/" .. SteamID)
	local img_url = string.match(steamcommunity_body, "<link rel=\"image_src\" href=\"(https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/[^\n]+)")
	local img_url = string.sub(img_url, 1, string.len(img_url) - 3)
	local img_jpg_data = http.Get(img_url)
	return common.DecodeJPEG(img_jpg_data)
end
local RGBA, width, height = get_steam_profile_picture(client.GetLocalPlayerIndex())
local texture = draw.CreateTexture(RGBA, width, height)

--function

--Mouse drag
local function is_inside(a, b, x, y, w, h) 
    return 
    a >= x and a <= w and b >= y and b <= h 
end

local function drag_menu(x, y, w, h)
    if not MENU:IsActive() then
        return tX, tY
    end
    local mouse_down = input.IsButtonDown(1)
    if mouse_down then
        local X, Y = input.GetMousePos()
        if not _drag then
            local w, h = x + w, y + h
            if is_inside(X, Y, x, y, w, h) then
                offsetX, offsetY = X - x, Y - y
                _drag = true
            end
        else
            tX, tY = X - offsetX, Y - offsetY
            Avatars_Circle_X:SetValue(tX) 
            Avatars_Circle_Y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--renderer text
renderer.text = function(x, y, clr, shadow, string, font, flags)

    local alpha = 255
    local textW, textH = draw.GetTextSize(string)

    if font ~= nil then
        draw.SetFont(font)
    end

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    if flags == "c" then
        x = x - (textW / 2)
    elseif flags == "l" then
        x = x - textW
    elseif flags == "r" then
        x = x + textW
    end

    if shadow == 1 or true then
        draw.Color(0, 0, 0, alpha)
        draw.Text(x + 1, y + 1, string)
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
	draw.Text(x, y, string)
    alpha = nil
    x, y = nil
end

--renderer rectangle
renderer.rectangle = function(x, y, w, h, clr, fill, radius)

    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)

    if fill then
        draw.FilledRect(x, y, x + w, y + h)
    else
        draw.OutlinedRect(x, y, x + w, y + h)
    end

    if fill == "shadow" then
        draw.ShadowRect(x, y, x + w, y + h, radius)
    end

    alpha = nil
end

--renderer roundedrect
renderer.roundedrect = function(x, y, w, h, fill, radius, clr, tl, tr, bl, br)

    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    if fill then
        draw.RoundedRectFill(x, y, x + w, y + h, radius, tl, tr, bl, br)
    else
        draw.RoundedRect(x, y, x + w, y + h, radius, tl, tr, bl, br)
    end
    alpha = nil
end

--renderer circle
renderer.circle = function(x, y, radius, clr, fill)

    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    if fill then
        draw.FilledCircle(x, y, radius)
    else
        draw.OutlinedCircle(x, y, radius)
    end
    alpha = nil
end

--renderer gradient
renderer.gradient = function(x, y, w, h, clr, clr1, vertical)
    
    local r, g, b, a = clr1[1], clr1[2], clr1[3], clr1[4]
	local r1, g1, b1, a1 = clr[1], clr[2], clr[3], clr[4]

    if a and a1 == nil then
        a, a1 = 255, 255
    end

    if vertical then
        if clr1[4] ~= 0 then
            if a1 and a ~= 255 then
                for i = 0, w do
                    local a2 = i / w * a1
                    renderer.rectangle(x, y + w - i, w, 1, {r1, g1, b1, a2}, true)
                end
            else
                renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
            end
        end
        if a2 ~= 0 then
            for i = 0, h do
                local a2 = i / h * a
                renderer.rectangle(x, y + i, w, 1, {r, g, b, a2}, true)
            end
        end
    else
        if clr[4] ~= 0 then
            if a1 and a ~= 255 then
                for i = 0, w do
                    local a2 = i / w * a1
                    renderer.rectangle(x + w - i, y, 1, h, {r1, g1, b1, a2}, true)
                end
            else
                renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
            end
        end
        if a2 ~= 0 then
            for i = 0, w do
                local a2 = i / w * a
                renderer.rectangle(x + i, y, 1, h, {r, g, b, a2}, true)
            end
        end
    end
    a, a1 = nil, nil
end

--renderer circle_smooth
renderer.circle_smooth = function(x, y, radius, clr)
    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    for i = 0, radius * 0.2 do
        local a2 = i / radius * alpha
        renderer.circle(x, y, radius * 0.95 + i * 0.2, {clr[1], clr[2], clr[3], a2})
        renderer.circle(x, y, radius - i * 0.2, {clr[1], clr[2], clr[3], a2})
    end
    alpha = nil

end

--renderer circle_ring
renderer.circle_ring = function(x, y, start, radius, number, thickness, clr, number2)

    if thickness > radius then
        thickness = radius
    end
    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end
    local _number2 = 1
    if number2 ~= nil then
        _number2 = number2
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)

    for steps = start, number + start - 1, 1 do   

        local sin_cur = math.sin(math.rad((steps * _number2) + (45 * _number2)))
        local sin_old = math.sin(math.rad((steps * _number2) + (45 * _number2) - (2 * _number2)))
        local cos_cur = math.cos(math.rad((steps * _number2) + (45 * _number2)))
        local cos_old = math.cos(math.rad((steps * _number2) + (45 * _number2) - (2 * _number2)))
        local cur_point = nil
        local old_point = nil
        local cur_point = {x + sin_cur * radius, y + cos_cur * radius}    
        local old_point = {x + sin_old * radius, y + cos_old * radius}
        local cur_point2 = nil
        local old_point2 = nil
        local cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)}    
        local old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)}

        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])    
    
    end
    _number2 = nil
    alpha = nil
end

--renderer end

--alpha
local function alpha_stop(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

--On draw

--Let drag position save
local function PositionSave()
    if tX ~= Avatars_Circle_X:GetValue() or tY ~= Avatars_Circle_Y:GetValue() then
        tX, tY = Avatars_Circle_X:GetValue(), Avatars_Circle_Y:GetValue()
    end
end

--Information bar
local function Information()

    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50

    if entities.GetLocalPlayer() ~= nil then

        --Health
        renderer.gradient(x - 110, y - 23, 60, 23, {34, 34, 34, 0},{34, 34, 34, 255})

        --Money
        renderer.gradient(x + 50, y, 120, 20, {40, 40, 40, 255},{40, 40, 40, 0})

        --Misc
        renderer.gradient(x + 60, y - 35, 170, 25, {34, 34, 34, 255},{34, 34, 34, 0})

    end

end

--Health Transition animation
local function animation()
    
    local lp = entities.GetLocalPlayer()
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50
    local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 30
    if lp ~= nil then

        local health = lp:GetHealth()

        if healthAlpha == nil then
            healthAlpha =  180
        end
        if health * 1.8 ~= 180 then -- alpha animation
            healthAlpha = alpha_stop(healthAlpha - fade_factor, health * 1.8, 180)
        else
            healthAlpha = alpha_stop(healthAlpha + fade_factor, 0, health * 1.8)
        end

        if health > 75 then --Multiple blood colors
            r, g, b, a = 134, 200, 134, 200
        elseif health > 60 then
            r, g, b, a = 171, 151, 106, 200
        elseif health > 40 then
            r, g, b, a = 190, 90, 90, 200
        elseif health > 20 then
            r, g, b, a = 200, 0, 60, 200
        elseif health >= 0 then
            r, g, b, a = 255, 0, 0, 200
        end
        renderer.circle_ring(x, y, 4 - healthAlpha, 57, healthAlpha, 2, {r, g, b, a}, 2)

        if health > 75 then --Multiple blood colors  For smooth edges
            r, g, b, a = 134, 200, 134, 50
        elseif health > 60 then
            r, g, b, a = 171, 151, 106, 50
        elseif health > 40 then
            r, g, b, a = 190, 90, 90, 50
        elseif health > 20 then
            r, g, b, a = 200, 0, 60, 50
        elseif health >= 0 then
            r, g, b, a = 255, 0, 0, 50
        end
        renderer.circle_ring(x, y, 4 - healthAlpha, 57.5, healthAlpha, 1, {r, g, b, a}, 2)
        
    end

end

--Circle
local function Circle()

    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50
    local lp = entities.GetLocalPlayer()

    if lp ~= nil then

        --picture
        local r, g, b, a = 255, 255, 255, 255
        draw.Color(255, 255, 255, 255)
        draw.SetTexture(texture)
        draw.FilledRect(x - 39, y - 39, width - 145 + x, height - 145 + y)

        --Number plate
        renderer.circle(x, y + 37, 15, {80, 163, 248, 150},true)
        renderer.circle_smooth(x, y + 37, 15, {80, 163, 248, 255})

        --draw roundedrect
        renderer.roundedrect(x - 50.5, y - 50.5, 101, 101, false, 50.5, {34, 34, 34, 255}, 50, 50,50, 50)
        renderer.roundedrect(x - 46, y - 46, 92, 92, false, 46, {34, 34, 34, 255}, 50, 50,50, 50)
        renderer.roundedrect(x - 44, y - 44, 88, 88, false, 44, {34, 34, 34, 255}, 50, 50,50, 50)
        renderer.roundedrect(x - 55, y - 55, 110, 110, false, 55, {34, 34, 34, 255}, 50, 50,50, 50)

        --draw circle_smooth
        renderer.circle_smooth(x, y, 56, {34, 34, 34, 255})
        
    end

end

--Need to cover Armor
local function cover()

    local lp = entities.GetLocalPlayer()
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50 , y + 50
    local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 30
    if lp ~= nil then

        local armor = lp:GetProp("m_ArmorValue")

        if armorAlpha == nil then
            armorAlpha = 180
        end
        if armor * 1.8 ~= 180 then-- alpha animation
            armorAlpha = alpha_stop(armorAlpha - fade_factor, armor * 1.8, 180)
        else
            armorAlpha = alpha_stop(armorAlpha + fade_factor, 0, armor * 1.8)
        end

        renderer.circle_ring(x, y - 0.5, -45, 41, armorAlpha, 1, {80, 163, 248, 200}, 2)
        renderer.circle_ring(x, y - 0.5, -45, 41.5, armorAlpha, 0.8, {80, 163, 248, 50}, 2)
        renderer.circle_ring(x, y - 0.5, -45, 40.5, armorAlpha, 0.8, {80, 163, 248, 50}, 2)

    end

end

--Health, Money Text
local function Text()

    local lp = entities.GetLocalPlayer()
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50
    local indexlp = client.GetLocalPlayerIndex()
    local userName = client.GetPlayerNameByIndex(indexlp)
    local r, g, b, a = Avatars_Circle_Clr:GetValue()
    local r2, g2, b2, a2 = Avatars_Circle_Clr2:GetValue()

    if lp ~= nil then

        local health = lp:GetHealth()
        local money = lp:GetProp("m_iAccount")
        local teamnumber = lp:GetTeamNumber()

        if health > 75 then --Multiple blood colors
            hpr, hpg, hpb = 134, 200, 134
        elseif health > 60 then
            hpr, hpg, hpb = 171, 151, 106 
        elseif health > 40 then
            hpr, hpg, hpb = 190, 90, 90 
        elseif health > 20 then
            hpr, hpg, hpb = 200, 0, 60
        elseif health >= 0 then
            hpr, hpg, hpb = 255, 0, 0
        end

        if (engine.GetServerIP() == "loopback") then -- Server
            server = "localhost"
        elseif string.find(engine.GetServerIP(), "A") then
            server = "valve"
        else
            server = "unknown"
        end

        if string.len(userName) > 8 then -- Calculate name length
            userName = string.match(userName, [[........]])
            userName = userName.."..."
        end

        renderer.text(x - 52, y - 16, {hpr, hpg, hpb}, true, health.." hp", font2, "l") --Health
        renderer.text(x + 65, y + 5, {r, g, b, a}, true, "Money ● ", font2) --Money
        renderer.text(x + 110, y + 5, {r2, g2, b2, a2}, true, "$"..money, font2) --Money
        renderer.text(x - 5, y + 27, {r2, g2, b2, a2}, true, teamnumber, font) --Team number  
        renderer.text(x + 65, y - 27, {r2, g2, b2, a2}, true, server.."  Hello "..userName, font2) --misc

        renderer.roundedrect(x + 40, y - 35, 20, 25, true, 10, {34, 34, 34, 255})
    end

end

--Callbacks
callbacks.Register("Draw", "avatars_circle", function()
    if Avatars_Circle_Checkbox:GetValue() then
        PositionSave()
        Information()
        animation()
        Circle()
        cover()
        Text()
    end
end)

--end
