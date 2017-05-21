---------------------------------------------------------------------------------------
--                     Author: Xavier CHOPIN <www.github.com/xchopin>                --
--                                 License: Apache 2.0                               --
---------------------------------------------------------------------------------------

local isShopMenuOpen = false

-- List of the clothing shops {parts,x,y,z}
local clothingShops = {
    { name="Binco's Clothing Shop", colour=47, id=73, x=72.2545394897461,  y=-1399.10229492188, z=29.3761386871338},
    { name="Binco's Clothing Shop", colour=47, id=73, x=-703.77685546875,  y=-152.258544921875, z=37.4151458740234},
    { name="Binco's Clothing Shop", colour=47, id=73, x=-167.863754272461, y=-298.969482421875, z=39.7332878112793},
    { name="Binco's Clothing Shop", colour=47, id=73, x=428.694885253906,  y=-800.1064453125,   z=29.4911422729492},
    { name="Binco's Clothing Shop", colour=47, id=73, x=-829.413269042969, y=-1073.71032714844, z=11.3281078338623},
    { name="Binco's Clothing Shop", colour=47, id=73, x=-1447.7978515625,  y=-242.461242675781, z=49.8207931518555},
    { name="Binco's Clothing Shop", colour=47, id=73, x=11.6323690414429,  y=6514.224609375,    z=31.8778476715088},
    { name="Binco's Clothing Shop", colour=47, id=73, x=123.64656829834,   y=-219.440338134766, z=54.5578384399414},
    { name="Binco's Clothing Shop", colour=47, id=73, x=1696.29187011719,  y=4829.3125,         z=42.0631141662598},
    { name="Binco's Clothing Shop", colour=47, id=73, x=618.093444824219,  y=2759.62939453125,  z=42.0881042480469},
    { name="Binco's Clothing Shop", colour=47, id=73, x=1190.55017089844,  y=2713.44189453125,  z=38.2226257324219},
    { name="Binco's Clothing Shop", colour=47, id=73, x=-1193.42956542969, y=-772.262329101563, z=17.3244285583496},
    { name="Binco's Clothing Shop", colour=47, id=73, x=-3172.49682617188, y=1048.13330078125,  z=20.8632030487061},
    { name="Binco's Clothing Shop", colour=47, id=73, x=-1108.44177246094, y=2708.92358398438,  z=19.1078643798828},
}
-- Places the blips on the map
Citizen.CreateThread(function()
    for _, item in pairs(clothingShops) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
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
        if IsNear() then
            DisplayHelpText("Welcome to the ~y~clothing shop~w~.")
            if IsControlJustReleased(1, 51)  then -- IF INPUT_PICKUP Is pressed
                if IsInVehicle() then
                    DisplayHelpText("You cannot change your clothes ~r~from a vehicle~w~.")
                else
                    if isShopMenuOpen then
                        -- ToDo: close the GUI
                    else
                        -- ToDo: open the GUI
                    end
                    isShopMenuOpen = not isShopMenuOpen
                end
            end
        else
            if isShopMenuOpen then
                -- ToDo: open the GUI
            end
            isShopMenuOpen = false
        end
    end
end)

-- Check if a player is near of a shop
local function isNear()
    local player = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(player, 0)
    for _, item in pairs(clothingShops) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= 2) then
            return true
        end
    end
end

-- Check if a player is in a vehicle
local function isInVehicle()
    local player = GetPlayerPed(-1)
    return IsPedSittingInAnyVehicle(player)
end

