---------------------------------------------------------------------------------------
--                     Author: Xavier CHOPIN <www.github.com/xchopin>                --
--                                 License: Apache 2.0                               --
---------------------------------------------------------------------------------------


local firstspawn = 0

AddEventHandler('playerSpawned', function(spawn)
    if firstspawn == 0 then
        TriggerServerEvent("clothing_shop:SpawnPlayer_server")
        firstspawn = 1
    end
end)

RegisterNetEvent("clothing_shop:loadSkin_client")
AddEventHandler("clothing_shop:loadSkin_client",function(skin)
    LoadSkin(skin)
end)

AddEventHandler('onPlayerDied', function()
    TriggerServerEvent("clothing_shop:SpawnPlayer_server")
end)




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


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Loads skin's client
function LoadSkin(skin)
    local modelhashed = GetHashKey(skin)
    RequestModel(modelhashed)
    while not HasModelLoaded(modelhashed) do 
        RequestModel(modelhashed)
        Citizen.Wait(2)
    end
    SetPlayerModel(PlayerId(), modelhashed)
    SetModelAsNoLongerNeeded(modelhashed)
end



-- Check if a player is near of a shop
function IsNearShop()
    for _, item in pairs(clothingShops) do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 35) then
            DrawMarker(1, item.x, item.y, item.z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 39, 221, 39, 0, 0, 2, 0, 0, 0, 0)
        end
        if(distance < 2) then
             DisplayHelpText('Appuyez sur ~INPUT_CONTEXT~ acheter des ~g~vêtements',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~          
            return true
        end
    end
end

-- Check if a player is in a vehicle
function IsInVehicle()
    local player = GetPlayerPed(-1)
    return IsPedSittingInAnyVehicle(player)
end


function BuyItem()
    --TriggerServerEvent("jobssystem:jobs", 2)
end

-- Set an item on client's character
----------------------------------------------------------
---- TYPE = "component"     --      TYPE = "prop"       --
----------------------------------------------------------
---- NAME      |  Part      ---- NAME      |  part      --
----------------------------------------------------------
---- Face      |    0       --  Hats       |     0      -- 
---- Mask      |    1       --  Glasses    |     1      -- 
---- Hair      |    2       --  Piercings  |     2      --           
---- Gloves    |    3       --             |            --    
---- Pants     |    4       --             |            --           
---- Bags      |    5       --             |            --           
---- Shoes     |    6       --             |            --           
---- Shirts    |    8       --             |            --           
---- Vests     |    9       --             |            --           
---- Jackets   |   11       --             |            --    
----------------------------------------------------------
function setItem(type, part, value, texture_value)
    if (part ~= nil and value ~= nil and texture_value ~= nil and type ~= nil) then
        if (type == "component") then
            SetPedComponentVariation(GetPlayerPed(-1), value, value_texture, 4)
        else if (type == "prop")
            SetPedPropIndex(GetPlayerPed(-1), value, value_texture, 0)
        end
    end   
end



local skinOptions = {
    open = false,
    title = "Changer de look",
    currentmenu = "main",
    lastmenu = "main",
    currentpos = nil,
    selectedbutton = 0,
    marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    buttons = 10,
    from = 1,
    to = 10,
    scale = 0.4,
    font = 0,
}

local skinMenu = ModuleMenu:create(skinOptions)

function skinMenu:getDrawableList(component)
    local list = {}
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), component) do
        local cmp               = component
        list[i]                 = {}
        list[i].name            = "Item n°".. i
        list[i].id              = i
        list[i].max             = false
        if GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmp, i) - 1 ~= nil or GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmp, i) - 1 > 0 then
            list[i].max         = GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmp, i) - 1
        end
        list[i].onClick         = function()
            skinMenu:saveItem( skinMenu.currentmenu, i, skinMenu.menu[skinMenu.currentmenu].userSelectVariation )
        end
        list[i].onLeft          = function()
            if skinMenu.menu[skinMenu.currentmenu].userSelectVariation > 0 then
                skinMenu:setCurrentVariation("left", skinMenu.currentmenu)
                SetPedComponentVariation(GetPlayerPed(-1), cmp, i, skinMenu.menu[skinMenu.currentmenu].userSelectVariation, 4)
            end
        end
        list[i].onRight         = function()
            if  skinMenu.menu[skinMenu.currentmenu].userSelectVariation < ( GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmp, i) - 1 ) then
                skinMenu:setCurrentVariation("right", skinMenu.currentmenu)
                SetPedComponentVariation(GetPlayerPed(-1), cmp, i, skinMenu.menu[skinMenu.currentmenu].userSelectVariation, 4)
            end
        end
        list[i].onSelected      = function()
            skinMenu.menu[skinMenu.currentmenu].userSelect = i
            SetPedComponentVariation(GetPlayerPed(-1), cmp, i, skinMenu.menu[skinMenu.currentmenu].userSelectVariation, 0)
        end
        list[i].onBack          = function()
            skinMenu:toMenu(skinMenu:getLastMenu())
        end
    end
    return list
