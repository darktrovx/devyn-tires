local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("tire", function(source, item)
    TriggerClientEvent("Tire:Handler", source, false)
end)

RegisterNetEvent('Tires:GiveTire', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem("tire", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["tire"], 'add', 1)    
end)

QBCore.Functions.CreateCallback("tire:CheckItem", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("tire", 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["tire"], 'remove', 1)  
        cb(true)
    else 
        cb(false)
    end
end)
