local QBCore = exports['qb-core']:GetCoreObject()

-- This ensures that using the headphone triggers the correct client event
QBCore.Functions.CreateUseableItem("headphones", function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    
    print("[DEBUG SERVER] Player used the headphones item")

    -- Trigger the client event to open the menu
    TriggerClientEvent('qb-core:useHeadphone', source)
end)

