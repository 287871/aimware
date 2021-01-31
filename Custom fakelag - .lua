--Custom fakelag 
--Made for aimware
--Part of the code comes from the aimware forum
--Producer: Qi 

--gui
local custom_fakelag_reference = gui.Reference( "Misc", "Enhancement" );
local custom_fakelag_maxticks = gui.Reference("Misc", "General", "Server", "sv_maxusrcmdprocessticks");
local custom_fakelag_maxticks = custom_fakelag_maxticks:GetValue()+1
local custom_fakelag_groupbox = gui.Groupbox( custom_fakelag_reference, "Custom fakelag ", 329, 312, 296, 0 );
local custom_fakelag_enabled = gui.Checkbox( custom_fakelag_groupbox, "customfakelag.enabled", "Enabled", 0 );
local custom_fakelag_combobox = gui.Combobox( custom_fakelag_groupbox, "customfakelag.state", "Player State", "static", "moving", "slow walk" );
local custom_fakelag_static_limit = gui.Slider( custom_fakelag_groupbox, "customfakelag.static.limit", "limit", 0, 0, custom_fakelag_maxticks/2 );
local custom_fakelag_static_frequency = gui.Slider( custom_fakelag_groupbox, "customfakelag.static.frequency", "Frequency", 1, 1, 50 );
local custom_fakelag_static_center = gui.Slider( custom_fakelag_groupbox, "customfakelag.static.center", "Center", 3, 3, custom_fakelag_maxticks );
local custom_fakelag_moving_limit = gui.Slider( custom_fakelag_groupbox, "customfakelag.moving.limit", "limit", 0, 0, custom_fakelag_maxticks/2 );
local custom_fakelag_moving_frequency = gui.Slider( custom_fakelag_groupbox, "customfakelag.moving.frequency", "Frequency", 1, 1, 50 );
local custom_fakelag_moving_center = gui.Slider( custom_fakelag_groupbox, "customfakelag.moving.center", "Center", 3, 3, custom_fakelag_maxticks );
local custom_fakelag_slowwalk_limit = gui.Slider( custom_fakelag_groupbox, "customfakelag.slowwalk.limit", "limit", 0, 0, custom_fakelag_maxticks/2 );
local custom_fakelag_slowwalk_frequency = gui.Slider( custom_fakelag_groupbox, "customfakelag.slowwalk.frequency", "Frequency", 1, 1, 50 );
local custom_fakelag_slowwalk_center = gui.Slider( custom_fakelag_groupbox, "customfakelag.slowwalk.center", "Center", 3, 3, custom_fakelag_maxticks );
local custom_fakelag_indicator = gui.Checkbox( custom_fakelag_groupbox, "customfakelag.indicator", "indicator", 0 );
local custom_fakelag_indicator_clr = gui.ColorPicker( custom_fakelag_indicator, "clr", "name", 4, 4, 4, 100 );
local custom_fakelag_indicator_clr2 = gui.ColorPicker( custom_fakelag_indicator, "clr2", "name", 65, 105, 225, 255 );
local custom_fakelag_indicator_clr3 = gui.ColorPicker( custom_fakelag_indicator, "clr3", "name", 106, 90, 205, 255 );
local x, y = draw.GetScreenSize();
local custom_fakelag_indicator_x = gui.Slider( custom_fakelag_groupbox, "customfakelag.indicato.x", "x", 20, 0, x );
local custom_fakelag_indicator_y = gui.Slider( custom_fakelag_groupbox, "customfakelag.indicato.y", "y", 600, 0, y )
custom_fakelag_indicator_x:SetInvisible(true)
custom_fakelag_indicator_y:SetInvisible(true)
-- UI
callbacks.Register("Draw", function()
    if custom_fakelag_enabled:GetValue() then

        custom_fakelag_combobox:SetInvisible(false)
        custom_fakelag_indicator:SetInvisible(false)

        if custom_fakelag_combobox:GetValue() == 0  then
            custom_fakelag_static_limit:SetInvisible(false)
            custom_fakelag_static_frequency:SetInvisible(false)
            custom_fakelag_static_center:SetInvisible(false)
        else
            custom_fakelag_static_limit:SetInvisible(true)
            custom_fakelag_static_frequency:SetInvisible(true)
            custom_fakelag_static_center:SetInvisible(true)
        end

        if custom_fakelag_combobox:GetValue() == 1  then
            custom_fakelag_moving_limit:SetInvisible(false)
            custom_fakelag_moving_frequency:SetInvisible(false)
            custom_fakelag_moving_center:SetInvisible(false)
        else
            custom_fakelag_moving_limit:SetInvisible(true)
            custom_fakelag_moving_frequency:SetInvisible(true)
            custom_fakelag_moving_center:SetInvisible(true)
        end

        if custom_fakelag_combobox:GetValue() == 2  then
            custom_fakelag_slowwalk_limit:SetInvisible(false)
            custom_fakelag_slowwalk_frequency:SetInvisible(false)
            custom_fakelag_slowwalk_center:SetInvisible(false)
        else
            custom_fakelag_slowwalk_limit:SetInvisible(true)
            custom_fakelag_slowwalk_frequency:SetInvisible(true)
            custom_fakelag_slowwalk_center:SetInvisible(true)
        end
    else
        custom_fakelag_combobox:SetInvisible(true)   
        custom_fakelag_indicator:SetInvisible(true)   
        custom_fakelag_static_limit:SetInvisible(true)
        custom_fakelag_static_frequency:SetInvisible(true)       
        custom_fakelag_static_center:SetInvisible(true)     
        custom_fakelag_moving_limit:SetInvisible(true)
        custom_fakelag_moving_frequency:SetInvisible(true)
        custom_fakelag_moving_center:SetInvisible(true)
        custom_fakelag_slowwalk_limit:SetInvisible(true)
        custom_fakelag_slowwalk_frequency:SetInvisible(true)
        custom_fakelag_slowwalk_center:SetInvisible(true)
    end
end)
--var
local font = draw.CreateFont( "Verdana", 12.5, 11.5 )
local tX, tY, offsetX, offsetY, _drag

