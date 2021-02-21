--Working on aimware
--Inspiration from bkt.lua
--by qi

--gui
local X, Y = draw.GetScreenSize()
local Custom_DmgHc_Reference = gui.Reference("Ragebot", "Accuracy", "Weapon")
local Custom_DmgHcKey_Reference = gui.Reference("Ragebot", "Accuracy")
local Custom_DmgHcKey_Groupbox = gui.Groupbox(Custom_DmgHcKey_Reference, "Custom Minimum Dmg & HC Misc", 329, 440, 296, 0)
local Custom_DmgHc_Ind = gui.Checkbox(Custom_DmgHcKey_Groupbox, "customdmghc.misc.ind", "Custom Minimum Dmg & HC Ind", 0)
local Custom_DmgHc_Ind_Clr = gui.ColorPicker(Custom_DmgHc_Ind, "clr", "clr", 255, 255, 255, 255)
local Custom_DmgHc_Ind_Clr2 = gui.ColorPicker(Custom_DmgHc_Ind, "clr2", "clr2", 181, 89, 181, 255)
local Custom_DmgHc_Ind_Rgb = gui.Checkbox(Custom_DmgHc_Ind, "rgb", "rgb", 0)
local Custom_DmgHc_Ind_X = gui.Slider(Custom_DmgHc_Ind, "x", "x", 400, 0, X)
local Custom_DmgHc_Ind_Y = gui.Slider(Custom_DmgHc_Ind, "y", "y", 400, 0, Y)

Custom_DmgHc_Ind_Rgb:SetInvisible(true)
Custom_DmgHc_Ind_X:SetInvisible(true)
Custom_DmgHc_Ind_Y:SetInvisible(true)

-- Shared
-- hitchance
local Shared_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "shared.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Shared_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "shared.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Shared_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "shared.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Shared_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "shared.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Shared_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "shared.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Shared_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "shared.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Shared_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "shared.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Shared_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "shared.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Shared_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "shared.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Shared_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "shared.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Zeus
-- hitchance
local Zeus_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "zeus.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Zeus_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "zeus.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Zeus_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "zeus.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Zeus_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "zeus.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Zeus_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "zeus.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Zeus_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "zeus.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Zeus_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "zeus.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Zeus_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "zeus.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Zeus_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "zeus.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Zeus_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "zeus.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Pistol
-- hitchance
local Pistol_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "pistol.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Pistol_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "pistol.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Pistol_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "pistol.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Pistol_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "pistol.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Pistol_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "pistol.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Pistol_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "pistol.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Pistol_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "pistol.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Pistol_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "pistol.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Pistol_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "pistol.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Pistol_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "pistol.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- H Pistol
-- hitchance
local hPistol_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "hpistol.customhd.enable", "Custom Minimum Dmg & HC", 0)
local hPistol_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "hpistol.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local hPistol_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "hpistol.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local hPistol_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "hpistol.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local hPistol_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "hpistol.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local hPistol_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "hpistol.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local hPistol_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "hpistol.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local hPistol_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "hpistol.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local hPistol_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "hpistol.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local hPistol_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "hpistol.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Smg
-- hitchance
local Smg_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "smg.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Smg_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "smg.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Smg_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "smg.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Smg_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "smg.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Smg_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "smg.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Smg_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "smg.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Smg_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "smg.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Smg_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "smg.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Smg_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "smg.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Smg_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "smg.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Rifle
-- hitchance
local Rifle_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "rifle.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Rifle_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "rifle.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Rifle_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "rifle.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Rifle_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "rifle.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Rifle_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "rifle.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Rifle_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "rifle.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Rifle_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "rifle.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Rifle_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "rifle.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Rifle_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "rifle.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Rifle_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "rifle.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Shotgun
-- hitchance
local Shotgun_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "shotgun.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Shotgun_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "shotgun.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Shotgun_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "shotgun.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Shotgun_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "shotgun.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Shotgun_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "shotgun.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Shotgun_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "shotgun.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Shotgun_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "shotgun.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Shotgun_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "shotgun.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Shotgun_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "shotgun.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Shotgun_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "shotgun.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Scout
-- hitchance
local Scout_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "scout.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Scout_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "scout.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Scout_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "scout.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Scout_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "scout.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Scout_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "scout.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Scout_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "scout.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Scout_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "scout.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Scout_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "scout.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Scout_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "scout.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Scout_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "scout.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- aSniper
-- hitchance
local aSniper_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "asniper.customhd.enable", "Custom Minimum Dmg & HC", 0)
local aSniper_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "asniper.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local aSniper_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "asniper.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local aSniper_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "asniper.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local aSniper_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "asniper.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local aSniper_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "asniper.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local aSniper_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "asniper.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local aSniper_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "asniper.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local aSniper_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "asniper.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local aSniper_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "asniper.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Sniper
-- hitchance
local Sniper_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "sniper.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Sniper_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "sniper.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Sniper_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "sniper.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Sniper_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "sniper.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Sniper_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "sniper.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Sniper_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "sniper.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Sniper_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "sniper.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Sniper_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "sniper.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Sniper_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "sniper.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Sniper_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "sniper.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

