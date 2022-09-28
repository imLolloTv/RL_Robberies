-- Please don't touch here
local RL_Rapina = false
local L = Config.Language
--

Citizen.CreateThread(function()
    for k,v in pairs(Config.Rapine) do
        TriggerEvent('gridsystem:registerMarker', {
            name = k..'-'..math.random(1,999999),
            pos = v.Coords,
            scale = vector3(0.5, 0.5, 0.5),
            shouldRotate = true,
            msg = '[E] Rapina '..v.Label,
            control = 'E',                
            type = 27,
            color = {r = 255, g = 255, b = 255},
            texture = 'rapine',
            show3D = false,
            action = function()
                local coords = GetEntityCoords(PlayerPedId(), true)
                local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                local street = GetStreetNameFromHashKey(s1)

                ESX.TriggerServerCallback('RL_Rapina:Start', function(esito, reason)
                    if esito then
                        exports.rprogress:MiniGame({
                            Difficulty = "Medium",
                            Timeout = 30000,
                            onComplete = function(success)
                                if success then
                                    RL_Rapina = k

                                    exports.rprogress:Stop()

                                    ESX.ShowNotification(Config.Lang[L].OpeningSafe)

                                    exports.rprogress:Custom({
                                        Async = true,
                                        canCancel = false,
                                        x = 0.1,
                                        y = 0.5,   
                                        From = 0, 
                                        To = 100,  
                                        Duration = ESX.Math.Round(v.Minuti * 60000),
                                        Radius = 60,
                                        Stroke = 10,
                                        Cap = 'butt', 
                                        Padding = 0,
                                        MaxAngle = 360,  
                                        Rotation = 0,
                                        Width = 300, 
                                        Height = 40,
                                        ShowTimer = true,      
                                        ShowProgress = false,   
                                        Easing = "easeLinear",
                                        Label = Config.Lang[L].Robbery,
                                        LabelPosition = "right",
                                        onComplete = function()
                                            if RL_Rapina ~= false then
                                                ESX.TriggerServerCallback('RL_Rapina:Fine', function()
                                                end, k)
                                                RL_Rapina = false
                                            end
                                        end
                                    })
                                else
                                    RL_Rapina = false
                                end    
                            end,
                            onTimeout = function()
                                RL_Rapina = false
                            end
                        })
                    else
                        if reason ~= '' then
                            ESX.ShowNotification(reason)
                        end
                    end
                end, k)
            end,
            onExit = function()
                ESX.UI.Menu.CloseAll()
            end,
        })

        blip = AddBlipForCoord(v.Coords)
        SetBlipSprite(blip, 156)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Lang[L].Robbery)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    local sleep = 100
    while true do
        if RL_Rapina ~= false then
            sleep = 500

            local PlayerCoords = GetEntityCoords(PlayerPedId(), false)
            local RapinaCoords = Config.Rapine[RL_Rapina].Coords 
            local Distanza = #(RapinaCoords - PlayerCoords)
            
            if Distanza > Config.Rapine[RL_Rapina].MaxDistance then
                RL_Rapina = false
                exports.rprogress:Stop()
                ESX.ShowNotification(Config.Lang[L].Distance)
            end
        else
            sleep = 1500
        end

        Wait(sleep)
    end
end)