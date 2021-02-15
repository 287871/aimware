--[[
Working on aimware enemy information watermark
by qi
]]

--gui
local X, Y = draw.GetScreenSize()
local Enemy_information_Reference = gui.Reference("Misc", "General", "Extra")
local Enemy_information_Enable = gui.Checkbox(Enemy_information_Reference, "enemyinformation", "Enemy information watermark", 0)
local Enemy_information_Clr = gui.ColorPicker(Enemy_information_Enable, "clr", "clr", 169, 251, 255, 100)
local Enemy_information_Clr2 = gui.ColorPicker(Enemy_information_Enable, "clr2", "clr2", 171, 77, 255, 100)
local Enemy_information_X = gui.Slider(Enemy_information_Enable, "x", "x", 400, 0, X)
local Enemy_information_Y = gui.Slider(Enemy_information_Enable, "y", "y", 400, 0, Y)

Enemy_information_X:SetInvisible(true)
Enemy_information_Y:SetInvisible(true)
--var
local font = draw.CreateFont("Verdana", 12)
local renderer = {}
local MENU = gui.Reference("MENU")
local tX, tY, offsetX, offsetY, _drag

--function

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

    if shadow then
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


--renderer line
renderer.line = function(x, y, w, h, clr)

    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    draw.Line(x, y, x + w, y + h)
    alpha = nil
end

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
            Enemy_information_X:SetValue(tX) 
            Enemy_information_Y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--Let drag position save
local function PositionSave()
    if tX ~= Enemy_information_X:GetValue() or tY ~= Enemy_information_Y:GetValue() then
        tX, tY = Enemy_information_X:GetValue(), Enemy_information_Y:GetValue()
    end
end

local function getenemy()
    local enemy = {}
    local lp = entities.GetLocalPlayer()
    if lp ~= nil then
      local players = entities.FindByClass("CCSPlayer")
        for i = 1, #players do
            local players = players[i]
            local name = players:GetName()
            if players:GetTeamNumber() ~= lp:GetTeamNumber() then
                table.insert(enemy, players)
            end
        end
    end 
    return enemy
end

local function string_len(var, frequency)
    if string.len(var) > frequency then
        var = string.match(var, [[.....]])
        var = var.."..."
    end
    return var
end

local function Ondraw(enemy)
    
    local x, y = drag_menu(tX, tY, 400, 100)

    local r, g, b, a = Enemy_information_Clr:GetValue()
    local r2, g2, b2, a2 = Enemy_information_Clr2:GetValue()
    local i = 0
    for index, players in pairs(enemy) do
        i = index
    end
    renderer.rectangle(x, y, 400, 20 + (i * 20), {r, g, b, a}, "shadow", 5)

    renderer.line(x, y + 15, 400, 0, {r2, g2, b2, a2})
    renderer.line(x + 45, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})
    renderer.line(x + 85, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})
    renderer.line(x + 135, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})
    renderer.line(x + 175, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})

    renderer.text(x + 10, y + 4, {255, 255, 255, 255}, true, "name", font)
    renderer.text(x + 50, y + 4, {255, 255, 255, 255}, true, "Health", font)
    renderer.text(x + 95, y + 4, {255, 255, 255, 255}, true, "money", font)
    renderer.text(x + 137, y + 4, {255, 255, 255, 255}, true, "activity", font)
    renderer.text(x + 250, y + 4, {255, 255, 255, 255}, true, "weapons", font)
    
    for index, players in pairs(enemy) do

        local ActiveWeapon = players:GetPropEntity("m_hActiveWeapon"):GetName()
        local Weapon = players:GetPropEntity("m_hMyWeapons", "002"):GetName()
        local Weapon2 = players:GetPropEntity("m_hMyWeapons", "001"):GetName()
        local Weapon3 = players:GetPropEntity("m_hMyWeapons", "000"):GetName()

        if ActiveWeapon then
            ActiveWeapon = string.match(ActiveWeapon, [[weapon_(.+)]])
        else
            ActiveWeapon = ""
        end

        if Weapon then
            Weapon = string.match(Weapon, [[weapon_(.+)]]).." , "
        else
            Weapon = ""
        end

        if Weapon2 then
            Weapon2= string.match(Weapon2, [[weapon_(.+)]]).." , "
        else
            Weapon2 = ""
        end

        if Weapon3 then
            Weapon3= string.match(Weapon3, [[weapon_(.+)]])
        else
            Weapon3 = ""
        end

        local health = players:GetHealth()
        
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
        
        if players:IsAlive() then
            IsAlive = 'true'
        else
            IsAlive = 'nil'
        end

        renderer.text(x + 5, y + (index * 20) + 5, {255, 255, 255, 255}, true, string_len(players:GetName(), 5), font)
        renderer.text(x + 50, y + (index * 20) + 5, {hpr, hpg, hpb, 255}, true, health.."hp", font)
        renderer.text(x + 92, y + (index * 20) + 5, {255, 255, 118, 255}, true, "$"..players:GetProp("m_iAccount"), font)
        renderer.text(x + 155, y + (index * 20) + 5, {255, 255, 255, 255}, true, IsAlive, font, "c")
        renderer.text(x + 185, y + (index * 20) + 5, {255, 255, 255, 255}, true, ActiveWeapon.."     "..Weapon..Weapon2..Weapon3, font)

    end

end


callbacks.Register("Draw", function()
    if entities.GetLocalPlayer() and Enemy_information_Enable:GetValue() then
        PositionSave()
        Ondraw(getenemy())
    end

end)