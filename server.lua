local function updateBlips()
    local dutyPlayers = {}
    local players = ESX.GetExtendedPlayers("job", "police")
    for _, xPlayer in pairs(players) do
        if xPlayer.job.name == 'police' then
            local coords = xPlayer.getCoords();
            dutyPlayers[#dutyPlayers+1] = {
                name = xPlayer.getName(),
                source = xPlayer.identifier,
                location = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                }
            }
        end
    end
    TriggerClientEvent('esx_policeblips:updateBlips', -1, dutyPlayers)
end

CreateThread(function()
    while true do
        updateBlips()
        Wait(5000)
    end
end)