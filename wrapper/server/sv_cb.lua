NeenWrapper.CreateCallback = function(Name, Cb)
    NeenWrapper.RegisteredCallbacks[Name] = Cb
end

RegisterNetEvent("neen-rpc:[Server]:Execute", function(Id, Name, ...)
    local src = source
    if not NeenWrapper.RegisteredCallbacks[Name] then return end
    if NeenWrapper.RegisteredCallbacks[Name] == nil then return end
    if src == 0 or src == nil then return end
    NeenWrapper.RegisteredCallbacks[Name](src, function(Data)
        TriggerClientEvent("neen-rpc:[Client]:Response", src, Id, Data)
    end, ...)
end)