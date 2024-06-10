NeenWrapper.TriggerCallback = function(Name, Cb, ...)
    local CbId = Name ..":" ..tostring(math.random(11111, 99999))
    NeenWrapper.RegisteredCallbacks[CbId] = Cb
    TriggerServerEvent("neen-rpc:[Server]:Execute", CbId, Name, ...)
end

NeenWrapper.ExecuteCB = function(Event, ...)
    local Promise = promise:new()
    NeenWrapper.TriggerCallback(Event, function(Result)
        Promise:resolve(Result)
    end, ...)
    return Citizen.Await(Promise)
end

RegisterNetEvent("neen-rpc:[Client]:Response", function(Id, Data)
    local CallbackEvent = NeenWrapper.RegisteredCallbacks[Id]
    if CallbackEvent ~= nil then
        CallbackEvent(Data)
        Wait(500)
        NeenWrapper.RegisteredCallbacks[Id] = nil
    end
end)