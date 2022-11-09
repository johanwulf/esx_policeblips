local DutyBlips = {}
local track = false;

local function createDutyBlips(playerId, playerName)
    local ped = GetPlayerPed(playerId);
    local blip = GetBlipFromEntity(ped);
    if not DoesBlipExist(blip) then
        if ped == GetPlayerPed(-1) and not Config.DrawSelfBlip then return end
        blip = AddBlipForEntity(ped);
        SetBlipSprite(blip, 1);
        SetBlipScale(blip, 1.0)
        if (ESX.GetPlayerData().job.name == "police") then
            SetBlipColour(blip, 38)
        end
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(playerName)
        EndTextCommandSetBlipName(blip)
        DutyBlips[#DutyBlips+1] = blip;
    end
end

RegisterNetEvent('esx_policeblips:updateBlips')
AddEventHandler('esx_policeblips:updateBlips', function(players)
    if DutyBlips then
        for _, v in pairs(DutyBlips) do
            RemoveBlip(v)
        end
    end
    DutyBlips = {}
    if ESX.PlayerData.job then
        if ESX.GetPlayerData().job.name == 'police' then
            if players then
                for _, data in pairs(players) do
                    local id = GetPlayerFromServerId(data.source)
                    createDutyBlips(id, data.name)
                end
            end
        end
    end
end)