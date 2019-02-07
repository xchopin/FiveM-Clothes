--[[Register]]--

RegisterNetEvent("clothing_shop:loadItems_client")
RegisterNetEvent("clothing_shop:getSkin_client")
RegisterNetEvent("clothing_shop:backPackInfo")
RegisterNetEvent("clothing_shop:noMoney")


--[[Local/Global]]--
local clothingShops = {
    { name="Binco's Clothing Shop", color=24, id=73, x=72.2545394897461,  y=-1399.10229492188, z=29.3761386871338},
    { name="Binco's Clothing Shop", color=24, id=73, x=-703.77685546875,  y=-152.258544921875, z=37.4151458740234},
    { name="Binco's Clothing Shop", color=24, id=73, x=-167.863754272461, y=-298.969482421875, z=39.7332878112793},
    { name="Binco's Clothing Shop", color=24, id=73, x=428.694885253906,  y=-800.1064453125,   z=29.4911422729492},
    { name="Binco's Clothing Shop", color=24, id=73, x=-829.413269042969, y=-1073.71032714844, z=11.3281078338623},
    { name="Binco's Clothing Shop", color=24, id=73, x=-1447.7978515625,  y=-242.461242675781, z=49.8207931518555},
    { name="Binco's Clothing Shop", color=24, id=73, x=11.6323690414429,  y=6514.224609375,    z=31.8778476715088},
    { name="Binco's Clothing Shop", color=24, id=73, x=123.64656829834,   y=-219.440338134766, z=54.5578384399414},
    { name="Binco's Clothing Shop", color=24, id=73, x=1696.29187011719,  y=4829.3125,         z=42.0631141662598},
    { name="Binco's Clothing Shop", color=24, id=73, x=618.093444824219,  y=2759.62939453125,  z=42.0881042480469},
    { name="Binco's Clothing Shop", color=24, id=73, x=1190.55017089844,  y=2713.44189453125,  z=38.2226257324219},
    { name="Binco's Clothing Shop", color=24, id=73, x=-1193.42956542969, y=-772.262329101563, z=17.3244285583496},
    { name="Binco's Clothing Shop", color=24, id=73, x=-3172.49682617188, y=1048.13330078125,  z=20.8632030487061},
    { name="Binco's Clothing Shop", color=24, id=73, x=-1108.44177246094, y=2708.92358398438,  z=19.1078643798828},
    { name="Clones'R us", color=58, id=73, x=125.640, y=-763.056, z=45.752},
}
local firstspawn = 0
local lang = 'en'
local txt = {
  ['en'] = {
        ['title'] = 'Binco Shop',
        ['gender'] = 'Change gender',
        ['head'] = 'Head',
        ['body'] = 'Body',
        ['pants'] = 'Pants',
        ['shoes'] = 'Shoes',
        ['vests'] = 'Vests',
        ['bags'] = 'Bags',
        ['close'] = 'Close',
        ['hair'] = 'Hair',
        ['face'] = 'Face',
        ['ears'] = 'Ears',
        ['glasses'] = 'Glasses',
        ['masks'] = "Masks",
        ['hats'] = "Hats",
        ['gloves'] = "Arms and gloves",
        ['shirts'] = "Shirts",
        ['jackets'] = "Jackets",
        ['message'] = "Press ~INPUT_CONTEXT~ to ~g~shop for clothes",
        ['close'] = "Close"
  },

    ['fr'] = {
        ['title'] = 'Nouveau look',
        ['gender'] = 'Changer de genre',
        ['head'] = 'Tete',
        ['body'] = 'Corps',
        ['pants'] = 'Pantalon',
        ['shoes'] = 'Chaussures',
        ['vests'] = 'Kevlar',
        ['bags'] = 'Sacs',
        ['close'] = 'Fermer',
        ['hair'] = 'Cheveux',
        ['face'] = 'Visages',
        ['ears'] = 'Accessoires oreilles',
        ['glasses'] = 'Lunettes',
        ['masks'] = "Masques",
        ['hats'] = "Chapeaux",
        ['gloves'] = "Bras et gants",
        ['shirts'] = "Haut",
        ['jackets'] = "Vestes",
        ['message'] = "Appuyez sur ~INPUT_CONTEXT~ pour faire des ~g~achats",
        ['close'] = "Fermer"
  },
}
local isLeaving = false
local skinOptions = {
    open = false,
    title = "Categories",
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

skinMenu:setMenu( "main",txt[lang]['title'],{

    {
        id="gender",
        name = txt[lang]['gender'],
        description = "",
        onClick = function()
            TriggerServerEvent("clothing_shop:GetSkin_server")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function() return false end
    },
    {
        id="head",
        name = txt[lang]['head'],
        description = "",
        onClick = function()
            skinMenu:toMenu("head")
        end,
        onLeft = function() return false end,
        onRight = function() return false end,
        onSelected = function() return false end,
        onBack = function() return false end
    }, {
        id="body",
        name = txt[lang]['body'],
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
        name = txt[lang]['pants'],
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
        name = txt[lang]['shoes'],
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
        name = txt[lang]['vests'],
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
        name = txt[lang]['bags'],
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
        name = txt[lang]['close'],
        description = "",
        onClick= function()
            skinMenu:close()
            isLeaving = false
            TriggerServerEvent("clothing_shop:SpawnPlayer_server") -- Validate the choices ;)
        end,
        onLeft= function() return false end,
        onRight= function() return false end,
        onSelected= function() return false end,
        onBack = function() return false end
    } }, false )

