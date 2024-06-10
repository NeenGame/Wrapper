NeenWrapper = {
    RegisteredCallbacks = {}
}

NeenWrapper.GetCoreObject = function()
    if SHWrapper.Framework == 'qb' then
        return exports[SHWrapper.QBCoreName]:GetCoreObject()
    elseif SHWrapper.Framework == 'custom' then
        return -- your core object
    end
end

NeenWrapper.GetJob = function(Source)
    if SHWrapper.Framework == 'qb' then
        return NeenWrapper.GetCoreObject().Functions.GetPlayer(Source).PlayerData.job.name
    elseif SHWrapper.Framework == 'custom' then
        return -- your way here
    end
end

NeenWrapper.Notify = function(Source, text, type, duration)
    if SHWrapper.Framework == 'qb' then
        -- if type == 'primary' then type = 'inform' end
        return NeenWrapper.GetCoreObject().Functions.Notify(Source, text, type, duration)
    elseif SHWrapper.Framework == 'custom' then
        return -- your way here
    end
end

--// Inventory \\--

NeenWrapper.HasItem = function(Source, item, metadata, returncount)
    if SHWrapper.Inventory == 'ox' then
        local hasItem =  exports[SHWrapper.InventoryName]:GetItem(Source, item, metadata, returncount)
        if hasItem <= 0 then
            return false
        end
        return true
    elseif SHWrapper.Inventory == 'qb' then
        return exports[SHWrapper.InventoryName]:HasItem(Source, item, 1)
    elseif SHWrapper.Inventory == 'custom' then
        return -- your way here
    end
end

NeenWrapper.Additem = function(src, item, amount)
    if SHWrapper.Inventory == 'ox' then
       return exports[SHWrapper.InventoryName]:AddItem(src, item, amount)
    elseif SHWrapper.Inventory == 'qb' then
        return exports[SHWrapper.InventoryName]:AddItem(src, item, amount, false, false)
    elseif SHWrapper.Inventory == 'custom' then
        return -- your way here
    end
end

NeenWrapper.CanCarryItem = function(src, item, amount)
    if SHWrapper.Inventory == 'ox' then
        return exports[SHWrapper.InventoryName]:CanCarryItem(src, item, amount)
    elseif SHWrapper.Inventory == 'qb' then
        local items = NeenWrapper.GetCoreObject().Functions.GetPlayer(src).PlayerData.items
        local weight = exports[SHWrapper.InventoryName]:GetTotalWeight(items)
        return weight
    elseif SHWrapper.Inventory == 'custom' then
        return --Your way here
    end
end

NeenWrapper.UpdateWeight = function(vehplate, weight)
    if SHWrapper.Inventory == 'ox' then
        exports[SHWrapper.InventoryName]:SetMaxWeight("trunk" .. vehplate, weight)
    elseif SHWrapper.Inventory == 'custom' then
        return -- your way here
    end
end

NeenWrapper.GetItemWeight = function(item)
    if SHWrapper.Inventory == 'ox' then
        local itemdata = exports[SHWrapper.InventoryName]:Items(item)
        return itemdata.weight
    elseif SHWrapper.Inventory == 'qb' then
        local itemdata = NeenWrapper.GetCoreObject().Shared.Items[item]
        return itemdata.weight
    elseif SHWrapper.Inventory == 'custom' then
        return -- your way here
    end
end

NeenWrapper.GetItemShit = function(inventoryId, item)
    if SHWrapper.Inventory == 'ox' then
        return exports[SHWrapper.InventoryName]:GetItem(inventoryId, item, nil, true)
    elseif SHWrapper.Inventory == 'custom' then
        return -- your way here. Needs to return item amount from the stash
    end
end

NeenWrapper.GetItemCount = function(src, item)
    if SHWrapper.Inventory == 'ox' then
        return exports[SHWrapper.InventoryName]:GetItem(src, item, nil, true)
    elseif SHWrapper.Inventory == 'qb' then
        return exports[SHWrapper.InventoryName]:GetItemCount(src, item)
    elseif SHWrapper.Inventory == 'custom' then
        return -- your way here. Needs to return item amount from the stash
    end
end

--// Inventory end \\--

NeenWrapper.SetVehicleKeys = function(src, Plate)
    if SHWrapper.Framework == 'qb' then
        TriggerClientEvent('vehiclekeys:client:SetOwner', src, Plate)
    elseif SHWrapper.Framework == 'custom' then
        -- Your way
    end
end

NeenWrapper.Rewards = function(src, data)
    if SHWrapper.Framework == 'qb' then
        -- Your way here
    elseif SHWrapper.Framework == 'custom' then
        -- Your way here
    end
end