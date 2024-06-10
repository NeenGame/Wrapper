NeenWrapper = {
    RegisteredCallbacks = {},
    DefaultNPCS = {},
}

NeenWrapper.GetCoreObject = function()
    if SHWrapper.Framework == 'qb' then
        return exports[SHWrapper.QBCoreName]:GetCoreObject()
    elseif SHWrapper.Framework == 'custom' then
        return -- your core object
    end
end

NeenWrapper.Notify = function(text, type, dure)
    if SHWrapper.Framework == 'qb' then
        -- if type == 'primary' then type = 'inform' end
        return NeenWrapper.GetCoreObject().Functions.Notify(text, type, dure)
    elseif SHWrapper.Framework == 'custom' then
        return -- your Notify function
    end
end

NeenWrapper.SpawnVehicle = function(model, coords)
    if SHWrapper.Framework == 'qb' then
        local VehId, VehiclePlate, networkID
        NeenWrapper.GetCoreObject().Functions.SpawnVehicle(model, function(veh)
            VehiclePlate = GetVehicleNumberPlateText(veh)
            networkID = NetworkGetNetworkIdFromEntity(veh)
            SetVehicleModKit(veh, 0)
            SetVehicleMod(veh, 48, 0)
            SetVehicleDirtLevel(veh, 0)
            SetVehicleFuelLevel(veh, 100.0)
            VehId = veh
        end, coords)
        return VehId, VehiclePlate, networkID
    elseif SHWrapper.Framework == 'custom' then
        -- your spawn way
    end
end

NeenWrapper.HasItem = function(Search, item, metadata)
    if SHWrapper.Inventory == 'ox' then
        return exports.ox_inventory:Search(Search, item, metadata) > 0
    elseif SHWrapper.Inventory == 'qb' then
        return exports[SHWrapper.InventoryName]:HasItem({item}, 1)
    elseif SHWrapper.Inventory == 'custom' then
        return -- your way here
    end
end

NeenWrapper.ProgressBar = function(Label, duration, anim, dict)
    if SHWrapper.ProgressBar == 'ox' then
        if exports[SHWrapper.LibName]:progressBar({
            duration = duration,
            label = Label,
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combar = true,
                sprint = true,
            },
            anim = {
                dict = dict,
                clip = anim
            },
        }) then return true else return false end
    elseif SHWrapper.ProgressBar == 'qb' then
        local done, breakloop = false, true
        NeenWrapper.GetCoreObject().Functions.Progressbar(Label..'prog', Label, duration, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {
            animDict = dict,
            anim = anim,
            flags = 49
        }, {}, {}, function() -- Done
            done = true
            breakloop = false
        end, function() -- Cancel
            done = false
            breakloop = false
        end)
        while breakloop do
            Wait(1000)
        end
        return done
    elseif SHWrapper.ProgressBar == 'custom' then
        return -- your way here
    end
end

NeenWrapper.TargetZone = function(Coords, id, icon, TargetIcon, label, event, type)
    if SHWrapper.Target == 'ox' then
        return exports[SHWrapper.TargetName]:addBoxZone({
            coords = vector3(Coords.x, Coords.y, Coords.z),
            size = vec3(2, 2, 2),
            options = {
                { targetIcon = TargetIcon },
                {
                    id = id,
                    icon = icon,
                    label = label,
                    serverEvent = event,
                    canInteract = function()
                        return true
                    end,
                    distance = 1.5
                },
            }
        })
    elseif SHWrapper.Target == 'qb' then
        local name = id
        exports[SHWrapper.TargetName]:AddBoxZone(name, vector3(Coords.x, Coords.y, Coords.z), 1.5, 1.6, {
            name = name,
            debugPoly = true,
            minZ = Coords.z - 2,
            maxZ = Coords.z + 2,
            }, {
            options = {
                {
                type = type,
                event = event,
                icon = icon,
                label = label,
                canInteract = function()
                    return true
                end,
                }
            },
            distance = 1.5,
        })
        return name
    elseif SHWrapper.Target == 'custom' then
        return -- your core object
    end
end

NeenWrapper.RemoveZone = function(zoneId)
    if SHWrapper.Target == 'ox' then
        exports[SHWrapper.TargetName]:removeZone(zoneId)
    elseif SHWrapper.Target == 'qb' then
        exports[SHWrapper.TargetName]:RemoveZone(zoneId)
    elseif SHWrapper.Target == 'custom' then
        -- your way here
    end
end