--function

local function rect( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    draw.FilledRect( x, y, x + w, y + h );
end

local function gradientH(x1, y1, x2, y2,col1, left)
    local w = x2 - x1
    local h = y2 - y1
 
    for i = 0, w do
        local a = (i / w) * col1[4]
        local r, g, b = col1[1], col1[2], col1[3], col1[4];
        draw.Color(r,g,b, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end

local function gradientV( x, y, w, h, col1,down )

    local r, g, b ,a= col1[1], col1[2], col1[3], col1[4];

    for i = 1, h do
        local a = i / h * col1[4];
        if down then
            rect( x, y + i, w, 1, { r, g, b, a } );
        else
            rect( x, y - i, w, 1, { r, g, b, a } );
        end
    end
end

local function draw_GradientRect(x, y, w, h, dir,  col1 ,  col2  )--Gradient rectangle 

    local r, g, b ,a= col1[1], col1[2], col1[3], col1[4]; 
    local r2, g2, b2 ,a2= col2[1], col2[2], col2[3], col2[4]; 
    if dir == 0  then   

    gradientV(x , y + h-w, w , h ,  {r2, g2, b2 ,a2} , true)
    gradientV(x , y + w , w , h ,  {r, g, b ,a} , false)
    elseif dir == 1  then

    gradientH(x ,y , w + x, h+y,  {r, g, b ,a}, true)
    gradientH(x ,y , w + x, h+y,  {r2, g2, b2 ,a2}, false)
    elseif dir ~= 1 or 0 then
        print( "GradientRect:Unexpected characters '"..dir.."' (Please use it 0 or 1)" )
    end

end

--Mouse drag
local is_inside = function(a, b, x, y, w, h) 
    return 
    a >= x and a <= w and b >= y and b <= h 
end

local drag_menu = function(x, y, w, h)
    if not gui.Reference("MENU"):IsActive() then
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
            custom_fakelag_indicator_x:SetValue(tX) 
            custom_fakelag_indicator_y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--jitter fakelag
local function jitter_fakelag()
    if tX ~= custom_fakelag_indicator_x:GetValue() or tY ~= custom_fakelag_indicator_y:GetValue() then -- Make location saveable
        tX, tY = custom_fakelag_indicator_x:GetValue(),custom_fakelag_indicator_y:GetValue()
    end

    local lp = entities.GetLocalPlayer();
    if lp ~= nil then

        local velocityX = lp:GetPropFloat( "localdata", "m_vecVelocity[0]" );
        local velocityY = lp:GetPropFloat( "localdata", "m_vecVelocity[1]" );
        local velocity = math.sqrt( velocityX^2 + velocityY^2 );
        local FinalVelocity = math.min( 9999, velocity ) + 0.2;
        local miscM = gui.GetValue("misc.master")
        if custom_fakelag_enabled:GetValue() then
            if miscM and math.floor(FinalVelocity) == 0 then

                local maths = (custom_fakelag_static_limit:GetValue() * math.cos((globals.RealTime()) / (custom_fakelag_static_frequency:GetValue()*(0.01)))+ custom_fakelag_static_center:GetValue());
                gui.SetValue("misc.fakelag.factor", maths)

            elseif miscM and math.floor(FinalVelocity) > 0 then
    
                local maths = (custom_fakelag_moving_limit:GetValue() * math.cos((globals.RealTime()) / (custom_fakelag_moving_frequency:GetValue()*(0.01)))+ custom_fakelag_moving_center:GetValue());
                gui.SetValue("misc.fakelag.factor", maths)
            end
            if  miscM and gui.GetValue("rbot.master") and gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then

                local maths = (custom_fakelag_slowwalk_limit:GetValue() * math.cos((globals.RealTime()) / (custom_fakelag_slowwalk_frequency:GetValue()*(0.01)))+ custom_fakelag_slowwalk_center:GetValue());
                gui.SetValue("misc.fakelag.factor", maths)
            end
            
            --On draw jitter ind
            if miscM and gui.GetValue("rbot.master") and custom_fakelag_indicator:GetValue() then
               
                local x, y = drag_menu(tX, tY, 190, 70);
                local r, g, b, a = custom_fakelag_indicator_clr:GetValue();
                local r2, g2, b2, a2 = custom_fakelag_indicator_clr2:GetValue();
                local r3, g3, b3, a3 = custom_fakelag_indicator_clr3:GetValue();
                local math_floor =  math.floor(math.sin(globals.RealTime() * 1 + 100) * 80 + 200)
                local math_floor2 =  math.floor(math.sin(globals.RealTime() * 0.75 + 100) * 80 + 200)
                local math_floor3 =  math.floor(math.sin(globals.RealTime() * 2 + 100) * 80 + 112)
                local st = lp:GetProp("m_flSimulationTime")
                local std = globals.CurTime() - st
                local choke = (std / globals.TickInterval())
                local percentage = 100 / client.GetConVar("sv_maxusrcmdprocessticks") * choke
                local maxticks = gui.Reference("Misc", "General", "Server", "sv_maxusrcmdprocessticks");
                local maxticks = maxticks:GetValue()

                draw_GradientRect( x, y, 10+math_floor2/2.5 , 2, 1 , {255, 255, 255, 0}, {r2, g2, b2, a2});
                draw_GradientRect( x, y+70, 20+math_floor2/2 , 2, 1 , {255, 255, 255, 0}, {r2, g2, b2, a2});
                draw_GradientRect( x, y+22, 20+percentage*1.8 , 3, 1 , {r2, g2, b2, a2*0.5}, {255, 255, 255, 0});
                draw_GradientRect( x, y+2, 200, 20, 1 , {255, 255, 255, 0}, {r, g, b, a});
                draw_GradientRect( x, y+25, 200, 45, 1 , {255, 255, 255, 0}, {r, g, b, a});
                draw_GradientRect( x, y, 1+math_floor/16, 71, 1 , {255, 255, 255, 0}, {r2, g2, b2, a2});
                draw_GradientRect( x, y+19, 20+gui.GetValue("misc.fakelag.factor")*5 , 3, 1 , {r2, g2, b2, a2*0.5}, {255, 255, 255, 0});
                draw.Color( r2, g2, b2, a2 );
                draw.FilledRect( x, y, x+2, y+70 );
                --text
                draw.SetFont( font )
                draw.Color( r3, g3, b3, a3 );
                draw.TextShadow( x+5, y+6, "FAKE LAG" )
                draw.TextShadow( x+5, y+30, "HISTORY" )
                local a3_1 = math_floor3+60
                draw.Color( 34, 156, 70, a3_1 );
                if gui.GetValue("misc.fakelag.type") == 0 then
                 
                    draw.Text( x+55, y+6, "NORMAL" )
                elseif gui.GetValue("misc.fakelag.type") == 1 then
                    
                    draw.Text( x+55, y+6, "ADAPTIVE" )
                elseif gui.GetValue("misc.fakelag.type") == 2 then
                   
                    draw.Text( x+55, y+6, "RANDOM" )
                elseif gui.GetValue("misc.fakelag.type") == 3 then
                  
                    draw.Text( x+55, y+6, "SWITCH" )
                end

                draw.Color( 65, 105, 225, 255 );    
                draw.TextShadow( x+120, y+7, "AIMWARE" )
                draw.Color( 189, 108, 39, 255 ); 
                if math.floor(FinalVelocity) == 0 then
                    
                    draw.TextShadow( x+55, y+30, custom_fakelag_static_center:GetValue().."-"..gui.GetValue("misc.fakelag.factor").."-"..custom_fakelag_static_limit:GetValue().."-"..custom_fakelag_static_frequency:GetValue() )
                    draw.TextShadow(  x+120, y+30, "M:"..maxticks )
                    draw.TextShadow(  x+155, y+30, "F:"..custom_fakelag_static_frequency:GetValue() )
                elseif math.floor(FinalVelocity) > 0 then

                    draw.TextShadow( x+55, y+30, custom_fakelag_moving_center:GetValue().."-"..gui.GetValue("misc.fakelag.factor").."-"..custom_fakelag_moving_limit:GetValue().."-"..custom_fakelag_moving_frequency:GetValue() )
                    draw.TextShadow(  x+120, y+30, "M:"..maxticks )
                    draw.TextShadow(  x+155, y+30, "F:"..custom_fakelag_moving_frequency:GetValue() )
                end
                if gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then

                    draw.TextShadow( x+55, y+30, custom_fakelag_slowwalk_center:GetValue().."-"..gui.GetValue("misc.fakelag.factor").."-"..custom_fakelag_slowwalk_limit:GetValue().."-"..custom_fakelag_slowwalk_frequency:GetValue() )
                    draw.TextShadow(  x+120, y+30, "M:"..maxticks )
                    draw.TextShadow(  x+155, y+30, "F:"..custom_fakelag_slowwalk_frequency:GetValue() )
                end
            end
        end    
    end
end
callbacks.Register("Draw", jitter_fakelag);

--Hit count ind
local s = 0;
local h = 0;
local m = 0;
local t = nil

callbacks.Register( "FireGameEvent", "Events", function(e)
    if e:GetName() == "player_hurt" then
        if not entities.GetLocalPlayer() then return end
        if not entities.GetLocalPlayer():IsAlive() then return end
        local ME = client.GetLocalPlayerIndex()
        if client.GetPlayerIndexByUserID(e:GetInt("attacker")) == ME and client.GetPlayerIndexByUserID(e:GetInt("userid")) ~= ME and not entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetName():match("knife") and t then
            h=h+1
        end
    end
    if e:GetName() == "weapon_fire" then
        if not entities.GetLocalPlayer() then return end
        if not entities.GetLocalPlayer():IsAlive() then return end
        if client.GetPlayerIndexByUserID(e:GetInt("userid")) == client.GetLocalPlayerIndex() and not entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetName():match("knife") and t then
            s=s+1
        end
    end
    
    if e:GetName() == "round_announce_match_start" or e:GetName() == "player_connect_full" then
        s,h,m=0,0,0
    end
end)

callbacks.Register( "Draw", "UpdateValues", function()
    if not entities.GetLocalPlayer() then 
        return 
    end

    if tX ~= custom_fakelag_indicator_x:GetValue() or tY ~= custom_fakelag_indicator_y:GetValue() then -- Make location saveable
        tX, tY = custom_fakelag_indicator_x:GetValue(),custom_fakelag_indicator_y:GetValue()
    end
    m=s-h
    local x, y = drag_menu(tX, tY, 190, 70);
    local w1, h1 = draw.GetTextSize(h);
    local w2, h2 = draw.GetTextSize(m);
    local p = string.format("%.1f",s ~= 0 and (h/s*100) or 0)
    if custom_fakelag_enabled:GetValue() then
        if gui.GetValue("misc.master") and gui.GetValue("rbot.master") and custom_fakelag_indicator:GetValue() then
            draw.SetFont(font)
            draw.Color( custom_fakelag_indicator_clr3:GetValue() )
            draw.TextShadow( x+6, y+52, "HITS:" )
            draw.TextShadow( x+55, y+52, "MISSES:" )
            draw.TextShadow( x+120, y+52, "PERCENT:" )

            draw.Color( 30, 144, 255, 255 ); 
            draw.TextShadow( x+45-w1/2, y+52, h )
            draw.Color( 255, 0, 0, 255 ); 
            draw.TextShadow( x+108-w2/2, y+52, m )
            draw.Color( 189, 108, 39, 255 ); 
            draw.TextShadow( x+170, y+52, p.."%" )
        end
    end
end)

callbacks.Register("AimbotTarget", function(e)
    t = e:GetName() ~= nil and e or nil
end)

--end