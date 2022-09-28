local Cooldown = {}
local PlayerCooldown = {}
local SecondiCooldown = Config.CooldownPlayer * 60000
local MinutiCooldown = Config.CooldownPlayer
local L = Config.Language

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		for k,v in pairs(Config.Rapine) do
            Cooldown[k] = 0
		end
	end
end)

AddEventHandler('esx:playerLoaded',function (src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if PlayerCooldown[xPlayer.identifier] == nil or PlayerCooldown[xPlayer.identifier] == 0 then
        PlayerCooldown[xPlayer.identifier] = 0
    end
end)

ESX.RegisterServerCallback('RL_Rapina:Start', function(source, cb, rapina)
    local xPlayer = ESX.GetPlayerFromId(source)

    local Count = 0
    local reason = nil

    local xPlayers = ESX.GetExtendedPlayers()
    for k,v in pairs(xPlayers) do
        -- print(ESX.DumpTable(v))
        if v.job.name == Config.PoliceJobName then
            Count = Count + 1 
        end
    end

    if Count >= Config.Rapine[rapina].Polizia then
        canStart = true
    else
        reason = Config.Lang[L].NoSuchPolice
    end

    if Cooldown[rapina] >= 1 then
        canStart = false
        reason = Config.Lang[L].SafeAlreadyOpened
    end

    if PlayerCooldown[xPlayer.identifier] ~= nil and PlayerCooldown[xPlayer.identifier] >= 30000 then
        canStart = false
        reason = string.format(Config.Lang[L].YouHaveCooldown, MinutiCooldown, ESX.Math.Round((PlayerCooldown[xPlayer.identifier] / 60000)))
    end

    if canStart then
        local xPlayers = ESX.GetExtendedPlayers()
        for k,v in pairs(xPlayers) do
            -- print(ESX.DumpTable(v))
            if v.job.name == Config.PoliceJobName then
                v.showNotification(string.format(Config.Lang[L].RobberyInProgress, Config.Rapine[rapina].Label))
            end
        end
    end

    if canStart then
        cb(true, '')
    else
        cb(false, reason)
    end
end)

ESX.RegisterServerCallback('RL_Rapina:Fine', function(source, cb, rapina)
    local xPlayer = ESX.GetPlayerFromId(source)

    local Guadagno = Config.Rapine[rapina].Guadagno

    Cooldown[rapina] = Config.Rapine[rapina].Cooldown * 60000

    xPlayer.addInventoryItem('black_money', Guadagno)

    xPlayer.showNotification(string.format(Config.Lang[L].YouEarned, Guadagno))

    PlayerCooldown[xPlayer.identifier] = SecondiCooldown
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)

        for k,v in pairs(Config.Rapine) do
            if Cooldown[k] >= 2000 then
                Cooldown[k] = Cooldown[k] - 2000
            end
		end
    end 
end)

Citizen.CreateThread(function()
    while true do
        Wait(30000)

        for k,v in pairs(ESX.GetExtendedPlayers()) do
            if PlayerCooldown[v.identifier] >= 30000 then
                PlayerCooldown[v.identifier] = PlayerCooldown[v.identifier] - 30000
            end
        end
    end
end)