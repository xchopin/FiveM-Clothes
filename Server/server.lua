require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "root")

RegisterServerEvent("clothing_shop:SpawnPlayer_server")
AddEventHandler("clothing_shop:SpawnPlayer_server", function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.identifier
		local executed_query = MySQL:executeQuery("SELECT isFirstConnection FROM users WHERE identifier = '@username'", {['@username'] = player})
		local result = MySQL:getResults(executed_query, {'isFirstConnection'}, "identifier")
        if(result[1].isFirstConnection == 1)then
            MySQL:executeQuery("INSERT INTO user_clothes(identifier) VALUES ('@identifier')",{['@identifier']=player})
            MySQL:executeQuery("UPDATE users SET isFirstConnection = 0 WHERE identifier = '@username'", {['@username'] = player})
            TriggerClientEvent("clothing_shop:loadSkin_client", source, "mp_m_freemode_01") -- Updates the client's skin
		else
            executed_query = MySQL:executeQuery("SELECT skin FROM outfits WHERE identifier = '@username'", {['@username'] = player})
		    local result2 = MySQL:getResults(executed_query, {'skin'}, "identifier")
			TriggerClientEvent("clothing_shop:loadSkin_client", source, result2[1].skin)
        end
	end)
end)

RegisterServerEvent("clothing_shop:LoadClientComponents")
AddEventHandler("clothing_shop:LoadClientComponents",function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
	    local player = user.identifier
        local executed_query = MySQL:executeQuery("SELECT * FROM user_clothes WHERE identifier='@user'",{['@user']=player})
        local result = MySQL:getResults(
        	executed_query, 
        		{'skin',
        		 'face',							
				 'face_texture',
				 'hair',
				 'hair_texture',
				 'shirt',
				 'shirt_texture',
				 'pants',
				 'pants_texture',
				 'shoes',
				 'shoes_texture',
				 'vest',
				 'vest_texture',
				 'bag',
				 'bag_texture',
				 'hat',
				 'hat_texture',
				 'mask',
				 'mask_texture',
				 'glasses',
				 'glasses_texture',
				 'gloves',
				 'gloves_texture',
				 'jacket',
				 'jacket_texture',
				 'ears',
				 'ears_texture'
				}, 
			"identifier")

        TriggerClientEvent("clothing_shop:SetComponents_client",source,
        {
       		result[1].skin,
			result[1].face,							
			result[1].face_texture,
			result[1].hair,
			result[1].hair_texture,
			result[1].shirt,
			result[1].shirt_texture,
			result[1].pants,
			result[1].pants_texture,
			result[1].shoes,
			result[1].shoes_texture,
			result[1].vest,
			result[1].vest_texture,
			result[1].bag,
			result[1].bag_texture,
			result[1].hat,
			result[1].hat_texture,
			result[1].mask,
			result[1].mask_texture,
			result[1].glasses,
			result[1].glasses_texture,
			result[1].gloves,
			result[1].gloves_texture,
			result[1].jacket,
			result[1].jacket_texture,
			result[1].ears,
			result[1].ears_texture
   		}
    )end)
end)
