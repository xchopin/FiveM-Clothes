---------------------------------------------------------------------------------------
--                     Author: Xavier CHOPIN <www.github.com/xchopin>                --
--                                 License: Apache 2.0                               --
---------------------------------------------------------------------------------------


local firstspawn = 0



AddEventHandler('playerSpawned', function(spawn)
    if firstspawn == 0 then
        TriggerServerEvent("clothingShop:SpawnPlayer_server")
        firstspawn = 1
    end
end)

RegisterNetEvent("clothingShop:loadSkin_client")
AddEventHandler("clothingShop:loadSkin_client",function(skin ,clothes)
    LoadSkin(skin, clothes)
end)

AddEventHandler('onPlayerDied', function()
	TriggerServerEvent("clothingShop:SpawnPlayer")
end)




