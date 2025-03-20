local ESX = exports["es_extended"]:getSharedObject()
local player = PlayerPedId()
local ultima_entrada_motel 

local marker_size = 0.75
local marker_colour = {r = 145, g = 10, b = 242, a = 100}
local trocar_outfit = vector3(151.7811, -1001.2399, -99.0001)
local motels = {
    [1] = {name = 'Motel1', coords_entrada = vector3(1142.22, 2654.74, 38.142), coords_saida = vector3(151.2901, -1007.8553, -99.0000), coords_saida_motel = vector3(1140.0439, 2654.8145, 37.9969)},
    [2] = {name = 'Motel2', coords_entrada = vector3(1142.3915, 2650.9753, 38.1409), coords_saida = vector3(151.2901, -1007.8553, -99.0000), coords_saida_motel = vector3(1140.3254, 2651.1858, 37.9969)},
}

local function DrawMotelMarker(coords)
    DrawMarker(20, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker_size, marker_size, marker_size, marker_colour.r, marker_colour.g, marker_colour.b, marker_colour.a, false, true, 2, false, false, false, false)
end

local function TeleportPlayer(coords)
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    DoScreenFadeOut(500)
    Wait(1000)
    SetEntityCoords(player, coords.x, coords.y, coords.z, false, false, false, true)
    DoScreenFadeIn(500)
end

CreateThread(function()
    while true do 
        local sleep = 1000
        if not player then player = PlayerPedId() end
        
        local coords = GetEntityCoords(player)

        local dist_outfit = #(coords - trocar_outfit)
        if dist_outfit <= 2 then 
            sleep = 0
            DrawMotelMarker(trocar_outfit)
            if IsControlJustReleased(0, 38) then 
                TriggerEvent("illenium-appearance:client:openClothingShopMenu")
            end
        end

        for _, motel in ipairs(motels) do
            local dist_entrada = #(coords - motel.coords_entrada)
            local dist_saida = #(coords - motel.coords_saida)

            if dist_entrada <= 8 then
                sleep = 0
                DrawMotelMarker(motel.coords_entrada)
                
                if dist_entrada <= 2 then 
                    Notificacao("Clica [E] para entrar no Motel")
                    if IsControlJustReleased(0, 38) then 
                        ultima_entrada_motel = motel.coords_entrada
                        TeleportPlayer(vector3(151.9549, -1004.67, -99.00))
                    end
                end
            end

            if dist_saida <= 2 then
                sleep = 0
                Notificacao("Clica [E] para sair do Motel")
                DrawMotelMarker(motel.coords_saida)

                if IsControlJustReleased(0, 38) and ultima_entrada_motel == motel.coords_entrada then
                    TeleportPlayer(motel.coords_saida_motel)
                    ultima_entrada_motel = nil
                end
            end
        end
        Wait(sleep)
    end
end)