-- Lmg
-- hitchance
local Lmg_Custom_DmgHc_Enable = gui.Checkbox(Custom_DmgHc_Reference, "lmg.customhd.enable", "Custom Minimum Dmg & HC", 0)
local Lmg_Hitchance_Default = gui.Slider(Custom_DmgHc_Reference, "lmg.custom.hitchance.default", "Hit Chance [Default]", 0, 0, 100)
local Lmg_Hitchance_Override = gui.Slider(Custom_DmgHc_Reference, "lmg.custom.hitchance.override", "Hit Chance [Override]", 0, 0, 100)
local Lmg_Hitchance_inAir = gui.Slider(Custom_DmgHc_Reference, "lmg.custom.hitchance.inair", "Hit Chance [inAir]", 0, 0, 100)
-- Damage
local Lmg_Damage_Visible = gui.Slider(Custom_DmgHc_Reference, "lmg.custom.mindmg.visible", "Minimum Damage [Visible]", 1, 1, 130)
local Lmg_Damage_Autowall = gui.Slider(Custom_DmgHc_Reference, "lmg.custom.mindmg.autowall", "Minimum Damage [Autowall]", 1, 1, 130)
local Lmg_Damage_Override = gui.Slider(Custom_DmgHc_Reference, "lmg.custom.mindmg.override", "Minimum Damage [Override]", 1, 1, 130)
local Lmg_Damage_inAir = gui.Slider(Custom_DmgHc_Reference, "lmg.custom.mindmg.inair", "Minimum Damage [inAir]", 1, 1, 130)
-- Key
local Lmg_Hitchance_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "lmg.custom.hitchance.override.key", "Hit Chance [Override] Key", 0)
local Lmg_Damage_Override_Key = gui.Checkbox(Custom_DmgHcKey_Groupbox, "lmg.custom.mindmg.override.key", "Minimum Damage [Override] Key", 0)

--Gui hide settings
-- Shared
local function SharedSetInvisible(boolean)
    Shared_Custom_DmgHc_Enable:SetInvisible(boolean)
    Shared_Hitchance_Default:SetInvisible(boolean)
    Shared_Hitchance_Override:SetInvisible(boolean)
    Shared_Hitchance_inAir:SetInvisible(boolean)
    Shared_Damage_Visible:SetInvisible(boolean)
    Shared_Damage_Autowall:SetInvisible(boolean)
    Shared_Damage_Override:SetInvisible(boolean)
    Shared_Damage_inAir:SetInvisible(boolean)
    Shared_Hitchance_Override_Key:SetInvisible(boolean)
    Shared_Damage_Override_Key:SetInvisible(boolean)
