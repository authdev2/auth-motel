ESX = exports["es_extended"]:getSharedObject()

local ultima_entrada_motel 

CreateThread(function()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)    
    local trocar_outfit = vector3(151.7811, -1001.2399, -99.0001)
    local sleep = 1000
    local motels = {
        [1] = {name = 'Motel1', coords_entrada = vector3(1142.22, 2654.74, 38.142), coords_saida = vector3(151.2901, -1007.8553, -99.0000), coords_saida_motel = vector3(1140.0439, 2654.8145, 37.9969)},
        [2] = {name = 'Motel2', coords_entrada = vector3(1142.3915, 2650.9753, 38.1409), coords_saida = vector3(151.2901, -1007.8553, -99.0000), coords_saida_motel = vector3(1140.3254, 2651.1858, 37.9969)},
    }

    while true do 
        Wait(4) 

        coords = GetEntityCoords(player)  
        sleep = 1000 

        for k, v in ipairs(motels) do
            local distance_entrada = #(coords - v.coords_entrada)
            local distance_saida = #(coords - v.coords_saida)

            if distance_entrada <= 8 then
                sleep = 500  
                DrawMarker(20, v.coords_entrada.x, v.coords_entrada.y, v.coords_entrada.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.75, 0.75, 0.75, 145, 10, 242, 100, false, true, 2, false, false, false, false)
                if distance_entrada <= 2 then 
                    Notificacao("Clica [E] para entrar no Motel")
                    if IsControlJustReleased(0, 38) then 
                        ultima_entrada_motel = v.coords_entrada 
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) 
                        DoScreenFadeOut(500) 
                        Wait(1000)
                        SetEntityCoords(player, 151.9549, -1004.67, -99.00, false, false, false, true)
                        DoScreenFadeIn(500)                                         
                    end
                end
            end

            if distance_saida <= 2 then
                Notificacao("Clica [E] para sair do Motel")
                DrawMarker(20, v.coords_saida.x, v.coords_saida.y, v.coords_saida.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.75, 0.75, 0.75, 145, 10, 242, 100, false, true, 2, false, false, false, false)

                if IsControlJustReleased(0, 38) then 
                    if ultima_entrada_motel == v.coords_entrada then
                        PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) 
                        DoScreenFadeOut(500) 
                        Wait(1000)      
                        SetEntityCoords(player, v.coords_saida_motel.x, v.coords_saida_motel.y, v.coords_saida_motel.z, false, false, false, true)
                        DoScreenFadeIn(500) 
                        ultima_entrada_motel = nil 
                    end
                end
            end
        end

        if #(coords - trocar_outfit) <= 2 then 
            DrawMarker(20, trocar_outfit.x, trocar_outfit.y, trocar_outfit.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.75, 0.75, 0.75, 145, 10, 242, 100, false, true, 2, false, false, false, false)
            if IsControlJustReleased(0, 38) then 
                TriggerEvent("illenium-appearance:client:openClothingShopMenu")
            end
        end
    end
end)


CreateThread(function()

    local motel_blip = {
        vector3(1113.0281, 2674.0969, 38.3732),
        vector3(577.2807, 2144.8730, 73.4494)
    }
    
    for k, motel_coords in ipairs(motel_blip) do 
        local blip = AddBlipForCoord(motel_coords.x, motel_coords.y, motel_coords.z)
        SetBlipSprite(blip, 78) 
        SetBlipColour(blip, 3) 
        SetBlipScale(blip, 0.7) 
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("MOTEL") 
        EndTextCommandSetBlipName(blip)
    end
end)


function Notificacao(msg)
    ESX.ShowHelpNotification(msg)
end