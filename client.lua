---------------------------------------------------------------------------------------
--                     Author: Xavier CHOPIN <www.github.com/xchopin>                --
--                                 License: Apache 2.0                               --
---------------------------------------------------------------------------------------


-- List of the clothing shops {parts,x,y,z}
local clothingShops = {
    { name="Binco's Clothing Shop", color=47, id=73, x=72.2545394897461,  y=-1399.10229492188, z=29.3761386871338},
    { name="Binco's Clothing Shop", color=47, id=73, x=-703.77685546875,  y=-152.258544921875, z=37.4151458740234},
    { name="Binco's Clothing Shop", color=47, id=73, x=-167.863754272461, y=-298.969482421875, z=39.7332878112793},
    { name="Binco's Clothing Shop", color=47, id=73, x=428.694885253906,  y=-800.1064453125,   z=29.4911422729492},
    { name="Binco's Clothing Shop", color=47, id=73, x=-829.413269042969, y=-1073.71032714844, z=11.3281078338623},
    { name="Binco's Clothing Shop", color=47, id=73, x=-1447.7978515625,  y=-242.461242675781, z=49.8207931518555},
    { name="Binco's Clothing Shop", color=47, id=73, x=11.6323690414429,  y=6514.224609375,    z=31.8778476715088},
    { name="Binco's Clothing Shop", color=47, id=73, x=123.64656829834,   y=-219.440338134766, z=54.5578384399414},
    { name="Binco's Clothing Shop", color=47, id=73, x=1696.29187011719,  y=4829.3125,         z=42.0631141662598},
    { name="Binco's Clothing Shop", color=47, id=73, x=618.093444824219,  y=2759.62939453125,  z=42.0881042480469},
    { name="Binco's Clothing Shop", color=47, id=73, x=1190.55017089844,  y=2713.44189453125,  z=38.2226257324219},
    { name="Binco's Clothing Shop", color=47, id=73, x=-1193.42956542969, y=-772.262329101563, z=17.3244285583496},
    { name="Binco's Clothing Shop", color=47, id=73, x=-3172.49682617188, y=1048.13330078125,  z=20.8632030487061},
    { name="Binco's Clothing Shop", color=47, id=73, x=-1108.44177246094, y=2708.92358398438,  z=19.1078643798828},
}

-- Main menu
local menu = {
    isOpen = false,
    title = "Clothes Shop",
    currentmenu = "main",
    lastmenu = nil,
    currentpos = nil,
    selectedbutton = 0,
    marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
    menu = {
        x = 0.11,
        y = 0.25,
        width = 0.2,
        height = 0.04,
        buttons = 10,
        from = 1,
        to = 10,
        scale = 0.4,
        font = 0,
        ["main"] = {
            title = "CATEGORIES",
            name = "main",
            buttons = {
                {name = "Face", description = ""},
                {name = "Hair", description = ""},
                {name = "Accessories", description = ""},
                {name = "Jackets", description = ""},
                {name = "Shirts", description = ""},
                {name = "Pants", description = ""},
                {name = "Shoes", description = ""},
                {name = "Close", description = ""},
            }
        },
        ["Face"] = {
            title = "Select a new face",
            name = "Face",
            buttons = {
                {name = "Next type", description = ''},
                {name = "Next texture", description = ''},
                {name = "Go back", description = ''},
            }
        },
    }
}




-- Places the blips on the map
Citizen.CreateThread(function()
    for _, item in pairs(clothingShops) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
        SetBlipColor(item.blip, item.color)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)
    end
end)

-- Thread to open the menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsNearShop()) then
            DisplayHelpText('Press ~INPUT_CONTEXT~ to ~b~buy new clothes~w~.',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~
            if IsControlJustReleased(1, 51) then
                if IsInVehicle() then
                    DisplayHelpText("You cannot change your clothes ~r~from a vehicle~w~.")
                else
                    if menu.isOpen then
                        CloseMenu()
                    else
                        OpenMenu()
                    end
                    menu.isOpen = not menu.isOpen
                end
            end
        else
            menu.isOpen = false
        end
    end
end)

-- Check if a player is near of a shop
function IsNearShop()
    for _, item in pairs(clothingShops) do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 35) then
            DisplayHelpText("Welcome to the ~y~clothing shop~w~.")
            DrawMarker(1, item.x, item.y, item.z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 39, 221, 39, 0, 0, 2, 0, 0, 0, 0)
        end
        if(distance < 2) then
            return true
        end
    end
end

-- Check if a player is in a vehicle
function IsInVehicle()
    local player = GetPlayerPed(-1)
    return IsPedSittingInAnyVehicle(player)
end

-------------------------------------------------------------------------------
------------------------- GRAPHIC USER INTERFACE ------------------------------
-------------------------------------------------------------------------------


-- Choices
function ButtonSelected(button)
    local player = GetPlayerPed(-1)
    local this = menu.currentmenu
    local btn = button.name
    if this == "main" then
        if btn == "Face" then
            OpenMenu('Face')
        elseif btn == "Close" then
            CloseMenu()
        end
    elseif this == "Face" then
        if btn == "Next type" then
            -- ToDo : function
        elseif btn == "Next texture" then
            -- ToDo : function
        elseif btn == "Go back" then
            -- ToDo : function
        end
    end