end
-- Zeus
local function ZeusSetInvisible(boolean)
    Zeus_Custom_DmgHc_Enable:SetInvisible(boolean)
    Zeus_Hitchance_Default:SetInvisible(boolean)
    Zeus_Hitchance_Override:SetInvisible(boolean)
    Zeus_Hitchance_inAir:SetInvisible(boolean)
    Zeus_Damage_Visible:SetInvisible(boolean)
    Zeus_Damage_Autowall:SetInvisible(boolean)
    Zeus_Damage_Override:SetInvisible(boolean)
    Zeus_Damage_inAir:SetInvisible(boolean)
    Zeus_Hitchance_Override_Key:SetInvisible(boolean)
    Zeus_Damage_Override_Key:SetInvisible(boolean)
end
-- Pistol
local function PistolSetInvisible(boolean)
    Pistol_Custom_DmgHc_Enable:SetInvisible(boolean)
    Pistol_Hitchance_Default:SetInvisible(boolean)
    Pistol_Hitchance_Override:SetInvisible(boolean)
    Pistol_Hitchance_inAir:SetInvisible(boolean)
    Pistol_Damage_Visible:SetInvisible(boolean)
    Pistol_Damage_Autowall:SetInvisible(boolean)
    Pistol_Damage_Override:SetInvisible(boolean)
    Pistol_Damage_inAir:SetInvisible(boolean)
    Pistol_Hitchance_Override_Key:SetInvisible(boolean)
    Pistol_Damage_Override_Key:SetInvisible(boolean)
end
-- hPistol
local function hPistolSetInvisible(boolean)
    hPistol_Custom_DmgHc_Enable:SetInvisible(boolean)
    hPistol_Hitchance_Default:SetInvisible(boolean)
    hPistol_Hitchance_Override:SetInvisible(boolean)
    hPistol_Hitchance_inAir:SetInvisible(boolean)
    hPistol_Damage_Visible:SetInvisible(boolean)
    hPistol_Damage_Autowall:SetInvisible(boolean)
    hPistol_Damage_Override:SetInvisible(boolean)
    hPistol_Damage_inAir:SetInvisible(boolean)
    hPistol_Hitchance_Override_Key:SetInvisible(boolean)
    hPistol_Damage_Override_Key:SetInvisible(boolean)
end
-- Smg
local function SmgSetInvisible(boolean)
    Smg_Custom_DmgHc_Enable:SetInvisible(boolean)
    Smg_Hitchance_Default:SetInvisible(boolean)
    Smg_Hitchance_Override:SetInvisible(boolean)
    Smg_Hitchance_inAir:SetInvisible(boolean)
    Smg_Damage_Visible:SetInvisible(boolean)
    Smg_Damage_Autowall:SetInvisible(boolean)
    Smg_Damage_Override:SetInvisible(boolean)
    Smg_Damage_inAir:SetInvisible(boolean)
    Smg_Hitchance_Override_Key:SetInvisible(boolean)
    Smg_Damage_Override_Key:SetInvisible(boolean)
end
-- Rifle
local function RifleSetInvisible(boolean)
    Rifle_Custom_DmgHc_Enable:SetInvisible(boolean)
    Rifle_Hitchance_Default:SetInvisible(boolean)
    Rifle_Hitchance_Override:SetInvisible(boolean)
    Rifle_Hitchance_inAir:SetInvisible(boolean)
    Rifle_Damage_Visible:SetInvisible(boolean)
    Rifle_Damage_Autowall:SetInvisible(boolean)
    Rifle_Damage_Override:SetInvisible(boolean)
    Rifle_Damage_inAir:SetInvisible(boolean)
    Rifle_Hitchance_Override_Key:SetInvisible(boolean)
    Rifle_Damage_Override_Key:SetInvisible(boolean)
