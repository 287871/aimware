--Working on aimware
--Steam picture come from Chicken4676 https://aimware.net/forum/user/17687 Thank you very much.
--by qi

--gui
local X, Y = draw.GetScreenSize()
local Steam_Avatars_Circle_Reference = gui.Reference("Visuals" , "Local" , "Camera")
local Steam_Avatars_Circle_Checkbox = gui.Checkbox(Steam_Avatars_Circle_Reference, "avatarscircle.enable", "Avatars Enable", 0)
local Steam_Avatars_Circle_X = gui.Slider(Steam_Avatars_Circle_Checkbox, "avatarscircle.x", "X", 400, 0, X) --You can save the drag position
local Steam_Avatars_Circle_Y = gui.Slider(Steam_Avatars_Circle_Checkbox, "avatarscircle.y", "Y", 70, 0, Y)
local Steam_Avatars_Circle_Clr = gui.ColorPicker(Steam_Avatars_Circle_Checkbox, "clr", "clr", 255, 255, 118, 255)
local Steam_Avatars_Circle_Clr2 = gui.ColorPicker(Steam_Avatars_Circle_Checkbox, "clr2", "clr2", 255, 255, 255, 255)
Steam_Avatars_Circle_X:SetInvisible(true)
Steam_Avatars_Circle_Y:SetInvisible(true)

--var and get steam picture
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
            Steam_Avatars_Circle_X:SetValue(tX) 
            Steam_Avatars_Circle_Y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--Gradient shadow