end

-- Open a category
function OpenMenu(menu)
    menu.lastmenu = menu.currentmenu
    if menu == "Face" then
        menu.lastmenu = "main"
    elseif menu == "Hair" then
        menu.lastmenu = "main"
    elseif menu == "Accessories" then
        menu.lastmenu = "main"
    end
    menu.menu.from = 1
    menu.menu.to = 10
    menu.selectedbutton = 0
    menu.currentmenu = menu
end

-- Prints a notification
function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- Creates notify messages
function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Prints the menu title
function drawMenuTitle(txt,x,y)
    local menu = menu.menu
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawRect(x,y,menu.width,menu.height,0,0,0,150)
    DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

-- Displays buttons
function drawMenuButton(button, x, y, selected)
    local menu = menu.menu
    SetTextFont(menu.font)
    SetTextProportional(0)
    SetTextScale(menu.scale, menu.scale)
    if selected then
        SetTextColour(0, 0, 0, 255)
    else
        SetTextColour(255, 255, 255, 255)
    end
    SetTextCentre(0)
    SetTextEntry("STRING")
    AddTextComponentString(button.name)
    if selected then
        DrawRect(x,y,menu.width,menu.height,255,255,255,255)
    else
        DrawRect(x,y,menu.width,menu.height,0,0,0,150)
    end
    DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

-- Shows the info about a button
function drawMenuInfo(text)
    local menu = menu.menu
    SetTextFont(menu.font)
    SetTextProportional(0)
    SetTextScale(0.45, 0.45)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
    DrawText(0.365, 0.934)
end

-- Displays a menu on the right
function drawMenuRight(txt,x,y,selected)
    menu = menu.menu
    SetTextFont(menu.font)
    SetTextProportional(0)
    SetTextScale(menu.scale, menu.scale)
    if selected then
        SetTextColour(0, 0, 0, 255)
    else
        SetTextColour(255, 255, 255, 255)
    end
    SetTextCentre(0)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

-- Prints the text
function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

-- Go back
function BackMenu()
    if backlock then
        return
    end
    backlock = true
    if menu.currentmenu == "main" then
        CloseMenu()
    elseif menu.currentmenu == "Face" or menu.currentmenu == "Hair" or menu.currentmenu == "Accessories" then
        OpenMenu(menu.lastmenu)
    else
        OpenMenu(menu.lastmenu)
    end
end

-- Opens the menu
function OpenMenu()
    menu.currentmenu = "main"
    menu.isOpen = true
    menu.selectedbutton = 0
end

-- Closes the menu
function CloseMenu()
    menu.isOpen = false
    menu.menu.from = 1
    menu.menu.to = 10
end

local backlock = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1,166) and menu.isOpen == true then
            CloseMenu()
        end
        if menu.isOpen then
            local ped = LocalPed()
            local menu = menu.menu[menu.currentmenu]
            drawTxt(menu.title,1,1,menu.menu.x,menu.menu.y,1.0, 255,255,255,255)
            drawMenuTitle(menu.title, menu.menu.x,menu.menu.y + 0.08)
            drawTxt(menu.selectedbutton.."/"..tablelength(menu.buttons),0,0,menu.menu.x + menu.menu.width/2 - 0.0385,menu.menu.y + 0.067,0.4, 255,255,255,255)
            local y = menu.menu.y + 0.12
            local buttoncount = tablelength(menu.buttons)
            local selected = false

            for i,button in pairs(menu.buttons) do
                if i >= menu.menu.from and i <= menu.menu.to then

                    if i == menu.selectedbutton then
                        selected = true
                    else
                        selected = false
                    end
                    drawMenuButton(button,menu.menu.x,y,selected)
                    if button.distance ~= nil then
                        drawMenuRight(button.distance.."m",menu.menu.x,y,selected)
                    end
                    y = y + 0.04
                    if selected and IsControlJustPressed(1,201) then
                        ButtonSelected(button)
                    end
                end
            end
        end
        if menu.isOpen then
            if IsControlJustPressed(1,202) then
                Backmenu()
            end
            if IsControlJustReleased(1,202) then
                backlock = false
            end
            if IsControlJustPressed(1,188) then
                if menu.selectedbutton > 1 then
                    menu.selectedbutton = menu.selectedbutton -1
                    if buttoncount > 10 and menu.selectedbutton < menu.menu.from then
                        menu.menu.from = menu.menu.from -1
                        menu.menu.to = menu.menu.to - 1
                    end
                end
            end
            if IsControlJustPressed(1,187)then
                if menu.selectedbutton < buttoncount then
                    menu.selectedbutton = menup.selectedbutton +1
                    if buttoncount > 10 and menu.selectedbutton > menu.menu.to then
                        menu.menu.to = menu.menu.to + 1
                        menu.menu.from = menu.menu.from + 1
                    end
                end
            end
        end

    end
end)


----------------------------------------------------
----------------- HELPER FUNCTIONS -----------------
----------------------------------------------------

function f(n)
    return n + 0.0001
end

function LocalPed()
    return GetPlayerPed(-1)
end

function try(f, catch_f)
    local status, exception = pcall(f)
    if not status then
        catch_f(exception)
    end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function round(num, idp)
    if idp and idp>0 then
        local mult = 10^idp
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end