end
-- Shotgun
local function ShotgunSetInvisible(boolean)
    Shotgun_Custom_DmgHc_Enable:SetInvisible(boolean)
    Shotgun_Hitchance_Default:SetInvisible(boolean)
    Shotgun_Hitchance_Override:SetInvisible(boolean)
    Shotgun_Hitchance_inAir:SetInvisible(boolean)
    Shotgun_Damage_Visible:SetInvisible(boolean)
    Shotgun_Damage_Autowall:SetInvisible(boolean)
    Shotgun_Damage_Override:SetInvisible(boolean)
    Shotgun_Damage_inAir:SetInvisible(boolean)
    Shotgun_Hitchance_Override_Key:SetInvisible(boolean)
    Shotgun_Damage_Override_Key:SetInvisible(boolean)
end
-- Scout
local function ScoutSetInvisible(boolean)
    Scout_Custom_DmgHc_Enable:SetInvisible(boolean)
    Scout_Hitchance_Default:SetInvisible(boolean)
    Scout_Hitchance_Override:SetInvisible(boolean)
    Scout_Hitchance_inAir:SetInvisible(boolean)
    Scout_Damage_Visible:SetInvisible(boolean)
    Scout_Damage_Autowall:SetInvisible(boolean)
    Scout_Damage_Override:SetInvisible(boolean)
    Scout_Damage_inAir:SetInvisible(boolean)
    Scout_Hitchance_Override_Key:SetInvisible(boolean)
    Scout_Damage_Override_Key:SetInvisible(boolean)
end
-- aSniper
local function aSniperSetInvisible(boolean)
    aSniper_Custom_DmgHc_Enable:SetInvisible(boolean)
    aSniper_Hitchance_Default:SetInvisible(boolean)
    aSniper_Hitchance_Override:SetInvisible(boolean)
    aSniper_Hitchance_inAir:SetInvisible(boolean)
    aSniper_Damage_Visible:SetInvisible(boolean)
    aSniper_Damage_Autowall:SetInvisible(boolean)
    aSniper_Damage_Override:SetInvisible(boolean)
    aSniper_Damage_inAir:SetInvisible(boolean)
    aSniper_Hitchance_Override_Key:SetInvisible(boolean)
    aSniper_Damage_Override_Key:SetInvisible(boolean)
end
-- Sniper
local function SniperSetInvisible(boolean)
    Sniper_Custom_DmgHc_Enable:SetInvisible(boolean)
    Sniper_Hitchance_Default:SetInvisible(boolean)
    Sniper_Hitchance_Override:SetInvisible(boolean)
    Sniper_Hitchance_inAir:SetInvisible(boolean)
    Sniper_Damage_Visible:SetInvisible(boolean)
    Sniper_Damage_Autowall:SetInvisible(boolean)
    Sniper_Damage_Override:SetInvisible(boolean)
    Sniper_Damage_inAir:SetInvisible(boolean)
    Sniper_Hitchance_Override_Key:SetInvisible(boolean)
    Sniper_Damage_Override_Key:SetInvisible(boolean)
end
-- Lmg
local function LmgSetInvisible(boolean)
    Lmg_Custom_DmgHc_Enable:SetInvisible(boolean)
    Lmg_Hitchance_Default:SetInvisible(boolean)
    Lmg_Hitchance_Override:SetInvisible(boolean)
    Lmg_Hitchance_inAir:SetInvisible(boolean)
    Lmg_Damage_Visible:SetInvisible(boolean)
    Lmg_Damage_Autowall:SetInvisible(boolean)
    Lmg_Damage_Override:SetInvisible(boolean)
    Lmg_Damage_inAir:SetInvisible(boolean)
    Lmg_Hitchance_Override_Key:SetInvisible(boolean)
    Lmg_Damage_Override_Key:SetInvisible(boolean)
end