skinMenu:setMenu( "head", txt[lang]['head'], {
    {
        id="hair",
        name = txt[lang]['hair'],
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
        name = txt[lang]['face'],
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
        id="ears",
        name = txt[lang]['ears'],
        description = "",
        onClick = function()
            skinMenu:toMenu("ears")
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
        name = txt[lang]['glasses'],
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
        name = txt[lang]['hats'],
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
    }
}, false )

skinMenu:setMenu( "glasses", txt[lang]['glasses'], function() return skinMenu:getPropList(1) end, true )
skinMenu:setMenu( "helmet", txt[lang]['hats'], function() return skinMenu:getPropList(0) end, true )
skinMenu:setMenu( "body", txt[lang]['body'], {
    {
        id="glove",
        name = txt[lang]['gloves'],
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
        name = txt[lang]['shirts'],
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
        name = txt[lang]['jackets'],
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

skinMenu:setMenu( "face", txt[lang]['face'], function() return skinMenu:getDrawableList(0) end , true )
skinMenu:setMenu( "hair", txt[lang]['hair'], function() return skinMenu:getDrawableList(2) end , true )
skinMenu:setMenu( "ears", txt[lang]['ears'], function() return skinMenu:getPropList(2) end , true )
skinMenu:setMenu( "mask", txt[lang]['masks'], function() return skinMenu:getDrawableList(1) end, true )
skinMenu:setMenu( "pant", txt[lang]['pants'], function() return skinMenu:getDrawableList(4) end, true )
skinMenu:setMenu( "shoe", txt[lang]['shoes'], function() return skinMenu:getDrawableList(6) end, true )
skinMenu:setMenu( "accessory1", txt[lang]['vests'], function() return skinMenu:getDrawableList(9) end, true )
skinMenu:setMenu( "accessory2", txt[lang]['bags'], function() return skinMenu:getDrawableList(5) end, true )
skinMenu:setMenu( "glove", txt[lang]['gloves'], function() return skinMenu:getDrawableList(3) end, true )
skinMenu:setMenu( "tshirt", txt[lang]['shirts'], function() return skinMenu:getDrawableList(8) end, true )
skinMenu:setMenu( "jacket", txt[lang]['jackets'], function() return skinMenu:getDrawableList(11) end, true )



--[[Functions]]--

function ChangeGender(skin)
    local newSkin = nil;
    if skin == "mp_m_freemode_01" then
        newSkin = "mp_f_freemode_01"
        setSkin(newSkin)
    else
        newSkin = "mp_m_freemode_01"
        setSkin(newSkin)
    end

    BuyItem({collection = "skin"}, {value = newSkin })
    SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 2, 11, 4, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 4, 1, 5, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 0, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 11, 7, 2, 2)
    SaveItem({collection = "component", id= 0}, {value = 0, texture_value = 0 })
    SaveItem({collection = "component", id= 2}, {value = 11, texture_value = 4 })
    SaveItem({collection = "component", id= 4}, {value = 1, texture_value = 5 })
    SaveItem({collection = "component", id= 6}, {value = 1, texture_value = 0 })
    SaveItem({collection = "component", id= 11}, {value = 7, texture_value = 2 })
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function LoadItems(items)
    if (items ~= nil) then
        setSkin(items.skin)
        setItem("component", 0, items.face, items.face_texture)
        setItem("component", 1, items.mask, items.mask_texture)
        setItem("component", 2, items.hair, items.hair_texture)
        setItem("component", 3, items.gloves, items.gloves_texture)
        setItem("component", 4, items.pants, items.pants_texture)
        setItem("component", 5, items.bag, items.bag_texture)
        setItem("component", 6, items.shoes, items.shoes_texture)
        setItem("component", 8, items.shirt, items.shirt_texture)
        setItem("component", 9, items.vest, items.vest_texture)
        setItem("component", 11, items.jacket, items.jacket_texture)
        -- Props (accessories that can fall) --
        setItem("prop", 0, items.hat, items.hat_texture)
        setItem("prop", 1, items.glasses, items.glasses_texture)
        setItem("prop", 2, items.ears, items.ears_texture)
    else
        setSkin("mp_m_freemode_01") -- I hope the feminists are not gonna argue lol
        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 2, 11, 4, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 1, 5, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 11, 7, 2, 2)
    end
    SetModelAsNoLongerNeeded(modelhashed)
end

function setSkin(skin)
    local modelhashed = GetHashKey(skin)
    RequestModel(modelhashed)
    while not HasModelLoaded(modelhashed) do
        RequestModel(modelhashed)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), modelhashed)
