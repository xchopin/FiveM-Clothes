--[[Info]]--


--[[Register]]--

RegisterServerEvent("clothing_shop:SetItems_server")
RegisterServerEvent("clothing_shop:SpawnPlayer_server")
RegisterServerEvent("skin_customization:SpawnPlayer")
RegisterServerEvent("clothing_shop:SaveItem_server")
RegisterServerEvent("clothing_shop:GetSkin_server")
RegisterServerEvent("clothing_shop:WithDraw_server")



--[[Local/Global]]--

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



--[[Function]]--

function getPlayerID(source)
	return getIdentifiant(GetPlayerIdentifiers(source))
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

-- Gives you the column name for a collection and id given
-- collection can be "skin", valueId can be null)
-- 					 "component", requires a valueId
-- 					 "prop", requires a valueId
function giveColumnName(collection, valueId)
    local res = nil
    if (collection == "skin") then
        res = "skin"
    else
        local id = tonumber(valueId)
        if (collection == "component") then
        	if (id == 0) then
        	    res = "face"
        	end
        	if (id == 1) then
        	    res = "mask"
        	end
        	if (id == 2) then
        	    res = "hair"
        	end
        	if (id == 3) then
        	    res = "gloves"
        	end
        	if (id == 4) then
        	    res = "pants"
        	end
        	if (id == 5) then
        	    res = "bag"
        	end
        	if (id == 6) then
        	    res = "shoes"
        	end
        	if (id == 8) then
        	    res = "shirt"
        	end
        	if (id == 9) then
        	    res = "vest"
        	end
        	if (id == 11) then
        	    res = "jacket"
        	end
		else
			if (collection == "prop") then
				if (id == 0) then
					res = "hat"
				end
				if (id == 1) then
					res = "glasses"
				end
				if (id == 2) then
					res = "ears"
				end
			end
		end
	end
 	return res
end

function getIsFirstConnection(source)
	return MySQL.Sync.fetchScalar("SELECT isFirstConnection FROM users WHERE identifier=@identifier",
		{['@identifier'] = getPlayerID(source)}) 
end

function createPlayerIntoDbClothes(source)
	MySQL.Async.execute("INSERT INTO user_clothes (identifier) VALUES (@identifier)",
		{['@identifier']= getPlayerID(source) }, function(data)  
	end)
end

function updateIsFirstConnection(source)
	MySQL.Async.execute("UPDATE users SET isFirstConnection=@isFirstConnection WHERE identifier=@identifier",
		{['@identifier'] = getPlayerID(source), ['@isFirstConnection'] = 0}, function(data)
	end)
end

function updatePlayerClothes1(source,values)
	local source = exports.essentialmode:getPlayerFromId(player)
	MySQL.Async.execute("UPDATE user_clothes SET skin=@value WHERE identifier=@identifier",
		{['@identifier'] = getPlayerID(source), ['@value'] = values }, function(data)
	end)
end

function updatePlayerClothes2(name,values,textures)

	MySQL.Async.execute("UPDATE user_clothes SET ".. name .."=@value, ".. name..'_texture' .."=@texture_value WHERE identifier=@identifier",
		{['@identifier'] = getPlayerID(source), ['@value'] = values, ['@texture_value'] = textures}, function(data)
	end)
end

function getSPlayerSkin(source)
	return MySQL.Sync.fetchScalar("SELECT skin FROM user_clothes WHERE identifier=@identifier",
		{['@identifier'] = getPlayerID(source)})
end

function getBackPackId(source,values)
	return MySQL.Sync.fetchScalar("SELECT id FROM backpack WHERE prop=@prop",
		{['@prop'] = values})
end

function getBackPackPrice(source,values)
	return MySQL.Sync.fetchScalar("SELECT price FROM backpack WHERE id=@backpack_id",
		{['@backpack_id'] = getBackPackId(values)})
end

function updatePlayerBackPack(source,values)
	if getBackPackId(values) then
		MySQL.Async.execute("UPDATE users SET backpack_id=@backpack_id WHERE identifier=@identifier",
			{['@identifier'] = getPlayerID(source), ['@backpack_id'] = getBackPackId(values)}, function(data)
		end)
		TriggerEvent('es:getPlayerFromId', source, function(user)
			if user.money >= getBackPackPrice(values) then
			user:removeMoney((getBackPackPrice(values)))			
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_SOCIAL_CLUB", 1, "Binco Shop", false, "You bought a new item!")
			else
				TriggerClientEvent("clothing_shop:noMoney", source)
			end
		end)
	else		
		TriggerClientEvent("es_freeroam:notify", source, "CHAR_SOCIAL_CLUB", 1, "Binco Shop", false, "You bought a new item!")
		TriggerClientEvent("clothing_shop:backPackInfo", source)
	end
end


--[[Events]]--

AddEventHandler("clothing_shop:SpawnPlayer_server", function()
	local source = source
	if(getIsFirstConnection(source) == 1) then
		createPlayerIntoDbClothes(source)
		updateIsFirstConnection(source)
		MySQL.Async.fetchAll("SELECT * FROM user_clothes WHERE identifier=@identifier", {['@identifier'] = getPlayerID(source)}, function(data)
			TriggerClientEvent("clothing_shop:loadItems_client", source, data[1])
		end)
	else
		MySQL.Async.fetchAll("SELECT * FROM user_clothes WHERE identifier=@identifier", {['@identifier'] = getPlayerID(source)}, function(data)
			TriggerClientEvent("clothing_shop:loadItems_client", source, data[1])
		end)
	end
end)

AddEventHandler("clothing_shop:SetItems_servers",function()
	MySQL.Async.fetchAll("SELECT * FROM user_clothes WHERE identifier=@identifier", {['@identifier'] = getPlayerID(source)}, function(data)
		TriggerClientEvent("clothing_shop:loadItems_client", source, data[1])
	end)
end)

AddEventHandler("clothing_shop:SaveItem_server", function(item, values)
	if (giveColumnName(item.collection, item.id) == "skin") then
		updatePlayerClothes1(values.value)		
		TriggerClientEvent("es_freeroam:notify", source, "CHAR_SOCIAL_CLUB", 1, "Binco Shop", false, "You bought a new item!")
	else
		updatePlayerClothes2(giveColumnName(item.collection, item.id),values.value,values.texture_value)
		if (giveColumnName(item.collection, item.id) == "bag" ) then

			updatePlayerBackPack(values.value)
		end
	end
end)

AddEventHandler("clothing_shop:GetSkin_server",function()
	TriggerClientEvent("clothing_shop:getSkin_client", source, getSPlayerSkin())
end)