local function Setactivity()
    if gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 then
        Custom_DmgHcKey_Groupbox:SetPosY(440)
    else
        Custom_DmgHcKey_Groupbox:SetPosY(378)
    end

    local Weapon_selection = string.match(Custom_DmgHc_Reference:GetValue(), [["(.+)"]]) --Get the correct name of the weapon
    if Weapon_selection == "Heavy Pistol" then
        Weapon_selection = "HPistol"
    elseif Weapon_selection == "Auto Sniper" then
        Weapon_selection = "ASniper"
    elseif Weapon_selection == "Submachine Gun" then
        Weapon_selection = "SMG"
    elseif Weapon_selection == "Light Machine Gun" then
        Weapon_selection = "LMG"
    end
    local Weapon = string.lower(Weapon_selection)

    SharedSetInvisible(true)
    ZeusSetInvisible(true)
    PistolSetInvisible(true)
    hPistolSetInvisible(true)
    SmgSetInvisible(true)
    RifleSetInvisible(true)
    ShotgunSetInvisible(true)
    ScoutSetInvisible(true)
    aSniperSetInvisible(true)
    SniperSetInvisible(true)
    LmgSetInvisible(true)

    if Weapon == "shared" then
        SharedSetInvisible(false)
    elseif Weapon == "zeus" then
        ZeusSetInvisible(false)
    elseif Weapon == "pistol" then
        PistolSetInvisible(false)
    elseif Weapon == "hpistol" then
        hPistolSetInvisible(false)
    elseif Weapon == "smg" then
        SmgSetInvisible(false)
    elseif Weapon == "rifle" then
        RifleSetInvisible(false)
    elseif Weapon == "shotgun" then
        ShotgunSetInvisible(false)
    elseif Weapon == "scout" then
        ScoutSetInvisible(false)
    elseif Weapon == "asniper" then
        aSniperSetInvisible(false)
    elseif Weapon == "sniper" then
        SniperSetInvisible(false)
    elseif Weapon == "lmg" then
        LmgSetInvisible(false)
    end
end

--var
local renderer = {}
local font = draw.CreateFont("Verdana Bold", 12)
local tX, tY, offsetX, offsetY, _drag
local MENU = gui.Reference("MENU")

--renderer
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
        draw.Color(clr[1], clr[2], clr[3], alpha)
        draw.Text(x, y, string)
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    draw.Text(x, y, string)
    alpha = nil
    x, y = nil
end
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

--Mouse drag
local function is_inside(a, b, x, y, w, h)
    return a >= x and a <= w and b >= y and b <= h
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
            Custom_DmgHc_Ind_X:SetValue(tX)
            Custom_DmgHc_Ind_Y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--Get the correct name of the weapon
local function MenuWeapon(var)
    local Weapon_selection = string.match(var, [["(.+)"]])
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
    return Weapon
end

--rgb
local function hue2rgb(p, q, t)
    if (t < 0) then
        t = t + 1
    end
    if (t > 1) then
        t = t - 1
    end
    if (t < 1 / 6) then
        return p + (q - p) * 6 * t
    end
    if (t < 1 / 2) then
        return q
    end
    if (t < 2 / 3) then
        return p + (q - p) * (2 / 3 - t) * 6
    end
    return p
end
local function hslToRgb(h, s, l)
    local r, g, b

    if (s == 0) then
        r = l
        g = l
        b = l
    else
        local q = 0
        if (l < 0.5) then
            q = l * (1 + s)
        else
            q = l + s - l * s
        end

        local p = 2 * l - q

        r = hue2rgb(p, q, h + 1 / 3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1 / 3)
    end
    return {r * 255, g * 255, b * 255}
end
local function Clamp(val, min, max)
    if (val > max) then
        return max
    elseif (val < min) then
        return min
    else
        return val
    end
end