end

function setItem(type, part, value, texture_value)
    if (part ~= nil and value ~= nil and texture_value ~= nil and type ~= nil) then
        if (type == "component") then
            SetPedComponentVariation(GetPlayerPed(-1), part, tonumber(value), tonumber(texture_value), 0)
        else
            if (type == "prop") then
                SetPedPropIndex(GetPlayerPed(-1), part, tonumber(value), tonumber(texture_value), 0)
            end
        end
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function IsNearShop()
    for _, item in pairs(clothingShops) do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 35) then
            DrawMarker(1, item.x, item.y, item.z-1,0,0,0,0,0,0,3.001,3.0001,0.5001,56,205,150,100,0,0,0,0)
        end
        if(distance < 2) then
            DisplayHelpText(txt[lang]['message'],0,1,0.5,0.8,0.6,255,255,255,255)
            return true
        end
    end
end

function IsInVehicle()
    local player = GetPlayerPed(-1)
    return IsPedSittingInAnyVehicle(player)
end

function BuyItem(item, values)
    TriggerServerEvent("clothing_shop:SaveItem_server", item, values)   
end

function SaveItem(item, values)
    TriggerServerEvent("clothing_shop:SaveItem_server", item, values)
end

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
            BuyItem({collection = "component", id = cmp}, {value = i, texture_value = skinMenu.menu[skinMenu.currentmenu].userSelectVariation})
            
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
            BuyItem({collection = "prop", id = cmp}, {value = i, texture_value = skinMenu.menu[skinMenu.currentmenu].userSelectVariation})
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
end



--[[Citizen]]--

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
                isLeaving = true
            end
        else
            skinMenu:close()
            if isLeaving then
              TriggerServerEvent("clothing_shop:SpawnPlayer_server") -- Validate the choices ;)
              isLeaving = false
            end
        end
        Citizen.Wait(0)
    end
end)



--[[Events]]--

AddEventHandler('playerSpawned', function(spawn)
    if firstspawn == 0 then
        TriggerServerEvent("clothing_shop:SpawnPlayer_server")
        firstspawn = 1
    end

    local a = ""
    TriggerServerEvent("weaponshop:playerSpawned", a)
end)

AddEventHandler("clothing_shop:loadItems_client",function(items)
    LoadItems(items)
end)

AddEventHandler('onPlayerDied', function()
    TriggerServerEvent("clothing_shop:SpawnPlayer_server")
end)

AddEventHandler("clothing_shop:getSkin_client",function(skin)
    ChangeGender(skin)
end)

AddEventHandler("clothing_shop:backPackInfo",function(skin)
    drawNotification("This bag has no carrying capacity, the good ones are :\n31 - $100000$\n41 - 500000$\n45 - 1000000$")
end)

AddEventHandler("clothing_shop:noMoney",function(skin)
    drawNotification("You do not have enough money")
end)