end

function skinMenu:getPropList(prop)
    local list = {}
    for i = 0, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), prop) do
        local cmp               = prop
        list[i]                 = {}
        list[i].name            = "Item n°".. i
        list[i].id              = i
        if GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmp, i) ~= nil then
            list[i].max         = GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmp, i) - 1
        else
            list[i].max         = 0
        end

        list[i].onClick         = function()
            skinMenu:saveItem(skinMenu.currentmenu, i,  skinMenu.menu[skinMenu.currentmenu].userSelectVariation)
        end
        list[i].onLeft          = function()
            if skinMenu.menu[skinMenu.currentmenu].userSelectVariation > 0 then
                skinMenu:setCurrentVariation("left", skinMenu.currentmenu)
                SetPedPropIndex(GetPlayerPed(-1), cmp, i, skinMenu.menu[skinMenu.currentmenu].userSelectVariation, 0)
            end
        end
        list[i].onRight         = function()
            if  skinMenu.menu[skinMenu.currentmenu].userSelectVariation < ( GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmp, i) - 1 ) then
                skinMenu:setCurrentVariation("right", skinMenu.currentmenu)
                SetPedPropIndex(GetPlayerPed(-1), cmp, i, skinMenu.menu[skinMenu.currentmenu].userSelectVariation, 0)
            end
        end
        list[i].onSelected      = function()
            SetPedPropIndex(GetPlayerPed(-1), cmp, i, skinMenu.menu[skinMenu.currentmenu].userSelectVariation, 0)
        end
        list[i].onBack          = function()
            skinMenu:toMenu(skinMenu:getLastMenu())
        end
    end
    return list
end


function skinMenu:saveItem(menuId, value, value_texture)
    local item = {
        menuId = menuId,
        value = value,
        value_texture = value_texture
    }
    TriggerServerEvent("clothesShop:saveItem", item)
end


skinMenu:setMenu( "main","Vetements",{ {
        id="tete",
        name = "Tete",
        description = "",
        onClick = function()
            skinMenu:toMenu("tete")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function() return false end
    }, {
        id="body",
        name = "Corps",
        description = "",
        onClick= function()
            skinMenu:toMenu("body")
        end,
        onLeft= function() return false end,
        onRight= function() return false end,
        onSelected= function() return false end,
        onBack = function() return false end
    }, {
        id="pantmenu",
        name = "Pantalons",
        description = "",
        onClick= function()
            skinMenu:toMenu("pant")
        end,
        onLeft= function() return false end,
        onRight= function() return false end,
        onSelected= function() return false end,
        onBack = function() return false end
    }, {
        id="shoeMenu",
        name = "Chaussures",
        description = "",
        onClick= function()
            skinMenu:toMenu("shoe")
        end,
        onLeft= function() return false end,
        onRight= function() return false end,
        onSelected= function() return false end,
        onBack = function() return false end
    }, {
        id="accessory1Main",
        name = "Kevlar (skin)",
        description = "",
        onClick= function()
            skinMenu:toMenu("accessory1")
        end,
        onLeft= function() return false end,
        onRight= function() return false end,
        onSelected= function() return false end,
        onBack = function() return false end
    }, {
        id="accessory2Main",
        name = "Sacs",
        description = "",
        onClick= function()
            skinMenu:toMenu("accessory2")
        end,
        onLeft= function() return false end,
        onRight= function() return false end,
        onSelected= function() return false end,
        onBack = function() return false end
    }, {
        id="exit",
        name = "Quitter",
        description = "",
        onClick= function()
            skinMenu:close()
        end,
        onLeft= function() return false end,
        onRight= function() return false end,
        onSelected= function() return false end,
        onBack = function() return false end
    } }, false )