--Hitchance
local function Hitchance()
    local lp = entities.GetLocalPlayer()
    local Weapon = MenuWeapon(Custom_DmgHc_Reference:GetValue())

    if gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".customhd.enable") then
        if gui.GetValue("rbot.accuracy." .. Weapon .. ".custom.hitchance.override.key") then
            local overrideHC = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.hitchance.override")
            gui.SetValue("rbot.accuracy.weapon." .. Weapon .. ".hitchance", overrideHC)
        else
            local defaultHC = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.hitchance.default")
            gui.SetValue("rbot.accuracy.weapon." .. Weapon .. ".hitchance", defaultHC)
        end

        if lp ~= nil then
            local flags = lp:GetPropInt("m_fFlags")
            if bit.band(flags, 1) == 0 then
                local inAirHC = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.hitchance.inair")
                gui.SetValue("rbot.accuracy.weapon." .. Weapon .. ".hitchance", inAirHC)
            end
        end
    end
end

--Min Damage
--Check for visibility
local function entities_check()
    local LocalPlayer = entities.GetLocalPlayer()
    local Player
    if LocalPlayer ~= nil then
        Player = LocalPlayer:GetAbsOrigin()
        if (math.floor((entities.GetLocalPlayer():GetPropInt("m_fFlags") % 4) / 2) == 1) then
            z = 46
        else
            z = 64
        end
        Player.z = Player.z + LocalPlayer:GetPropVector("localdata", "m_vecViewOffset[0]").z
        return Player, LocalPlayer
    end
end

local function is_vis(LocalPlayerPos)
    local is_vis = false
    local players = entities.FindByClass("CCSPlayer")
    local fps = 4
    for i, player in pairs(players) do
        if player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and player:IsPlayer() and entities_check() ~= nil and player:IsAlive() then
            for i = 0, 4 do
                for x = 0, fps do
                    local v = player:GetHitboxPosition(i)

                    if x == 0 then
                        v.x = v.x
                        v.y = v.y
                    elseif x == 1 then
                        v.x = v.x
                        v.y = v.y + 4
                    elseif x == 2 then
                        v.x = v.x
                        v.y = v.y - 4
                    elseif x == 3 then
                        v.x = v.x + 4
                        v.y = v.y
                    elseif x == 4 then
                        v.x = v.x - 4
                        v.y = v.y
                    end

                    local c = (engine.TraceLine(LocalPlayerPos, v, 0x1)).contents
                    if c == 0 then
                        is_vis = true
                        break
                    end
                end
            end
        end
    end
    return is_vis
end
--Min Damage
local function Damage()
    local lp = entities.GetLocalPlayer()
    local Weapon = MenuWeapon(Custom_DmgHc_Reference:GetValue())
    local Player, LocalPlayer = entities_check()

    if gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".customhd.enable") then
        if is_vis(Player) then
            local visDmg = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.visible")
            gui.SetValue("rbot.accuracy.weapon." .. Weapon .. ".mindmg", visDmg)
        else
            local autowallDmg = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.autowall")
            gui.SetValue("rbot.accuracy.weapon." .. Weapon .. ".mindmg", autowallDmg)
        end

        if gui.GetValue("rbot.accuracy." .. Weapon .. ".custom.mindmg.override.key") then
            local overrideDmg = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.override")
            gui.SetValue("rbot.accuracy.weapon." .. Weapon .. ".mindmg", overrideDmg)
        end

        if lp ~= nil then
            local flags = lp:GetPropInt("m_fFlags")
            if bit.band(flags, 1) == 0 then
                local inAirDmg = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.inair")
                gui.SetValue("rbot.accuracy.weapon." .. Weapon .. ".mindmg", inAirDmg)
            end
        end
    end
end

--Let drag position save
local function PositionSave()
    if tX ~= Custom_DmgHc_Ind_X:GetValue() or tY ~= Custom_DmgHc_Ind_Y:GetValue() then
        tX = Custom_DmgHc_Ind_X:GetValue()
        tY = Custom_DmgHc_Ind_Y:GetValue()
    end
end

