local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

ESX.RegisterUsableItem('thuoc_doiadn', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('thuoc_doiadn', 1)

    TriggerClientEvent('esx_animaladn:chuanbidoiadn', source)
    
end)

ESX.RegisterUsableItem('thuoc_giaiadn', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('thuoc_giaiadn', 1)

    TriggerClientEvent('esx_animaladn:giaibiendoiadn', source)
    
end)