skinMenu:setMenu( "tete", "Tete", {
       {
        id="hair",
        name = "Cheveux",
        description = "",
        onClick = function()
            skinMenu:toMenu("hair")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
    },  {
        id="face",
        name = "Visage",
        description = "",
        onClick = function()
            skinMenu:toMenu("face")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
    },
    {
        id="glasses",
        name = "Lunettes",
        description = "",
        onClick = function()
            skinMenu:toMenu("glasses")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
    },
    {
        id="helmet",
        name = "Chapeaux",
        description = "",
        onClick = function()
            skinMenu:toMenu("helmet")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
    },
    {
        id="mask",
        name = "Masque",
        description = "",
        onClick = function()
            skinMenu:toMenu("mask")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
    }
}, false )

skinMenu:setMenu( "glasses", "Lunettes", function() return skinMenu:getPropList(1) end, true )
skinMenu:setMenu( "helmet", "Chapeaux", function() return skinMenu:getPropList(0) end, true )
skinMenu:setMenu( "body", "Corps", {
    {
        id="glove",
        name = "Bras et gants",
        description = "",
        onClick = function()
            skinMenu:toMenu("glove")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
},
    {
        id="tshirt",
        name = "T-Shirts",
        description = "",
        onClick = function()
            skinMenu:toMenu("tshirt")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
    },
    {
        id="jacket",
        name = "Vestes",
        description = "",
        onClick = function()
            skinMenu:toMenu("jacket")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function()
            skinMenu:toMenu('main')
        end
    },
}, false )

skinMenu:setMenu( "face", "Visage", function() return skinMenu:getDrawableList(0) end , true )
skinMenu:setMenu( "hair", "Cheveux", function() return skinMenu:getDrawableList(2) end , true )
skinMenu:setMenu( "percing", "Piercing", function() return skinMenu:getPropList(2) end , true )
skinMenu:setMenu( "mask", "Masque", function() return skinMenu:getDrawableList(1) end, true )
skinMenu:setMenu( "pant", "Pantalons", function() return skinMenu:getDrawableList(4) end, true )
skinMenu:setMenu( "shoe", "Chaussures", function() return skinMenu:getDrawableList(6) end, true )
skinMenu:setMenu( "accessory1", "Kevlar (skin)", function() return skinMenu:getDrawableList(9) end, true )
skinMenu:setMenu( "accessory2", "Sacs", function() return skinMenu:getDrawableList(5) end, true )
skinMenu:setMenu( "glove", "Torse et gants", function() return skinMenu:getDrawableList(3) end, true )
skinMenu:setMenu( "tshirt", "T-shirt", function() return skinMenu:getDrawableList(8) end, true )
skinMenu:setMenu( "jacket", "Vestes", function() return skinMenu:getDrawableList(11) end, true )


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

    while (true) do
        if skinMenu.open == true then
            skinMenu:display()
        end     
        if(IsNearShop()) then 
           if IsControlJustPressed(1,51) then
                skinMenu.open = true
            end
        else
            skinMenu:close() 
        end
         Citizen.Wait(0)
    end
end)