--On draw ind
local function Ondrawind()
    local x, y = drag_menu(tX, tY, 200, 85)
    local rgb = hslToRgb((globals.CurTime() / Clamp(100 - 90, 1, 100)) % 1, 1, 0.5)
    local r, g, b, a = Custom_DmgHc_Ind_Clr:GetValue()
    local r2, g2, b2, a2 = Custom_DmgHc_Ind_Clr2:GetValue()
    local r3, g3, b3, a3 = Custom_DmgHc_Ind_Clr:GetValue()
    local r4, g4, b4, a4 = Custom_DmgHc_Ind_Clr2:GetValue()
    local Weapon = MenuWeapon(Custom_DmgHc_Reference:GetValue())

    local hitchance = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".hitchance")
    local hitchanceDef = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.hitchance.default")
    local hitchanceOve = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.hitchance.override")
    local hitchanceAir = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.hitchance.inair")
    local hitchanceMode = "Def"
    if hitchance == hitchanceDef then
        hitchanceMode = "Def"
    elseif hitchance == hitchanceOve then
        hitchanceMode = "Ove"
    elseif hitchance == hitchanceAir then
        hitchanceMode = "Air"
    end

    local mindmg = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".mindmg")
    local mindmgVis = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.visible")
    local mindmgAW = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.autowall")
    local mindmgOve = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.override")
    local mindmgAir = gui.GetValue("rbot.accuracy.weapon." .. Weapon .. ".custom.mindmg.inair")
    local mindmgMode = "Def"
    if mindmg == mindmgVis then
        mindmgMode = "Vis"
    elseif mindmg == mindmgAW then
        mindmgMode = "AW"
    elseif mindmg == mindmgOve then
        mindmgMode = "Ove"
    elseif mindmg == mindmgAir then
        mindmgMode = "Air"
    end

    --draw ind
    local x1, y1 = 200, 85
    renderer.rectangle(x, y, x1, y1, {4, 4, 4, 255}, true)
    renderer.rectangle(x + 0.5, y + 0.5, x1 - 1, y1 - 1, {24, 24, 24, 255}, true)
    renderer.rectangle(x + 5, y + 5, x1 - 10, y1 - 10, {34, 34, 34, 255}, true)
    renderer.rectangle(x + 5.5, y + 5.5, x1 - 11, y1 - 11, {18, 18, 18, 255}, true)

    if Custom_DmgHc_Ind_Rgb:GetValue() then
        renderer.gradient(x + 6, y + 5, x1 - 13, 2, {rgb[1], rgb[2], rgb[3], 255}, {rgb[2], rgb[3], rgb[1], 255}, nil)
        r3, g3, b3, a3 = rgb[1], rgb[2], rgb[3], 255
        r4, g4, b4, a4 = rgb[2], rgb[3], rgb[1], 255
    else
        renderer.rectangle(x + 6, y + 5, x1 - 12, 2, {r, g, b, a}, true)
    end

    renderer.text(x + 85, y + 13, {r, g, b, a}, true, "D & H", font)

    renderer.gradient(x + 100, y + 31, hitchance * 0.85, 7, {r3, g3, b3, a3}, {r4, g4, b4, a4}, nil)
    renderer.text(x + 15, y + 30, {204, 203, 97, 255}, true, "HC " .. hitchance, font)
    renderer.text(x + 70, y + 30, {r2, g2, b2, a2}, true, hitchanceMode, font)

    renderer.gradient(x + 100, y + 46, mindmg * 0.65, 7, {r3, g3, b3, a3}, {r4, g4, b4, a4}, nil)
    renderer.text(x + 15, y + 45, {204, 203, 97, 255}, true, "DMG " .. mindmg, font)
    renderer.text(x + 70, y + 45, {r2, g2, b2, a2}, true, mindmgMode, font)

    renderer.text(x + 15, y + 60, {204, 203, 97, 255}, true, "Weapon", font)
    renderer.text(x + 70, y + 60, {r2, g2, b2, a2}, true, Weapon, font)
end
callbacks.Register(
    "Draw",
    function()
        Setactivity()
        Hitchance()
        Damage()
        if Custom_DmgHc_Ind:GetValue() then
            PositionSave()
            Ondrawind()
        end
    end
)
