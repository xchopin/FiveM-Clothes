require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "Nadoreevax_5$")


local SQL_COLUMNS = {
	'skin',
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
}

-- Gives you the column name for a collection and id given
-- collection can be "skin", valueId can be null)
-- 					 "component", requires a valueId
-- 					 "prop", requires a valueId
function giveColumnName(collection, valueId)
	local res = nil
	if (collection == "skin")
		res = "skin"
	else
		local id = tonumber(valueId)
		if (collection == "component")
				if (id == 0)
					res = "face"
				end
				if (id == 1)
					res = "mask"
				end
				if (id == 2)
					res = "hair"
				end
				if (id == 3)
					res = "gloves"
				end
				if (id == 4)
					res = "pants"
				end
				if (id == 5)
					res = "bag"
				end
				if (id == 6)
					res = "shoes"
				end
				if (id == 8)
					res = "shirt"
				end
				if (id == 9)
					res = "vest"
				end
				if (id == 11)
					res = "jacket"
				end
		else
			if (collection == "prop")	
				if (id == 0)
					res = "hat"
				end
				if (id == 1)
					res = "glasses"
				end
				if (id == 2)
					res = "ears"
				end
			end
		end	
	end	
	return res
end


RegisterServerEvent("clothing_shop:SpawnPlayer_server")
AddEventHandler("clothing_shop:SpawnPlayer_server", function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.identifier
		local executed_query = MySQL:executeQuery("SELECT isFirstConnection FROM users WHERE identifier = '@username'", {['@username'] = player})
		local result = MySQL:getResults(executed_query, {'isFirstConnection'}, "identifier")
        if(result[1].isFirstConnection == 1)then
            MySQL:executeQuery("INSERT INTO user_clothes(identifier) VALUES ('@identifier')",{['@identifier']=player})
            MySQL:executeQuery("UPDATE users SET isFirstConnection = 0 WHERE identifier = '@username'", {['@username'] = player})
		end
        executed_query = MySQL:executeQuery("SELECT * FROM user_clothes WHERE identifier = '@username'", {['@username'] = player})
		result = MySQL:getResults(executed_query, SQL_COLUMNS, "identifier")
		TriggerClientEvent("clothing_shop:loadItems_client", source, result[1]) -- Updates the client's skin with default values
	end)
end)

RegisterServerEvent("clothing_shop:SetItems_server")
AddEventHandler("clothing_shop:SetItems_servers",function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
	    local player = user.identifier
	    local executed_query = MySQL:executeQuery("SELECT * FROM user_clothes WHERE identifier = '@username'", {['@username'] = player})
		local result = MySQL:getResults(executed_query, SQL_COLUMNS, "identifier")
	    TriggerClientEvent("clothing_shop:loadItems_client", source, result[1])
    )end)
end)

RegisterServerEvent("clothing_shop:SaveItem_server")
AddEventHandler("clothing_shop:SetItems_servers",function(item, values)
    TriggerEvent('es:getPlayerFromId', source, function(user)
	    local player = user.identifier
	    local executed_query = MySQL:executeQuery(
												"INSERT INTO user_clothes( ('@name'), ('@texture_name') ) VALUES ('@value'), ('@texture_value')
												 WHERE identifier = ('@identifier')",
												 {
												   ['@name'] = giveColumnName(item.collection, item.id),
												   ['@texture_name'] = giveColumnName(item.collection, item.id)..'_texture',
												   ['@value'] = values.value,
												   ['@texture_value'] = values.texture_value,
												   ['@identifier'] = player,

												 })
		--local result = MySQL:getResults(executed_query, SQL_COLUMNS, "identifier")
	    --TriggerClientEvent("clothing_shop:loadItems_client", source, result[1])
    )end)
end)