local function gradientH(x1, y1, x2, y2,col1, left)
    local w = x2 - x1
    local h = y2 - y1
 
    for i = 0, w do
        local a = (i / w) * col1[4]
        local r, g, b = col1[1], col1[2], col1[3]
        draw.Color(r,g,b, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end

--alpha
local function alpha_stop(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

--Circular
local function Circular(x, y, start, radius, number, thickness)

    if thickness > radius then
        thickness = radius
    end

    for steps = start, number + start - 1, 1 do   

        local sin_cur = math.sin(math.rad(steps))
        local sin_old = math.sin(math.rad(steps - 1))
        local cos_cur = math.cos(math.rad(steps))
        local cos_old = math.cos(math.rad(steps - 1))
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

end

--On draw

--Let drag position save
local function PositionSave()
    if tX ~= Steam_Avatars_Circle_X:GetValue() or tY ~= Steam_Avatars_Circle_Y:GetValue() then
        tX, tY = Steam_Avatars_Circle_X:GetValue(), Steam_Avatars_Circle_Y:GetValue()
    end
end

--Information bar
local function Information()

    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50
    local lp = entities.GetLocalPlayer()
    if lp ~= nil then
        --Health
        local r, g, b, a = 34, 34, 34, 255
        gradientH(x - 130, y, x, y - 23,{ r, g, b, a * 0.6 }, true)
        gradientH(x - 125, y, x, y - 23,{ r, g, b, a * 0.8 }, true)
        gradientH(x - 120, y, x, y - 23,{ r, g, b, a }, true)
        gradientH(x - 115, y, x, y - 23,{ r, g, b, a }, true)
        gradientH(x - 112, y, x, y - 23,{ r, g, b, a }, true)
        gradientH(x - 110, y, x, y - 23,{ r, g, b, a }, true)
        gradientH(x - 108, y, x, y - 23,{ r, g, b, a }, true)
        gradientH(x - 106, y, x, y - 23,{ r, g, b, a }, true)
        --Money
        local r, g, b, a = 40, 40, 40, 255
        gradientH(x, y, x + 170, y + 20,{ r, g, b, a * 0.6 }, false)
        gradientH(x, y, x + 165, y + 20,{ r, g, b, a * 0.8 }, false)
        gradientH(x, y, x + 165, y + 20,{ r, g, b, a }, false)
        gradientH(x, y, x + 160, y + 20,{ r, g, b, a }, false)
        gradientH(x, y, x + 155, y + 20,{ r, g, b, a }, false)
        gradientH(x, y, x + 152, y + 20,{ r, g, b, a }, false)
        gradientH(x, y, x + 150, y + 20,{ r, g, b, a }, false)
        gradientH(x, y, x + 148, y + 20,{ r, g, b, a }, false)
        gradientH(x, y, x + 146, y + 20,{ r, g, b, a }, false)
        --Misc
        local r, g, b, a = 34, 34, 34, 255
        gradientH(x + 42, y - 10, x + 220, y - 35,{ r, g, b, a * 0.8 }, false)
        gradientH(x + 42, y - 10, x + 215, y - 35,{ r, g, b, a * 0.6 }, false)
        gradientH(x + 42, y - 10, x + 210, y - 35,{ r, g, b, a }, false)
        gradientH(x + 42, y - 10, x + 208, y - 35,{ r, g, b, a }, false)
        gradientH(x + 42, y - 10, x + 206, y - 35,{ r, g, b, a }, false)
        gradientH(x + 42, y - 10, x + 204, y - 35,{ r, g, b, a }, false)
        gradientH(x + 42, y - 10, x + 202, y - 35,{ r, g, b, a }, false)

    end

end

--Health Transition animation
local function animation()
    
    local lp = entities.GetLocalPlayer()
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50
    local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 65
    if lp ~= nil then
        local health = lp:GetHealth()
        if healthA == nil then
            healthA = {alpha = 360}
        end
        if health * 3.6 ~= 360 then -- alpha animation
            healthA.alpha = alpha_stop(healthA.alpha - fade_factor, health * 3.6, 360)
        else
            healthA.alpha = alpha_stop(healthA.alpha + fade_factor, 0, health * 3.6)
        end

        if health > 75 then --Multiple blood colors
            draw.Color(134, 200, 134, 200)
        elseif health > 60 then
            draw.Color(171, 151, 106, 200) 
        elseif health > 40 then
            draw.Color(190, 90, 90, 200)  
        elseif health > 20 then
            draw.Color(200, 0, 60, 200) 
        elseif health >= 0 then
            draw.Color(255, 0, 0, 200) 
        end
        
        Circular(x, y, 95 - healthA.alpha, 57, healthA.alpha, 1)

        if health > 75 then --Multiple blood colors  For smooth edges
            draw.Color(134, 200, 134, 150)
        elseif health > 60 then
            draw.Color(171, 151, 106, 130) 
        elseif health > 40 then
            draw.Color(190, 90, 90, 130)  
        elseif health > 20 then
            draw.Color(200, 0, 60, 130) 
        elseif health >= 0 then
            draw.Color(255, 0, 0, 130) 
        end
        Circular(x, y, 95 - healthA.alpha, 57.5, healthA.alpha, 1)

    end

end

--Circle
local function Circle()

    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50
    local lp = entities.GetLocalPlayer()

    if lp ~= nil then
        -- To make the edges smooth
        local r , g , b , a = 36, 36, 36, 255
        draw.Color(r, g, b, a)
        draw.FilledCircle(x, y, 55)
        draw.Color(r, g, b, a * 0.8)
        draw.FilledCircle(x, y, 55.1)
        draw.FilledCircle(x, y, 55.2)
        draw.Color(r, g, b, a * 0.6)
        draw.FilledCircle(x, y, 55.3)
        draw.FilledCircle(x, y, 55.4)
        draw.FilledCircle(x, y, 55.5)
        draw.Color(r, g, b, a * 0.4)
        draw.FilledCircle(x, y, 55.6)
        draw.FilledCircle(x, y, 55.7)
        draw.FilledCircle(x, y, 55.8)
        draw.FilledCircle(x, y, 55.9)
        draw.Color(r, g, b, a * 0.2)
        draw.FilledCircle(x, y, 56)
        draw.FilledCircle(x, y, 56.1)
        draw.FilledCircle(x, y, 56.2)

        --picture
        local r, g, b, a = 255, 255, 255, 255
        draw.Color(255, 255, 255, 255)
        draw.SetTexture(texture)
        draw.FilledRect(x - 39, y - 39, width - 145 + x, height - 145 + y)

        --Number plate
        local r, g, b, a = 80, 163, 248, 50
        draw.Color(r, g, b, a)
        draw.FilledCircle(x, y + 37, 14)
        draw.Color(r, g, b, a * 0.8)
        draw.FilledCircle(x, y + 37, 14.1)
        draw.Color(r, g, b, a * 0.6)
        draw.FilledCircle(x, y + 37, 14.2)
        draw.FilledCircle(x, y + 37, 14.3)
        draw.Color(r, g, b, a * 0.4)
        draw.FilledCircle(x, y + 37, 14.4)
        draw.FilledCircle(x, y + 37, 14.5)
        draw.FilledCircle(x, y + 37, 14.6)
        draw.Color(r, g, b, a * 0.2)
        draw.FilledCircle(x, y + 37, 14.7)
        draw.FilledCircle(x, y + 37, 14.8)
        draw.FilledCircle(x, y + 37, 14.9)
        draw.FilledCircle(x, y + 37, 15)

        --draw Circular
        draw.Color(34, 34, 34, 255)
        Circular(x, y, 1, 55, 360, 16)
        --For smoothing
        local r, g, b, a = 34, 34, 34, 255
        draw.Color(r, g, b, a * 0.8)
        draw.OutlinedCircle(x, y, 39.9)
        draw.Color(r, g, b, a * 0.6)
        draw.OutlinedCircle(x, y, 39.8)
        draw.OutlinedCircle(x, y, 39.7)
        draw.Color(r, g, b, a * 0.4)
        draw.OutlinedCircle(x, y, 39.6)
        draw.OutlinedCircle(x, y, 39.5)
        draw.OutlinedCircle(x, y, 39.4)
        draw.Color(r, g, b, a * 0.2)
        draw.OutlinedCircle(x, y, 39.3)
        draw.OutlinedCircle(x, y, 39.2)
        draw.OutlinedCircle(x, y, 39.1)
        draw.OutlinedCircle(x, y, 39)
 
    end

end

--Need to cover Armor
local function cover()

    local lp = entities.GetLocalPlayer()
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50 , y + 50
    local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 65
    if lp ~= nil then

        local armor = lp:GetProp("m_ArmorValue")
        if armorA == nil then
            armorA = {alpha = 360}
        end
        if armor * 3.6 ~= 360 then-- alpha animation
            armorA.alpha = alpha_stop(armorA.alpha - fade_factor, armor * 3.6, 360)
        else
            armorA.alpha = alpha_stop(armorA.alpha + fade_factor, 0, armor * 3.6)
        end

        draw.Color(80, 163, 248, 200) --I don't want to repeat that, but for the sake of smoothness
        Circular(x, y - 0.5, 1, 41, armorA.alpha, 0.8)
        draw.Color(80, 163, 248, 150)
        Circular(x, y - 0.5, 1, 41.2, armorA.alpha, 0.8)
        draw.Color(80, 163, 248, 150)
        Circular(x, y - 0.5, 1, 40.8, armorA.alpha, 0.8)

    end
end

--Health, Money Text
local function Text()

    local lp = entities.GetLocalPlayer()
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50, y + 50
    local indexlp = client.GetLocalPlayerIndex()
    local userName = client.GetPlayerNameByIndex(indexlp)

    if lp ~= nil then

        local health = lp:GetHealth()
        local money = lp:GetProp("m_iAccount")
        local teamnumber = lp:GetTeamNumber()
        local x1, y1 = draw.GetTextSize(teamnumber)

        if health > 75 then --Multiple blood colors
            draw.Color(134, 200, 134, 255)
        elseif health > 60 then
            draw.Color(171, 151, 106, 255) 
        elseif health > 40 then
            draw.Color(190, 90, 90, 255)  
        elseif health > 20 then
            draw.Color(200, 0, 60, 255) 
        elseif health >= 0 then
            draw.Color(255, 0, 0, 255) 
        end
        draw.SetFont( font2 )
        draw.TextShadow(x - 92, y - 16, health.." hp") --Health


        draw.Color(Steam_Avatars_Circle_Clr:GetValue())
        draw.TextShadow(x + 65, y + 5, "Money ● ")

        draw.Color(Steam_Avatars_Circle_Clr2:GetValue())
        draw.TextShadow(x + 110, y + 5, "$"..money) --Money

        draw.SetFont( font )
        draw.TextShadow(x - x1 + 4, y + 27, teamnumber) --Team number  

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

        draw.SetFont(font2)
        draw.TextShadow(x + 65, y - 27, server.."  Hello "..userName) --Server UserName

    end
end

--Callbacks
callbacks.Register("Draw", function()
    if Steam_Avatars_Circle_Checkbox:GetValue() then
        PositionSave()
        Information()
        animation()
        Circle()
        cover()
        Text()
    end
end)
--end