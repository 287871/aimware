LoadScript("SenseUI/SenseUI.lua")
UnloadScript("SenseUI/SenseUI.lua")

local Ragebot_Accuracy_WeaponMovement_Reference = gui.Reference("Ragebot", "Accuracy", "Weapon Movement")
local Ragebot_Accuracy_Weapon_Reference = gui.Reference("Ragebot", "Accuracy", "Weapon")
local Ragebot_Hitscan_Mode_Reference = gui.Reference("Ragebot", "Hitscan", "Mode")
local Legitbot_Triggerbot_Weapon_Reference = gui.Reference("Legitbot", "Triggerbot", "Weapon")
local Legitbot_Weapon_Visibility_Reference = gui.Reference("Legitbot", "Weapon", "Visibility")
local Legitbot_Aimbot_HitboxSelection_Reference = gui.Reference("Legitbot", "Aimbot", "Hitbox Selection")
local Legitbot_Weapon_Accuracy_Reference = gui.Reference("Legitbot", "Weapon", "Accuracy")
local Legitbot_Weapon_Aiming_Reference = gui.Reference("Legitbot", "Weapon", "Aiming")
local Legitbot_Weapon_Target_Reference = gui.Reference("Legitbot", "Weapon", "Target")


local window_bkey = ui.Keys.delete
local window_bact = false
local window_bdet = ui.KeyDetection.on_hotkey
local window_moveable = true
local show_gradient = true
local function draw_callback()

    if ui.BeginWindow("senseui.menu", 50, 50, 650, 700) then
        ui.DrawTabBar()
        if show_gradient then
            ui.AddGradient()
        end

        ui.SetWindowOpenKey(window_bkey)
        ui.SetWindowDrawTexture( false )
        ui.SetWindowMoveable( window_moveable )


        if ui.BeginTab("ragebot", ui.Icons.rage) then
            if ui.BeginGroup("rbot.aimbot", "Aimbot", 25, 25, 250, 650) then

                gui.SetValue("rbot.master", ui.Checkbox("Enable", gui.GetValue("rbot.master")))
                
                gui.SetValue("rbot.aim.enable", ui.Checkbox("Automatic fire", gui.GetValue("rbot.aim.enable")))

                gui.SetValue("rbot.aim.automation.pistol", ui.Checkbox("Auto pistol", gui.GetValue("rbot.aim.automation.pistol")))

                local Weapon_selection = string.match(Ragebot_Hitscan_Mode_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                gui.SetValue("rbot.hitscan.mode."..Weapon..".autowall", ui.Checkbox("Auto wall", gui.GetValue("rbot.hitscan.mode."..Weapon..".autowall")))
                
                gui.SetValue("rbot.aim.automation.revolver", ui.Checkbox("Auto revolver", gui.GetValue("rbot.aim.automation.revolver")))

                gui.SetValue("rbot.aim.target.fov",ui.Slider("Field of vision", 0, 180, "%", "0%", "180%", false, gui.GetValue("rbot.aim.target.fov")))

                gui.SetValue("rbot.aim.target.lock", ui.Checkbox("Aim lock", gui.GetValue("rbot.aim.target.lock")))

                gui.SetValue("rbot.aim.target.silentaim", ui.Checkbox("Silent aim", gui.GetValue("rbot.aim.target.silentaim")))

                gui.SetValue("rbot.accuracy.posadj.backtrack", ui.Checkbox("Backtracking", gui.GetValue("rbot.accuracy.posadj.backtrack")))

                gui.SetValue("rbot.accuracy.posadj.resolver", ui.Checkbox("Resolver", gui.GetValue("rbot.accuracy.posadj.resolver")))

                if gui.GetValue("rbot.accuracy.movement.slowkey") == 0 then
                    ui.Label("Slow Walk")
                    gui.SetValue("rbot.accuracy.movement.slowkey", ui.Bind("slow", false, gui.GetValue("rbot.accuracy.movement.slowkey")))
                end
                
                if gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 then
                    gui.SetValue("rbot.accuracy.movement.slowspeed",ui.Slider("Slow speed", 0, 130, "%", "0%", "100%", false, gui.GetValue("rbot.accuracy.movement.slowspeed")))
                    gui.SetValue("rbot.accuracy.movement.slowkey", ui.Bind("slow", false, gui.GetValue("rbot.accuracy.movement.slowkey")))
                end
                
                local Weapon_selection = string.match(Ragebot_Accuracy_Weapon_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                gui.SetValue("rbot.accuracy.weapon."..Weapon..".hitchance",ui.Slider("Hit chance", 0, 100, "%", "0%", "100%", false, gui.GetValue("rbot.accuracy.weapon."..Weapon..".hitchance")))

                gui.SetValue("rbot.accuracy.weapon."..Weapon..".mindmg",ui.Slider("Min damage", 0, 130, "", "0", "130", false, gui.GetValue("rbot.accuracy.weapon."..Weapon..".mindmg")))

                gui.SetValue("rbot.accuracy.weapon.shared.antirecoil", ui.Checkbox("Anti-recoil", gui.GetValue("rbot.accuracy.weapon.shared.antirecoil")))

                ui.Label("Double fire")
                local doublefire = 0
                if Weapon ~= "sniper" and Weapon ~= "scout" and Weapon ~= "zeus" then
                    gui.SetValue("rbot.accuracy.weapon."..Weapon..".doublefire", ui.Combo("doublefire", {"Off", "Shift", "Rapid"}, gui.GetValue("rbot.accuracy.weapon."..Weapon..".doublefire") + 1 - 1))
                    if gui.GetValue("rbot.accuracy.weapon."..Weapon..".doublefire") ~= 0 then
                        gui.SetValue("rbot.accuracy.weapon."..Weapon..".doublefirehc",ui.Slider("Double fire hit chance", 0, 100, "%", "0%", "100%", false, gui.GetValue("rbot.accuracy.weapon."..Weapon..".doublefirehc")))
                    end

                end
                
                gui.SetValue("rbot.hitscan.precisehitscan", ui.Checkbox("Precise hitscan", gui.GetValue("rbot.hitscan.precisehitscan")))

                gui.SetValue("rbot.hitscan.predictive", ui.Checkbox("Predictive", gui.GetValue("rbot.hitscan.predictive")))

                gui.SetValue("rbot.hitscan.maxprocessingtime",ui.Slider("Max processing time", 5, 75, "%", "5%", "75%", false, gui.GetValue("rbot.hitscan.maxprocessingtime")))

                ui.EndGroup()
            end

            if ui.BeginGroup("rbot.autostop", "Auto Stop", 295, 25, 250, 145) then

                local Weapon_selection = string.match(Ragebot_Accuracy_WeaponMovement_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)
                
                gui.SetValue("rbot.accuracy.wpnmovement."..Weapon..".autostop", ui.Checkbox("Enable", gui.GetValue("rbot.accuracy.wpnmovement."..Weapon..".autostop")))

                gui.SetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.betweenshots", ui.Checkbox("Between shots", gui.GetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.betweenshots")))

                gui.SetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.early", ui.Checkbox("Early", gui.GetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.early")))

                gui.SetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.slowwalk", ui.Checkbox("Slow walk", gui.GetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.slowwalk")))

                gui.SetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.duck", ui.Checkbox("Duck", gui.GetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.duck")))

                gui.SetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.inmolotov", ui.Checkbox("In molotov", gui.GetValue("rbot.accuracy.wpnmovement."..Weapon..".autostopopts.inmolotov")))
                
                ui.EndGroup()
            end

            if ui.BeginGroup("rbot.mode", "Hitscan mode", 295, 190, 250, 250) then

                local Weapon_selection = string.match(Ragebot_Hitscan_Mode_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                ui.Label("----------------Bodyaim----------------")

                gui.SetValue("rbot.hitscan.mode."..Weapon..".bodyaim.force", ui.Checkbox("Force", gui.GetValue("rbot.hitscan.mode."..Weapon..".bodyaim.force"))) 

                gui.SetValue("rbot.hitscan.mode."..Weapon..".bodyaim.lethal", ui.Checkbox("Lethal", gui.GetValue("rbot.hitscan.mode."..Weapon..".bodyaim.lethal"))) 

                gui.SetValue("rbot.hitscan.mode."..Weapon..".bodyaim.onshot", ui.Checkbox("On shot", gui.GetValue("rbot.hitscan.mode."..Weapon..".bodyaim.onshot"))) 

                gui.SetValue("rbot.hitscan.mode."..Weapon..".bodyaim.safepoint", ui.Checkbox("No head safepoint", gui.GetValue("rbot.hitscan.mode."..Weapon..".bodyaim.safepoint"))) 

                ui.Label("----------Prioritize safe point----------")

                gui.SetValue("rbot.hitscan.mode."..Weapon..".prefersafe.body", ui.Checkbox("Body", gui.GetValue("rbot.hitscan.mode."..Weapon..".prefersafe.body"))) 

                gui.SetValue("rbot.hitscan.mode."..Weapon..".prefersafe.head", ui.Checkbox("Head", gui.GetValue("rbot.hitscan.mode."..Weapon..".prefersafe.head"))) 

                gui.SetValue("rbot.hitscan.mode."..Weapon..".prefersafe.limbs", ui.Checkbox("Limbs", gui.GetValue("rbot.hitscan.mode."..Weapon..".prefersafe.limbs"))) 
                
                ui.Label("------------Force safe point------------")

                gui.SetValue("rbot.hitscan.mode."..Weapon..".forcesafe.body", ui.Checkbox("Body", gui.GetValue("rbot.hitscan.mode."..Weapon..".forcesafe.body"))) 

                gui.SetValue("rbot.hitscan.mode."..Weapon..".forcesafe.head", ui.Checkbox("Head", gui.GetValue("rbot.hitscan.mode."..Weapon..".forcesafe.head"))) 

                gui.SetValue("rbot.hitscan.mode."..Weapon..".forcesafe.limbs", ui.Checkbox("Limbs", gui.GetValue("rbot.hitscan.mode."..Weapon..".forcesafe.limbs"))) 

            ui.EndGroup()
            end

            if ui.BeginGroup("rbot.misc", "Misc", 295, 460, 250, 215) then

                ui.Label("Auto Scope")
                gui.SetValue("rbot.aim.automation.scope", ui.Combo("scope", {"Off", "On - auot unzoom", "On - no unzoom"}, gui.GetValue("rbot.aim.automation.scope") + 1) - 1)

            ui.EndGroup()
            end
        ui.EndTab()
        end

        if ui.BeginTab( "anti-aim", ui.Icons.antiaim) then

            if ui.BeginGroup("rbot.antiaim", "Anti-aim", 25, 25, 250, 650) then

                if gui.GetValue("rbot.master") then

                    gui.SetValue("rbot.antiaim.advanced.autodir.edges", ui.Checkbox("Auto direction at edges", gui.GetValue("rbot.antiaim.advanced.autodir.edges"))) 

                    gui.SetValue("rbot.antiaim.advanced.autodir.targets", ui.Checkbox("Auto direction at targets", gui.GetValue("rbot.antiaim.advanced.autodir.targets"))) 

                    ui.Label("-------------Base direction-------------")

                    gui.SetValue("rbot.antiaim.base",ui.Slider("Base offset", -180, 180, "°", "-180°", "180°", false, string.gsub(gui.GetValue("rbot.antiaim.base"),'[%a%a"]'," ") * 1))

                    gui.SetValue("rbot.antiaim.base.rotation",ui.Slider("Rotation offset", -58, 58, "°", "-58°", "58°", false, gui.GetValue("rbot.antiaim.base.rotation")))

                    gui.SetValue("rbot.antiaim.base.lby",ui.Slider("Lby offset", -180, 180, "°", "-180°", "180°", false, gui.GetValue("rbot.antiaim.base.lby")))

                    ui.Label("Pitch Angle")
                    gui.SetValue("rbot.antiaim.advanced.pitch", ui.Combo("pitch", {"Off", "89°", "180°"}, gui.GetValue("rbot.antiaim.advanced.pitch") + 1) - 1)

                    if gui.GetValue("rbot.antiaim.advanced.autodir.edges") then

                        ui.Label("------------Left direction------------")

                        gui.SetValue("rbot.antiaim.left",ui.Slider("Base offset", -180, 180, "°", "-180°", "180°", false, string.gsub(gui.GetValue("rbot.antiaim.left"),'[%a%a"]'," ") * 1))

                        gui.SetValue("rbot.antiaim.left.rotation",ui.Slider("Rotation offset", -58, 58, "°", "-58°", "58°", false, gui.GetValue("rbot.antiaim.left.rotation")))
    
                        gui.SetValue("rbot.antiaim.left.lby",ui.Slider("Lby offset", -180, 180, "°", "-180°", "180°", false, gui.GetValue("rbot.antiaim.left.lby")))

                        ui.Label("-----------Right direction-----------")

                        gui.SetValue("rbot.antiaim.right",ui.Slider("Base offset", -180, 180, "°", "-180°", "180°", false, string.gsub(gui.GetValue("rbot.antiaim.right"),'[%a%a"]'," ") * 1))

                        gui.SetValue("rbot.antiaim.right.rotation",ui.Slider("Rotation offset", -58, 58, "°", "-58°", "58°", false, gui.GetValue("rbot.antiaim.right.rotation")))
    
                        gui.SetValue("rbot.antiaim.right.lby",ui.Slider("Lby offset", -180, 180, "°", "-180°", "180°", false, gui.GetValue("rbot.antiaim.right.lby")))

                    end

                    ui.Label("Anti-align type")
                    gui.SetValue("rbot.antiaim.advanced.antialign", ui.Combo("antialign", {"Lowerbody", "Micromovement"}, gui.GetValue("rbot.antiaim.advanced.antialign") + 1) - 1)

                    ui.Label("Auto direction priority")
                    gui.SetValue("rbot.antiaim.advanced.autodirstyle", ui.Combo("autodirstyle", {"Field of vision based", "Distance based"}, gui.GetValue("rbot.antiaim.advanced.autodirstyle") + 1) - 1)

                    gui.SetValue("rbot.antiaim.advanced.antiresolver", ui.Checkbox("Anti-resolver", gui.GetValue("rbot.antiaim.advanced.antiresolver"))) 

                elseif gui.GetValue("lbot.master") then

                    ui.Label("Direction")
                    gui.SetValue("lbot.antiaim.direction", ui.Combo("direction", {"Auto", "Manual"}, gui.GetValue("lbot.antiaim.direction") + 1) - 1)

                        if gui.GetValue("lbot.antiaim.direction") > 0 then

                            ui.Label("Left side")
                            gui.SetValue("lbot.antiaim.leftkey", ui.Bind("leftkey", false, gui.GetValue("lbot.antiaim.leftkey")))

                            ui.Label("Right side")
                            gui.SetValue("lbot.antiaim.rightkey", ui.Bind("rightkey", false, gui.GetValue("lbot.antiaim.rightkey")))

                        end


                end

            ui.EndGroup()
            end

            if ui.BeginGroup("misc.fakelag", "Fake lag", 295, 25, 250, 145) then

                gui.SetValue("misc.fakelag.enable", ui.Checkbox("Enable", gui.GetValue("misc.fakelag.enable")))

                gui.SetValue("misc.fakelag.key", ui.Bind("fakelag.key", false, gui.GetValue("misc.fakelag.key")))

                gui.SetValue("misc.fakelag.factor",ui.Slider("Factor", 3, 17, "", "3", "17", false, gui.GetValue("misc.fakelag.factor")))

                ui.Label("-----------Conditions-----------")

                gui.SetValue("misc.fakelag.condition.peek", ui.Checkbox("Peek", gui.GetValue("misc.fakelag.condition.peek")))
                
                gui.SetValue("misc.fakelag.condition.inair", ui.Checkbox("While standing", gui.GetValue("misc.fakelag.condition.inair")))

                gui.SetValue("misc.fakelag.condition.moving", ui.Checkbox("While moving", gui.GetValue("misc.fakelag.condition.moving")))

                gui.SetValue("misc.fakelag.condition.standing", ui.Checkbox("While in air", gui.GetValue("misc.fakelag.condition.standing")))

                if gui.GetValue("rbot.master") then


                
                elseif gui.GetValue("lbot.master") then



                end
            ui.EndGroup()
            end 

            if ui.BeginGroup("rbot.antiaim.Condition", "Condition", 295, 190, 250, 250) then

                if gui.GetValue("rbot.master") then

                    gui.SetValue("rbot.antiaim.condition.shiftonshot", ui.Checkbox("Shift on shot", gui.GetValue("rbot.antiaim.condition.shiftonshot"))) 

                    ui.Label("----------Disable conditions----------")
                    gui.SetValue("rbot.antiaim.condition.use", ui.Checkbox("On use", gui.GetValue("rbot.antiaim.condition.use"))) 

                    gui.SetValue("rbot.antiaim.condition.knife", ui.Checkbox("On knife", gui.GetValue("rbot.antiaim.condition.knife"))) 

                    gui.SetValue("rbot.antiaim.condition.grenade", ui.Checkbox("On gernade", gui.GetValue("rbot.antiaim.condition.grenade"))) 

                    gui.SetValue("rbot.antiaim.condition.freezetime", ui.Checkbox("During freeze time", gui.GetValue("rbot.antiaim.condition.freezetime"))) 

                elseif gui.GetValue("lbot.master") then

                    gui.SetValue("lbot.antiaim.onknife", ui.Checkbox("Disable on knife", gui.GetValue("lbot.antiaim.onknife"))) 

                    gui.SetValue("lbot.antiaim.enemy", ui.Checkbox("On enemy aiming", gui.GetValue("lbot.antiaim.enemy"))) 

                    gui.SetValue("lbot.antiaim.ongrenade", ui.Checkbox("Disable on grenade", gui.GetValue("lbot.antiaim.ongrenade"))) 


                end

            ui.EndGroup()
            end 

            if ui.BeginGroup("rbot.antiaim.extra", "Extra", 295, 460, 250, 215) then

                gui.SetValue("misc.fakelatency.enable", ui.Checkbox("Fakelatency enable", gui.GetValue("misc.fakelatency.enable"))) 

                gui.SetValue("misc.fakelatency.key", ui.Bind("fakelag.key", false, gui.GetValue("misc.fakelatency.key")))

                gui.SetValue("misc.fakelatency.amount",ui.Slider("Fakelatency amount", 0, 1000, "", "0", "1000", false, gui.GetValue("misc.fakelatency.amount")))

                if gui.GetValue("rbot.master") then

                    gui.SetValue("rbot.antiaim.extra.staticlegs", ui.Checkbox("Staic legs", gui.GetValue("rbot.antiaim.extra.staticlegs"))) 

                    ui.Label("Fake duck")
                    gui.SetValue("rbot.antiaim.extra.fakecrouchkey", ui.Bind("fakecrouchkey", false, gui.GetValue("rbot.antiaim.extra.fakecrouchkey")))

                    gui.SetValue("rbot.antiaim.extra.fakecrouchstyle", ui.Combo("fakecrouchstyle", {"Duck", "Un duck"}, gui.GetValue("rbot.antiaim.extra.fakecrouchstyle") + 1) - 1)

                    ui.Label("Fake expose toggle")
                    gui.SetValue("rbot.antiaim.advanced.exposefake", ui.Bind("exposefake", false, gui.GetValue("rbot.antiaim.advanced.exposefake")))

                    gui.SetValue("rbot.antiaim.advanced.exposetype", ui.Combo("exposetype", {"1s", "1.5s"}, gui.GetValue("rbot.antiaim.advanced.exposetype") + 1) - 1)

                elseif gui.GetValue("lbot.master") then



                end

            ui.EndGroup()
            end

        ui.EndTab()
        end

        if ui.BeginTab("lbot.legit", ui.Icons.legit) then

            if ui.BeginGroup("lbot.aimbot", "Aimbot", 25, 25, 250, 650) then

                gui.SetValue("lbot.aim.enable", ui.Checkbox("Enable", gui.GetValue("lbot.aim.enable"))) 

                gui.SetValue("lbot.aim.key", ui.Bind("lbot.aim.key", false, gui.GetValue("lbot.aim.key")))

                gui.SetValue("lbot.aim.autofire", ui.Checkbox("Automatic fire", gui.GetValue("lbot.aim.autofire"))) 

                local Weapon_selection = string.match(Legitbot_Weapon_Visibility_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                gui.SetValue("lbot.weapon.vis."..Weapon..".autowall", ui.Checkbox("Auto wall", gui.GetValue("lbot.weapon.vis."..Weapon..".autowall"))) 

                gui.SetValue("lbot.weapon.vis."..Weapon..".smoke", ui.Checkbox("Through smoke", gui.GetValue("lbot.weapon.vis."..Weapon..".smoke"))) 

                gui.SetValue("lbot.aim.fireonpress", ui.Checkbox("Fire on press", gui.GetValue("lbot.aim.fireonpress"))) 

                gui.SetValue("lbot.aim.autopistol",ui.Slider("Auto pistol interval", 0, 500, "ms", "0ms", "500ms", false, gui.GetValue("lbot.aim.autopistol")))

                gui.SetValue("lbot.semirage.silentaimbot", ui.Checkbox("Silent aimbot", gui.GetValue("lbot.semirage.silentaimbot"))) 

                gui.SetValue("lbot.movement.quickstop", ui.Checkbox("Quick stop", gui.GetValue("lbot.movement.quickstop")))

                gui.SetValue("lbot.movement.walkcustom", ui.Checkbox("Walk speed customization", gui.GetValue("lbot.movement.walkcustom")))

                if gui.GetValue("lbot.movement.walkcustom") then
                    gui.SetValue("lbot.movement.walkspeed",ui.Slider("Walk speed", 75, 135, "", "75", "135", false, gui.GetValue("lbot.movement.walkspeed")))
                end
                
                gui.SetValue("lbot.semirage.autostop", ui.Checkbox("Auto stop", gui.GetValue("lbot.semirage.autostop"))) 

                gui.SetValue("lbot.posadj.backtrack", ui.Checkbox("Backtracking", gui.GetValue("lbot.posadj.backtrack")))
            
                if gui.GetValue("lbot.posadj.backtrack") then
                    gui.SetValue("lbot.extra.backtrack",ui.Slider("Backtracking time", 0, 500, "ms", "0ms", "500ms", false, gui.GetValue("lbot.extra.backtrack")))
                end

                gui.SetValue("lbot.posadj.resolver", ui.Checkbox("Resolver", gui.GetValue("lbot.posadj.resolver"))) 

                local Weapon_selection = string.match(Legitbot_Aimbot_HitboxSelection_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                gui.SetValue("lbot.aim."..Weapon..".nearest", ui.Checkbox("Nearest to crosshair", gui.GetValue("lbot.aim."..Weapon..".nearest"))) 

                gui.SetValue("lbot.aim."..Weapon..".hitboxstep",ui.Slider("Hitbox advance multipler", 1, 4, "", "1", "4", false, gui.GetValue("lbot.aim."..Weapon..".hitboxstep")))

                ui.EndGroup()
            end

            if ui.BeginGroup("lbot.trg", "Triggerbot", 295, 25, 250, 160) then

                gui.SetValue("lbot.trg.enable", ui.Checkbox("Enable", gui.GetValue("lbot.trg.enable"))) 

                gui.SetValue("lbot.trg.key", ui.Bind("lbot.trg.key", false, gui.GetValue("lbot.trg.key")))

                gui.SetValue("lbot.trg.autofire", ui.Checkbox("Auto fire", gui.GetValue("lbot.trg.autofire"))) 

                local Weapon_selection = string.match(Legitbot_Triggerbot_Weapon_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                if gui.GetValue("lbot.trg.enable") then

                    gui.SetValue("lbot.trg."..Weapon..".delay",ui.Slider("Trigger delay", 0, 500, "ms", "0ms", "500ms", false, gui.GetValue("lbot.trg."..Weapon..".delay")))

                    gui.SetValue("lbot.trg."..Weapon..".burst",ui.Slider("Trigger burst", 0, 500, "ms", "0ms", "500ms", false, gui.GetValue("lbot.trg."..Weapon..".burst")))

                    gui.SetValue("lbot.trg."..Weapon..".hitchance",ui.Slider("Hit chance", 0, 100, "%", "0%", "100%", false, gui.GetValue("lbot.trg."..Weapon..".hitchance")))

                    gui.SetValue("lbot.trg."..Weapon..".antirecoil", ui.Checkbox("Anti-recoil", gui.GetValue("lbot.trg."..Weapon..".antirecoil"))) 

                end

                gui.SetValue("lbot.extra.knifetrigger", ui.Checkbox("Knife triggerbot", gui.GetValue("lbot.extra.knifetrigger"))) 


            ui.EndGroup()
            end

            if ui.BeginGroup("lbot.weapon", "Weapon", 295, 210, 250, 465) then

                local Weapon_selection = string.match(Legitbot_Weapon_Accuracy_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                gui.SetValue("lbot.weapon.accuracy."..Weapon..".rcs", ui.Checkbox("Recoil control system", gui.GetValue("lbot.weapon.accuracy."..Weapon..".rcs"))) 

                gui.SetValue("lbot.weapon.accuracy."..Weapon..".rcs", ui.Checkbox("Srandalone recoil control", gui.GetValue("lbot.weapon.accuracy."..Weapon..".rcs"))) 

                gui.SetValue("lbot.weapon.accuracy."..Weapon..".hrecoil",ui.Slider("Horizontal recoil", 0, 100, "%", "0%", "100%", false, gui.GetValue("lbot.weapon.accuracy."..Weapon..".hrecoil")))

                gui.SetValue("lbot.weapon.accuracy."..Weapon..".vrecoil",ui.Slider("Vertical recoil", 0, 100, "%", "0%", "100%", false, gui.GetValue("lbot.weapon.accuracy."..Weapon..".vrecoil")))

                local Weapon_selection = string.match(Legitbot_Weapon_Aiming_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                gui.SetValue("lbot.weapon.aim."..Weapon..".smooth",ui.Slider("Smooth factor", 0, 50, "", "0", "50", false, gui.GetValue("lbot.weapon.aim."..Weapon..".smooth")))

                gui.SetValue("lbot.weapon.aim."..Weapon..".randomize",ui.Slider("Randomize factor", 0, 10, "", "0", "10", false, gui.GetValue("lbot.weapon.aim."..Weapon..".randomize")))

                gui.SetValue("lbot.weapon.aim."..Weapon..".curve",ui.Slider("Curve factor", 0, 2, "", "0", "2", false, gui.GetValue("lbot.weapon.aim."..Weapon..".curve")))

                local Weapon_selection = string.match(Legitbot_Weapon_Target_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
                if Weapon_selection == "Heavy Pistol" then
                    Weapon_selection = "hpistol"
                elseif Weapon_selection == "Auto Sniper" then
                    Weapon_selection = "asniper"
                elseif Weapon_selection == "Submachine Gun" then
                    Weapon_selection = "Smg"
                elseif Weapon_selection == "Light Machine Gun" then
                    Weapon_selection = "Lmg"
                end
                local Weapon = string.lower(Weapon_selection)

                gui.SetValue("lbot.weapon.target.pistol.minfov",ui.Slider("Minimum fov range", 0, 5, " ", "0", "5", false, gui.GetValue("lbot.weapon.target.pistol.minfov")))

                gui.SetValue("lbot.weapon.target.pistol.maxfov",ui.Slider("Maximum fov range", 0, 30, " ", "0", "30", false, gui.GetValue("lbot.weapon.target.pistol.maxfov")))

                gui.SetValue("lbot.weapon.target.pistol.tsd",ui.Slider("Target switch delay", 0, 1000, "ms", "0", "1000", false, gui.GetValue("lbot.weapon.target.pistol.tsd")))

                gui.SetValue("lbot.weapon.target.pistol.fsd",ui.Slider("First shot delay", 0, 1000, "ms", "0", "1000", false, gui.GetValue("lbot.weapon.target.pistol.fsd")))

            ui.EndGroup()
            end

        ui.EndTab()
        end

        if ui.BeginTab( "visuals", ui.Icons.visuals ) then
            
            if ui.BeginGroup("esp.overlay", "Esp", 25, 25, 250, 650) then

                ui.Label("----------------Enemy----------------")
                ui.Label("Box")
                gui.SetValue("esp.overlay.enemy.box", ui.Combo("enemy.box", {"Off", "Outlined", "Normal"}, gui.GetValue("esp.overlay.enemy.box") + 1) - 1)

                gui.SetValue("esp.overlay.enemy.precision", ui.Checkbox("Box precision", gui.GetValue("esp.overlay.enemy.precision"))) 

                gui.SetValue("esp.overlay.enemy.name", ui.Checkbox("Name", gui.GetValue("esp.overlay.enemy.name"))) 

                gui.SetValue("esp.overlay.enemy.skeleton", ui.Checkbox("Skeleton", gui.GetValue("esp.overlay.enemy.skeleton"))) 

                gui.SetValue("esp.overlay.enemy.armor", ui.Checkbox("Armor", gui.GetValue("esp.overlay.enemy.armor"))) 

                ui.Label("Weapon")
                gui.SetValue("esp.overlay.enemy.weapon", ui.Combo("enemy.weapon", {"Off", "Icon", "Name"}, gui.GetValue("esp.overlay.enemy.weapon") + 1) - 1)

                ui.Label("Weapon fiter")
                gui.SetValue("esp.overlay.enemy.weaponfilter", ui.Combo("enemy.weaponfilter", {"Acctive", "Acctive + Nades", "All"}, gui.GetValue("esp.overlay.enemy.weaponfilter") + 1) - 1)

                gui.SetValue("esp.overlay.enemy.ammo", ui.Checkbox("Ammo", gui.GetValue("esp.overlay.enemy.ammo"))) 

                gui.SetValue("esp.overlay.enemy.money", ui.Checkbox("Money", gui.GetValue("esp.overlay.enemy.money"))) 

                gui.SetValue("esp.overlay.enemy.barrel", ui.Checkbox("Barrel", gui.GetValue("esp.overlay.enemy.barrel"))) 

                gui.SetValue("esp.overlay.enemy.dormant", ui.Checkbox("Dormant", gui.GetValue("esp.overlay.enemy.dormant"))) 

                ui.Label("----------------Weapon----------------")

                ui.Label("Box")
                gui.SetValue("esp.overlay.weapon.box", ui.Combo("weapon.box", {"Off", "Outlined", "Normal"}, gui.GetValue("esp.overlay.weapon.box") + 1) - 1)

                ui.Label("Name")
                gui.SetValue("esp.overlay.weapon.name", ui.Combo("weapon.name", {"Off", "Icon", "Name"}, gui.GetValue("esp.overlay.weapon.name") + 1) - 1)

                gui.SetValue("esp.overlay.weapon.ammo", ui.Checkbox("Ammo", gui.GetValue("esp.overlay.weapon.ammo")))

                gui.SetValue("esp.overlay.weapon.defuser", ui.Checkbox("Defuser", gui.GetValue("esp.overlay.weapon.defuser")))

                gui.SetValue("esp.overlay.weapon.c4timer", ui.Checkbox("C4 timer", gui.GetValue("esp.overlay.weapon.c4timer")))

                gui.SetValue("esp.overlay.weapon.dzitems", ui.Checkbox("Danger zone items", gui.GetValue("esp.overlay.weapon.dzitems")))

                gui.SetValue("esp.overlay.weapon.dzturret", ui.Checkbox("Danger zone turret", gui.GetValue("esp.overlay.weapon.dzturret")))

            ui.EndGroup()
            end

            if ui.BeginGroup("esp.world", "World", 295, 25, 250, 160) then

                gui.SetValue("esp.world.dmgindicator", ui.Checkbox("Damage indicator", gui.GetValue("esp.world.dmgindicator")))

                gui.SetValue("esp.world.sounds", ui.Checkbox("Sounds", gui.GetValue("esp.world.sounds")))

                gui.SetValue("esp.world.materials.walls", ui.Checkbox("Materials walls", gui.GetValue("esp.world.materials.walls")))

                gui.SetValue("esp.world.materials.staticprops", ui.Checkbox("Materials static prope", gui.GetValue("esp.world.materials.staticprops")))

                ui.Label("Skybox")
                gui.SetValue("esp.world.materials.skybox", ui.Combo("materials.skybox", {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19"}, gui.GetValue("esp.world.materials.skybox") + 1) - 1)

            ui.EndGroup()
            end

            if ui.BeginGroup("esp.local", "Local", 295, 210, 250, 465) then

                gui.SetValue("esp.local.thirdperson", ui.Checkbox("Third person enable", gui.GetValue("esp.local.thirdperson")))

                gui.SetValue("esp.local.thirdpersondist",ui.Slider("Third person distance", 0, 500, "", "0", "500", false, gui.GetValue("esp.local.thirdpersondist")))

                gui.SetValue("esp.local.fov",ui.Slider("View fov", 50, 120, "", "50", "120", false, gui.GetValue("esp.local.fov")))

                gui.SetValue("esp.local.viewmodelfov",ui.Slider("Viewmodel fov", 40, 90, "", "40", "90", false, gui.GetValue("esp.local.viewmodelfov")))

                gui.SetValue("esp.local.smoothghost", ui.Checkbox("Smooth ghost model", gui.GetValue("esp.local.smoothghost")))

                ui.Label("Out of view")
                gui.SetValue("esp.local.outofview", ui.Combo("local.outofview", {"Off", "Arrow", "Arrow + Info"}, gui.GetValue("esp.local.outofview") + 1) - 1)

                gui.SetValue("esp.other.crosshair", ui.Checkbox("Crosshair", gui.GetValue("esp.other.crosshair")))

                ui.Label("Crosshair recoil")
                gui.SetValue("esp.other.recoilcrosshair", ui.Combo("recoilcrosshair", {"Off", "Line", "Fade"}, gui.GetValue("esp.other.recoilcrosshair") + 1) - 1)

            ui.EndGroup()
            end       

        ui.EndTab()
        end

        if ui.BeginTab( "settings", ui.Icons.settings ) then
            
            if ui.BeginGroup("misc.general", "General", 25, 25, 250, 650) then

                gui.SetValue("misc.showspec", ui.Checkbox("Show spectators", gui.GetValue("misc.showspec")))

                gui.SetValue("misc.rankreveal", ui.Checkbox("Show ranks", gui.GetValue("misc.rankreveal")))

                gui.SetValue("misc.autoaccept", ui.Checkbox("Auto-accept match", gui.GetValue("misc.autoaccept")))

                gui.SetValue("misc.fastduck", ui.Checkbox("Fast duck", gui.GetValue("misc.fastduck")))

                gui.SetValue("misc.slidewalk", ui.Checkbox("Slide walk", gui.GetValue("misc.slidewalk")))

                gui.SetValue("misc.autothrow", ui.Checkbox("Auto throw", gui.GetValue("misc.autothrow")))

                gui.SetValue("misc.autothrowgrenade",ui.Slider("Grenade distance", 0, 10, "", "0", "10", false, gui.GetValue("misc.autothrowgrenade")))

                gui.SetValue("misc.autothrowincendiary",ui.Slider("Incendiary distance", 0, 10, "", "0", "10", false, gui.GetValue("misc.autothrowincendiary")))

                gui.SetValue("misc.speedburst.enable", ui.Checkbox("Speed burst", gui.GetValue("misc.speedburst.enable")))

                gui.SetValue("misc.speedburst.key", ui.Bind("speedburst.key", false, gui.GetValue("misc.speedburst.key")))

                gui.SetValue("misc.speedburst.indicator", ui.Checkbox("Speed burst indicator", gui.GetValue("misc.speedburst.indicator")))

                gui.SetValue("misc.log.purchases", ui.Checkbox("Log purchases", gui.GetValue("misc.log.purchases")))

                gui.SetValue("misc.log.console", ui.Checkbox("Log console", gui.GetValue("misc.log.console")))

                ui.Label("Steal name")
                gui.SetValue("misc.stealname", ui.Bind("misc.stealname", false, gui.GetValue("misc.stealname")))

                gui.SetValue("misc.invisiblename", ui.Checkbox("Invisible name", gui.GetValue("misc.invisiblename")))

                gui.SetValue("misc.chatspam", ui.Checkbox("Chat spam", gui.GetValue("misc.chatspam")))

                gui.SetValue("misc.clantag", ui.Checkbox("Clantag changer", gui.GetValue("misc.clantag")))

                ui.Label("Open menu key")
                window_bkey, window_bact, window_bdet = ui.Bind("Openmenukey", false, window_bkey, window_bact, window_bdet)

            ui.EndGroup()
            end  

            if ui.BeginGroup("misc.restrictions", "Restrictions", 295, 25, 250, 200) then

                gui.SetValue("misc.antiuntrusted", ui.Checkbox("Anti-untrusted", gui.GetValue("misc.antiuntrusted")))

                gui.SetValue("misc.bypasspure", ui.Checkbox("Bypass sv_pure", gui.GetValue("misc.bypasspure")))

                gui.SetValue("misc.bypasscheats", ui.Checkbox("Bypass sv_cheats", gui.GetValue("misc.bypasscheats")))

            ui.EndGroup()
            end

            if ui.BeginGroup("misc.movement", "Movement", 295, 250, 250, 425) then

                gui.SetValue("misc.strafe.enable", ui.Checkbox("Strafe enable", gui.GetValue("misc.strafe.enable")))

                gui.SetValue("misc.strafe.air", ui.Checkbox("Air strafe", gui.GetValue("misc.strafe.air")))

                gui.SetValue("misc.bypasscheats", ui.Checkbox("Bypass sv_cheats", gui.GetValue("misc.bypasscheats")))

                ui.Label("Mode")
                gui.SetValue("misc.strafe.mode", ui.Combo("misc.strafe.mode", {"Silent", "Normal", "Sidewaye", "W-Only", "Mouse"}, gui.GetValue("misc.strafe.mode") + 1) - 1)

                ui.Label("Circle strafe ")
                gui.SetValue("misc.strafe.circle", ui.Bind("misc.strafe.circle", false, gui.GetValue("misc.strafe.circle")))

                ui.Label("Snake strafe")
                gui.SetValue("misc.strafe.snake", ui.Bind("misc.strafe.snake", false, gui.GetValue("misc.strafe.snake")))
                
                gui.SetValue("misc.strafe.retrack",ui.Slider("Retrack speed", 0, 8, "", "0", "8", false, gui.GetValue("misc.strafe.retrack")))

                ui.Label("Auto jump")
                gui.SetValue("misc.autojump", ui.Combo("misc.autojump", {"Off", "Perfect", "Legit"}, gui.GetValue("misc.autojump") + 1) - 1)

                ui.Label("Edge jump")
                gui.SetValue("misc.edgejump", ui.Bind("misc.edgejump", false, gui.GetValue("misc.edgejump")))

                ui.Label("Auto jump-bug")
                gui.SetValue("misc.autojumpbug", ui.Bind("misc.autojumpbug", false, gui.GetValue("misc.autojumpbug")))

                gui.SetValue("misc.duckjump", ui.Checkbox("Duck jump", gui.GetValue("misc.duckjump")))

            ui.EndGroup()
            end

        ui.EndTab()
        end

        if ui.BeginTab( "skinchanger", ui.Icons.skinchanger ) then
            
            if ui.BeginGroup("esp.skins", "Skins", 25, 25, 510, 150) then

                ui.Label("Skin option is not currently supported", true)

            ui.EndGroup()
            end

        ui.EndTab()
        end

        if ui.BeginTab( "playerlist", ui.Icons.playerlist ) then
            
            if ui.BeginGroup("misc.playerlist", "Playerlist", 25, 25, 510, 150) then
            
            gui.SetValue("misc.playerlist", ui.Checkbox("Player list", gui.GetValue("misc.playerlist")))

            ui.EndGroup()
            end

            if ui.BeginGroup("misc.Credits", "Credits", 25, 200, 510, 150) then
            
                ui.Label("Creator (Discord: Uglych#1515)", true)

            ui.EndGroup()
            end
            
        ui.EndTab()
        end

    ui.EndWindow()
    end

end
    
callbacks.Register( "Draw", "suitest", draw_callback )